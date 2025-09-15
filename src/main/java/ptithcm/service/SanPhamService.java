package ptithcm.service;

import java.math.BigDecimal;
import java.util.List;

import ptithcm.entity.CTDonHangEntity;
import ptithcm.entity.HinhAnhEntity;
import ptithcm.entity.SanPhamEntity;

public interface SanPhamService {
    SanPhamEntity laySanPham(String maSp);
    
    List<SanPhamEntity> laySanPhamTheoMa(String key);
    
    List<SanPhamEntity> laySanPhamTheoListMaSP(List<String> listMaSP);
    
    List<SanPhamEntity> laySanPhamMotTrang(int page, int pageSize);
    
	List<SanPhamEntity> laySanPhamMotTran(List<SanPhamEntity> list, int page, int pageSize);
    
    List<SanPhamEntity> laySanPhamMotTrangTheoLoai(String loai, int page, int pageSize);
    
    List<SanPhamEntity> layAllSanPham();
    
    public void updateSoLuongSP(String maSP, int soLuong);
    
    boolean kiemTraMaSanPhamTonTai(String maSP);
    
    List<String> layDanhSachMauSac(String tenSanPham);
    
    List<String> layDanhSachBoNho(String tenSanPham);
    
    SanPhamEntity findSanPhamByAttributes(String tenSanPham, String mauSac, String boNhoTrong);

    List<String> layDanhSachBoNhoTheoMauSac(String tenSanPham, String mauSac);
    
    List<String> layDanhSachMauSacTheoBoNho(String tenSanPham, String boNho);
    
    List<SanPhamEntity> layAllSanPhamDaNgungBan();
    
    List<SanPhamEntity> laySanPhamTheoTen(String tenSP) ;
    
    List<SanPhamEntity> laySanPhamTheoTens(String tenSP) ;
    
    List<SanPhamEntity> laySanPhamTheoLoai(String loai);
    
    List<SanPhamEntity> layAllSanPhamTheoLoai(String loai);
    
    List<SanPhamEntity> laySanPhamCungLoai(String maSp);
    
    List<SanPhamEntity> layTatCaSanPhamCungKieu(String kieu);
    
    List<SanPhamEntity> laySanPhamCungKieu(String maSp);
    
    List<SanPhamEntity> laySanPhamNgauNhien();
    
    List<SanPhamEntity> laySanPhamMoi();
    
    List<SanPhamEntity> locSanPhamTrung(List<SanPhamEntity> list);
    
    List<SanPhamEntity> locSanPham(List<String> stylesList, BigDecimal minPrice, BigDecimal maxPrice);
    
    boolean kiemTraSanPhamCoNamTrongGioHang(String maSP);
    
    boolean kiemTraSanPhamCoNamTrongDonHang(String maSP);
    
    List<CTDonHangEntity> laySanPhamPhoBien(int soLuongSanPham);
    
    float tinhSoSaoTB(SanPhamEntity sanPham);
    
    void themSanPham(SanPhamEntity sanPham);
    
    void updateSanPham(SanPhamEntity sanPham);
    
    void xoaSanPham(SanPhamEntity sanPham);
    
    void themHinhAnhSanPham(HinhAnhEntity hinhAnh);
    
    void suaHinhAnhSanPham(HinhAnhEntity hinhAnh);
    
    void xoaHinhAnhSanPham(HinhAnhEntity hinhAnh);
    
    void themListSanPham(List<SanPhamEntity> sanPhamList);
    
    List<SanPhamEntity> laySanPhamKhuyenMai();
    
    public void updateSoSaoSP(String maSP, float soSaoTB);

}
