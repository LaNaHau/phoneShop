package ptithcm.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptithcm.entity.CTDonHangEntity;
import ptithcm.entity.DanhGiaEntity;
import ptithcm.entity.SanPhamEntity;

@Repository

public class CTDonHangDAOImpl implements CTDonHangDAO {

	@Autowired
	private SessionFactory factory;

	@Override
	public void luuCtdh(CTDonHangEntity ctdh) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(ctdh);
			t.commit();

		} catch (Exception ex) {
			t.rollback();

		} finally {
			session.close();

		}

	}
	
	
	@Override
	public List<SanPhamEntity> layDanhSachMaSanPhamTheoMaDH(String maDH){
		Session session = factory.openSession();
	      // Sử dụng HQL để truy vấn danh sách sản phẩm từ đơn hàng theo maDH
        String hql = "SELECT c.sanPham FROM CTDonHangEntity c WHERE c.donHang.maDh = :maDH";
        
        // Tạo query và truyền tham số vào
        Query query = session.createQuery(hql);
        query.setParameter("maDH", Integer.parseInt(maDH)); // Chuyển maDH thành int nếu cần
        
        // Lấy kết quả và trả về danh sách các sản phẩm
        List<SanPhamEntity> list = query.list();
        return list;
	}
	

	@Override
	public void updateCtdh(CTDonHangEntity ctdh) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(ctdh);
			t.commit();

		} catch (Exception ex) {
			t.rollback();

		} finally {
			session.close();

		}

	}

	@Override
	public List<CTDonHangEntity> timctdhTheoMaDh(int maDh) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CTDonHangEntity WHERE donHang.maDh=:maDh";
		Query query = session.createQuery(hql);
		query.setParameter("maDh", maDh);
		List<CTDonHangEntity> ctDonHangList = query.list();
		return ctDonHangList;
	}

	@Override
	public CTDonHangEntity timCtdhTheoMaCtdh(int maCTDH) {
		Session session = factory.getCurrentSession();
		String hql = "FROM CTDonHangEntity WHERE maCTDH=:maCTDH";
		Query query = session.createQuery(hql);
		query.setParameter("maCTDH", maCTDH);
		CTDonHangEntity ctdh = (CTDonHangEntity) query.uniqueResult();
		return ctdh;
	}

	@Override
	public List<CTDonHangEntity> layAllCTDonHang() {
		Session session = factory.getCurrentSession();
		String hql = "FROM CTDonHangEntity";
		Query query = session.createQuery(hql);
		List<CTDonHangEntity> ListAllctDonHang = query.list();
		return ListAllctDonHang;
	}

	@Override
	public CTDonHangEntity timCtdhTheoMaDHMaSP(int maDh, String maSP) {
		// TODO Auto-generated method stub
		Session session = factory.getCurrentSession();
		String hql = "FROM CTDonHangEntity WHERE donHang.maDh=:maDh and sanPham.maSP =:maSP";
		Query query = session.createQuery(hql);
		query.setParameter("maDh", maDh);
		query.setParameter("maSP", maSP);
		if(query.list().size() == 0) {
			return null;
		}
		List<CTDonHangEntity> ctdhList = query.list();
		CTDonHangEntity ctdh = ctdhList.get(0);
		return ctdh;

	}
	
	@Override
	public int laySoLuongSanPhamTrongDonHang(int maDh, String maSP) {
	    Session session = factory.getCurrentSession();
	    String hql = "SELECT c.soLuong FROM CTDonHangEntity c WHERE c.donHang.maDh = :maDh AND c.sanPham.maSP = :maSP";
	    Query query = session.createQuery(hql);
	    query.setParameter("maDh", maDh);
	    query.setParameter("maSP", maSP);
	    
	    // Trả về số lượng nếu có kết quả, nếu không trả về 0
	    Integer soLuong = (Integer) query.uniqueResult();
	    return soLuong != null ? soLuong : 0;  // Nếu không có kết quả thì trả về 0
	}

	
	@Override
	public List<Object[]> tongSoLuongTheoKieuLoai(int maKieu, int trangThai) {
	    // Mở phiên làm việc
	    Session session = factory.getCurrentSession();
	    
	    // HQL query sửa đổi để lọc theo cả maKieu và trangThai
	    String hql = "SELECT s.maKieu, SUM(c.soLuong) " +
	                 "FROM CTDonHangEntity c " +
	                 "JOIN c.sanPham s " +       // Liên kết với bảng SanPham
	                 "JOIN c.donHang d " +       // Liên kết với bảng DonHang
	                 "WHERE s.maKieu = :maKieu " +  // Lọc sản phẩm theo maKieu
	                 "AND d.trangThai = :trangThai " +  // Lọc đơn hàng theo trangThai
	                 "GROUP BY s.maKieu";       // Nhóm theo maKieu của sản phẩm

	    // Tạo query và thiết lập các tham số maKieu và trangThai
	    Query query = session.createQuery(hql);
	    query.setParameter("maKieu", maKieu);   // Truyền tham số maKieu vào query
	    query.setParameter("trangThai", trangThai);  // Truyền tham số trangThai vào query
	    
	    // Lấy kết quả và trả về danh sách
	    List<Object[]> result = query.list();
	    return result;
	}



}