package ptithcm.controller;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.entity.DonHangEntity;
import ptithcm.entity.NguoiDungEntity;
import ptithcm.service.CTDonHangService;
import ptithcm.service.DonHangService;
import ptithcm.service.SanPhamService;
import ptithcm.entity.SanPhamEntity;

@Transactional
@Controller
public class quanLiDonHangController {

	@Autowired
	SessionFactory factory;

	@Autowired
	DonHangService donHangService;

	@Autowired
	CTDonHangService ctDonHangService;
	
	@Autowired
	SanPhamService sanPhamService;

	@RequestMapping(value = "admin93123/order", method = RequestMethod.GET)
	public String product(ModelMap model, HttpServletRequest request) throws Exception {
		HttpSession session0 = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session0.getAttribute("USER");

		List<DonHangEntity> listDonHang = donHangService.layAllDonHang();
		model.addAttribute("listDonHang", listDonHang);

		return "admin93123/order";
	}

	@RequestMapping(value = "admin93123/order", params = "changeStatus2", method = RequestMethod.POST)
	public String chuyenDonHangSangDangGiao(HttpServletRequest request, RedirectAttributes redirectAttributes) throws Exception {//để lưu thông báo tạm thời và truyền lại trong quá trình redirect.
	    int maDonHang = Integer.parseInt(request.getParameter("maDonHangDuyet"));
	    int trangThai = Integer.parseInt(request.getParameter("trangThaiDonDuyet"));

	    if (trangThai == 1) { // Nếu trạng thái là "Chờ xác nhận"
	        DonHangEntity donHang = donHangService.timDonHangTheoMa(maDonHang);
	        boolean isValidForShipping = true;
	        for (SanPhamEntity sanPham : ctDonHangService.layDanhSachMaSanPhamTheoMaDH(Integer.toString(maDonHang))) {
	            if (!sanPham.getTrangThai()) {
	                isValidForShipping = false;
	                break;
	            }
	        }

	        if (isValidForShipping) {
	            donHang.setTrangThai(2); // Chuyển trạng thái đơn hàng sang "Đang giao"
	            donHangService.updateDonHang(donHang);
	            redirectAttributes.addFlashAttribute("successMessage", "Đơn hàng đã được chuyển sang trạng thái 'Đang giao'.");
	        } else {
	            redirectAttributes.addFlashAttribute("errorMessage", "Không thể chuyển đơn hàng sang 'Đang giao' vì một số sản phẩm không sẵn sàng.");
	        }
	    }

	    return "redirect:/admin93123/order.htm";
	}


	@RequestMapping(value = "admin93123/order", params = "changeStatus0", method = RequestMethod.POST)
	public String chuyenDonHangSangHuy(HttpServletRequest request) throws Exception {
		int maDonHang = Integer.parseInt(request.getParameter("maDonHangHuy"));
		int trangThai = Integer.parseInt(request.getParameter("trangThaiDonHuy"));

		if (trangThai == 1) { // Nếu trạng thái là "Chờ xác nhận"
			DonHangEntity donHang = donHangService.timDonHangTheoMa(maDonHang);
			donHang.setTrangThai(0);
	        // Lấy danh sách sản phẩm trong đơn hàng
	        List<SanPhamEntity> danhSachSanPham = ctDonHangService.layDanhSachMaSanPhamTheoMaDH(Integer.toString(maDonHang));

	        // Cập nhật lại số lượng sản phẩm trong kho
	        for (SanPhamEntity sanPham : danhSachSanPham) {
	            // Giả sử rằng bạn có phương thức để lấy số lượng sản phẩm đã mua từ chi tiết đơn hàng
	            int soLuongDaMua = ctDonHangService.laySoLuongSanPhamTrongDonHang(maDonHang, sanPham.getMaSP());

	            // Cập nhật lại số lượng sản phẩm trong kho (giả sử sanPhamService.updateSanPham là phương thức cập nhật sản phẩm)
	            sanPham.setSoLuong(sanPham.getSoLuong() + soLuongDaMua); // Thêm lại số lượng vào kho
	            sanPhamService.updateSanPham(sanPham); // Gọi phương thức update
	        }
			donHangService.updateDonHang(donHang);
		}

		return "redirect:/admin93123/order.htm";
	}
	
	@RequestMapping(value = "admin93123/order/search", method = RequestMethod.GET)
	public String search(
	        @RequestParam(value = "hoTen", required = false) String hoTen,
	        @RequestParam(value = "trangThai", required = false) Integer trangThai,
	        @RequestParam(value = "ngayTaoMin", required = false) String ngayTaoMin,
	        @RequestParam(value = "ngayTaoMax", required = false) String ngayTaoMax,
	        ModelMap model, HttpServletRequest request) throws Exception {

		
	    // Kiểm tra giá trị nhập vào cho hoTen không chứa ký tự đặc biệt
	    if (hoTen != null && !hoTen.trim().isEmpty()) {
	        // Biểu thức chính quy chỉ cho phép chữ cái (hoa và thường), dấu cách và dấu phẩy
	        if (!hoTen.matches("^[a-zA-Zàáảãạăắằẳẵặâấầẩẫậđèéẻẽẹêếềểễệìíỉĩịòóỏõọôốồổỗộơớờởỡợùúủũụưứừửữựýỷỹỵ\\s,]*$")) {
	            model.addAttribute("errorSearch", "Tên không được chứa ký tự đặc biệt.");
	            return "admin93123/order"; // Quay lại trang tìm kiếm với thông báo lỗi
	        }
	    }
		
	    // Chuyển đổi ngày tháng từ String sang Date nếu có
	    Date minDate = null;
	    Date maxDate = null;

	    try {
	        if (ngayTaoMin != null && !ngayTaoMin.isEmpty()) {
	            minDate = new SimpleDateFormat("yyyy-MM-dd").parse(ngayTaoMin); // Định dạng ngày theo kiểu yyyy-MM-dd
	        }
	        if (ngayTaoMax != null && !ngayTaoMax.isEmpty()) {
	            maxDate = new SimpleDateFormat("yyyy-MM-dd").parse(ngayTaoMax);
	        }
	    } catch (ParseException e) {
	        e.printStackTrace();
	        // Handle exception, return empty results or an error message if needed
	    }

	    // Gọi service để tìm kiếm đơn hàng theo các tham số đã chuyển đổi
	    List<DonHangEntity> listSearch = donHangService.timDonHangTheoTrangThaiVaThuocTinhKhac(trangThai, hoTen, minDate, maxDate);
	    
	    // Lấy danh sách tất cả đơn hàng để hiển thị trong bảng chính
	    List<DonHangEntity> listDonHang = donHangService.layAllDonHang();
	    
	    // Thêm danh sách tìm kiếm và danh sách chính vào model
	    model.addAttribute("listSearch", listSearch);
	    model.addAttribute("listDonHang", listDonHang);
	    
	    // Thêm các tham số tìm kiếm để hiển thị lại trong form tìm kiếm
	    model.addAttribute("hoTen", hoTen);
	    model.addAttribute("trangThai", trangThai);
	    model.addAttribute("ngayTaoMin", ngayTaoMin);
	    model.addAttribute("ngayTaoMax", ngayTaoMax);

	    return "admin93123/order"; // Tên file JSP
	}



	
	
}
