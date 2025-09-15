package ptithcm.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ptithcm.entity.DonHangEntity;
import ptithcm.entity.KieuSanPhamEntity;
import ptithcm.entity.LoaiSanPhamEntity;
import ptithcm.entity.SanPhamEntity;
import ptithcm.entity.VoucherEntity;
import ptithcm.service.DonHangService;
import ptithcm.service.VoucherService;

@Transactional
@Controller
public class quanLiVoucherController {
	@Autowired
	VoucherService voucherService;

	@Autowired
	DonHangService donHangService;

	@RequestMapping(value = "/admin93123/voucher/add", method = RequestMethod.GET)
	public String viewAddVoucher(ModelMap model, HttpServletRequest request) {
		model.addAttribute("voucherForm", new VoucherEntity());
		return "admin93123/addVoucher";
	}

	@RequestMapping(value = "/admin93123/voucher/add", params = "add", method = RequestMethod.POST)
	public String addVoucher(@ModelAttribute("vourcherForm") VoucherEntity voucher, ModelMap model) throws IOException {
		try {
			voucherService.themVoucher(voucher);

			// Thông báo thành công
			model.addAttribute("successMessage", "Thêm voucher thành công.");
		} catch (Exception e) {
			// Thông báo lỗi
			model.addAttribute("errorMessage", "Có lỗi xảy ra khi thêm voucher: " + e.getMessage());
			return "/admin93123/addVoucher";
		}

		return "redirect:/admin93123/product";
	}

	@RequestMapping(value = "/admin93123/voucher/edit/{maVoucher}", method = RequestMethod.GET)
	public String viewEditVoucher(@PathVariable("maVoucher") String maVoucher, ModelMap model,
			HttpServletRequest request) throws Exception {
		// Lấy thông tin voucher từ database
		VoucherEntity voucher = voucherService.layVoucherTheoMa(maVoucher);
		// Truyền dữ liệu vào model để hiển thị lên form
		model.addAttribute("voucher", voucher);
		return "admin93123/editVoucher";
	}

	@RequestMapping(value = "/admin93123/voucher/edit/{maVoucher}", params = "update", method = RequestMethod.POST)
	public String editVoucher(@PathVariable("maVoucher") String maVoucher,
			@ModelAttribute("voucher") VoucherEntity voucher, ModelMap model) {
		try {
			voucherService.updateVoucher(voucher);
			model.addAttribute("successMessage", "Cập nhật sản phẩm thành công.");
		} catch (Exception e) {
			model.addAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật voucher: " + e.getMessage());
			return "/admin93123/editVoucher";
		}
		return "redirect:/admin93123/product";
	}

	@RequestMapping(value = "admin93123/product", params = "deleteVoucher", method = RequestMethod.POST)
	public String deleteVoucher(HttpServletRequest request, ModelMap model) throws Exception {
		String maVoucher = request.getParameter("maVoucherXoa");
		VoucherEntity voucher = voucherService.layVoucherTheoMa(maVoucher);
		List<DonHangEntity> donhang = donHangService.layDonHangTheoMaVoucher(maVoucher);
		if (!donhang.isEmpty()) {
			model.addAttribute("errorMessageLoai", "Không thể xóa voucher vì có đơn hàng đang liên kết!");
			return "admin93123/product";
		} else {
			voucherService.xoaVoucher(voucher);
		}

		return "redirect:/admin93123/product.htm";
	}
}