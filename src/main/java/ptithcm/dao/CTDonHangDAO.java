package ptithcm.dao;

import java.util.List;

import ptithcm.entity.CTDonHangEntity;
import ptithcm.entity.SanPhamEntity;

public interface CTDonHangDAO {
	public void luuCtdh(CTDonHangEntity ctdh);

	public void updateCtdh(CTDonHangEntity ctdh);

	public List<CTDonHangEntity> timctdhTheoMaDh(int maDh);
	
    public CTDonHangEntity timCtdhTheoMaDHMaSP(int maDh, String maSP);

    public List<SanPhamEntity> layDanhSachMaSanPhamTheoMaDH(String maDH);
    

	public CTDonHangEntity timCtdhTheoMaCtdh(int maCTDH);

	public List<CTDonHangEntity> layAllCTDonHang();
	
	public int laySoLuongSanPhamTrongDonHang(int maDh, String maSP);
	
	public List<Object[]> tongSoLuongTheoKieuLoai(int maKieu, int trangThai);
}