package ptithcm.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.encrypt.AesEncrypt;
import ptithcm.encrypt.DesEncrypt;
import ptithcm.entity.DonHangEntity;
import ptithcm.entity.KieuSanPhamEntity;
import ptithcm.entity.NguoiDungEntity;
import ptithcm.entity.WebActionLogEntity;
import ptithcm.service.CTDonHangService;
import ptithcm.service.DonHangService;
import ptithcm.service.KieuSanPhamService;
import ptithcm.service.SanPhamService;
import ptithcm.service.WebActionLogService;
import ptithcm.service.nguoiDungService;

@Transactional
@Controller
@RequestMapping("/admin93123/")
public class adminController {

	@Autowired
	SanPhamService sanPhamService;

	@Autowired
	DonHangService donHangService;

	@Autowired
	CTDonHangService ctDonHangService;

	@Autowired
	nguoiDungService nguoiDungService;

	@Autowired
	KieuSanPhamService kieuSanPhamService;

	@Autowired
	private WebActionLogService logService;

	@RequestMapping("index")
	public String index(HttpServletRequest request, ModelMap model) throws Exception {
		HttpSession session0 = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session0.getAttribute("USER");

		List<DonHangEntity> donThanhCong = donHangService.layDonHangTheoTrangThai(3);
		BigDecimal tongDoanhThu = BigDecimal.ZERO; // Initialize with BigDecimal.ZERO
		for (DonHangEntity donHang : donThanhCong) {
			tongDoanhThu = tongDoanhThu.add(donHang.getTongTien());

		}

		model.addAttribute("tongDoanhThu", tongDoanhThu);

		// Tính tổng doanh thu theo từng tháng
		List<Long> monthlyRevenues = new ArrayList<>();
		for (int i = 1; i <= 12; i++) {
			long totalRevenue = donHangService.tinhTongDoanhThuTheoThang(i);
			monthlyRevenues.add(totalRevenue);
		}

		/*
		 * List<KieuSanPhamEntity> listMaKieu = kieuSanPhamService.layKieu(); // Khai
		 * báo một danh sách để lưu kết quả doanh thu theo từng kiểu sản phẩm
		 * List<Object[]> tongSoLuongTheoKieu = new ArrayList<>();
		 * 
		 * // Lặp qua từng kiểu sản phẩm int trangThai = 0; for (KieuSanPhamEntity kieu
		 * : listMaKieu) { // Lấy mã kiểu sản phẩm int maKieu = kieu.getMaKieu();
		 * 
		 * // Gọi phương thức tongSoLuongTheoKieuLoai với maKieu hiện tại List<Object[]>
		 * result = ctDonHangService.tongSoLuongTheoKieuLoai(maKieu,trangThai);
		 * model.addAttribute("result_" + maKieu + "_" + trangThai, result);
		 * 
		 * trangThai = (trangThai + 1) % 4; // Trang thái tự tăng từ 0 đến 3 }
		 */
		model.addAttribute("monthlyRevenues", monthlyRevenues);

		// Thống kê số người dùng

		List<NguoiDungEntity> listNguoiDung = nguoiDungService.getAllUserByRole(0);
		int tongSoNguoiDung = listNguoiDung.size();
		model.addAttribute("tongSoNguoiDung", tongSoNguoiDung);

		// Thống kêsố đơn hàng
		int tongDonChoXacNhan = donHangService.layDonHangTheoTrangThai(1).size();
		int tongDonDangGiao = donHangService.layDonHangTheoTrangThai(2).size();
		int tongDonThanhCong = donHangService.layDonHangTheoTrangThai(3).size();
		int tongDonDaHuy = donHangService.layDonHangTheoTrangThai(0).size();

		model.addAttribute("pendingOrders", tongDonChoXacNhan);
		model.addAttribute("deliveringOrders", tongDonDangGiao);
		model.addAttribute("completedOrders", tongDonThanhCong);
		model.addAttribute("cancelledOrders", tongDonDaHuy);

		/*
		 * List<Object[]> tongSoLuongTheoKieuLoai =
		 * ctDonHangService.tongSoLuongTheoKieuLoai(123); // Thay 123 bằng mã đơn hàng
		 * thực tế model.addAttribute("tongSoLuongTheoKieuLoai",
		 * tongSoLuongTheoKieuLoai);
		 */

		return "admin93123/index";
	}

	@RequestMapping("logView")
	public String logView(@RequestParam(required = false) String severity, HttpServletRequest request, ModelMap model) {

		HttpSession session0 = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session0.getAttribute("USER");

		List<WebActionLogEntity> logs;
		if (severity != null && !severity.isEmpty()) {
			logs = logService.getLogsBySeverity(severity);
		} else {
			logs = logService.getLogs();
		}
		model.addAttribute("logs", logs);

		return "admin93123/logView";
	}

	@RequestMapping("adminAccount")
	public String account(HttpServletRequest request, ModelMap model) throws Exception {
		HttpSession session0 = request.getSession();
		List<NguoiDungEntity> adminList = nguoiDungService.getAllUserByRole(1);

		Collections.sort(adminList, new Comparator<NguoiDungEntity>() {
			@Override
			public int compare(NguoiDungEntity nguoi1, NguoiDungEntity nguoi2) {
				boolean trangThai1 = nguoi1.isTrangThai();
				boolean trangThai2 = nguoi2.isTrangThai();

				// Sắp xếp theo thứ tự giảm dần (true trước, false sau)
				return Boolean.compare(trangThai2, trangThai1);
			}
		});

		model.addAttribute("adminList", adminList);
		return "admin93123/adminAccount";
	}

	@RequestMapping("inforAcc/{maNd}")
	public String inforAcc(@PathVariable("maNd") int maNd, HttpServletRequest request, ModelMap model)
			throws Exception {
		HttpSession session0 = request.getSession();
		NguoiDungEntity user = nguoiDungService.findUserById(maNd);
		model.addAttribute("user", user);

		return "admin93123/inforAcc";
	}

	@RequestMapping(value = "changeInfo", params = "save", method = RequestMethod.POST)
	public String infoUpdate(HttpServletRequest request, ModelMap model, @ModelAttribute("admin") NguoiDungEntity admin,
			BindingResult errors) throws Exception {
		Boolean hasError = Boolean.TRUE;
		HttpSession session = request.getSession();
		NguoiDungEntity adminSession = (NguoiDungEntity) session.getAttribute("USER");
		admin.setUserName(adminSession.getUserName()); // Lấy lại userName từ session để đảm bảo không thay đổi.

		// Lấy ngày sinh từ request và kiểm tra
		String ngaySinhInput = request.getParameter("ngaySinh");
		if (admin.getHoTen().isEmpty()) {
			model.addAttribute("loiHoTen", "Họ tên không được để trống!");
			hasError = Boolean.FALSE;
		} else if (admin.getHoTen().length() > 50) {
			model.addAttribute("loiHoTen", "Họ tên quá dài!");
			hasError = Boolean.FALSE;
		} else if (!admin.getHoTen().matches("[\\p{L} ]+")) {
			model.addAttribute("loiHoTen", "Họ tên không được chứa số hoặc ký tự đặc biệt!");
			hasError = Boolean.FALSE;
		}

		if (ngaySinhInput == null || ngaySinhInput.isEmpty()) {
			model.addAttribute("loiNgaySinh", "Hãy nhập ngày sinh!");
			hasError = Boolean.FALSE;
		} else {
			try {
				Date ngaySinh = java.sql.Date.valueOf(ngaySinhInput);
				admin.setNgaySinh(ngaySinh);
				if (!isValidAndOver18(ngaySinh)) {
					model.addAttribute("loiNgaySinh", "Bạn phải trên 18 tuổi để cập nhật thông tin!");
					hasError = Boolean.FALSE;
				}
			} catch (IllegalArgumentException e) {
				model.addAttribute("loiNgaySinh", "Ngày sinh không hợp lệ!");
				hasError = Boolean.FALSE;
			}
		}

		if (admin.getDiaChi().isEmpty()) {
			model.addAttribute("loiDiaChi", "Địa chỉ không được để trống!");
			hasError = Boolean.FALSE;
		}

		if (admin.getSdt().isEmpty()) {
			model.addAttribute("loiSdt", "Hãy nhập số điện thoại!");
			hasError = Boolean.FALSE;
		} else if (!admin.getSdt().matches("[0-9]+")) {
			model.addAttribute("loiSdt", "Số điện thoại chỉ được chứa số!");
			hasError = Boolean.FALSE;
		} else if (admin.getSdt().length() < 10 || admin.getSdt().length() > 11) {
			model.addAttribute("loiSdt", "Số điện thoại phải từ 10 đến 11 số!");
			hasError = Boolean.FALSE;
		}

		if (admin.getEmail().isEmpty()) {
			model.addAttribute("loiEmail", "Hãy nhập email!");
			hasError = Boolean.FALSE;
		} else if (!admin.getEmail().matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
			model.addAttribute("loiEmail", "Email không đúng định dạng!");
			hasError = Boolean.FALSE;
		}

		// Nếu có lỗi, trả về trang "me.jsp" và giữ lại dữ liệu người dùng
		if (!hasError) {
			model.addAttribute("admin", adminSession); // Giữ lại admin từ session
			return "admin93123/me";
		}

		// Cập nhật thông tin admin
		adminSession.setHoTen(admin.getHoTen());
		adminSession.setNgaySinh(admin.getNgaySinh());
		adminSession.setDiaChi(admin.getDiaChi());
		adminSession.setSdt(admin.getSdt());
		adminSession.setEmail(admin.getEmail());
		adminSession.setGioiTinh(admin.isGioiTinh());

		session.setAttribute("USER", adminSession); // Cập nhật lại session
		nguoiDungService.updateUser(adminSession); // Ghi dữ liệu vào database
		// Cập nhật vào database
		nguoiDungService.updateUser(adminSession);

		NguoiDungEntity detachedUser = new NguoiDungEntity();
		detachedUser.setMaNd(adminSession.getMaNd());
		detachedUser.setUserName(adminSession.getUserName());
		detachedUser.setGioiTinh(adminSession.isGioiTinh());
		detachedUser.setHoTen(adminSession.getHoTen());
		detachedUser.setNgaySinh(adminSession.getNgaySinh());
		detachedUser.setAvatar(adminSession.getAvatar());
		detachedUser.setDiaChi(adminSession.getDiaChi());
		detachedUser.setSdt(DesEncrypt.desDecrypt(adminSession.getSdt(), DesEncrypt.desKey)); // Giải mã số điện thoại
		detachedUser.setEmail(AesEncrypt.aesDecrypt(adminSession.getEmail(), AesEncrypt.aesKey256)); // Giải mã email
		detachedUser.setPassWord(adminSession.getPassWord());
		detachedUser.setTrangThai(adminSession.isTrangThai());
		detachedUser.setQuyen(adminSession.getQuyen());
		detachedUser.setGioHangs(adminSession.getGioHangs());
		detachedUser.setDanhGiaList(adminSession.getDanhGiaList());
		detachedUser.setDonHangs(adminSession.getDonHangs());
		detachedUser.setYeuThichList(adminSession.getYeuThichList());

		// Cập nhật vào session
		session.setAttribute("USER", detachedUser);
		model.addAttribute("user", detachedUser);
		model.addAttribute("successMessage", "Cập nhật thông tin thành công!");
		return "admin93123/me";
	}

	@RequestMapping("changePass")
	public String changPass() {
		return "/admin93123/changePass";

	}

	@RequestMapping(value = "changePass.htm", params = "save", method = RequestMethod.POST)
	public String changePass(HttpServletRequest request, ModelMap model) {
		Boolean loi = Boolean.TRUE;
		HttpSession session = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USER");
		String pass = request.getParameter("pass");
		String newPass = request.getParameter("newPass");
		String reNewPass = request.getParameter("renewPass");

		if (pass.isEmpty()) {
			model.addAttribute("loiPass", "Hãy nhập mật khẩu cũ !!!");
			loi = Boolean.FALSE;

		} else if (!nguoiDungService.kiemTraMatKhau(pass, user.getPassWord())) {
			model.addAttribute("loiPass", "Mật khẩu cũ không đúng !!!");
			return "/admin93123/changePass";
		}

		if (newPass.isEmpty()) {
			model.addAttribute("loiNewPass", "Hãy nhập mật khẩu mới !!!");
			loi = Boolean.FALSE;
		} else if (newPass.length() < 8) {
			model.addAttribute("loiNewPass", "Mật khẩu tối thiểu 8 kí tự !!!");
			loi = Boolean.FALSE;
		} else if (newPass.contains(" ")) {
			model.addAttribute("loiNewPass", "Mật khẩu không được chứa khoảng trắng !!!");
			loi = Boolean.FALSE;
		} else if (reNewPass.isEmpty()) {
			model.addAttribute("loiRePass", "Hãy nhập lại mật khẩu !!!");
			loi = Boolean.FALSE;
		} else if (!reNewPass.equals(newPass)) {
			model.addAttribute("loiRePass", "Xác nhận mật khẩu không đúng !!!");
			loi = Boolean.FALSE;
		}

		if (loi == Boolean.TRUE) {
			user.setPassWord(nguoiDungService.maHoaMatKhau(newPass));

			nguoiDungService.updateUser(user);
			model.addAttribute("successMessage", "Đổi mật khẩu thành công !!!");

		}

		return "/admin93123/changePass";
	}

	@RequestMapping("createAcc")
	public String createAcc(HttpServletRequest request, ModelMap model) {
		NguoiDungEntity admin = new NguoiDungEntity();
		model.addAttribute("admin", admin);
		return "admin93123/createAcc";
	}

	@RequestMapping(value = "/form/addAcc", params = "add", method = RequestMethod.POST)
	public String addAcc(HttpServletRequest request, ModelMap model, @ModelAttribute("admin") NguoiDungEntity admin,
			BindingResult errors) throws Exception {

		Boolean loi = Boolean.TRUE;
		String rePassword = request.getParameter("re-passWord");
		NguoiDungEntity userCheck;

		if (admin.getEmail().isEmpty()) {
			errors.rejectValue("email", "user", "Hãy nhập email !!!");
			loi = Boolean.FALSE;
		} else if (!admin.getEmail().endsWith("@gmail.com")) {
			errors.rejectValue("email", "user", "Hãy nhập email đúng định dạng !!!");
			loi = Boolean.FALSE;
		}
		if (admin.getUserName().isEmpty()) {
			errors.rejectValue("userName", "user", "Hãy nhập username !!!");
			loi = Boolean.FALSE;
		} else if (admin.getUserName().contains(" ")) {
			errors.rejectValue("userName", "user", "UserName không được chứa khoảng trắng !!!");
			loi = Boolean.FALSE;
		} else if (admin.getUserName().length() > 30) {
			errors.rejectValue("userName", "user", "UserName không được dài quá 30 kí tự !!!");
			loi = Boolean.FALSE;
		}

		userCheck = nguoiDungService.findUserByNameAndEmail(admin.getUserName(), admin.getEmail());
		if (userCheck != null) {
			if (userCheck.getEmail().equals(admin.getEmail())) {
				errors.rejectValue("email", "user", "Email đã được sử dụng !!!");
				loi = Boolean.FALSE;
			}
			if (userCheck.getUserName().equals(admin.getUserName())) {
				errors.rejectValue("userName", "user", "Username đã được sử dụng !!!");
				loi = Boolean.FALSE;
			}

		}

		if (admin.getPassWord().isEmpty()) {
			errors.rejectValue("passWord", "user", "Hãy nhập mật khẩu !!!");
			loi = Boolean.FALSE;
		} else if (admin.getPassWord().length() < 8) {
			errors.rejectValue("passWord", "user", "Password tối thiểu 8 kí tự !!!");
			loi = Boolean.FALSE;
		} else if (admin.getPassWord().contains(" ")) {
			errors.rejectValue("passWord", "user", "Password không được chứa khoảng trắng !!!");
			loi = Boolean.FALSE;
		} else if (rePassword.isEmpty()) {
			errors.rejectValue("passWord", "user", "Hãy nhập lại mật khẩu !!!");
			loi = Boolean.FALSE;
		} else if (!rePassword.equals(admin.getPassWord())) {
			errors.rejectValue("passWord", "user", "Xác nhận mật khẩu không đúng !!!");
			loi = Boolean.FALSE;
		}
		if (admin.getHoTen().isEmpty()) {
			errors.rejectValue("hoTen", "user", "Hãy nhập họ tên !!!");
			loi = Boolean.FALSE;
		} else if (admin.getHoTen().length() > 50) {
			errors.rejectValue("hoTen", "user", "Họ tên quá dài !!!");
			loi = Boolean.FALSE;
		} else if (!admin.getHoTen().matches("[\\p{L} ]+")) {
			errors.rejectValue("hoTen", "user", "Họ tên không được chứa số !!!");
			loi = Boolean.FALSE;
		}

		if (admin.getNgaySinh() == null) {
			errors.rejectValue("ngaySinh", "user", "Hãy nhập ngày sinh !!!");
			loi = Boolean.FALSE;
		} else if (!isValidAndOver18(admin.getNgaySinh())) {
			errors.rejectValue("ngaySinh", "user", "Admin cần lớn hơn 18 tuổi để tạo tài khoản !!!");
			loi = Boolean.FALSE;
		}
		if (admin.getSdt().isEmpty()) {
			errors.rejectValue("sdt", "user", "Hãy nhập sdt !!!");
			loi = Boolean.FALSE;
		} else if (!admin.getSdt().matches("[0-9]+")) {
			errors.rejectValue("sdt", "user", "SDT không hợp lệ !!!");
			loi = Boolean.FALSE;
		} else if (admin.getSdt().length() != 10 && admin.getSdt().length() != 11) {
			errors.rejectValue("sdt", "user", "SDT không hợp lệ !!!");
			loi = Boolean.FALSE;
		}
		if (admin.getDiaChi().isEmpty()) {
			errors.rejectValue("diaChi", "user", "Hãy nhập địa chỉ !!!");
			loi = Boolean.FALSE;
		}

		if (loi == Boolean.FALSE) {
			model.addAttribute("errorMessage", "Lỗi thêm Admin");

			return "/admin93123/createAcc";
		}

		String NGAYSINH = request.getParameter("ngaySinh");
		java.sql.Date ns = java.sql.Date.valueOf(NGAYSINH);
		admin.setPassWord(nguoiDungService.maHoaMatKhau(admin.getPassWord()));
		admin.setNgaySinh(ns);
		admin.setHoTen(capitalizeString(admin.getHoTen()));
		admin.setTrangThai(true);
		admin.setQuyen(1);
		nguoiDungService.addUser(admin);
		model.addAttribute("successMessage", "Thêm Admin mới thành công");
		return "/admin93123/createAcc";
	}

	@RequestMapping("on/{maNd}")
	public String on(@PathVariable("maNd") int maNd, HttpServletRequest request, ModelMap model) throws Exception {
		HttpSession session0 = request.getSession();
		/*
		 * NguoiDungEntity user = nguoiDungService.findUserById(maNd);
		 * user.setTrangThai(false);
		 */
		System.out.println("setTrangThai: On");
		nguoiDungService.updateTrangThaiUser(maNd, true);
		return "redirect:/admin93123/customerAccount.htm";
	}

	/*
	 * @RequestMapping("off/{maNd}") public String off(@PathVariable("maNd") int
	 * maNd, HttpServletRequest request, ModelMap model) throws Exception {
	 * HttpSession session0 = request.getSession();
	 * 
	 * NguoiDungEntity user = nguoiDungService.findUserById(maNd);
	 * user.setTrangThai(false);
	 * 
	 * System.out.println("setTrangThai: Off");
	 * nguoiDungService.updateTrangThaiUser(maNd, false); if (user.getQuyen() == 0)
	 * return "redirect:/admin93123/customerAccount.htm";
	 * 
	 * return "redirect:/admin93123/adminAccount.htm"; }
	 */

	@RequestMapping("off/{maNd}")
	public String off(@PathVariable("maNd") int maNd, HttpServletRequest request, ModelMap model) throws Exception {
		HttpSession session0 = request.getSession();
		/*
		 * NguoiDungEntity user = nguoiDungService.findUserById(maNd);
		 * user.setTrangThai(false);
		 */
		System.out.println("setTrangThai: Off");
		nguoiDungService.updateTrangThaiUser(maNd, false);
		return "redirect:/admin93123/customerAccount.htm";
	}

	@RequestMapping("customerAccount")
	public String cusAccount(HttpServletRequest request, ModelMap model) throws Exception {
		HttpSession session0 = request.getSession();
		List<NguoiDungEntity> cusList = nguoiDungService.getAllUserByRole(0);
		/* desEncrypt.desEncrypt(null, desEncrypt.desKey); */
	    // Duyệt qua danh sách và giải mã số điện thoạ
		Collections.sort(cusList, new Comparator<NguoiDungEntity>() {
			@Override
			public int compare(NguoiDungEntity nguoi1, NguoiDungEntity nguoi2) {
				boolean trangThai1 = nguoi1.isTrangThai();
				boolean trangThai2 = nguoi2.isTrangThai();

				// Sắp xếp theo thứ tự giảm dần (true trước, false sau)
				return Boolean.compare(trangThai2, trangThai1);
			}
		});

		model.addAttribute("userList", cusList);
		return "admin93123/customerAccount";
	}

	@RequestMapping("me")
	public String me(HttpServletRequest request, ModelMap model) {
		HttpSession session0 = request.getSession();
		NguoiDungEntity admin = (NguoiDungEntity) session0.getAttribute("USER");
		model.addAttribute("admin", admin);
		return "admin93123/me";
	}

	public boolean isValidAndOver18(Date ngaySinh) {
		if (ngaySinh instanceof java.sql.Date) {
			// Chuyển đổi từ java.sql.Date sang LocalDate
			LocalDate dob = ((java.sql.Date) ngaySinh).toLocalDate();
			LocalDate today = LocalDate.now();
			int age = Period.between(dob, today).getYears();
			Date currentDate = new Date();
			return !ngaySinh.after(currentDate) && age >= 18;
		} else {
			throw new IllegalArgumentException("Ngày sinh không hợp lệ");
		}
	}

	public static String capitalizeString(String str) {
		String[] words = str.split("\\s+");
		for (int i = 0; i < words.length; i++) {
			words[i] = words[i].substring(0, 1).toUpperCase() + words[i].substring(1);
		}
		return String.join(" ", words);
	}

	@RequestMapping(value = "customerAccount/search", method = RequestMethod.GET)
	public String search(@RequestParam(value = "hoTen", required = false) String hoTen, ModelMap model,
			HttpServletRequest request) throws Exception {

		if (hoTen != null && !hoTen.trim().isEmpty()) {
			// Biểu thức chính quy chỉ cho phép chữ cái (hoa và thường), dấu cách và dấu
			// phẩy
			if (!hoTen.matches("^[a-zA-Zàáảãạăắằẳẵặâấầẩẫậđèéẻẽẹêếềểễệìíỉĩịòóỏõọôốồổỗộơớờởỡợùúủũụưứừửữựýỷỹỵ\\s,]*$")) {
				model.addAttribute("errorSearch", "Tên không được chứa ký tự đặc biệt.");
				return "admin93123/customerAccount"; // Quay lại trang tìm kiếm với thông báo lỗi
			}
		}

		System.out.print(hoTen);

		// Gọi service để tìm kiếm đơn hàng theo các tham số đã chuyển đổi
		List<NguoiDungEntity> listSearch = nguoiDungService.findUserByNames(hoTen);

		// Lấy danh sách tất cả đơn hàng để hiển thị trong bảng chính
		List<NguoiDungEntity> cusList = nguoiDungService.getAllUserByRole(0);

		System.out.print(listSearch);
		// Thêm danh sách tìm kiếm và danh sách chính vào model
		model.addAttribute("listSearch", listSearch);
		Collections.sort(cusList, new Comparator<NguoiDungEntity>() {
			@Override
			public int compare(NguoiDungEntity nguoi1, NguoiDungEntity nguoi2) {
				boolean trangThai1 = nguoi1.isTrangThai();
				boolean trangThai2 = nguoi2.isTrangThai();

				// Sắp xếp theo thứ tự giảm dần (true trước, false sau)
				return Boolean.compare(trangThai2, trangThai1);
			}
		});

		model.addAttribute("userList", cusList);

		// Thêm các tham số tìm kiếm để hiển thị lại trong form tìm kiếm
		model.addAttribute("hoTen", hoTen);

		return "admin93123/customerAccount"; // Tên file JSP
	}

}
