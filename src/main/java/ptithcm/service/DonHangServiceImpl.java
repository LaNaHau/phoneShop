package ptithcm.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ptithcm.entity.DonHangEntity;
import ptithcm.dao.DonHangDAO;

@Service
@Transactional

public class DonHangServiceImpl implements DonHangService{

	@Autowired
	private DonHangDAO DonHang;
	
	@Override
	public void luuDonHang(DonHangEntity donHang) {
		DonHang.luuDonHang(donHang);
		return;
	}

	@Override
	public List<DonHangEntity> timDonHangCuaUserTheoTrangThai(int maNd, int trangThai) throws Exception {
		
		return DonHang.timDonHangCuaUserTheoTrangThai(maNd, trangThai);
		
	}

	@Override
	public void updateDonHang(DonHangEntity donHang) {
		DonHang.updateDonHang(donHang);
		
	}

	@Override
	public DonHangEntity timDonHangTheoMa(int maDh) throws Exception {
		return DonHang.timDonHangTheoMa(maDh);
	}

	@Override
	public List<DonHangEntity> layAllDonHang() throws Exception {
		return DonHang.layAllDonHang();
	}

	@Override
	public List<DonHangEntity> layDonHangTheoTrangThai(int trangThai) throws Exception {
		return DonHang.layDonHangTheoTrangThai(trangThai);
	}

	@Override
	public long tinhTongDoanhThuTheoThang(int thang) {
		return DonHang.tinhTongDoanhThuTheoThang(thang);
	}
	
	@Override
	public List<String> layMaSanPhamTrongDonHangGanNhatCuaUser(int maNd){
		return DonHang.layMaSanPhamTrongDonHangGanNhatCuaUser(maNd);
	}
	
	@Override
	public List<DonHangEntity> layDonHangTheoMaVoucher(String maVoucher) throws Exception {
		return DonHang.layDonHangTheoMaVoucher(maVoucher);
	}
	
	@Override
	public List<DonHangEntity> timDonHangTheoTrangThaiVaThuocTinhKhac(
		    Integer trangThai, 
		    String hoTen, 
		    Date ngayTaoMin, 
		    Date ngayTaoMax) throws Exception {
		return DonHang.timDonHangTheoTrangThaiVaThuocTinhKhac(trangThai, hoTen, ngayTaoMin, ngayTaoMax);
	}
}