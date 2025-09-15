package ptithcm.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import ptithcm.entity.DanhGiaEntity;
import ptithcm.entity.GioHangEntity;
import ptithcm.entity.NguoiDungEntity;
import ptithcm.entity.SanPhamEntity;
import ptithcm.entity.YeuThichEntity;
import ptithcm.service.DanhGiaService;
import ptithcm.service.RecaptchaService;
import ptithcm.service.SanPhamService;
import ptithcm.service.gioHangService;
import ptithcm.service.yeuThichService;

@Transactional
@Controller
@RequestMapping()
public class sanPhamController {

	@Autowired
	SanPhamService sanPhamService;
	@Autowired
	DanhGiaService danhGiaService;
	@Autowired
	gioHangService gioHangService;
	@Autowired
	yeuThichService yeuThichService;
	
	@Autowired
	RecaptchaService recaptchaService;
	

	@RequestMapping("/product/{maSp}")
	public String sanPham(@PathVariable("maSp") String maSp, ModelMap model, HttpServletRequest request) {
		// Lấy sản phẩm theo mã
		SanPhamEntity sanPham = sanPhamService.laySanPham(maSp);

		// Lấy các sản phẩm cùng loại
		List<SanPhamEntity> sanPhamCungKieu = sanPhamService.laySanPhamCungKieu(maSp);
		sanPhamCungKieu = sanPhamService.locSanPhamTrung(sanPhamCungKieu);
		model.addAttribute("sanPhamCungKieu", sanPhamCungKieu);

		// Lấy danh sách đánh giá của sản phẩm
		List<DanhGiaEntity> listDanhGia = danhGiaService.layDanhGiaSanPham(maSp);
		int count = listDanhGia.size();

		// Lấy danh sách màu sắc và bộ nhớ của sản phẩm
		List<String> mauSacList = sanPhamService.layDanhSachMauSac(sanPham.getTenSanPham()); // Dùng tên sản phẩm
		List<String> boNhoList = sanPhamService.layDanhSachBoNho(sanPham.getTenSanPham()); // Dùng tên sản phẩm

		// Thêm vào model để truyền ra view
		model.addAttribute("sanPham", sanPham);
		model.addAttribute("count", count);
		model.addAttribute("danhGiaList", listDanhGia);
		model.addAttribute("mauSacList", mauSacList);
		model.addAttribute("boNhoList", boNhoList);

		return "/sanPham/sanPham";
	}

	@RequestMapping(value = "themVaoGio/{maSp}")
	public String addToCart(@PathVariable("maSp") String maSp, ModelMap model, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		
		
        // Lấy reCAPTCHA response từ request
	    String recaptchaResponse = request.getParameter("g-recaptcha-response");
	    // Gọi hàm verify() từ RecaptchaService
	    if (!recaptchaService.verify(recaptchaResponse)) {
			redirectAttributes.addFlashAttribute("messenger", "Vui lòng nhập captcha!");
			return "redirect:/product/" + maSp; // Chuyển hướng về lại trang sản phẩm
	    }
		
		/* System.out.print("haha"+maSp); */
		SanPhamEntity selectedSanPham = sanPhamService.laySanPham(maSp);

		HttpSession session = request.getSession();
		int amount = Integer.parseInt(request.getParameter("soLuong"));;
		NguoiDungEntity user = (NguoiDungEntity) session.getAttribute("USER");

		if (user == null) {
			model.addAttribute("user", new NguoiDungEntity());
			return "user/login"; // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
		}

		/*
		 * SanPhamEntity selectedSanPham =
		 * sanPhamService.findSanPhamByAttributes(sanPham.getTenSanPham(), mauSac,
		 * boNhoTrong);
		 */
		/*
		 * if (selectedSanPham == null) {
		 * redirectAttributes.addFlashAttribute("messenger",
		 * "Sản phẩm với màu sắc và bộ nhớ được chọn không tồn tại!"); return
		 * "redirect:/product/" + maSp; // Chuyển hướng về lại trang sản phẩm }
		 */
		// Thêm vào giỏ hàng hoặc cập nhật giỏ hàng
		List<GioHangEntity> productsListInCart = gioHangService.layGioHangCuaUser(user.getMaNd());
		boolean alreadyInCart = false;
		
		
		if (selectedSanPham.getSoLuong() < amount) {
			redirectAttributes.addFlashAttribute("messenger", "Số lượng sản phẩm trong kho không đủ!");
			return "redirect:/product/" + maSp; // Chuyển hướng về lại trang sản phẩm
		}

		for (GioHangEntity gioHang : productsListInCart) {
			if (gioHang.getSanPham().equals(selectedSanPham)) {
				
				if(gioHang.getSoLuong() + amount>selectedSanPham.getSoLuong())
				{
					redirectAttributes.addFlashAttribute("messenger", "Số lượng SP không đủ đáp ứng yêu cầu của bạn, vui lòng kiểm tra giỏ hàng");
					return "redirect:/product/" + maSp; 
				}
				gioHang.setSoLuong(gioHang.getSoLuong() + amount);
				gioHangService.updateGioHang(gioHang);
				alreadyInCart = true;
				break;
			}
		}

		if (!alreadyInCart) {
			GioHangEntity gioHang = new GioHangEntity();
			gioHang.setNguoiDung(user);
			gioHang.setSanPham(selectedSanPham);
			gioHang.setSoLuong(amount);
			gioHangService.addGioHang(gioHang);
		}
		redirectAttributes.addFlashAttribute("messenger", "Thêm thành công !");
		return "redirect:/product/" + maSp; // Chuyển hướng về lại trang sản phẩm sau khi thêm giỏ hàng
	}

	@RequestMapping("themVaoYT/{maSP}")
	public String addYeuThich(@PathVariable("maSP") String maSp, ModelMap model, HttpServletRequest request) {
		SanPhamEntity sanPham = sanPhamService.laySanPham(maSp);
		HttpSession session0 = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session0.getAttribute("USER");
		if (user == null) {
			model.addAttribute("user", new NguoiDungEntity());
			System.out.println("Nguoi dung moi");
			return "user/login";
		}
		System.out.println("them vao YT");
		List<YeuThichEntity> yeuThichList = yeuThichService.layDSYeuThichCuaUser(user.getMaNd());
		boolean already = false;
		for (int i = 0; i < yeuThichList.size(); i++) {
			if (yeuThichList.get(i).getSanPham() == sanPham) {
				already = true;
				break;
			}
		}
		if (already == false) {
			YeuThichEntity yeuThich = new YeuThichEntity();
			yeuThich.setNguoiDung(user);
			yeuThich.setSanPham(sanPham);
			yeuThichService.addYeuThich(yeuThich);
		}

		List<SanPhamEntity> sanPhamCungKieu = sanPhamService.laySanPhamCungKieu(maSp);
		model.addAttribute("sanPhamCungKieu", sanPhamCungKieu);
		model.addAttribute("sanPham", sanPham);
		model.addAttribute(yeuThichList);
		return "sanPham/sanPham";
	}

	public class SizeComparator implements Comparator<String> {
		@Override
		public int compare(String size1, String size2) {
			// Xác định thứ tự ưu tiên của các size
			List<String> sizeOrder = List.of("S", "M", "L", "XL", "XXL");

			int index1 = sizeOrder.indexOf(size1);
			int index2 = sizeOrder.indexOf(size2);

			// So sánh dựa trên thứ tự ưu tiên
			return Integer.compare(index1, index2);
		}
	}

	@ResponseBody
	@RequestMapping(value = "/product/getMauSac", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String layMauSacTheoBoNho(@RequestParam("tenSanPham") String tenSanPham,
	                                 @RequestParam(value = "boNho", required = false) String boNho) {
	    List<String> result = boNho == null || boNho.isEmpty()
	                          ? sanPhamService.layDanhSachMauSac(tenSanPham)
	                          : sanPhamService.layDanhSachMauSacTheoBoNho(tenSanPham, boNho);
	    return new Gson().toJson(result); // Sử dụng Gson để serialize
	}

	@ResponseBody
	@RequestMapping(value = "/product/getBoNho", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String layBoNhoTheoMauSac(@RequestParam("tenSanPham") String tenSanPham,
	                                 @RequestParam(value = "mauSac", required = false) String mauSac) {
	    List<String> result = mauSac == null || mauSac.isEmpty()
	                          ? sanPhamService.layDanhSachBoNho(tenSanPham)
	                          : sanPhamService.layDanhSachBoNhoTheoMauSac(tenSanPham, mauSac);
	    return new Gson().toJson(result); // Sử dụng Gson để serialize danh sách
	}


	@ResponseBody
	@RequestMapping(value = "/test-json", produces = "application/json")
	public List<String> testJson() {
	    return List.of("Apple", "Orange", "Banana");
	}
	
	@ResponseBody
	@RequestMapping(value = "/product/getImageByAttributes", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String layHinhAnhTheoThuocTinh(@RequestParam("tenSanPham") String tenSanPham,
	                                      @RequestParam("mauSac") String mauSac,
	                                      @RequestParam("boNho") String boNho) {
	    // Tìm sản phẩm theo tên, màu sắc và bộ nhớ
	    SanPhamEntity sanPham = sanPhamService.findSanPhamByAttributes(tenSanPham, mauSac, boNho);
	    
	    // Khởi tạo các giá trị mặc định
	    String imageLink = "";
	    String maSP = "";
	    String soLuong = "";
	    String giamGia = "";
	    String donGia = "";
	    String soSaoTB = "";
	    String trangThai = "";
	    List<Map<String, Object>> danhGiaList = new ArrayList<>();  // Danh sách đánh giá (dạng Map hoặc DTO)

	    // Sử dụng if thay vì toán tử điều kiện
	    if (sanPham != null) {
	        if (sanPham.getHinhAnh() != null) {
	            imageLink = sanPham.getHinhAnh().getLink();
	        }
	        maSP = sanPham.getMaSP();
	        soLuong = String.valueOf(sanPham.getSoLuong());
	        giamGia = String.valueOf(sanPham.getGiamGia());
	        donGia = String.valueOf(sanPham.getDonGia());
	        soSaoTB = String.valueOf(sanPham.getSoSaoTB());
	        trangThai = String.valueOf(sanPham.getTrangThai());

	        // Xử lý danh sách đánh giá
	        for (DanhGiaEntity danhGiaEntity : sanPham.getDanhGiaList()) {
	            Map<String, Object> danhGiaMap = new HashMap<>();
	            danhGiaMap.put("soSao", danhGiaEntity.getSoSao());
	            danhGiaMap.put("noiDung", danhGiaEntity.getNoiDung());
	            danhGiaMap.put("nguoiDung", danhGiaEntity.getNguoiDung().getHoTen());  // Giả sử bạn muốn hiển thị tên người dùng
	            danhGiaMap.put("ngay", danhGiaEntity.getNgay());  // Ngày đánh giá (nếu có)

	            // Thêm vào danh sách đánh giá
	            danhGiaList.add(danhGiaMap);
	        }
	    }

	    // Tạo một Map để trả về cả thông tin sản phẩm và danh sách đánh giá
	    Map<String, Object> response = new HashMap<>();
	    response.put("maSP", maSP);
	    response.put("imageLink", imageLink);
	    response.put("soLuong", soLuong);
	    response.put("giamGia", giamGia);
	    response.put("donGia", donGia);
	    response.put("soSaoTB", soSaoTB);
	    response.put("mauSac", mauSac);  // Thêm màu sắc vào response
	    response.put("danhGia", danhGiaList);  
	    response.put("boNho", boNho);
	    response.put("trangThai", trangThai); // Danh sách đánh giá (mỗi đánh giá là một Map)

	    // Trả về đối tượng JSON chứa tất cả các thông tin
	    return new Gson().toJson(response);
	}







}
