package ptithcm.dao;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import ptithcm.encrypt.AesEncrypt;
import ptithcm.encrypt.DesEncrypt;
import ptithcm.entity.NguoiDungEntity;

@Transactional
@Repository
public class nguoiDungDaoImpl implements nguoiDungDao {

	@Autowired
	SessionFactory factory;

	@Override
	public void addUser(NguoiDungEntity user) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			user.setSdt(DesEncrypt.desEncrypt(user.getSdt(), DesEncrypt.desKey));
			user.setEmail(AesEncrypt.aesEncrypt(user.getEmail(), AesEncrypt.aesKey256));
			session.save(user);
			t.commit();

		} catch (Exception ex) {
			t.rollback();
			System.out.print("loi");

		} finally {
			session.close();
		}

	}

	@Override
	public void updateUser(NguoiDungEntity user) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			user.setSdt(DesEncrypt.desEncrypt(user.getSdt(), DesEncrypt.desKey));
			user.setEmail(AesEncrypt.aesEncrypt(user.getEmail(), AesEncrypt.aesKey256));
			
			session.update(user);
			t.commit();

		} catch (Exception ex) {
			t.rollback();
			System.out.print("loi");

		} finally {
			session.close();
		}

	}
	
	@Override
	public void updateTrangThaiUser(Integer maND, boolean trangThai) {
	    Session session = factory.openSession();
	    Transaction t = session.beginTransaction();
	    try {
	        // Tạo câu truy vấn HQL để cập nhật trạng thái
	        String hql = "UPDATE NguoiDungEntity nd SET nd.trangThai = :trangThai WHERE nd.maNd = :maND";
	        Query query = session.createQuery(hql);
	        query.setParameter("trangThai", trangThai);
	        query.setParameter("maND", maND);

	        // Thực thi câu truy vấn
	        int result = query.executeUpdate();
	        if (result > 0) {
	            System.out.println("Update trạng thái thành công cho người dùng có maND: " + maND);
	        } else {
	            System.out.println("Không tìm thấy người dùng có maND: " + maND);
	        }

	        // Commit giao dịch
	        t.commit();
	    } catch (Exception e) {
	        // Rollback giao dịch nếu xảy ra lỗi
	        t.rollback();
	        System.err.println("Lỗi khi cập nhật trạng thái người dùng: " + e.getMessage());
	    } finally {
	        // Đóng session
	        session.close();
	    }
	}

	@Override
	public NguoiDungEntity findUserById(Integer maNd) throws Exception {
		Session session = factory.getCurrentSession();
		String hql = "FROM NguoiDungEntity nd WHERE nd.maNd = :maNd ";
		Query query = session.createQuery(hql).setParameter("maNd", maNd);
		NguoiDungEntity user = (NguoiDungEntity) query.uniqueResult();
		NguoiDungEntity detachedUser = new NguoiDungEntity();
        detachedUser.setMaNd(user.getMaNd());
        detachedUser.setUserName(user.getUserName());
        detachedUser.setGioiTinh(user.isGioiTinh());
        detachedUser.setHoTen(user.getHoTen());
        detachedUser.setNgaySinh(user.getNgaySinh());
        detachedUser.setAvatar(user.getAvatar());
        detachedUser.setDiaChi(user.getDiaChi());
        detachedUser.setSdt(DesEncrypt.desDecrypt(user.getSdt(), DesEncrypt.desKey)); // Giải mã số điện thoại
        detachedUser.setEmail(AesEncrypt.aesDecrypt(user.getEmail(), AesEncrypt.aesKey256)); // Giải mã email
        detachedUser.setPassWord(user.getPassWord());
        detachedUser.setTrangThai(user.isTrangThai());
        detachedUser.setQuyen(user.getQuyen());
        detachedUser.setGioHangs(user.getGioHangs());
        detachedUser.setDanhGiaList(user.getDanhGiaList());
        detachedUser.setDonHangs(user.getDonHangs());
        detachedUser.setYeuThichList(user.getYeuThichList());

		return detachedUser;

	}

	@Override
	public NguoiDungEntity findUserByNameAndEmail(String userName, String email) throws Exception {
		Session session = factory.getCurrentSession();
		String hql = "FROM NguoiDungEntity nd WHERE nd.userName = :userName OR nd.email = :email";
		Query query = session.createQuery(hql);
		query.setParameter("userName", userName);
		query.setParameter("email", email);

		List<NguoiDungEntity> user = query.list();
			    if (user.size() > 0) {
			        NguoiDungEntity managedUser = user.get(0); // Đối tượng được quản lý bởi Hibernate

			     // Tạo một bản sao độc lập để giải mã
			        NguoiDungEntity detachedUser = new NguoiDungEntity();
			        detachedUser.setMaNd(managedUser.getMaNd());
			        detachedUser.setUserName(managedUser.getUserName());
			        detachedUser.setGioiTinh(managedUser.isGioiTinh());
			        detachedUser.setHoTen(managedUser.getHoTen());
			        detachedUser.setNgaySinh(managedUser.getNgaySinh());
			        detachedUser.setAvatar(managedUser.getAvatar());
			        detachedUser.setDiaChi(managedUser.getDiaChi());
			        detachedUser.setSdt(DesEncrypt.desDecrypt(managedUser.getSdt(), DesEncrypt.desKey)); // Giải mã số điện thoại
			        detachedUser.setEmail(AesEncrypt.aesDecrypt(managedUser.getEmail(), AesEncrypt.aesKey256)); // Giải mã email
			        detachedUser.setPassWord(managedUser.getPassWord());
			        detachedUser.setTrangThai(managedUser.isTrangThai());
			        detachedUser.setQuyen(managedUser.getQuyen());
			        detachedUser.setGioHangs(managedUser.getGioHangs());
			        detachedUser.setDanhGiaList(managedUser.getDanhGiaList());
			        detachedUser.setDonHangs(managedUser.getDonHangs());
			        detachedUser.setYeuThichList(managedUser.getYeuThichList());
			        // Sao chép các thuộc tính khác nếu cần

			        return detachedUser; // Trả về đối tượng đã giải mã
		}
		return null;
	}

	@Override
	public List<NguoiDungEntity> getAllUserByRole(Integer maQuyen) throws Exception {
		Session session = factory.getCurrentSession();
		String hql = "FROM NguoiDungEntity nd WHERE nd.quyen = :maQuyen";
		Query query = session.createQuery(hql);
		query.setParameter("maQuyen", maQuyen);

		List<NguoiDungEntity> listUser = query.list();
		List<NguoiDungEntity> listDetachedUser = new ArrayList<>();
		for (NguoiDungEntity user: listUser) {
			NguoiDungEntity detachedUser = new NguoiDungEntity();
	        detachedUser.setMaNd(user.getMaNd());
	        detachedUser.setUserName(user.getUserName());
	        detachedUser.setHoTen(user.getHoTen());
	        detachedUser.setGioiTinh(user.isGioiTinh());
	        detachedUser.setNgaySinh(user.getNgaySinh());
	        detachedUser.setAvatar(user.getAvatar());
	        detachedUser.setDiaChi(user.getDiaChi());
	        detachedUser.setSdt(DesEncrypt.desDecrypt(user.getSdt(), DesEncrypt.desKey)); // Giải mã số điện thoại
	        detachedUser.setEmail(AesEncrypt.aesDecrypt(user.getEmail(), AesEncrypt.aesKey256)); // Giải mã email
	        detachedUser.setPassWord(user.getPassWord());
	        detachedUser.setTrangThai(user.isTrangThai());
	        detachedUser.setQuyen(user.getQuyen());
	        detachedUser.setGioHangs(user.getGioHangs());
	        detachedUser.setDanhGiaList(user.getDanhGiaList());
	        detachedUser.setDonHangs(user.getDonHangs());
	        detachedUser.setYeuThichList(user.getYeuThichList());
	        
	        listDetachedUser.add(detachedUser);
		}
		return listDetachedUser;
	}
	
	@Override
	public List<NguoiDungEntity> findUserByName(String hoTen) throws Exception {
		Session session = factory.getCurrentSession();
		String hql = "FROM NguoiDungEntity nd WHERE nd.hoTen LIKE :hoTen AND nd.quyen = 0";
		Query query = session.createQuery(hql).setParameter("hoTen",  "%" + hoTen + "%");
		
		List<NguoiDungEntity> listUser = query.list();
		List<NguoiDungEntity> listDetachedUser = new ArrayList<>();
		for (NguoiDungEntity user: listUser) {
			NguoiDungEntity detachedUser = new NguoiDungEntity();
	        detachedUser.setMaNd(user.getMaNd());
	        detachedUser.setUserName(user.getUserName());
	        detachedUser.setHoTen(user.getHoTen());
	        detachedUser.setGioiTinh(user.isGioiTinh());
	        detachedUser.setNgaySinh(user.getNgaySinh());
	        detachedUser.setAvatar(user.getAvatar());
	        detachedUser.setDiaChi(user.getDiaChi());
	        detachedUser.setSdt(DesEncrypt.desDecrypt(user.getSdt(), DesEncrypt.desKey)); // Giải mã số điện thoại
	        detachedUser.setEmail(AesEncrypt.aesDecrypt(user.getEmail(), AesEncrypt.aesKey256)); // Giải mã email
	        detachedUser.setPassWord(user.getPassWord());
	        detachedUser.setTrangThai(user.isTrangThai());
	        detachedUser.setQuyen(user.getQuyen());
	        detachedUser.setGioHangs(user.getGioHangs());
	        detachedUser.setDanhGiaList(user.getDanhGiaList());
	        detachedUser.setDonHangs(user.getDonHangs());
	        detachedUser.setYeuThichList(user.getYeuThichList());
	        
	        listDetachedUser.add(detachedUser);
		}
		return listDetachedUser;

	}
	@Override
	public List<NguoiDungEntity> findUserByNames(String hoTen) throws Exception {
	    Session session = factory.getCurrentSession();
	    System.out.print("Ten trong DAO"+hoTen);	
	    // Nếu hoTen không rỗng và chứa dấu phẩy, tách nó thành danh sách
	    if (hoTen != null && !hoTen.trim().isEmpty()) {
	        // Tách các tên từ chuỗi hoTen, sử dụng dấu phẩy làm phân cách
	        String[] hoTenArray = hoTen.split("\\s*,\\s*"); // Tách chuỗi theo dấu phẩy và loại bỏ khoảng trắng

	        // Xây dựng câu truy vấn động với LIKE cho từng tên
	        StringBuilder hql = new StringBuilder("FROM NguoiDungEntity nd WHERE nd.quyen = 0");

	        // Thêm điều kiện LIKE cho mỗi họ tên
	        for (int i = 0; i < hoTenArray.length; i++) {
	            if (i == 0) {
	                hql.append(" AND nd.hoTen LIKE :hoTen" + i);
	            } else {
	                hql.append(" OR nd.hoTen LIKE :hoTen" + i);
	            }
	        }

	        // Tạo truy vấn và thiết lập các tham số
	        Query query = session.createQuery(hql.toString());

	        // Thiết lập tham số LIKE cho từng tên trong mảng
	        for (int i = 0; i < hoTenArray.length; i++) {
	            query.setParameter("hoTen" + i, "%" + hoTenArray[i].trim() + "%");
	        }

	        // Thực thi truy vấn và trả về kết quả
	        List<NguoiDungEntity> users = query.list();
			List<NguoiDungEntity> listDetachedUser = new ArrayList<>();
			for (NguoiDungEntity user: users) {
				NguoiDungEntity detachedUser = new NguoiDungEntity();
		        detachedUser.setMaNd(user.getMaNd());
		        detachedUser.setUserName(user.getUserName());
		        detachedUser.setGioiTinh(user.isGioiTinh());
		        detachedUser.setNgaySinh(user.getNgaySinh());
		        detachedUser.setHoTen(user.getHoTen());
		        detachedUser.setAvatar(user.getAvatar());
		        detachedUser.setDiaChi(user.getDiaChi());
		        detachedUser.setSdt(DesEncrypt.desDecrypt(user.getSdt(), DesEncrypt.desKey)); // Giải mã số điện thoại
		        detachedUser.setEmail(AesEncrypt.aesDecrypt(user.getEmail(), AesEncrypt.aesKey256)); // Giải mã email
		        detachedUser.setPassWord(user.getPassWord());
		        detachedUser.setTrangThai(user.isTrangThai());
		        detachedUser.setQuyen(user.getQuyen());
		        detachedUser.setGioHangs(user.getGioHangs());
		        detachedUser.setDanhGiaList(user.getDanhGiaList());
		        detachedUser.setDonHangs(user.getDonHangs());
		        detachedUser.setYeuThichList(user.getYeuThichList());
		        
		        listDetachedUser.add(detachedUser);
			}
			return listDetachedUser;
	    }

	    // Nếu không có tên nào được nhập, trả về danh sách rỗng hoặc bạn có thể xử lý theo cách khác.
	    return new ArrayList<>();
	}

}