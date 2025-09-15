package ptithcm.service;



import java.util.List;

import ptithcm.entity.CTDonHangEntity;
import ptithcm.entity.SanPhamEntity;


public interface CTDonHangService{
	public void luuCtdh(CTDonHangEntity ctdh) ;
	public void updateCtdh(CTDonHangEntity ctdh) ;
	public List<CTDonHangEntity> timctdhTheoMaDh(int maDh);
    public CTDonHangEntity timCtdhTheoMaCtdh(int maCTDH);
	public CTDonHangEntity timCtdhTheoMaDhMaSP(int maDHTypeInt, String maSp);
	public List<SanPhamEntity> layDanhSachMaSanPhamTheoMaDH(String maDH);
	public int laySoLuongSanPhamTrongDonHang(int maDh, String maSP);
	public List<Object[]> tongSoLuongTheoKieuLoai(int maKieu, int trangThai);
}