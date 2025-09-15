package ptithcm.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptithcm.encrypt.DesEncrypt;
import ptithcm.entity.DonHangEntity;
import ptithcm.entity.GioHangEntity;
import ptithcm.entity.SanPhamEntity;

@Repository

public class DonHangDaoImpl implements DonHangDAO {

	@Autowired
	private SessionFactory factory;

	@Override
	public void luuDonHang(DonHangEntity donHang) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			donHang.setSdt(DesEncrypt.desEncrypt(donHang.getSdt(), DesEncrypt.desKey));
			session.save(donHang);
			t.commit();

		} catch (Exception ex) {
			t.rollback();

		} finally {
			session.close();

		}

	}

	@Override
	public void updateDonHang(DonHangEntity donHang) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			donHang.setSdt(DesEncrypt.desEncrypt(donHang.getSdt(), DesEncrypt.desKey));
			session.update(donHang);
			t.commit();

		} catch (Exception ex) {
			t.rollback();

		} finally {
			session.close();

		}

	}

	@Override
	public List<DonHangEntity> timDonHangCuaUserTheoTrangThai(int maNd, int trangThai) throws Exception {
		Session session = factory.getCurrentSession();
		String hql = "FROM DonHangEntity where nguoiDung.maNd=:maNd and trangThai=:trangThai order by ngayTao DESC";

		Query query = session.createQuery(hql);
		query.setParameter("maNd", maNd);
		query.setParameter("trangThai", trangThai);
		List<DonHangEntity> donHangList = query.list();
		List<DonHangEntity> clonedDonHangList = new ArrayList<>();

		for (DonHangEntity donHang : donHangList) {
		    DonHangEntity clonedDonHang = new DonHangEntity();
		    
		    // Sao chép các thuộc tính cơ bản
		    clonedDonHang.setMaDh(donHang.getMaDh());
		    clonedDonHang.setNgayTao(donHang.getNgayTao());
		    clonedDonHang.setHoTen(donHang.getHoTen());
		    clonedDonHang.setSdt(DesEncrypt.desDecrypt(donHang.getSdt(), DesEncrypt.desKey));
		    clonedDonHang.setDiaChi(donHang.getDiaChi());
		    clonedDonHang.setTongTien(donHang.getTongTien());
		    clonedDonHang.setTrangThai(donHang.getTrangThai());
		    clonedDonHang.setNguoiDung(donHang.getNguoiDung());
		    clonedDonHang.setCtDonHangList(donHang.getCtDonHangList());
		    clonedDonHang.setVoucher(donHang.getVoucher());
		    
		    clonedDonHangList.add(clonedDonHang);
		}
		return clonedDonHangList;
	}

	@Override
	public DonHangEntity timDonHangTheoMa(int maDh) throws Exception {

		Session session = factory.getCurrentSession();
		String hql = "FROM DonHangEntity where maDh=:maDh";

		Query query = session.createQuery(hql);
		query.setParameter("maDh", maDh);
		DonHangEntity donHang = (DonHangEntity) query.uniqueResult();
		DonHangEntity clonedDonHang = new DonHangEntity();
	    
	    // Sao chép các thuộc tính cơ bản
	    clonedDonHang.setMaDh(donHang.getMaDh());
	    clonedDonHang.setNgayTao(donHang.getNgayTao());
	    clonedDonHang.setHoTen(donHang.getHoTen());
	    clonedDonHang.setSdt(DesEncrypt.desDecrypt(donHang.getSdt(), DesEncrypt.desKey));
	    clonedDonHang.setDiaChi(donHang.getDiaChi());
	    clonedDonHang.setTongTien(donHang.getTongTien());
	    clonedDonHang.setTrangThai(donHang.getTrangThai());
	    clonedDonHang.setNguoiDung(donHang.getNguoiDung());
	    clonedDonHang.setCtDonHangList(donHang.getCtDonHangList());
	    clonedDonHang.setVoucher(donHang.getVoucher());
	    
	    return clonedDonHang;
	}

	@Override
	public List<DonHangEntity> layAllDonHang() throws Exception{
		Session session = factory.getCurrentSession();
		String hql = "FROM DonHangEntity ORDER BY ngayTao DESC";
	    Query query = session.createQuery(hql);
	    List<DonHangEntity> listDonHang = query.list();
		List<DonHangEntity> clonedDonHangList = new ArrayList<>();

		for (DonHangEntity donHang : listDonHang) {
		    DonHangEntity clonedDonHang = new DonHangEntity();
		    
		    // Sao chép các thuộc tính cơ bản
		    clonedDonHang.setMaDh(donHang.getMaDh());
		    clonedDonHang.setNgayTao(donHang.getNgayTao());
		    clonedDonHang.setHoTen(donHang.getHoTen());
		    clonedDonHang.setSdt(DesEncrypt.desDecrypt(donHang.getSdt(), DesEncrypt.desKey));
		    clonedDonHang.setDiaChi(donHang.getDiaChi());
		    clonedDonHang.setTongTien(donHang.getTongTien());
		    clonedDonHang.setTrangThai(donHang.getTrangThai());
		    clonedDonHang.setNguoiDung(donHang.getNguoiDung());
		    clonedDonHang.setCtDonHangList(donHang.getCtDonHangList());
		    clonedDonHang.setVoucher(donHang.getVoucher());
		    
		    clonedDonHangList.add(clonedDonHang);
		}
		return clonedDonHangList;
	}
	
	@Override
	public List<DonHangEntity> layDonHangTheoTrangThai(int trangThai) throws Exception {
	    Session session = factory.getCurrentSession();
	    String hql = "FROM DonHangEntity WHERE trangThai = :trangThai";
	    Query query = session.createQuery(hql);
	    query.setParameter("trangThai", trangThai);
	    List<DonHangEntity> listDonHang = query.list();
		List<DonHangEntity> clonedDonHangList = new ArrayList<>();

		for (DonHangEntity donHang : listDonHang) {
		    DonHangEntity clonedDonHang = new DonHangEntity();
		    
		    // Sao chép các thuộc tính cơ bản
		    clonedDonHang.setMaDh(donHang.getMaDh());
		    clonedDonHang.setNgayTao(donHang.getNgayTao());
		    clonedDonHang.setHoTen(donHang.getHoTen());
		    clonedDonHang.setSdt(DesEncrypt.desDecrypt(donHang.getSdt(), DesEncrypt.desKey));
		    clonedDonHang.setDiaChi(donHang.getDiaChi());
		    clonedDonHang.setTongTien(donHang.getTongTien());
		    clonedDonHang.setTrangThai(donHang.getTrangThai());
		    clonedDonHang.setNguoiDung(donHang.getNguoiDung());
		    clonedDonHang.setCtDonHangList(donHang.getCtDonHangList());
		    clonedDonHang.setVoucher(donHang.getVoucher());
		    
		    clonedDonHangList.add(clonedDonHang);
		}
		return clonedDonHangList;
	}

	@Override
	public long tinhTongDoanhThuTheoThang(int thang) {
	    Session session = factory.getCurrentSession();
	    String hql = "SELECT SUM(dh.tongTien) FROM DonHangEntity dh WHERE MONTH(dh.ngayTao) = :thang AND dh.trangThai = 3";
	    Query query = session.createQuery(hql);
	    query.setParameter("thang", thang);

	    // Lấy kết quả truy vấn và xử lý giá trị null
	    BigDecimal tongDoanhThu = (BigDecimal) query.uniqueResult();

	    // Chuyển đổi BigDecimal thành Long, xử lý giá trị null
	    return (tongDoanhThu != null) ? tongDoanhThu.longValue() : 0L;
	}


	@Override
	public List<String> layMaSanPhamTrongDonHangGanNhatCuaUser(int maNd) {
	    Session session = factory.getCurrentSession();
	    
	    // Tạo một truy vấn HQL để lấy đơn hàng gần nhất của người dùng
	    String hql = "SELECT dh.maDh FROM DonHangEntity dh " +
	                 "WHERE dh.nguoiDung.maNd = :maNd " +
	                 "ORDER BY dh.ngayTao DESC";

	    Query query = session.createQuery(hql);
	    query.setParameter("maNd", maNd);
	    query.setMaxResults(1); // Giới hạn kết quả chỉ trả về 1 bản ghi (đơn hàng gần nhất)
	    
	    Integer maDonHang = (Integer) query.uniqueResult(); // Lấy mã đơn hàng gần nhất
	    
	    if (maDonHang != null) {
	        // Tạo một truy vấn HQL để lấy các mã sản phẩm trong đơn hàng gần nhất
	        String hql2 = "SELECT ctp.sanPham FROM CTDonHangEntity ctp " +
	                      "WHERE ctp.donHang.maDh = :maDonHang";
	        
	        Query query2 = session.createQuery(hql2);
	        query2.setParameter("maDonHang", maDonHang);
	        
	        List<SanPhamEntity> sanPhamList = query2.list(); // Danh sách các sản phẩm trong đơn hàng

	        // Lặp qua danh sách sản phẩm và lấy tên từng sản phẩm
	        List<String> tenSanPhamList = new ArrayList<>();
	        for (SanPhamEntity sanPham : sanPhamList) {
	            tenSanPhamList.add(sanPham.getMaSP());
	        }

	        return tenSanPhamList;
	    }

	    // Trả về danh sách trống nếu không có đơn hàng gần nhất
	    return new ArrayList<>();
	}
	
	@Override
	public List<DonHangEntity> layDonHangTheoMaVoucher(String maVoucher) throws Exception {
		Session session = factory.getCurrentSession();
		String hql = "FROM DonHangEntity where voucher.maVoucher = :maVoucher";

		Query query = session.createQuery(hql);
		query.setParameter("maVoucher", maVoucher);
		List<DonHangEntity> donHangList = query.list();
		List<DonHangEntity> clonedDonHangList = new ArrayList<>();

		for (DonHangEntity donHang : donHangList) {
		    DonHangEntity clonedDonHang = new DonHangEntity();
		    
		    // Sao chép các thuộc tính cơ bản
		    clonedDonHang.setMaDh(donHang.getMaDh());
		    clonedDonHang.setNgayTao(donHang.getNgayTao());
		    clonedDonHang.setHoTen(donHang.getHoTen());
		    clonedDonHang.setSdt(DesEncrypt.desDecrypt(donHang.getSdt(), DesEncrypt.desKey));
		    clonedDonHang.setDiaChi(donHang.getDiaChi());
		    clonedDonHang.setTongTien(donHang.getTongTien());
		    clonedDonHang.setTrangThai(donHang.getTrangThai());
		    clonedDonHang.setNguoiDung(donHang.getNguoiDung());
		    clonedDonHang.setCtDonHangList(donHang.getCtDonHangList());
		    clonedDonHang.setVoucher(donHang.getVoucher());
		    
		    clonedDonHangList.add(clonedDonHang);
		}
		return clonedDonHangList;
	}
	
	
	@Override
	public List<DonHangEntity> timDonHangTheoTrangThaiVaThuocTinhKhac(
	    Integer trangThai, 
	    String hoTen, 
	    Date ngayTaoMin, 
	    Date ngayTaoMax) throws Exception {

	    Session session = factory.getCurrentSession();

	    // Xây dựng câu truy vấn động
	    StringBuilder hql = new StringBuilder("FROM DonHangEntity dh WHERE 1=1");

	    // Thêm điều kiện trangThai nếu có
	    if (trangThai != null) {
	        hql.append(" AND dh.trangThai = :trangThai");
	    }

	    // Thêm điều kiện hoTen nếu có, sử dụng LIKE và IN để tìm nhiều tên
	    if (hoTen != null && !hoTen.isEmpty()) {
	        // Tách hoTen thành các tên riêng biệt dựa trên dấu phẩy
	        String[] hoTenArray = hoTen.split("\\s*,\\s*"); // Chia chuỗi theo dấu phẩy và loại bỏ khoảng trắng
	        if (hoTenArray.length > 0) {
	            hql.append(" AND (");
	            for (int i = 0; i < hoTenArray.length; i++) {
	                hql.append("dh.hoTen LIKE :hoTen" + i);
	                if (i < hoTenArray.length - 1) {
	                    hql.append(" OR ");
	                }
	            }
	            hql.append(")");
	        }
	    }

	    // Thêm điều kiện ngày tạo nếu có
	    if (ngayTaoMin != null) {
	        hql.append(" AND dh.ngayTao >= :ngayTaoMin");
	    }
	    if (ngayTaoMax != null) {
	        hql.append(" AND dh.ngayTao <= :ngayTaoMax");
	    }

	    // Tạo truy vấn và thiết lập các tham số
	    Query query = session.createQuery(hql.toString());

	    // Thiết lập tham số trang thái nếu có
	    if (trangThai != null) {
	        query.setParameter("trangThai", trangThai);
	    }

	    // Thiết lập các tham số tìm kiếm hoTen (dùng LIKE)
	    if (hoTen != null && !hoTen.isEmpty()) {
	        String[] hoTenArray = hoTen.split("\\s*,\\s*"); // Tách chuỗi theo dấu phẩy và loại bỏ khoảng trắng
	        for (int i = 0; i < hoTenArray.length; i++) {
	            query.setParameter("hoTen" + i, "%" + hoTenArray[i].trim() + "%");  // Tìm kiếm với LIKE
	        }
	    }

	    // Thiết lập các tham số ngày tạo nếu có
	    if (ngayTaoMin != null) {
	        query.setParameter("ngayTaoMin", ngayTaoMin);
	    }
	    if (ngayTaoMax != null) {
	        query.setParameter("ngayTaoMax", ngayTaoMax);
	    }

	 // Thực thi truy vấn và trả về kết quả
	 		List<DonHangEntity> donHangList = query.list();
	 		List<DonHangEntity> clonedDonHangList = new ArrayList<>();

	 		for (DonHangEntity donHang : donHangList) {
	 		    DonHangEntity clonedDonHang = new DonHangEntity();
	 		    
	 		    // Sao chép các thuộc tính cơ bản
	 		    clonedDonHang.setMaDh(donHang.getMaDh());
	 		    clonedDonHang.setNgayTao(donHang.getNgayTao());
	 		    clonedDonHang.setHoTen(donHang.getHoTen());
	 		    clonedDonHang.setSdt(DesEncrypt.desDecrypt(donHang.getSdt(), DesEncrypt.desKey));
	 		    clonedDonHang.setDiaChi(donHang.getDiaChi());
	 		    clonedDonHang.setTongTien(donHang.getTongTien());
	 		    clonedDonHang.setTrangThai(donHang.getTrangThai());
	 		    clonedDonHang.setNguoiDung(donHang.getNguoiDung());
	 		    clonedDonHang.setCtDonHangList(donHang.getCtDonHangList());
	 		    clonedDonHang.setVoucher(donHang.getVoucher());
	 		    
	 		    clonedDonHangList.add(clonedDonHang);
	 		}
	 		return clonedDonHangList;
	}






}