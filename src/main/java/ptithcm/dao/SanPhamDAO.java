package ptithcm.dao;

import java.math.BigDecimal;
import java.util.List;
import ptithcm.entity.CTDonHangEntity;
import ptithcm.entity.SanPhamEntity;

public interface SanPhamDAO {
    SanPhamEntity laySanPham(String maSp);

    List<SanPhamEntity> laySanPhamTheoMa(String key);

    List<SanPhamEntity> laySanPhamTheoListMaSP(List<String> listMaSP);

    List<SanPhamEntity> laySanPhamMotTrang(int page, int pageSize);

    List<SanPhamEntity> laySanPhamMotTrangTheoLoai(String loai, int page, int pageSize);

    List<SanPhamEntity> layAllSanPham();
    
    public void updateSoLuongSP(String maSP, int soLuong);
    
    boolean kiemTraMaSanPhamTonTai(String maSP);
    
    List<String> getDanhSachMauSac(String tenSanPham);
    
    List<String> getDanhSachBoNho(String tenSanPham);

    List<SanPhamEntity> layAllSanPhamDaNgungBan();

    List<SanPhamEntity> laySanPhamTheoLoai(String loai);

    List<SanPhamEntity> laySanPhamTheoGioiTinh(String gioiTinh);

    List<SanPhamEntity> layAllSanPhamTheoLoai(String loai);

    List<SanPhamEntity> layTatCaSanPhamCungKieu(String kieu);

    List<SanPhamEntity> laySanPhamCungKieu(String maSp);

    List<SanPhamEntity> laySanPhamCungLoai(String maSp);

    List<SanPhamEntity> laySanPhamNgauNhien();

    List<SanPhamEntity> laySanPhamMoi();

    List<SanPhamEntity> locSanPham(List<String> stylesList, BigDecimal minPrice, BigDecimal maxPrice);

    List<CTDonHangEntity> laySanPhamPhoBien(int soLuongSanPham);
    
    List<String> layDanhSachBoNhoTheoMauSac(String tenSanPham, String mauSac);
    
    List<String> layDanhSachMauSacTheoBoNho(String tenSanPham, String boNho);

    float tinhSoSaoTB(SanPhamEntity sanPham);

    void themSanPham(SanPhamEntity sanPham);

    void updateSanPham(SanPhamEntity sanPham);

    void xoaSanPham(SanPhamEntity sanPham);
    
    public SanPhamEntity findSanPhamByAttributes(String tenSanPham, String mauSac, String boNhoTrong);
    
    void themListSanPham(List<SanPhamEntity> sanPhamList);
    
    public List<SanPhamEntity> laySanPhamTheoTen(String tenSP) ;
    
    public List<SanPhamEntity> laySanPhamTheoTens(String tenSP) ;
    
    public List<SanPhamEntity> laySanPhamKhuyenMai();
    
    public void updateSoSaoSP(String maSP, float soSaoTB);
}
