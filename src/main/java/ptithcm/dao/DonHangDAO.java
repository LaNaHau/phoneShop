package ptithcm.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import ptithcm.entity.DonHangEntity;

public interface DonHangDAO{
	public void luuDonHang(DonHangEntity donHang);
	public void updateDonHang(DonHangEntity donHang);
	public DonHangEntity timDonHangTheoMa(int maDh) throws Exception;
	public List<DonHangEntity> timDonHangCuaUserTheoTrangThai(int maNd, int trangThai) throws Exception;
	public List<DonHangEntity> layDonHangTheoMaVoucher (String maVoucher) throws Exception;
	
	public List<DonHangEntity> layAllDonHang() throws Exception;	
	public List<DonHangEntity> layDonHangTheoTrangThai(int trangThai) throws Exception;
	public long tinhTongDoanhThuTheoThang(int thang);
	
	public List<DonHangEntity> timDonHangTheoTrangThaiVaThuocTinhKhac(
		    Integer trangThai, 
		    String hoTen, 
		    Date ngayTaoMin, 
		    Date ngayTaoMax) throws Exception;
	
	public List<String> layMaSanPhamTrongDonHangGanNhatCuaUser(int maNd);
}