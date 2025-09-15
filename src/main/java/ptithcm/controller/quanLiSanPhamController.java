package ptithcm.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.LinkedHashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.apache.commons.text.StringEscapeUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFPictureData;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.dto.SanPhamDTO;
import ptithcm.entity.HinhAnhEntity;
import ptithcm.entity.KieuSanPhamEntity;
import ptithcm.entity.LoaiSanPhamEntity;
import ptithcm.entity.NguoiDungEntity;
import ptithcm.entity.SanPhamEntity;
import ptithcm.service.KieuSanPhamService;
import ptithcm.service.SanPhamService;
import ptithcm.service.VoucherService;
import ptithcm.service.loaiSanPhamService;

@Transactional
@Controller
public class quanLiSanPhamController {

	@Autowired
	SanPhamService sanPhamService;
	@Autowired
	KieuSanPhamService kieuService;
	@Autowired
	loaiSanPhamService loaiService;

	@Autowired
	VoucherService voucherService;

//	@Autowired
//	ServletContext context;
	String filePath = "D:\\WS\\ShopDienThoai\\src\\main\\webapp\\assets\\img\\product\\"; // Đường dẫn tới thư mục lưu
																							// trữ tệp tin hình ảnh
	String imgXoaPath = "D:\\WS\\ShopDienThoai\\src\\main\\webapp\\"; // để xóa hình

	@RequestMapping(value = "/admin93123/product", method = RequestMethod.GET)
	public String product(ModelMap model, HttpServletRequest request) throws Exception {
		HttpSession session0 = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session0.getAttribute("USER");

		List<SanPhamEntity> allSanPhams = sanPhamService.laySanPhamMoi();

		// Group products by maSP
		Map<String, SanPhamDTO> sanPhamGroup = new LinkedHashMap<>();
		for (SanPhamEntity sp : allSanPhams) {
			String maSP = sp.getMaSP();

			// If the product group doesn't exist, create a new DTO
			if (!sanPhamGroup.containsKey(maSP)) {
				SanPhamDTO dto = new SanPhamDTO();
				dto.setMaSP(maSP);
				dto.setTenSanPham(sp.getTenSanPham());
				dto.setTrangThai(sp.getTrangThai());
				dto.setMauSacs(new ArrayList<>());
				dto.setDungLuongs(new ArrayList<>());
				dto.setGiaBan(new ArrayList<>());
				dto.setImages(new ArrayList<>()); // Add a list to hold images
				sanPhamGroup.put(maSP, dto);
			}

			// Add attributes to the DTO
			SanPhamDTO dto = sanPhamGroup.get(maSP);
			if (sp.getMauSac() != null)
				dto.getMauSacs().add(sp.getMauSac());
			if (sp.getRam() != null && sp.getBoNhoTrong() != null)
				dto.getDungLuongs().add(sp.getRam() + "/" + sp.getBoNhoTrong());
			if (sp.getDonGia() != null)
				dto.getGiaBan().add(sp.getDonGia());
			if (sp.getHinhAnh() != null && sp.getHinhAnh().getLink() != null)
				dto.getImages().add(sp.getHinhAnh().getLink()); // Add image link
		}

		// Randomly select an image for each product group
		for (SanPhamDTO dto : sanPhamGroup.values()) {
			if (!dto.getImages().isEmpty()) {
				Random random = new Random();
				int randomIndex = random.nextInt(dto.getImages().size());
				dto.setRandomImage(dto.getImages().get(randomIndex)); // Set a random image
			}
		}

		// Pass the grouped data to the view
		model.addAttribute("groupedSanPhams", sanPhamGroup.values());

		// Other lists
		model.addAttribute("listNgungBan", sanPhamService.layAllSanPhamDaNgungBan());
		model.addAttribute("listkieu", kieuService.layKieu());
		model.addAttribute("listLoai", loaiService.layLoai());
		model.addAttribute("listVoucher", voucherService.layVoucher());


		return "admin93123/product";
	}

	@RequestMapping(value = "/admin93123/product", params = "trainSP", method = RequestMethod.POST)
	public String trainSP(HttpServletRequest request, ModelMap model) throws IOException {

		boolean processCompleted = false; // Biến để kiểm tra quá trình đã hoàn thành hay chưa

		try {
			ProcessBuilder builder = new ProcessBuilder("cmd.exe", "/c",
					"cd D:\\WS\\ShopDienThoai\\src\\main\\python\\python & python store_vectors.py");
			builder.redirectErrorStream(true);
			Process p = builder.start();
			BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));

			System.out.println("test train");

			String line;
			while ((line = r.readLine()) != null) {
				System.out.println(line);
			}

			// Quá trình đã hoàn thành
			processCompleted = true;
		} catch (IOException e) {
			// Xử lý các ngoại lệ nếu cần
		}

		if (processCompleted) {
			System.out.println("Hoan thanh train");
			model.addAttribute("TrainMessage", "Hoàn thành train");
		} else {
			System.out.println("Chua hoan thanh hoac co loi!!!");
			model.addAttribute("TrainMessage", "Chưa hoàn thành hoặc có lỗi!!!");
		}

		HttpSession session0 = request.getSession();
		NguoiDungEntity user = (NguoiDungEntity) session0.getAttribute("USER");

		List<SanPhamEntity> listAllSanPham = sanPhamService.layAllSanPham();
		listAllSanPham = sanPhamService.locSanPhamTrung(listAllSanPham);
		model.addAttribute("listAllSanPham", listAllSanPham);

		List<SanPhamEntity> listSanPhamNgungBan = sanPhamService.layAllSanPhamDaNgungBan();
		model.addAttribute("listNgungBan", listSanPhamNgungBan);

		List<KieuSanPhamEntity> listkieu = kieuService.layKieu();
		model.addAttribute("listkieu", listkieu);

		List<LoaiSanPhamEntity> listLoai = loaiService.layLoai();
		model.addAttribute("listLoai", listLoai);
		return "admin93123/product";
	}

	@RequestMapping(value = "/admin93123/product", params = "changeStatus", method = RequestMethod.POST)
	public String updateTrangThaiSanPham(HttpServletRequest request) {
		String maSp = request.getParameter("maSPSuaTT");
		boolean trangThai = Boolean.parseBoolean(request.getParameter("trangThaiSp"));
		SanPhamEntity sanPham = sanPhamService.laySanPham(maSp);
		sanPham.setTrangThai(!trangThai); // set trạng thái sản phẩm từ "đang bán" sang "ngừng bán" hoặc ngược lại
		sanPhamService.updateSanPham(sanPham);

		return "redirect:/admin93123/product.htm";
	}

	@RequestMapping(value = "/admin93123/product/add", method = RequestMethod.GET)
	public String viewAddProduct(ModelMap model, HttpServletRequest request) {
		List<KieuSanPhamEntity> listkieu = kieuService.layKieu();
		model.addAttribute("listkieu", listkieu);
		model.addAttribute("productForm", new SanPhamEntity());
		return "admin93123/addProduct";
	}

	@RequestMapping(value = "/admin93123/product/add", params = "add", method = RequestMethod.POST)
	public String addProduct(@ModelAttribute("productForm") SanPhamEntity product,
	                         @RequestParam("avatar") MultipartFile avatar, 
	                         ModelMap model) throws IOException {

	    // Kiểm tra mã sản phẩm có tồn tại hay không
	    if (sanPhamService.kiemTraMaSanPhamTonTai(product.getMaSP())) {
	        // Nếu mã sản phẩm đã tồn tại, trả về thông báo lỗi
	        model.addAttribute("errorMessage", "Mã sản phẩm đã tồn tại. Vui lòng nhập mã sản phẩm khác.");
	        List<KieuSanPhamEntity> listkieu = kieuService.layKieu();
	        model.addAttribute("listkieu", listkieu);
	        return "/admin93123/addProduct";  // Trả về trang thêm sản phẩm với thông báo lỗi
	    }

	    // Lấy ngày hiện tại
	    Date today = new Date();
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	    String now = formatter.format(today);

	    // Xử lý tên file ảnh
	    String avatarFileName = product.getMaSP() + "_" + now + ".jpg";
	    String avatarFilePath = filePath + avatarFileName;
	    File avatarFile = new File(avatarFilePath);

	    try {
	        // Lưu file ảnh lên server
	        avatar.transferTo(avatarFile);

	        // Tạo đối tượng hình ảnh
	        HinhAnhEntity hinhAnh = new HinhAnhEntity();
	        hinhAnh.setLink("assets/img/product/" + avatarFileName);
	        sanPhamService.themHinhAnhSanPham(hinhAnh);

	        // Thiết lập hình ảnh và ngày thêm cho sản phẩm
	        product.setHinhAnh(hinhAnh);
	        product.setNgayThem(today);
	        
	        String moTa = StringEscapeUtils.escapeHtml4(product.getMoTa());
	        product.setMoTa(moTa);

	        // Lưu sản phẩm
	        sanPhamService.themSanPham(product);

	        // Thông báo thành công
	        model.addAttribute("successMessage", "Thêm sản phẩm thành công.");
	    } catch (Exception e) {
	        // Thông báo lỗi
	        model.addAttribute("errorMessage", "Có lỗi xảy ra khi thêm sản phẩm: " + e.getMessage());
	        return "/admin93123/addProduct";  // Trả về trang thêm sản phẩm với thông báo lỗi
	    }

	    return "redirect:/admin93123/product";  // Redirect đến trang sản phẩm sau khi thêm thành công
	}


	@RequestMapping(value = "/admin93123/product/edit/{masp}", method = RequestMethod.GET)
	public String viewEditProduct(@PathVariable("masp") String masp, ModelMap model, HttpServletRequest request) {

		// Lấy thông tin sản phẩm từ database
		SanPhamEntity sanPham = sanPhamService.laySanPham(masp);

		// Lấy danh sách kiểu sản phẩm
		List<KieuSanPhamEntity> listkieu = kieuService.layKieu();

		// Truyền dữ liệu vào model để hiển thị lên form
		model.addAttribute("sanPham", sanPham);
		model.addAttribute("listkieu", listkieu);
		model.addAttribute("product", sanPham); // Dùng để liên kết với thẻ Spring Form

		return "admin93123/editProduct";
	}

	@RequestMapping(value = "/admin93123/product/edit/{masp}", params = "update", method = RequestMethod.POST)
	public String editProduct(@PathVariable("masp") String masp, @ModelAttribute("product") SanPhamEntity product,
			@RequestParam("avatar") MultipartFile avatar, ModelMap model) {

		try {
			// Lấy sản phẩm hiện tại từ database
			SanPhamEntity oldProduct = sanPhamService.laySanPham(masp);
			if (oldProduct == null) {
				model.addAttribute("errorMessage", "Sản phẩm không tồn tại.");
				return "/admin93123/editProduct";
			}

			// Kiểm tra các giá trị nhập vào
			if (product.getDonGia() == null || product.getDonGia().compareTo(BigDecimal.ZERO) < 0) {
				model.addAttribute("errorMessage", "Đơn giá không hợp lệ.");
				return "/admin93123/editProduct";
			}

			if (product.getSoLuong() == null || product.getSoLuong() < 0) {
				model.addAttribute("errorMessage", "Số lượng không hợp lệ.");
				return "/admin93123/editProduct";
			}

			// Cập nhật các thông tin sản phẩm
			oldProduct.setTenSanPham(product.getTenSanPham());
			oldProduct.setMoTa(product.getMoTa());
			oldProduct.setSoLuong(product.getSoLuong());
			oldProduct.setDonGia(product.getDonGia());
			oldProduct.setManHinh(product.getManHinh());
			oldProduct.setKichThuocManHinh(product.getKichThuocManHinh());
			oldProduct.setDoPhanGiai(product.getDoPhanGiai());
			oldProduct.setCameraSau(product.getCameraSau());
			oldProduct.setCameraTruoc(product.getCameraTruoc());
			oldProduct.setCpu(product.getCpu());
			oldProduct.setRam(product.getRam());
			oldProduct.setBoNhoTrong(product.getBoNhoTrong());
			oldProduct.setPin(product.getPin());
			oldProduct.setHeDieuHanh(product.getHeDieuHanh());
			oldProduct.setMauSac(product.getMauSac());
			oldProduct.setCongKetNoi(product.getCongKetNoi());
			oldProduct.setKetNoiKhac(product.getKetNoiKhac());
			oldProduct.setKichThuoc(product.getKichThuoc());
			oldProduct.setTrongLuong(product.getTrongLuong());
			oldProduct.setTrangThai(product.getTrangThai());
			oldProduct.setGiamGia(product.getGiamGia());

			// Xử lý thay đổi hình ảnh (nếu có)
			if (!avatar.isEmpty()) {
				String avatarFileName = product.getMaSP() + "_"
						+ new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
				String avatarFilePath = filePath + avatarFileName;
				File avatarFile = new File(avatarFilePath);

				if (!avatarFile.getParentFile().exists()) {
					avatarFile.getParentFile().mkdirs();
				}

				avatar.transferTo(avatarFile);

				if (oldProduct.getHinhAnh() != null) {
					oldProduct.getHinhAnh().setLink("assets/img/product/" + avatarFileName);
					sanPhamService.suaHinhAnhSanPham(oldProduct.getHinhAnh());
				} else {
					HinhAnhEntity newImage = new HinhAnhEntity();
					newImage.setLink("assets/img/product/" + avatarFileName);
					sanPhamService.themHinhAnhSanPham(newImage);
					oldProduct.setHinhAnh(newImage);
				}
			}

			// Cập nhật sản phẩm
			sanPhamService.updateSanPham(oldProduct);

			model.addAttribute("successMessage", "Cập nhật sản phẩm thành công.");
			return "redirect:/admin93123/product";

		} catch (IOException e) {
			model.addAttribute("errorMessage", "Lỗi khi xử lý ảnh: " + e.getMessage());
			return "/admin93123/editProduct";
		} catch (Exception e) {
			model.addAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật sản phẩm: " + e.getMessage());
			return "/admin93123/editProduct";
		}
	}

	/*
	 * @RequestMapping(value = "/admin93123/product/addSize", method = RequestMethod.GET)
	 * public String viewAddNewSizeProductForm(ModelMap model, HttpServletRequest
	 * request) { HttpSession session = request.getSession(); SanPhamEntity
	 * spThemSize = (SanPhamEntity) session.getAttribute("spThemSize"); return
	 * "admin93123/addSize"; }
	 */

	/*
	 * @RequestMapping(value = "/admin93123/product/addSize", params = "add", method =
	 * RequestMethod.POST) public String
	 * AddNewSizeProductForm(@ModelAttribute("productForm") SanPhamEntity product,
	 * ModelMap model, HttpServletRequest request, @RequestParam("sizemoi") String
	 * sizemoi, @RequestParam("gia") int gia,
	 * 
	 * @RequestParam("soluong") int soluong) {
	 * 
	 * HttpSession session = request.getSession(); SanPhamEntity spThemSize =
	 * (SanPhamEntity) session.getAttribute("spThemSize");
	 * 
	 * product = spThemSize; String maSP = spThemSize.getMaSP(); int lastIndex =
	 * maSP.lastIndexOf("_"); // Tìm vị trí cuối cùng của dấu gạch String maSPMoi =
	 * maSP.substring(0, lastIndex); product.setSize(sizemoi);
	 * product.setMaSP(maSPMoi + "_" + sizemoi); product.setSoLuong(soluong);
	 * product.setDonGia(gia); Date today = new Date(); product.setNgayThem(today);
	 * try { sanPhamService.themSanPham(product);
	 * model.addAttribute("successMessage", "Thêm thành công."); } catch (Exception
	 * e) { model.addAttribute("errorMessage", "Có lỗi xảy ra khi thêm" +
	 * e.getMessage()); return "/admin93123/addSize"; }
	 * 
	 * // session.removeAttribute("spThemSize"); // return
	 * "redirect:/admin93123/product/addSize.htm"; return "admin93123/addSize"; }
	 */

	public void xoaTepTinHinhAnh(String tenTep) {
		String imgPath = imgXoaPath + tenTep; // Đường dẫn tới thư mục chứa hình ảnh
		File tepTin = new File(imgPath);

		if (tepTin.exists()) {
			tepTin.delete(); // Xóa tệp tin hình ảnh từ server
		}
	}

	@RequestMapping(value = "admin93123/product", params = "deleteSP", method = RequestMethod.POST)
	public String deleteSanPham(HttpServletRequest request, ModelMap model) {
		String maSp = request.getParameter("maSPXoa");
		SanPhamEntity sanPham = sanPhamService.laySanPham(maSp);

		boolean coGioHangLienKet = sanPhamService.kiemTraSanPhamCoNamTrongGioHang(maSp);
		boolean coDonHangLienKet = sanPhamService.kiemTraSanPhamCoNamTrongDonHang(maSp);

		if (coGioHangLienKet) {
			model.addAttribute("errorMessageXoaSP", "Không thể xóa sản phẩm vì đang nằm trong giỏ hàng!");
			return "admin93123/product";
		} else if (coDonHangLienKet) {
			model.addAttribute("errorMessageXoaSP", "Không thể xóa sản phẩm vì đang nằm đơn hàng!");
			return "admin93123/product";
		} else {

			// Xóa hình sản phẩm trong cơ sở dữ liệu
			sanPhamService.xoaHinhAnhSanPham(sanPham.getHinhAnh());
			// Xóa hình đại diện
			String hinhAnhDaiDien = sanPham.getHinhAnh().getLink();
			if (hinhAnhDaiDien != null) {
				xoaTepTinHinhAnh(hinhAnhDaiDien);
			}

			// Xóa sản phẩm trong cơ sở dữ liệu
			sanPhamService.xoaSanPham(sanPham);

		}

		return "redirect:/admin93123/product.htm";
	}

	@RequestMapping(value = "admin93123/product", params = "deleteKieu", method = RequestMethod.POST)
	public String deleteKieu(HttpServletRequest request, ModelMap model) {
		int maKieu = Integer.parseInt(request.getParameter("maKieuXoa"));
		KieuSanPhamEntity kieu = kieuService.layKieuTheoMa(maKieu);

		boolean coSanPhamLienKet = kieuService.kiemTraSanPhamTheoKieu(maKieu);

		if (coSanPhamLienKet) {
			model.addAttribute("errorMessageKieu", "Không thể xóa kiểu vì có sản phẩm đang liên kết!");
			return "admin93123/product";
		} else
			kieuService.xoaKieu(kieu);

		return "redirect:/admin93123/product.htm";
	}

	@RequestMapping(value = "admin93123/product", params = "deleteLoai", method = RequestMethod.POST)
	public String deleteLoai(HttpServletRequest request, ModelMap model) {
		String maLoai = request.getParameter("maLoaiXoa");
		LoaiSanPhamEntity loai = loaiService.layLoaiTheoMa(maLoai);

		boolean coKieuLienKet = loaiService.kiemTraLoai(maLoai);

		if (coKieuLienKet) {
			model.addAttribute("errorMessageLoai", "Không thể xóa loại vì có kiểu đang liên kết!");
			return "admin93123/product";
		} else
			loaiService.xoaLoai(loai);

		return "redirect:/admin93123/product.htm";
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
	
	@RequestMapping(value = "/admin93123/product/addByFile", method = RequestMethod.GET)
	public String viewAddProductByFile(ModelMap model, HttpServletRequest request) {
		return "admin93123/addProductByFile";
	}

	// Phương thức lưu file ảnh
	private String saveImage(byte[] imageData, String maSP, Date ngayThem) throws IOException {
	    // Đường dẫn lưu ảnh
	    Path directoryPath = Paths.get(filePath);
	    if (!Files.exists(directoryPath)) {
	        Files.createDirectories(directoryPath); // Tạo thư mục nếu chưa tồn tại
	    }

	    // Tạo tên file duy nhất
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	    String timestamp = formatter.format(ngayThem);
	    String fileName = maSP + "_" + timestamp + ".jpg";
	    Path imagePath = directoryPath.resolve(fileName);

	    // Lưu file
	    Files.write(imagePath, imageData);

	    // Trả về link để lưu vào DB
	    return "assets/img/product/" + fileName;
	}

	@RequestMapping(value = "/admin93123/product/addByFile", method = RequestMethod.POST)
	public String uploadFile(@RequestParam("file") MultipartFile file, ModelMap model) {
	    try (InputStream inputStream = file.getInputStream();
	         Workbook workbook = new XSSFWorkbook(inputStream)) {

	        Sheet sheet = workbook.getSheetAt(0);
	        List<XSSFPictureData> pictures = ((XSSFWorkbook) workbook).getAllPictures();
	        List<SanPhamEntity> sanPhamList = new ArrayList<>();

	        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
	            Row row = sheet.getRow(i);
	            SanPhamEntity sanPham = new SanPhamEntity();
	            HinhAnhEntity hinhAnh = new HinhAnhEntity();

	            KieuSanPhamEntity kieu = kieuService.layKieuTheoMa((int) row.getCell(6).getNumericCellValue());

	            // Đọc các trường từ Excel
	            sanPham.setMaSP(row.getCell(0).getStringCellValue());
	            sanPham.setTenSanPham(row.getCell(1).getStringCellValue());
	            sanPham.setMoTa(row.getCell(2).getStringCellValue());
	            sanPham.setSoLuong((int) row.getCell(3).getNumericCellValue());
	            sanPham.setDonGia(BigDecimal.valueOf(row.getCell(4).getNumericCellValue()));
	            sanPham.setTrangThai(row.getCell(5).getNumericCellValue() == 1.0);
	            sanPham.setMaKieu(kieu);
	            if (row.getCell(7).getStringCellValue().equals("")) {
	            	sanPham.setSoSaoTB(0);
	            }else {
	            	sanPham.setSoSaoTB(Float.parseFloat(row.getCell(7).getStringCellValue()));
	            }
	            sanPham.setNgayThem(row.getCell(8).getDateCellValue());

	            // Kiểm tra và lưu hình ảnh nếu có
	            if (i - 1 < pictures.size()) {
	                XSSFPictureData pictureData = pictures.get(i - 1);
	                byte[] imageData = pictureData.getData();

	                // Lưu file ảnh và lấy link
	                String imageLink = saveImage(imageData, sanPham.getMaSP(), sanPham.getNgayThem());
	                hinhAnh.setLink(imageLink);
	                sanPhamService.themHinhAnhSanPham(hinhAnh);
	            } else {
	                hinhAnh = null;
	            }

	            sanPham.setHinhAnh(hinhAnh);

	            // Đọc các trường khác
	            sanPham.setManHinh(row.getCell(10).getStringCellValue());
	            sanPham.setKichThuocManHinh(row.getCell(11).getStringCellValue());
	            sanPham.setDoPhanGiai(row.getCell(12).getStringCellValue());
	            sanPham.setCameraSau(row.getCell(13).getStringCellValue());
	            sanPham.setCameraTruoc(row.getCell(14).getStringCellValue());
	            sanPham.setCpu(row.getCell(15).getStringCellValue());
	            sanPham.setRam(row.getCell(16).getStringCellValue());
	            sanPham.setBoNhoTrong(row.getCell(17).getStringCellValue());
	            sanPham.setPin(row.getCell(18).getStringCellValue());
	            sanPham.setHeDieuHanh(row.getCell(19).getStringCellValue());
	            sanPham.setMauSac(row.getCell(20).getStringCellValue());
	            sanPham.setCongKetNoi(row.getCell(21).getStringCellValue());
	            sanPham.setKetNoiKhac(row.getCell(22).getStringCellValue());
	            sanPham.setKichThuoc(row.getCell(23).getStringCellValue());
	            sanPham.setTrongLuong(row.getCell(24).getStringCellValue());
	            if ((int) row.getCell(25).getNumericCellValue() == 0) {
	            sanPham.setGiamGia(null);
	            } else {
	            	sanPham.setGiamGia((int) row.getCell(25).getNumericCellValue());
	            }

	            sanPhamList.add(sanPham);
	        }

	        sanPhamService.themListSanPham(sanPhamList); // Lưu danh sách sản phẩm vào DB
	        model.addAttribute("successMessage", "Thêm sản phẩm thành công.");
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("errorMessage", "Có lỗi xảy ra khi thêm sản phẩm.");
	    }

	    return "redirect:/admin93123/product";
	}
	
	@RequestMapping(value = "admin93123/product/search", method = RequestMethod.GET)
	public String search(
	        @RequestParam(value = "tenSanPham", required = false) String tenSanPham,
	        ModelMap model, HttpServletRequest request) throws Exception {

		
		
		if (tenSanPham != null && !tenSanPham.trim().isEmpty()) {
		    // Biểu thức chính quy cho phép chữ cái (hoa và thường), dấu cách, dấu phẩy và chữ số
		    if (!tenSanPham.matches("^[a-zA-Zàáảãạăắằẳẵặâấầẩẫậđèéẻẽẹêếềểễệìíỉĩịòóỏõọôốồổỗộơớờởỡợùúủũụưứừửữựýỷỹỵ0-9\\s,]*$")) {
		        model.addAttribute("errorSearch", "Tên không được chứa ký tự đặc biệt.");
		        return "admin93123/product"; // Quay lại trang tìm kiếm với thông báo lỗi
		    }
		}

	    // Gọi service để tìm kiếm đơn hàng theo các tham số đã chuyển đổi
	    List<SanPhamEntity> listSearch = sanPhamService.laySanPhamTheoTens(tenSanPham);
	    
	    
	 // Group products by maSP
	 		Map<String, SanPhamDTO> searchGroup = new LinkedHashMap<>();
	 		for (SanPhamEntity sp : listSearch) {
	 			String maSP = sp.getMaSP();

	 			// If the product group doesn't exist, create a new DTO
	 			if (!searchGroup.containsKey(maSP)) {
	 				SanPhamDTO dto = new SanPhamDTO();
	 				dto.setMaSP(maSP);
	 				dto.setTenSanPham(sp.getTenSanPham());
	 				dto.setTrangThai(sp.getTrangThai());
	 				dto.setMauSacs(new ArrayList<>());
	 				dto.setDungLuongs(new ArrayList<>());
	 				dto.setGiaBan(new ArrayList<>());
	 				dto.setImages(new ArrayList<>()); // Add a list to hold images
	 				searchGroup.put(maSP, dto);
	 			}

	 			// Add attributes to the DTO
	 			SanPhamDTO dto = searchGroup.get(maSP);
	 			if (sp.getMauSac() != null)
	 				dto.getMauSacs().add(sp.getMauSac());
	 			if (sp.getRam() != null && sp.getBoNhoTrong() != null)
	 				dto.getDungLuongs().add(sp.getRam() + "/" + sp.getBoNhoTrong());
	 			if (sp.getDonGia() != null)
	 				dto.getGiaBan().add(sp.getDonGia());
	 			if (sp.getHinhAnh() != null && sp.getHinhAnh().getLink() != null)
	 				dto.getImages().add(sp.getHinhAnh().getLink()); // Add image link
	 		}
	    
	 		
	 		for (SanPhamDTO dto : searchGroup.values()) {
				if (!dto.getImages().isEmpty()) {
					Random random = new Random();
					int randomIndex = random.nextInt(dto.getImages().size());
					dto.setRandomImage(dto.getImages().get(randomIndex)); // Set a random image
				}
			}
	 		
	    // Lấy danh sách tất cả đơn hàng để hiển thị trong bảng chính
	    List<SanPhamEntity> allSanPhams = sanPhamService.laySanPhamMoi();

		// Group products by maSP
		Map<String, SanPhamDTO> sanPhamGroup = new LinkedHashMap<>();
		for (SanPhamEntity sp : allSanPhams) {
			String maSP = sp.getMaSP();

			// If the product group doesn't exist, create a new DTO
			if (!sanPhamGroup.containsKey(maSP)) {
				SanPhamDTO dto = new SanPhamDTO();
				dto.setMaSP(maSP);
				dto.setTenSanPham(sp.getTenSanPham());
				dto.setTrangThai(sp.getTrangThai());
				dto.setMauSacs(new ArrayList<>());
				dto.setDungLuongs(new ArrayList<>());
				dto.setGiaBan(new ArrayList<>());
				dto.setImages(new ArrayList<>()); // Add a list to hold images
				sanPhamGroup.put(maSP, dto);
			}

			// Add attributes to the DTO
			SanPhamDTO dto = sanPhamGroup.get(maSP);
			if (sp.getMauSac() != null)
				dto.getMauSacs().add(sp.getMauSac());
			if (sp.getRam() != null && sp.getBoNhoTrong() != null)
				dto.getDungLuongs().add(sp.getRam() + "/" + sp.getBoNhoTrong());
			if (sp.getDonGia() != null)
				dto.getGiaBan().add(sp.getDonGia());
			if (sp.getHinhAnh() != null && sp.getHinhAnh().getLink() != null)
				dto.getImages().add(sp.getHinhAnh().getLink()); // Add image link
		}

		// Randomly select an image for each product group
		for (SanPhamDTO dto : sanPhamGroup.values()) {
			if (!dto.getImages().isEmpty()) {
				Random random = new Random();
				int randomIndex = random.nextInt(dto.getImages().size());
				dto.setRandomImage(dto.getImages().get(randomIndex)); // Set a random image
			}
		}

		// Pass the grouped data to the view
		model.addAttribute("groupedSanPhams", sanPhamGroup.values());

		// Other lists
		model.addAttribute("listNgungBan", sanPhamService.layAllSanPhamDaNgungBan());
		model.addAttribute("listkieu", kieuService.layKieu());
		model.addAttribute("listLoai", loaiService.layLoai());
		model.addAttribute("listVoucher", voucherService.layVoucher());
	    
	    // Thêm danh sách tìm kiếm và danh sách chính vào model
	    model.addAttribute("listSearch", searchGroup.values());
	    
	    // Thêm các tham số tìm kiếm để hiển thị lại trong form tìm kiếm
	    model.addAttribute("tenSanPham", tenSanPham);

	    return "admin93123/product"; // Tên file JSP
	}

}
