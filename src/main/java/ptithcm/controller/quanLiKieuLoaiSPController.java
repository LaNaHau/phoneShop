package ptithcm.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.KieuSanPhamEntity;
import ptithcm.entity.LoaiSanPhamEntity;
import ptithcm.service.SanPhamService;
import ptithcm.service.loaiSanPhamService;
import ptithcm.service.KieuSanPhamService;

@Transactional
@Controller
@RequestMapping(value = "admin93123/brands/")
public class quanLiKieuLoaiSPController {

	@Autowired
	KieuSanPhamService KieuService;
	@Autowired
	loaiSanPhamService LoaiService;

	@RequestMapping(value = "addKieu", method = RequestMethod.GET)
	public String viewAddKieu(@ModelAttribute("brandForm") KieuSanPhamEntity brand, ModelMap model) {
		List<LoaiSanPhamEntity> listLoai = LoaiService.layLoai();
		model.addAttribute("listLoai", listLoai);

		return "admin93123/addKieu";
	}

	@RequestMapping(value = "addKieu", params = "add", method = RequestMethod.POST)
	public String addKieu(@ModelAttribute("brandForm") KieuSanPhamEntity brand, ModelMap model) throws IOException {
		String regex = "^[\\p{L}0-9 ]+$";
		// Kiểm tra regex
		if (!brand.getTenKieu().matches(regex)) {
			model.addAttribute("errorMessage",
					"Tên kiểu sản phẩm không hợp lệ. Chỉ được chứa chữ cái, số và khoảng trắng.");
			List<LoaiSanPhamEntity> listLoai = LoaiService.layLoai();
			model.addAttribute("listLoai", listLoai);
			return "admin93123/addKieu";
		}

		// Kiểm tra trùng tên kiểu sản phẩm
		if (KieuService.kiemTraTenKieuTonTai(brand.getTenKieu())) {
			model.addAttribute("errorMessage", "Tên kiểu sản phẩm đã tồn tại. Vui lòng nhập tên khác.");
			List<LoaiSanPhamEntity> listLoai = LoaiService.layLoai();
			model.addAttribute("listLoai", listLoai);
			return "admin93123/addKieu";
		}

		try {
			KieuService.themKieu(brand);
			model.addAttribute("successMessage", "Thêm thành công.");
		} catch (Exception e) {
			model.addAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
			return "admin93123/addKieu";
		}

		return "admin93123/addKieu";
	}

	@RequestMapping(value = "editKieu/{maKieu}", method = RequestMethod.GET)
	public String viewEditKieu(@PathVariable("maKieu") int maKieu, @ModelAttribute("brandForm") KieuSanPhamEntity brand,
			ModelMap model, HttpServletRequest request) {
		KieuSanPhamEntity Kieu = KieuService.layKieuTheoMa(maKieu);
		model.addAttribute("Kieu", Kieu);

		List<LoaiSanPhamEntity> listLoai = LoaiService.layLoai();
		model.addAttribute("listLoai", listLoai);

		return "admin93123/editKieu";
	}

	@RequestMapping(value = "editKieu/{maKieu}", params = "update", method = RequestMethod.POST)
	public String editKieu(@PathVariable("maKieu") int maKieu, @ModelAttribute("brandForm") KieuSanPhamEntity brand,
			ModelMap model) throws IOException {
		String regex = "^[\\p{L}0-9 ]+$";
		// Kiểm tra regex
		if (!brand.getTenKieu().matches(regex)) {
			model.addAttribute("errorMessage",
					"Tên kiểu sản phẩm không hợp lệ. Chỉ được chứa chữ cái, số và khoảng trắng.");
			List<LoaiSanPhamEntity> listLoai = LoaiService.layLoai();
			model.addAttribute("listLoai", listLoai);
			return "admin93123/editKieu";
		}

		// Kiểm tra trùng tên kiểu sản phẩm (ngoại trừ chính nó)
		KieuSanPhamEntity existingKieu = KieuService.layKieuTheoMa(maKieu);
		if (!existingKieu.getTenKieu().equals(brand.getTenKieu())
				&& KieuService.kiemTraTenKieuTonTai(brand.getTenKieu())) {
			model.addAttribute("errorMessage", "Tên kiểu sản phẩm đã tồn tại. Vui lòng nhập tên khác.");
			List<LoaiSanPhamEntity> listLoai = LoaiService.layLoai();
			model.addAttribute("listLoai", listLoai);
			return "admin93123/editKieu";
		}

		try {
			KieuService.updateKieu(brand);
			model.addAttribute("successMessage", "Cập nhật thành công.");
		} catch (Exception e) {
			model.addAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật: " + e.getMessage());
			return "admin93123/editKieu";
		}

		return "admin93123/editKieu";
	}

	@RequestMapping(value = "addLoai", method = RequestMethod.GET)
	public String viewAddLoai(@ModelAttribute("brandForm") LoaiSanPhamEntity brand, ModelMap model) {
		return "admin93123/addLoai";
	}

	@RequestMapping(value = "addLoai", params = "add", method = RequestMethod.POST)
	public String addLoai(@ModelAttribute("brandForm") LoaiSanPhamEntity brand, ModelMap model) throws IOException {
		String regex = "^[\\p{L}0-9 ]+$";

		// Kiểm tra regex
		if (!brand.getTenLoai().matches(regex)) {
			model.addAttribute("errorMessage",
					"Tên loại sản phẩm không hợp lệ. Chỉ được chứa chữ cái, số và khoảng trắng.");
			return "admin93123/addLoai";
		}

		// Kiểm tra trùng tên loại sản phẩm
		if (LoaiService.kiemTraTenLoaiTonTai(brand.getTenLoai())) {
			model.addAttribute("errorMessage", "Tên loại sản phẩm đã tồn tại. Vui lòng nhập tên khác.");
			return "admin93123/addLoai";
		}

		try {
			LoaiService.themLoai(brand);
			model.addAttribute("successMessage", "Thêm thành công.");
		} catch (Exception e) {
			model.addAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
			return "admin93123/addLoai";
		}

		return "admin93123/addLoai";
	}

	@RequestMapping(value = "editLoai/{maLoai}", method = RequestMethod.GET)
	public String viewEditLoai(@PathVariable("maLoai") String maLoai, ModelMap model, HttpServletRequest request) {
		LoaiSanPhamEntity Loai = LoaiService.layLoaiTheoMa(maLoai);
		model.addAttribute("Loai", Loai);
		return "admin93123/editLoai";
	}

	@RequestMapping(value = "editLoai/{maLoai}", params = "update", method = RequestMethod.POST)
	public String editLoai(@PathVariable("maLoai") String maLoai, ModelMap model, HttpServletRequest request)
			throws IOException {
		// Lấy giá trị từ request
		String maLoai1 = request.getParameter("maLoai");
		String tenLoai = request.getParameter("tenLoai");

		// Định nghĩa regex
		String regex = "^[\\p{L}0-9 ]+$";

		// Kiểm tra trường 'tenLoai' có hợp lệ hay không
		if (!tenLoai.matches(regex)) {
			model.addAttribute("errorMessage",
					"Tên loại sản phẩm không hợp lệ. Chỉ được chứa chữ cái, số và khoảng trắng.");
			LoaiSanPhamEntity Loai = LoaiService.layLoaiTheoMa(maLoai1);
			model.addAttribute("Loai", Loai); // Giữ lại thông tin hiện tại để hiển thị trên form
			return "admin93123/editLoai";
		}

		// Lấy đối tượng LoaiSanPhamEntity từ database
		LoaiSanPhamEntity Loai = LoaiService.layLoaiTheoMa(maLoai1);
		if (Loai == null) {
			model.addAttribute("errorMessage", "Không tìm thấy loại sản phẩm.");
			return "admin93123/editLoai";
		}

		// Kiểm tra trùng tên loại sản phẩm (ngoại trừ chính nó)
		if (!Loai.getTenLoai().equals(tenLoai) && LoaiService.kiemTraTenLoaiTonTai(tenLoai)) {
			model.addAttribute("errorMessage", "Tên loại sản phẩm đã tồn tại. Vui lòng nhập tên khác.");
			model.addAttribute("Loai", Loai); // Giữ lại thông tin hiện tại để hiển thị trên form
			return "admin93123/editLoai";
		}

		// Cập nhật giá trị
		Loai.setTenLoai(tenLoai);

		try {
			// Cập nhật vào database
			LoaiService.updateLoai(Loai);
			model.addAttribute("successMessage", "Cập nhật thành công.");
		} catch (Exception e) {
			model.addAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật: " + e.getMessage());
			return "admin93123/editLoai";
		}

		return "admin93123/editLoai";
	}

}
