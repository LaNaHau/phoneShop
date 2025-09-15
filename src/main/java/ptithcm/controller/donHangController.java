package ptithcm.controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.entity.CTDonHangEntity;
import ptithcm.entity.DanhGiaEntity;
import ptithcm.entity.DonHangEntity;
import ptithcm.entity.GioHangEntity;
import ptithcm.entity.NguoiDungEntity;
import ptithcm.entity.SanPhamEntity;
import ptithcm.entity.VoucherEntity;
import ptithcm.service.CTDonHangService;
import ptithcm.service.DanhGiaService;
import ptithcm.service.DonHangService;
import ptithcm.service.RecaptchaService;
import ptithcm.service.SanPhamService;
import ptithcm.service.VoucherService;
import ptithcm.service.gioHangService;

@Controller

public class donHangController {

	@Autowired
	DonHangService DonHangService;
	@Autowired
	gioHangService gioHangService;
	@Autowired
	CTDonHangService ctDonHangService;
	@Autowired
	SanPhamService sanPhamService;
	@Autowired
	DanhGiaService danhGiaService;
	@Autowired
	VoucherService voucherService;
	@Autowired
	RecaptchaService recaptchaService;

	@RequestMapping("donHang")
	public String donHang(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USER");

		List<GioHangEntity> gioHangList = gioHangService.layGioHangCuaUser(user.getMaNd());
		model.addAttribute("gioHangList", gioHangList);

		return "/donHang/donHang";

	}

	@RequestMapping("donHang/newInfo")
	public String donHang1(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USER");

		List<GioHangEntity> gioHangList = gioHangService.layGioHangCuaUser(user.getMaNd());
		model.addAttribute("gioHangList", gioHangList);
		System.out.print("test");
		return "/donHang/donHang";

	}

	/*
	 * @RequestMapping(value = "donHang/newInfo", method = RequestMethod.POST)
	 * public String newInfo(HttpServletRequest request) { HttpSession session =
	 * request.getSession(); NguoiDungEntity newInfo = new NguoiDungEntity(); String
	 * ten = request.getParameter("ten"); String sdt = request.getParameter("sdt");
	 * String diaChi = request.getParameter("diaChi"); newInfo.setHoTen(ten);
	 * newInfo.setSdt(sdt); newInfo.setDiaChi(diaChi);
	 * session.setAttribute("NEWINFO", newInfo); System.out.print("newinfo"); return
	 * "redirect:/donHang.htm"; }
	 */
	@RequestMapping(value = "donHang/newInfo", method = RequestMethod.POST)
	public String newInfo(HttpServletRequest request, ModelMap model, RedirectAttributes redirectAttributes) {
		HttpSession session = request.getSession();
		NguoiDungEntity newInfo = new NguoiDungEntity();

		String recaptchaResponse = request.getParameter("g-recaptcha-response");
		if (!recaptchaService.verify(recaptchaResponse)) {
			redirectAttributes.addFlashAttribute("errorCaptcha", "Vui lòng nhập captcha!");
			return "redirect:/donHang.htm"; // Chuyển hướng về lại trang sản phẩm
		}
		// Lấy và kiểm tra các tham số từ request
		String ten = request.getParameter("ten");
		String sdt = request.getParameter("sdt");
		String diaChi = request.getParameter("diaChi");

		boolean isValid = true;

		// Kiểm tra họ tên
		if (ten == null || ten.isEmpty()) {
			model.addAttribute("loiHoTen", "Họ tên không được để trống!");
			isValid = false;
		} else if (ten.length() > 50) {
			model.addAttribute("loiHoTen", "Họ tên không được vượt quá 50 ký tự!");
			isValid = false;
		} else if (!ten.matches("[\\p{L} ]+")) {
			model.addAttribute("loiHoTen", "Họ tên chỉ được chứa chữ cái!");
			isValid = false;
		} else {
			newInfo.setHoTen(ten);
		}

		// Kiểm tra số điện thoại
		if (sdt == null || sdt.isEmpty()) {
			model.addAttribute("loiSDT", "Số điện thoại không được để trống!");
			isValid = false;
		} else if (!sdt.matches("\\d{10}")) { // Chỉ chấp nhận số từ 10 đến 15 chữ số
			model.addAttribute("loiSDT", "Số điện thoại không hợp lệ!");
			isValid = false;
		} else {
			newInfo.setSdt(sdt);
		}

		// Kiểm tra địa chỉ
		if (diaChi == null || diaChi.isEmpty()) {
			model.addAttribute("loiDiaChi", "Địa chỉ không được để trống!");
			isValid = false;
		} else if (!diaChi.matches("^[\\p{L}0-9\\s\\-,./]+$")) {
			model.addAttribute("loiDiaChi", "Địa chỉ chỉ được chứa chữ cái, số, khoảng trắng và các ký tự: - , . /");
			isValid = false;
		} else if (diaChi.length() > 255) {
			model.addAttribute("loiDiaChi", "Địa chỉ không được vượt quá 255 ký tự!");
			isValid = false;
		} else {
			newInfo.setDiaChi(diaChi);
		}

		// Lưu thông tin hợp lệ vào session
		session.setAttribute("NEWINFO", newInfo);

		return "redirect:/donHang.htm";
	}

	@RequestMapping(value = "donHang/datHang", method = RequestMethod.POST, params = "datHang")
	public String datHang(HttpServletRequest request, HttpSession session, ModelMap model) {

		NguoiDungEntity newInfo = (NguoiDungEntity) session.getAttribute("NEWINFO"); // lấy địa chỉ mới
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USER");
		List<GioHangEntity> gioHangList = gioHangService.layGioHangCuaUser(user.getMaNd());
		BigDecimal tongTien = new BigDecimal(request.getParameter("tongTien"));
		
        String recaptchaResponse = request.getParameter("g-recaptcha-response");
        // Gọi hàm verify() từ RecaptchaService
        if (!recaptchaService.verify(recaptchaResponse)) {
            model.addAttribute("errorCaptcha", "reCAPTCHA xác thực không thành công. Vui lòng thử lại.");
            return "redirect:/donHang.htm";
        }
		
		
		if (gioHangList == null || gioHangList.isEmpty()) {
			model.addAttribute("errorMessage", "Giỏ hàng trống !");
			return "gioHang/gioHang";
		}
		DonHangEntity donHang = new DonHangEntity();
		Date currentDate = new Date();
		donHang.setNgayTao(currentDate);
		donHang.setTongTien(tongTien);
		donHang.setTrangThai(1);
		if (newInfo == null) {
			donHang.setHoTen(user.getHoTen());
			donHang.setSdt(user.getSdt());
			donHang.setDiaChi(user.getDiaChi());

			donHang.setNguoiDung(user);

		} else {
			donHang.setHoTen(newInfo.getHoTen());
			donHang.setSdt(newInfo.getSdt());
			donHang.setDiaChi(newInfo.getDiaChi());
			donHang.setNguoiDung(user);
		}

		VoucherEntity voucher = (VoucherEntity) session.getAttribute("Voucher");

		donHang.setVoucher(voucher);

		if (donHang.getVoucher() != null) {
			voucher.setSoLuong(voucher.getSoLuong() - 1);
			voucherService.updateVoucher(voucher);
		}
		session.removeAttribute("Voucher");
		session.removeAttribute("errorVoucher");
		session.removeAttribute("successVoucher");

		DonHangService.luuDonHang(donHang);

		GioHangEntity gh = new GioHangEntity();
		SanPhamEntity sp = new SanPhamEntity();

		for (int i = 0; i < gioHangList.size(); i++) {
			gh = gioHangList.get(i);
			CTDonHangEntity ctdh = new CTDonHangEntity();
			ctdh.setDonHang(donHang);
			ctdh.setSanPham(gh.getSanPham());
			ctdh.setDonGia(gh.getSanPham().getDonGia());
			ctdh.setSoLuong(gh.getSoLuong());
			ctdh.setTrangThaiDanhGia(false);
			ctDonHangService.luuCtdh(ctdh);

			sp = sanPhamService.laySanPham(gh.getSanPham().getMaSP());
			int soLuong = sp.getSoLuong() - gh.getSoLuong();
			sanPhamService.updateSoLuongSP(sp.getMaSP(), soLuong);//
			gioHangService.deleteGioHang(gh.getMaGh());

		}

		return "/donHang/thanhCong";

	}

	@RequestMapping("diaChiMacDinh")
	public String macDinh(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("NEWINFO");
		return "redirect:/donHang.htm";
	}

	@RequestMapping("chiTietDonHang/{maDh}")
	public String ctDonHang(@PathVariable("maDh") int maDh, ModelMap model, HttpSession session) throws Exception {
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USER");
		if (user == null) {
			model.addAttribute("user", new NguoiDungEntity());

			return "/user/login";
		}
		DonHangEntity donHang = DonHangService.timDonHangTheoMa(maDh);
		List<CTDonHangEntity> ctDonHangList = ctDonHangService.timctdhTheoMaDh(maDh);
		model.addAttribute("donHang", donHang);
		model.addAttribute("ctDonHangList", ctDonHangList);
		return "donHang/chiTietDonHang";
	}

	@RequestMapping(value = "donHang/checkVoucher", method = RequestMethod.POST)
	public String checkVoucher(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.removeAttribute("errorVoucher");
		session.removeAttribute("successVoucher");
		String maVoucher = request.getParameter("voucher");
		VoucherEntity voucher = voucherService.layVoucherTheoMa(maVoucher);
		if (voucher == null || voucher.getSoLuong() == 0 || voucher.getTrangThai() == 1) {
			session.setAttribute("errorVoucher", "Mã voucher không đúng hoặc hết số lượng hoặc hết hạn");
		} else {
			session.setAttribute("successVoucher", "Thêm voucher thành công");
			session.setAttribute("Voucher", voucher);
			System.out.println(voucher);
		}
		System.out.println(maVoucher);
		return "redirect:/donHang.htm";
	}

	@RequestMapping("daNhanHang/{maDh}")
	public String daNhanHang(@PathVariable("maDh") int maDh) throws Exception {
		DonHangEntity donHang = DonHangService.timDonHangTheoMa(maDh);
		donHang.setTrangThai(3);
		DonHangService.updateDonHang(donHang);

		return "redirect:/lich-su-mua-hang.htm";
	}

	@RequestMapping("huyDonHang/{maDh}")
	public String huyDonHang(@PathVariable("maDh") int maDh) throws Exception {
		DonHangEntity donHang = DonHangService.timDonHangTheoMa(maDh);
		donHang.setTrangThai(0);
		DonHangService.updateDonHang(donHang);

		List<CTDonHangEntity> ctDonHangList = ctDonHangService.timctdhTheoMaDh(maDh);
		SanPhamEntity sp = new SanPhamEntity();
		for (int i = 0; i < ctDonHangList.size(); i++) {
			sp = sanPhamService.laySanPham(ctDonHangList.get(i).getSanPham().getMaSP());
			int soLuong = sp.getSoLuong() + ctDonHangList.get(i).getSoLuong();
			sanPhamService.updateSoLuongSP(sp.getMaSP(), soLuong);
		}

		return "redirect:/lich-su-mua-hang.htm";
	}

}