package ptithcm.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ptithcm.entity.CTDonHangEntity;
import ptithcm.entity.GioHangEntity;
import ptithcm.entity.HinhAnhEntity;
import ptithcm.entity.SanPhamEntity;
import ptithcm.dao.CTDonHangDAO;
import ptithcm.dao.HinhAnhDAO;
import ptithcm.dao.SanPhamDAO;

@Service
@Transactional
public class SanPhamServiceImpl implements SanPhamService {
    @Autowired
    private SanPhamDAO sanPhamDAO;

    @Autowired
    private HinhAnhDAO hinhAnhDAO;

    @Autowired
    private gioHangService gioHangService;

    @Autowired
    private CTDonHangDAO ctdonHangDao;

    @Override
    public SanPhamEntity laySanPham(String maSp) {
        return sanPhamDAO.laySanPham(maSp);
    }

    @Override
    public List<SanPhamEntity> laySanPhamTheoMa(String key) {        
        return sanPhamDAO.laySanPhamTheoMa(key);   
    }
    
    @Override
    public List<SanPhamEntity> laySanPhamTheoListMaSP(List<String> listMaSP) {
        return sanPhamDAO.laySanPhamTheoListMaSP(listMaSP);
    }
    
    @Override
    public List<SanPhamEntity> laySanPhamMotTrang(int page, int pageSize) {
        return sanPhamDAO.laySanPhamMotTrang(page, pageSize);
    }
    
	@Override
	public List<SanPhamEntity> laySanPhamMotTran(List<SanPhamEntity> list, int page, int pageSize){		
		List<SanPhamEntity> SPMotTrang = new ArrayList<>();
		int offset = page * pageSize;
		int endIndex = pageSize + offset;
		if (endIndex>list.size()) endIndex = list.size();
		for (int i =offset; i<endIndex;i++) {
			SPMotTrang.add(list.get(i));
		}
		return SPMotTrang;
	}
    
    @Override
    public List<SanPhamEntity> laySanPhamMotTrangTheoLoai(String loai, int page, int pageSize) {
        return sanPhamDAO.laySanPhamMotTrangTheoLoai(loai, page, pageSize);
    }
    
    @Override
    public List<SanPhamEntity> laySanPhamTheoLoai(String loai) {
        return sanPhamDAO.laySanPhamTheoLoai(loai);
    }
    
    @Override
    public List<SanPhamEntity> layAllSanPhamTheoLoai(String loai) {
        return sanPhamDAO.layAllSanPhamTheoLoai(loai);
    }

    @Override
    public List<SanPhamEntity> laySanPhamCungLoai(String maSp) {
        return sanPhamDAO.laySanPhamCungLoai(maSp);
    }
    
    @Override
    public List<SanPhamEntity> layTatCaSanPhamCungKieu(String kieu) {
        return sanPhamDAO.layTatCaSanPhamCungKieu(kieu);
    }
    
    @Override
    public List<SanPhamEntity> laySanPhamCungKieu(String maSp) {
        return sanPhamDAO.laySanPhamCungKieu(maSp);
    }
    
    @Override
    public List<SanPhamEntity> laySanPhamNgauNhien() {
        return sanPhamDAO.laySanPhamNgauNhien();
    }
    
    @Override
    public List<SanPhamEntity> laySanPhamMoi() {
        return sanPhamDAO.laySanPhamMoi();
    }
    
    @Override
    public List<SanPhamEntity> locSanPhamTrung(List<SanPhamEntity> list) {
        Set<String> uniqueSet = new HashSet<>();
        List<SanPhamEntity> result = new ArrayList<>();
        for (SanPhamEntity sanPham : list) {
            if (uniqueSet.add(sanPham.getTenSanPham())) {
                result.add(sanPham);
            }
        }
        return result;
    }
    
    @Override
    public List<SanPhamEntity> locSanPham(List<String> stylesList, BigDecimal minPrice, BigDecimal maxPrice) {
        return sanPhamDAO.locSanPham(stylesList, minPrice, maxPrice);
    }
    
    @Override
    public boolean kiemTraSanPhamCoNamTrongGioHang(String maSP) {
        return gioHangService.layAllGioHang().stream()
                .anyMatch(gioHang -> gioHang.getSanPham().getMaSP().equals(maSP));
    }
    
    @Override
    public boolean kiemTraSanPhamCoNamTrongDonHang(String maSP) {
        return ctdonHangDao.layAllCTDonHang().stream()
                .anyMatch(ctdonHang -> ctdonHang.getSanPham().getMaSP().equals(maSP));
    }

    @Override
    public float tinhSoSaoTB(SanPhamEntity sanPham) {
        return sanPhamDAO.tinhSoSaoTB(sanPham);
    }

    @Override
    public List<SanPhamEntity> layAllSanPham() {
        return sanPhamDAO.layAllSanPham();
    }

    @Override
    public List<SanPhamEntity> layAllSanPhamDaNgungBan() {
        return sanPhamDAO.layAllSanPhamDaNgungBan();
    }

    @Override
    public void themSanPham(SanPhamEntity sanPham) {
        sanPhamDAO.themSanPham(sanPham);
    }
    
    @Override
    @Transactional
    public void updateSanPham(SanPhamEntity sanPham) {
        if (sanPham == null) {
            throw new IllegalArgumentException("SanPhamEntity không được null.");
        }
        if (sanPham.getMaSP() == null || sanPham.getTenSanPham() == null) {
            throw new IllegalArgumentException("Mã sản phẩm hoặc tên sản phẩm không được null.");
        }

        try {
            sanPhamDAO.updateSanPham(sanPham);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi cập nhật sản phẩm: " + e.getMessage(), e);
        }
    }

    @Override
    public void xoaSanPham(SanPhamEntity sanPham) {
        sanPhamDAO.xoaSanPham(sanPham);
    }

    @Override
    @Transactional
    public void themHinhAnhSanPham(HinhAnhEntity hinhAnh) {
        if (hinhAnh == null) {
            throw new IllegalArgumentException("HinhAnhEntity không được null.");
        }
        try {
            hinhAnhDAO.themHinhAnhSanPham(hinhAnh);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi thêm hình ảnh: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public void suaHinhAnhSanPham(HinhAnhEntity hinhAnh) {
        if (hinhAnh == null) {
            throw new IllegalArgumentException("HinhAnhEntity không được null.");
        }
        try {
            hinhAnhDAO.suaHinhAnhSanPham(hinhAnh);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi sửa hình ảnh: " + e.getMessage(), e);
        }
    }

    @Override
    public void xoaHinhAnhSanPham(HinhAnhEntity hinhAnh) {
        hinhAnhDAO.xoaHinhAnhSanPham(hinhAnh);
    }

    @Override
    public List<CTDonHangEntity> laySanPhamPhoBien(int soLuongSanPham) {
        return sanPhamDAO.laySanPhamPhoBien(soLuongSanPham);
    }
    
    @Override
    public List<String> layDanhSachMauSac(String tenSanPham) {
        return sanPhamDAO.getDanhSachMauSac(tenSanPham);
    }

    @Override
    public List<String> layDanhSachBoNho(String tenSanPham) {
        return sanPhamDAO.getDanhSachBoNho(tenSanPham);
    }
    
    @Override
    public SanPhamEntity findSanPhamByAttributes(String tenSanPham, String mauSac, String boNhoTrong) {
        return sanPhamDAO.findSanPhamByAttributes(tenSanPham, mauSac, boNhoTrong);
    }
	/*
	 * @Override public List<String> layDanhSachBoNhoTheoMauSac(String tenSanPham,
	 * String mauSac){ return sanPhamDAO.layDanhSachBoNhoTheoMauSac(tenSanPham,
	 * mauSac); }
	 */
    
    @Override
    public List<String> layDanhSachBoNhoTheoMauSac(String tenSanPham, String mauSac) {
        // Lấy danh sách bộ nhớ từ database hoặc nguồn dữ liệu
        List<String> boNhoList = sanPhamDAO.layDanhSachBoNhoTheoMauSac(tenSanPham, mauSac);

		/*
		 * // Hiển thị danh sách trước khi trả về if (boNhoList != null &&
		 * !boNhoList.isEmpty()) { System.out.println("Danh sách bộ nhớ cho sản phẩm \""
		 * + tenSanPham + "\" với màu sắc \"" + mauSac + "\":"); for (String boNho :
		 * boNhoList) { System.out.println(boNho); // In từng phần tử trong danh sách }
		 * } else { System.out.println("Không có bộ nhớ nào phù hợp."); }
		 */

        // Trả về danh sách bộ nhớ
        return boNhoList;
    }
    @Override
    public List<String> layDanhSachMauSacTheoBoNho(String tenSanPham, String boNho){
    	return sanPhamDAO.layDanhSachMauSacTheoBoNho(tenSanPham, boNho);
    }
    
    @Override
    public boolean kiemTraMaSanPhamTonTai(String maSP) {
    	return sanPhamDAO.kiemTraMaSanPhamTonTai(maSP);
    }
    
    @Override
    public List<SanPhamEntity> laySanPhamTheoTen(String tenSP){
    	return sanPhamDAO.laySanPhamTheoTen( tenSP);
    }
    
    @Override
    public List<SanPhamEntity> laySanPhamTheoTens(String tenSP){
    	return sanPhamDAO.laySanPhamTheoTens( tenSP);
    }
    
    @Override
    public void themListSanPham(List<SanPhamEntity> sanPhamList) {
    	sanPhamDAO.themListSanPham(sanPhamList);
    }
    @Override
    public List<SanPhamEntity> laySanPhamKhuyenMai(){
    	return sanPhamDAO.laySanPhamKhuyenMai();
    }
    
    @Override
    public void updateSoLuongSP(String maSP, int soLuong) {
    	sanPhamDAO.updateSoLuongSP(maSP, soLuong);
    }
    
    @Override
    public void updateSoSaoSP(String maSP, float soSaoTB)
    {
    	sanPhamDAO.updateSoSaoSP(maSP, soSaoTB);
    }
}
