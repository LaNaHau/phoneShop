package ptithcm.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.bean.LogService;
import ptithcm.bean.Mailer;
import ptithcm.encrypt.AesEncrypt;
import ptithcm.encrypt.DesEncrypt;
import ptithcm.entity.NguoiDungEntity;
import ptithcm.entity.SanPhamEntity;
import ptithcm.entity.UserContextHolder;
import ptithcm.service.RecaptchaService;
import ptithcm.service.WebActionLogService;
import ptithcm.service.nguoiDungService;

@Transactional
@Controller
public class userController {

	@Autowired
	SessionFactory factory;

	@Autowired
	Mailer mailer;

	@Autowired
	nguoiDungService userService;
	@Autowired
	RecaptchaService recaptchaService;
	@Autowired
	LogService logService;
	@Autowired
	WebActionLogService webActionLogService;

	int flag = 3;

	@RequestMapping("user/login")
	public String login(ModelMap model) {
		model.addAttribute("user", new NguoiDungEntity());
		System.out.println("hello");
		return "/user/login";

	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login0(ModelMap model) {
		model.addAttribute("user", new NguoiDungEntity());
		System.out.print("login");
		return "user/login";
	}

	@RequestMapping(value = "signup", method = RequestMethod.GET)
	public String signUp0(ModelMap model) {
		model.addAttribute("user", new NguoiDungEntity());
		System.out.print("signup");
		return "/user/signup";
	}

	@RequestMapping("forgotpass")
	public String forgotpass() {
		return "/user/forgotpass";
	}

	@RequestMapping("userInfo.htm")
	public String userInfo(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USER");

		/*
		 * if (user == null) { user = new NguoiDungEntity(); // Hoặc trả về trang đăng
		 * nhập }
		 */
		model.addAttribute("user", user);
		return "/user/user-info";
	}

	/*
	 * // /* // * @RequestMapping(value = "form/login", params = "login", method =
	 * // * RequestMethod.POST) public String login(ModelMap model,
	 * HttpServletRequest // * request, @ModelAttribute("user") NguoiDungEntity
	 * user, BindingResult errors) // * throws Exception { // * // * // Lấy
	 * reCAPTCHA response từ request String recaptchaResponse = // *
	 * request.getParameter("g-recaptcha-response"); // Gọi hàm verify() từ // *
	 * RecaptchaService if (!recaptchaService.verify(recaptchaResponse)) { // *
	 * model.addAttribute("errorMessage", // *
	 * "reCAPTCHA xác thực không thành công. Vui lòng thử lại."); // * // * // Ghi
	 * log xác thực reCAPTCHA thất bại // *
	 * webActionLogService.logAction("Login attempt failed", // *
	 * "reCAPTCHA verification failed", user.getUserName(), request.getRemoteAddr(),
	 * // * request.getHeader("User-Agent"), "Medium"); // return "/user/login"; }
	 * // * // * // Xử lý đăng nhập boolean loi = true; // * // * // Kiểm tra
	 * username trống if (user.getUserName().isEmpty()) { // *
	 * errors.rejectValue("userName", "user", "Hãy nhập username hoặc email !!!");
	 * // * // * // Ghi log hành động nhập thiếu username // *
	 * logService.logSuspiciousActivity(user.getUserName(), "Username trống"); // *
	 * webActionLogService.logAction("Invalid login attempt", "Username trống", // *
	 * user.getUserName(), request.getRemoteAddr(), request.getHeader("User-Agent"),
	 * // * "Medium"); // * // * return "/user/login"; } // Kiểm tra password trống
	 * if // * (user.getPassWord().isEmpty()) { errors.rejectValue("passWord",
	 * "user", // * "Hãy nhập mật khẩu !!!"); // * // * // Ghi log hành động nhập
	 * thiếu password // * webActionLogService.logAction("Invalid login attempt",
	 * "Password trống", // * user.getUserName(), request.getRemoteAddr(),
	 * request.getHeader("User-Agent"), // * "Medium"); // * // * return
	 * "/user/login"; } // * // * // Kiểm tra tài khoản tồn tại NguoiDungEntity
	 * check = // * userService.findUserByNameAndEmail(user.getUserName(),
	 * user.getUserName()); // * // * if (check == null) {
	 * errors.rejectValue("passWord", "user", // *
	 * "Sai tài khoản hoặc mật khẩu !!!"); // * // * // Ghi log tài khoản không tồn
	 * tại // * webActionLogService.logAction("Invalid login attempt", // *
	 * "Account does not exist", user.getUserName(), request.getRemoteAddr(), // *
	 * request.getHeader("User-Agent"), "High"); loi = false; } // Kiểm tra mật khẩu
	 * // * else if (!userService.kiemTraMatKhau(user.getPassWord(), // *
	 * check.getPassWord())) { errors.rejectValue("passWord", "user", // *
	 * "Sai tài khoản hoặc mật khẩu !!!"); // * // * // Ghi log sai mật khẩu // *
	 * webActionLogService.logAction("Invalid login attempt", "Incorrect password",
	 * // * user.getUserName(), request.getRemoteAddr(),
	 * request.getHeader("User-Agent"), // * "High"); loi = false; } // Kiểm tra tài
	 * khoản bị khóa else if // * (!check.isTrangThai()) {
	 * errors.rejectValue("userName", "user", // *
	 * "Tài khoản của bạn đã bị khoá !!!"); // * // * // Ghi log tài khoản bị khóa
	 * // * logService.logAccountLockedAttempt(user.getUserName()); // *
	 * webActionLogService.logAction("Invalid login attempt", "Account is locked",
	 * // * user.getUserName(), request.getRemoteAddr(),
	 * request.getHeader("User-Agent"), // * "High"); loi = false; } // * // * if
	 * (!loi) { return "/user/login"; } // * // * // Lưu thông tin người dùng vào
	 * session HttpSession session = // * request.getSession();
	 * session.setAttribute("USER", check); // * // * // Ghi log đăng nhập thành
	 * công // * webActionLogService.logAction("Login successful", // *
	 * "User logged in successfully", user.getUserName(), request.getRemoteAddr(),
	 * // * request.getHeader("User-Agent"), "Low"); // * // * // Xác định quyền
	 * người dùng và chuyển hướng if (check.getQuyen() != 0) { // *
	 * UserContextHolder.setUserRole(request, "admin"); // *
	 * System.out.println("Set UserContextHolder role: admin"); return // *
	 * "redirect:/admin93123/index.htm"; } else { // *
	 * UserContextHolder.setUserRole(request, "user"); // *
	 * System.out.println("Set UserContextHolder role: user"); } // * // * return
	 * "redirect:/"; } //
	 */
	@RequestMapping(value = "form/login", params = "login", method = RequestMethod.POST)
	public String login(ModelMap model, HttpServletRequest request, @ModelAttribute("user") NguoiDungEntity user,
			BindingResult errors) throws Exception {

		// Lấy reCAPTCHA response từ request
		String recaptchaResponse = request.getParameter("g-recaptcha-response");
		// Gọi hàm verify() từ RecaptchaService
		if (!recaptchaService.verify(recaptchaResponse)) {
			model.addAttribute("errorMessage", "reCAPTCHA xác thực không thành công. Vui lòng thử lại.");
			return "/user/login";
		}

		// Xử lý đăng nhập
		boolean loi = true;

		if (user.getUserName().isEmpty()) {
			errors.rejectValue("userName", "user", "Hãy nhập username hoặc email !!!");
			return "/user/login";
		} else if (user.getPassWord().isEmpty()) {
			errors.rejectValue("passWord", "user", "Hãy nhập mật khẩu !!!");
			return "/user/login";
		}

		NguoiDungEntity check = userService.findUserByNameAndEmail(user.getUserName(), user.getUserName());

		if (check == null) {
			errors.rejectValue("passWord", "user", "Sai tài khoản hoặc mật khẩu !!!");
			loi = false;
		} else if (!userService.kiemTraMatKhau(user.getPassWord(), check.getPassWord())) {
			errors.rejectValue("passWord", "user", "Sai tài khoản hoặc mật khẩu !!!");
			loi = false;
		} else if (!check.isTrangThai()) {
			errors.rejectValue("userName", "user", "Tài khoản của bạn đã bị khoá !!!");
			loi = false;
		}

		if (!loi) {
			return "/user/login";
		}

		// Lưu thông tin người dùng vào session
		HttpSession session = request.getSession();
		session.setAttribute("USER", check);

		// Set quyền người dùng
		// Chuyển hướng dựa trên quyền
		if (check.getQuyen() != 0) {
			UserContextHolder.setUserRole(request, "admin");
			System.out.println("Set UserContextHolder role: admin");
			return "redirect:/admin93123/index.htm";
		} else {
			UserContextHolder.setUserRole(request, "user");
			System.out.println("Set UserContextHolder role: user");
		}

		return "redirect:/";
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	@RequestMapping(value = "form/signup", params = "signup", method = RequestMethod.POST)
	public String signUp(HttpServletRequest request, ModelMap model, @ModelAttribute("user") NguoiDungEntity user,
			BindingResult errors) throws Exception {
		// Lấy reCAPTCHA response từ request
		String recaptchaResponse = request.getParameter("g-recaptcha-response");
		// Gọi hàm verify() từ RecaptchaService
		if (!recaptchaService.verify(recaptchaResponse)) {
			model.addAttribute("errorMessage", "reCAPTCHA xác thực không thành công. Vui lòng thử lại.");
			return "/user/signup";
		}
		// ---co chinh sua
		String regex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[(@#$%^&+=!)])(?=.{8,}).*$";
		// -------

		Boolean loi = Boolean.TRUE;
		String rePassword = request.getParameter("re-passWord");
		NguoiDungEntity userCheck;
		// --chinh sua
		LocalTime hethan = LocalTime.now().plusSeconds(180);
		LocalTime batdau = LocalTime.now();
		int batdau_second = batdau.toSecondOfDay();
		int hethan_second = hethan.toSecondOfDay();
		int distance = hethan_second - batdau_second;
		String otp = taoOTP();

		// Regex patterns
		String emailRegex = "^[\\w._%+-]+@gmail\\.com$"; // Email phải là Gmail và đúng định dạng
		String usernameRegex = "^[a-zA-Z0-9._-]{1,30}$"; // Chỉ chữ, số, ., _, - và không quá 30 ký tự
		String nameRegex = "^[\\p{L}'\\- ]+$"; // Chỉ chứa ký tự Unicode và khoảng trắng
		String phoneRegex = "^[0-9]{10}$"; // 10 chữ số
		String addressRegex = "^[a-zA-Z0-9\\p{L}\\s,.-]+$"; // Loại bỏ ký tự đặc biệt như < > ' "

		if (user.getEmail().isEmpty()) {
			errors.rejectValue("email", "user", "Hãy nhập email !!!");
			loi = Boolean.FALSE;
		} else if (!user.getEmail().matches(emailRegex)) {
			errors.rejectValue("email", "user", "Hãy nhập email đúng định dạng (ví dụ: user@gmail.com) !!!");
			loi = Boolean.FALSE;
		}

		if (user.getUserName().isEmpty()) {
			errors.rejectValue("userName", "user", "Hãy nhập username !!!");
			loi = Boolean.FALSE;
		} else if (!user.getUserName().matches(usernameRegex)) {
			errors.rejectValue("userName", "user",
					"UserName không hợp lệ (không chứa ký tự nhạy cảm, tối đa 30 ký tự) !!!");
			loi = Boolean.FALSE;
		}

		userCheck = userService.findUserByNameAndEmail(user.getUserName(), user.getEmail());
		/*
		 * userCheck.setEmail(EncryptionUtil.decrypt(user.getEmail()));
		 * userCheck.setSdt(EncryptionUtil.decrypt(user.getSdt()));
		 */
		if (userCheck != null) {
			if (userCheck.getEmail().equals(user.getEmail())) {
				errors.rejectValue("email", "user", "Email đã được sử dụng !!!");
				loi = Boolean.FALSE;
			}
			if (userCheck.getUserName().equals(user.getUserName())) {
				errors.rejectValue("userName", "user", "Username đã được sử dụng !!!");
				loi = Boolean.FALSE;
			}
		}

		// ----co chinh sua
		String password = user.getPassWord();

		if (!password.matches(regex)) {
			loi = Boolean.FALSE;
			errors.rejectValue("passWord", "user", "Password sai định dạng");
		}
		// ---------

		if (user.getPassWord().isEmpty()) {
			errors.rejectValue("passWord", "user", "Hãy nhập mật khẩu !!!");
			loi = Boolean.FALSE;
		} else if (user.getPassWord().length() < 8) {
			errors.rejectValue("passWord", "user", "Password tối thiểu 8 kí tự !!!");
			loi = Boolean.FALSE;
		} else if (user.getPassWord().contains(" ")) {
			errors.rejectValue("passWord", "user", "Password không được chứa khoảng trắng !!!");
			loi = Boolean.FALSE;
		} else if (rePassword.isEmpty()) {
			errors.rejectValue("passWord", "user", "Hãy nhập lại mật khẩu !!!");
			loi = Boolean.FALSE;
		} else if (!rePassword.equals(user.getPassWord())) {
			errors.rejectValue("passWord", "user", "Xác nhận mật khẩu không đúng !!!");
			loi = Boolean.FALSE;
		}

		if (user.getHoTen().isEmpty()) {
			errors.rejectValue("hoTen", "user", "Hãy nhập họ tên !!!");
			loi = Boolean.FALSE;
		} else if (!user.getHoTen().matches(nameRegex)) {
			errors.rejectValue("hoTen", "user", "Họ tên chỉ chứa chữ cái và khoảng trắng !!!");
			loi = Boolean.FALSE;
		}

		if (user.getSdt().isEmpty()) {
			errors.rejectValue("sdt", "user", "Hãy nhập số điện thoại !!!");
			loi = Boolean.FALSE;
		} else if (!user.getSdt().matches(phoneRegex)) {
			errors.rejectValue("sdt", "user", "SDT phải gồm 10 chữ số !!!");
			loi = Boolean.FALSE;
		}

		if (user.getDiaChi().isEmpty()) {
			errors.rejectValue("diaChi", "user", "Hãy nhập địa chỉ !!!");
			loi = Boolean.FALSE;
		} else if (!user.getDiaChi().matches(addressRegex)) {
			errors.rejectValue("diaChi", "user", "Địa chỉ không hợp lệ (loại bỏ các ký tự nhạy cảm như < > ' \") !!!");
			loi = Boolean.FALSE;
		}

		if (loi == Boolean.FALSE)
			return "/user/signup";

		String NGAYSINH = request.getParameter("ngaySinh");
		java.sql.Date ns = java.sql.Date.valueOf(NGAYSINH);
		user.setPassWord(userService.maHoaMatKhau(user.getPassWord())); // Mã hóa mật khẩu
		user.setNgaySinh(ns);
		user.setHoTen(capitalizeString(user.getHoTen()));
		user.setTrangThai(true);
		user.setQuyen(0);
		HttpSession session = request.getSession();
		session.setAttribute("timer", distance);
		session.setAttribute("USERSIGNUP", user);
		session.setAttribute("OTP", otp);
		mailer.sendMailAsync("PtitPhoneShop", user.getEmail(), "OTP", "Mã OTP của bạn là: " + otp);
		return "/user/verify";
	}

	@RequestMapping(value = "form/forgotpass", params = "tieptheo", method = RequestMethod.POST)
	public String forgotPass(HttpServletRequest request, ModelMap model) throws Exception {
		// ----co chinh sua
		LocalTime hethan = LocalTime.now().plusSeconds(180);
		LocalTime batdau = LocalTime.now();
		int batdau_second = batdau.toSecondOfDay();
		int hethan_second = hethan.toSecondOfDay();
		int distance = hethan_second - batdau_second;
		String otp = taoOTP();

		String userName = request.getParameter("username");
		System.out.print(userName);
		// Lấy reCAPTCHA response từ request
		String recaptchaResponse = request.getParameter("g-recaptcha-response");
		// Gọi hàm verify() từ RecaptchaService
		if (!recaptchaService.verify(recaptchaResponse)) {
			model.addAttribute("errorMessage", "reCAPTCHA xác thực không thành công. Vui lòng thử lại.");
			return "/user/forgotpass";
		}

		if (userName.equals(null)) {
			model.addAttribute("errorMessage", "Hãy nhập Username/Email của bạn !!!");
			return "/user/forgotpass";
		}
		NguoiDungEntity user = userService.findUserByNameAndEmail(userName, userName);
		if (user == null) {
			model.addAttribute("errorMessage", "Không tìm thấy tài khoản !!!");
			return "/user/forgotpass";
		}
		HttpSession session = request.getSession();

		// ----co chinh sua
		session.setAttribute("username", userName);
		session.setAttribute("timer", distance);
		session.setAttribute("hethan", hethan_second);

		// ----------

		session.setAttribute("USERFORGOT", user);
		session.setAttribute("OTP", otp);
		mailer.sendMailAsync("PTIT PHONE SHOP", user.getEmail(), "OTP", "Mã OTP của bạn là: " + otp);
		model.addAttribute("email", "****" + user.getEmail().substring(user.getEmail().length() - 13));
		return "/user/verify2";
	}

	@RequestMapping(value = "form/verify", params = "verify", method = RequestMethod.POST)
	public String verify(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();

		// ---chinh sua
		flag--;
		session.setAttribute("OTP_times", flag);
		LocalTime batdau = LocalTime.now();
		int batdau_second = batdau.toSecondOfDay();
		int hethan_second = Integer.valueOf((session.getAttribute("hethan").toString()));
		int distance = hethan_second - batdau_second;

		String a = request.getParameter("a");
		String b = request.getParameter("b");
		String c = request.getParameter("c");
		String d = request.getParameter("d");
		String e = request.getParameter("e");
		String f = request.getParameter("f");

		String otp = session.getAttribute("OTP").toString();
		String temp = a + b + c + d + e + f;
		System.out.print("OTP: " + otp);
		System.out.print("temp: " + temp);
		if (otp.equals(temp)) {
			NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USERSIGNUP");
			System.out.print("USerDangKey: " + user);
			/*
			 * user.setEmail(EncryptionUtil.encrypt(user.getEmail()));
			 * user.setSdt(EncryptionUtil.encrypt(user.getSdt()));
			 */
			userService.addUser(user);
			model.addAttribute("user", new NguoiDungEntity()); // nếu nhập đúng OTP thì sẽ chuyển đến trang login
			return "/user/login";
		}
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USERSIGNUP");
		model.addAttribute("email", "****" + user.getEmail().substring(user.getEmail().length() - 13));

		model.addAttribute("messenger", "OTP bạn nhập không đúng !!!");
		return "/user/verify";
	}

	@RequestMapping(value = "form/verify2", params = "verify", method = RequestMethod.POST)
	public String verify2(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		// ----co chinh sua
		flag--;
		session.setAttribute("OTP_times", flag);
		LocalTime batdau = LocalTime.now();
		int batdau_second = batdau.toSecondOfDay();
		int hethan_second = Integer.valueOf((session.getAttribute("hethan").toString()));
		int distance = hethan_second - batdau_second;
		// --------------
		String a = request.getParameter("a");
		String b = request.getParameter("b");
		String c = request.getParameter("c");
		String d = request.getParameter("d");
		String e = request.getParameter("e");
		String f = request.getParameter("f");

		String otp = session.getAttribute("OTP").toString();
		String username = session.getAttribute("username").toString();

		String temp = a + b + c + d + e + f;

		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USERFORGOT");
		model.addAttribute("email", "****" + user.getEmail().substring(user.getEmail().length() - 13));
		// ----co chinh sua
		if (flag == 0) {
			return "/login";
		} else if (flag < 0) {
			flag = 3;
		}
		if (otp.equals(temp) && user.getUserName().equals(username)) {
			return "/user/newpass";
		} else {
			String otp_times = "Bạn còn " + flag + " lần nhập";
			model.addAttribute("messenger", "OTP bạn nhập không đúng !!!");
			model.addAttribute("otp", otp_times);
			model.addAttribute("timer", distance);
		}
		if (distance <= 0) {
			model.addAttribute("messenger", "OTP đã hết hạn");
			otp = taoOTP();
		}
		// -----------------------
		return "/user/verify2";
	}

	@RequestMapping(value = "form/verify", params = "again", method = RequestMethod.POST)
	public String guiLaiMa(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();

		LocalTime hethan = LocalTime.now().plusSeconds(180);
		int hethan_second = hethan.toSecondOfDay();
		String otp = taoOTP();
		session.setAttribute("OTP", otp);
		session.setAttribute("hethan", hethan_second);

		// ---- co chinh sua
		flag = 3;

		String recaptchaResponse = request.getParameter("g-recaptcha-response");
		// Gọi hàm verify() từ RecaptchaService
		if (!recaptchaService.verify(recaptchaResponse)) {
			NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USERSIGNUP");
			model.addAttribute("messenger", "reCAPTCHA xác thực không thành công. Vui lòng thử lại.");
			return "/user/verify";
		}
		session.setAttribute("OTP", otp);
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USERSIGNUP");
//		sendMail("THEGIOIDIENMAY", user.getEmail(), "OTP", "Mã OTP của bạn là: " + otp);
		mailer.sendMailAsync("THEGIOIDIENMAY", user.getEmail(), "OTP", "Mã OTP của bạn là: " + otp);
		model.addAttribute("email", "****" + user.getEmail().substring(user.getEmail().length() - 13));
		model.addAttribute("again", "OTP đã được gửi lại !!!");
		return "/user/verify";
	}

	@RequestMapping(value = "form/verify2", params = "again", method = RequestMethod.POST)
	public String guiLaiMa2(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		// ---co chinh sua
		LocalTime hethan = LocalTime.now().plusSeconds(180);
		int hethan_second = hethan.toSecondOfDay();
		String otp = taoOTP();
		session.setAttribute("OTP", otp);
		session.setAttribute("hethan", hethan_second);
		flag = 3;
		// ------
		// Lấy reCAPTCHA response từ request
		String recaptchaResponse = request.getParameter("g-recaptcha-response");
		// Gọi hàm verify() từ RecaptchaService
		if (!recaptchaService.verify(recaptchaResponse)) {
			NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USERSIGNUP");
			model.addAttribute("messenger", "reCAPTCHA xác thực không thành công. Vui lòng thử lại.");
			return "/user/verify2";
		}
		session.setAttribute("OTP", otp);
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USERFORGOT");
//		sendMail("THEGIOIDIENMAY", user.getEmail(), "OTP", "Mã OTP của bạn là: " + otp);
		mailer.sendMailAsync("THEGIOIDIENMAY", user.getEmail(), "OTP", "Mã OTP của bạn là: " + otp);
		model.addAttribute("email", "****" + user.getEmail().substring(user.getEmail().length() - 13));
		model.addAttribute("again", "OTP đã được gửi lại !!!");
		return "/user/verify2";
	}

	@RequestMapping(value = "form/newpass", params = "hoanTat", method = RequestMethod.POST)
	public String newPass(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();

		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USERFORGOT");
		String pass = request.getParameter("password");
		String confirmPass = request.getParameter("confirmPass");
		// ----chinh sua
		String username = session.getAttribute("username").toString();
		String regex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[(@#$%^&+=!)])(?=.{8,}).*$";
		if (!pass.matches(regex)) {
			model.addAttribute("errorMessage", "Mật khẩu sai định dạng !!!");
			return "/user/newpass";
		}
		// -----------------

		if (pass.isEmpty()) {
			model.addAttribute("errorMessage", "Mật khẩu không được trống !!!");
			return "/user/newpass";
		}
		if (!pass.equals(confirmPass)) {
			model.addAttribute("errorMessage", "Xác nhận mật khẩu không khớp !!!");
			return "/user/newpass";
		}
		if (pass.length() < 8) {
			model.addAttribute("errorMessage", "Mật khẩu phải hơn 8 kí tự !!!");
			return "/user/newpass";
		}
		if (pass.equals(confirmPass)) {

			user.setPassWord(userService.maHoaMatKhau(pass));

			userService.updateUser(user);

			model.addAttribute("user", new NguoiDungEntity());
			return "/user/login";
		}
		// ----chinh sua
		if (pass.equals(confirmPass) && user.getUserName().equals(username)) {

			user.setPassWord(userService.maHoaMatKhau(pass));

			userService.updateUser(user);

			model.addAttribute("user", new NguoiDungEntity());
			return "/user/login";
		}
		return "/user/newpass";
	}

	@RequestMapping("user/info")
	public String info(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USER");

		model.addAttribute("user", user);

		return "/user/user-info";
	}

	@RequestMapping(value = "form/info", params = "save", method = RequestMethod.POST)
	public String infoUpdate(HttpServletRequest request, ModelMap model, @ModelAttribute("user") NguoiDungEntity user,
			BindingResult errors) throws Exception {
		Boolean isValid = Boolean.TRUE;
		HttpSession session = request.getSession();
		NguoiDungEntity currentUser = (NguoiDungEntity) session.getAttribute("USER");

		// Giữ lại các thông tin không được chỉnh sửa
		user.setUserName(currentUser.getUserName());
		user.setEmail(currentUser.getEmail());
		user.setSdt(currentUser.getSdt());

		// Lấy ngày sinh từ request
		String ngaySinhInput = request.getParameter("ngaySinh");
		Date ngaySinh = null;
		try {
			ngaySinh = java.sql.Date.valueOf(ngaySinhInput);
			user.setNgaySinh(ngaySinh);
		} catch (IllegalArgumentException e) {
			model.addAttribute("loiNgaySinh", "Ngày sinh không hợp lệ!");
			isValid = Boolean.FALSE;
		}

		// Kiểm tra họ tên
		if (user.getHoTen().isEmpty()) {
			model.addAttribute("loiHoTen", "Họ tên không được để trống!");
			isValid = Boolean.FALSE;
		} else if (user.getHoTen().length() > 50) {
			model.addAttribute("loiHoTen", "Họ tên không được vượt quá 50 ký tự!");
			isValid = Boolean.FALSE;
		} else if (!user.getHoTen().matches("[\\p{L} ]+")) {
			model.addAttribute("loiHoTen", "Họ tên không hợp lệ, chỉ được chứa chữ cái!");
			isValid = Boolean.FALSE;
		}

		// Kiểm tra ngày sinh hợp lệ và lớn hơn 18 tuổi
		if (ngaySinh != null && !isValidAndOver18(new java.sql.Date(ngaySinh.getTime()))) {
			model.addAttribute("loiNgaySinh", "Bạn cần lớn hơn 18 tuổi!");
			isValid = Boolean.FALSE;
		}

		// Kiểm tra địa chỉ
		if (user.getDiaChi().isEmpty()) {
			model.addAttribute("loiDiaChi", "Địa chỉ không được để trống!");
			isValid = Boolean.FALSE;
		} else if (!user.getDiaChi().matches("^[\\p{L}0-9\\s\\-,./]+$")) {
			model.addAttribute("loiDiaChi", "Địa chỉ chỉ được chứa chữ cái, số, khoảng trắng và các ký tự: - , . /");
			isValid = Boolean.FALSE;
		} else if (user.getDiaChi().length() > 200) { // Giới hạn độ dài
			model.addAttribute("loiDiaChi", "Địa chỉ không được vượt quá 200 ký tự!");
			isValid = Boolean.FALSE;
		}

		// Nếu có lỗi, trả về lại trang thông tin với thông báo lỗi
		if (!isValid) {
			model.addAttribute("user", currentUser);
			return "/user/user-info";
		}

		// Cập nhật thông tin người dùng
		currentUser.setHoTen(user.getHoTen());
		currentUser.setGioiTinh(user.isGioiTinh());
		currentUser.setNgaySinh(user.getNgaySinh());
		currentUser.setDiaChi(user.getDiaChi());

		// Cập nhật vào database
		userService.updateUser(currentUser);

		NguoiDungEntity detachedUser = new NguoiDungEntity();
		detachedUser.setMaNd(currentUser.getMaNd());
		detachedUser.setUserName(currentUser.getUserName());
		detachedUser.setGioiTinh(currentUser.isGioiTinh());
		detachedUser.setHoTen(currentUser.getHoTen());
		detachedUser.setNgaySinh(currentUser.getNgaySinh());
		detachedUser.setAvatar(currentUser.getAvatar());
		detachedUser.setDiaChi(currentUser.getDiaChi());
		detachedUser.setSdt(DesEncrypt.desDecrypt(currentUser.getSdt(), DesEncrypt.desKey)); // Giải mã số điện thoại
		detachedUser.setEmail(AesEncrypt.aesDecrypt(currentUser.getEmail(), AesEncrypt.aesKey256)); // Giải mã email
		detachedUser.setPassWord(currentUser.getPassWord());
		detachedUser.setTrangThai(currentUser.isTrangThai());
		detachedUser.setQuyen(currentUser.getQuyen());
		detachedUser.setGioHangs(currentUser.getGioHangs());
		detachedUser.setDanhGiaList(currentUser.getDanhGiaList());
		detachedUser.setDonHangs(currentUser.getDonHangs());
		detachedUser.setYeuThichList(currentUser.getYeuThichList());

		// Cập nhật vào session
		session.setAttribute("USER", detachedUser);
		model.addAttribute("user", detachedUser);
		model.addAttribute("successMessage", "Cập nhật thông tin thành công!");
		return "/user/user-info";
	}

	@RequestMapping(value = "form/changePass.htm", params = "save", method = RequestMethod.POST)
	public String changePass(HttpServletRequest request, ModelMap model) {
		Boolean loi = Boolean.TRUE;
		HttpSession session = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USER");
		String pass = request.getParameter("password");
		String newPass = request.getParameter("newPassword");
		String reNewPass = request.getParameter("reNewPassword");

		// Kiểm tra mật khẩu cũ
		if (pass.isEmpty()) {
			model.addAttribute("loiPassword", "Hãy nhập mật khẩu cũ !!!");
			loi = Boolean.FALSE;

		} else if (!userService.kiemTraMatKhau(pass, user.getPassWord())) {
			model.addAttribute("loiPassword", "Mật khẩu cũ không đúng !!!");
			loi = Boolean.FALSE;
		}

		// Kiểm tra mật khẩu mới
		if (newPass.isEmpty()) {
			model.addAttribute("loiNewPassword", "Hãy nhập mật khẩu mới !!!");
			loi = Boolean.FALSE;
		} else if (newPass.length() < 8) {
			model.addAttribute("loiNewPassword", "Mật khẩu tối thiểu 8 kí tự !!!");
			loi = Boolean.FALSE;
		} else if (newPass.contains(" ")) {
			model.addAttribute("loiNewPassword", "Mật khẩu không được chứa khoảng trắng !!!");
			loi = Boolean.FALSE;
		} else if (reNewPass.isEmpty()) {
			model.addAttribute("loiRePassword", "Hãy nhập lại mật khẩu !!!");
			loi = Boolean.FALSE;
		} else if (!reNewPass.equals(newPass)) {
			model.addAttribute("loiRePassword", "Xác nhận mật khẩu không đúng !!!");
			loi = Boolean.FALSE;
		}

		// Nếu có lỗi, trả về trang user-info với thông tin lỗi
		if (!loi) {
			model.addAttribute("user", user); // Đảm bảo đối tượng user luôn được truyền vào model
			return "/user/user-info";
		}

		// Cập nhật mật khẩu mới
		user.setPassWord(userService.maHoaMatKhau(newPass));
		userService.updateUser(user);
		session.setAttribute("USER", user);

		model.addAttribute("user", user); // Thêm đối tượng user vào model để JSP binding
		model.addAttribute("successPassMessage", "Đổi mật khẩu thành công !!!");

		return "/user/user-info"; // Trả về trang user-info
	}

	@RequestMapping(value = "user/logout")
	public String logout(HttpServletRequest request, ModelMap model) {
		HttpSession session0 = request.getSession();
		UserContextHolder.clear(request); // Clear ThreadLocal
		session0.removeAttribute("USER");
		session0.removeAttribute("SANPHAM");
		session0.removeAttribute("NEWINFO");
		session0.invalidate();
		return "redirect:/";

	}

	public List<SanPhamEntity> laySanPhamTheoLoai(String loai) {
		Session session = factory.getCurrentSession();
		String hql = "FROM SanPhamEntity sp WHERE sp.loaiSanPham.maLoai = :loai ";
		Query query = session.createQuery(hql).setParameter("loai", loai);
		query.setMaxResults(6);
		List<SanPhamEntity> list = query.list();
		return list;
	}

	public boolean isValidAndOver18(java.sql.Date ngaySinh) {
		// Chuyển java.sql.Date thành java.util.Date
		java.util.Date utilDate = new java.util.Date(ngaySinh.getTime());

		// Chuyển java.util.Date thành LocalDate
		LocalDate dob = utilDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

		// Lấy ngày hiện tại
		LocalDate today = LocalDate.now();

		// Kiểm tra nếu tuổi lớn hơn hoặc bằng 18
		return !dob.isAfter(today.minusYears(18));
	}

	public static String capitalizeString(String str) {
		String[] words = str.split("\\s+");
		for (int i = 0; i < words.length; i++) {
			words[i] = words[i].substring(0, 1).toUpperCase() + words[i].substring(1);
		}
		return String.join(" ", words);
	}

	public String taoOTP() {

		// 0123456789qwertyuiopasdfghjkzxcvbnmQWERTYUOPLKJHGFDSAZXCVBNM
		String alphabelt = "0123456789qwertyuiopasdfghjkzxcvbnmQWERTYUOPLKJHGFDSAZXCVBNM";

		String otp = "";
		Random random = new Random();
		for (int i = 0; i < 6; i++) {
			otp += alphabelt.charAt(random.nextInt(60));
			/* otp += alphabelt.charAt(random.nextInt(alphabelt.length())); */ // full 0
		}

		return otp;
	}

}