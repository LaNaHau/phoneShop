package ptithcm.dao;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptithcm.entity.CTDonHangEntity;
import ptithcm.entity.SanPhamEntity;

@Transactional
@Repository
public class SanPhamDaoImpl implements SanPhamDAO {

    @Autowired
    private SessionFactory sessionFactory;

	@Override
	public SanPhamEntity laySanPham(String maSp) {
		SanPhamEntity sanPham = (SanPhamEntity) sessionFactory.getCurrentSession().get(SanPhamEntity.class, maSp);
		return sanPham;
	}
	
	@Override
    public void themListSanPham(List<SanPhamEntity> sanPhamList) {
        for (SanPhamEntity sp : sanPhamList) {
        	sessionFactory.getCurrentSession().save(sp);
        }
    }

    @Override
    public List<SanPhamEntity> laySanPhamTheoMa(String key) {
        String hql = "FROM SanPhamEntity sp WHERE sp.maSP LIKE :key OR sp.tenSanPham LIKE :key OR sp.maKieu.tenKieu LIKE :key";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("key", "%" + key + "%");
        return query.list();
    }

    @Override
    public List<SanPhamEntity> laySanPhamTheoListMaSP(List<String> listMaSP) {
        String hql = "FROM SanPhamEntity sp WHERE sp.maSP IN :listMaSP";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameterList("listMaSP", listMaSP);
        return query.list();
    }

    @Override
    public List<SanPhamEntity> laySanPhamMotTrang(int page, int pageSize) {
        String hql = "FROM SanPhamEntity sp WHERE sp.trangThai = true ORDER BY sp.ngayThem DESC";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setFirstResult(page * pageSize).setMaxResults(pageSize);
        return query.list();
    }

    @Override
    public List<SanPhamEntity> laySanPhamMotTrangTheoLoai(String loai, int page, int pageSize) {
        String hql = "FROM SanPhamEntity sp WHERE sp.maKieu.loai.maLoai = :loai AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("loai", loai);
        query.setFirstResult(page * pageSize).setMaxResults(pageSize);
        return query.list();
    }

    @Override
    public List<SanPhamEntity> layAllSanPham() {
        String hql = "FROM SanPhamEntity sp WHERE sp.trangThai = true ORDER BY sp.ngayThem DESC";
        return sessionFactory.getCurrentSession().createQuery(hql).list();
    }

    @Override
    public List<SanPhamEntity> layAllSanPhamDaNgungBan() {
        String hql = "FROM SanPhamEntity sp WHERE sp.trangThai = false ORDER BY sp.ngayThem DESC";
        return sessionFactory.getCurrentSession().createQuery(hql).list();
    }

    @Override
    public List<SanPhamEntity> laySanPhamTheoLoai(String loai) {
        String hql = "FROM SanPhamEntity sp WHERE sp.maKieu.loai.maLoai = :loai AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("loai", loai);
        return query.list();
    }

    @Override
    public List<SanPhamEntity> laySanPhamTheoGioiTinh(String gioiTinh) {
        String hql = "FROM SanPhamEntity sp WHERE sp.maKieu.loai.tenLoai LIKE :gioiTinh AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("gioiTinh", "%" + gioiTinh + "%");
        return query.list();
    }

    @Override
    public List<SanPhamEntity> layAllSanPhamTheoLoai(String loai) {
        String hql = "FROM SanPhamEntity sp WHERE sp.maKieu.loai.maLoai = :loai AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("loai", loai);
        return query.list();
    }

    @Override
    public List<SanPhamEntity> layTatCaSanPhamCungKieu(String kieu) {
        String hql = "FROM SanPhamEntity sp WHERE sp.maKieu.tenKieu = :kieu AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("kieu", kieu);
        return query.list();
    }

    @Override
    public List<SanPhamEntity> laySanPhamCungKieu(String maSp) {
        SanPhamEntity sp = laySanPham(maSp);
        String hql = "FROM SanPhamEntity sp WHERE sp.maKieu = :maKieu AND sp.maSP != :maSp AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("maKieu", sp.getMaKieu());
        query.setParameter("maSp", sp.getMaSP());
        return query.list();
    }

    @Override
    public List<SanPhamEntity> laySanPhamCungLoai(String maSp) {
        return new ArrayList<>(); // Để trống vì chưa đủ logic dữ liệu
    }

    @Override
    public List<SanPhamEntity> laySanPhamNgauNhien() {
        String hql = "FROM SanPhamEntity sp WHERE sp.trangThai = true ORDER BY NEWID()";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        return query.list();
    }

    @Override
    public List<SanPhamEntity> laySanPhamMoi() {
        String hql = "FROM SanPhamEntity sp WHERE sp.trangThai = true ORDER BY sp.ngayThem DESC";
        return sessionFactory.getCurrentSession().createQuery(hql).list();
    }

    @Override
    public List<SanPhamEntity> locSanPham(List<String> stylesList, BigDecimal minPrice, BigDecimal maxPrice) {
        String hql = "FROM SanPhamEntity sp WHERE sp.trangThai = true";

        // Kiểm tra điều kiện stylesList
        if (stylesList != null && !stylesList.isEmpty()) {
            hql += " AND sp.maKieu.tenKieu IN :stylesList";
        }

        // Kiểm tra điều kiện giá trị minPrice và maxPrice
        if (minPrice != null && maxPrice != null) {
            hql += " AND (CASE WHEN sp.giamGia IS NOT NULL THEN "
                 + "(sp.donGia - (sp.donGia * sp.giamGia / 100)) "
                 + "ELSE sp.donGia END) BETWEEN :minPrice AND :maxPrice";
        }

        Query query = sessionFactory.getCurrentSession().createQuery(hql);

        // Gán giá trị tham số stylesList
        if (stylesList != null && !stylesList.isEmpty()) {
            query.setParameterList("stylesList", stylesList);
        }

        // Gán giá trị tham số minPrice và maxPrice
        if (minPrice != null && maxPrice != null) {
            query.setParameter("minPrice", minPrice);
            query.setParameter("maxPrice", maxPrice);
        }

        return query.list();
    }




    @Override
    public float tinhSoSaoTB(SanPhamEntity sanPham) {
        String hql = "SELECT AVG(dg.soSao) FROM DanhGiaEntity dg WHERE dg.sanPham = :sanPham";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("sanPham", sanPham);
        Double avg = (Double) query.uniqueResult();
        return avg != null ? avg.floatValue() : 0f;
    }

    @Override
    public void themSanPham(SanPhamEntity sanPham) {
        sessionFactory.getCurrentSession().save(sanPham);
    }

    @Override
    public void updateSanPham(SanPhamEntity sanPham) {
        if (sanPham == null || sanPham.getMaSP() == null) {
            throw new IllegalArgumentException("SanPhamEntity hoặc mã sản phẩm không được null.");
        }

        try {
            sessionFactory.getCurrentSession().update(sanPham);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi cập nhật sản phẩm: " + e.getMessage(), e);
        }
    }


    @Override
    public void xoaSanPham(SanPhamEntity sanPham) {
        sessionFactory.getCurrentSession().delete(sanPham);
    }

    @Override
    public List<SanPhamEntity> laySanPhamKhuyenMai() {
        String hql = "FROM SanPhamEntity sp WHERE sp.giamGia IS NOT NULL AND sp.trangThai = true ORDER BY sp.ngayThem DESC";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        return query.list();
    }

    
    @Override
    public List<SanPhamEntity> laySanPhamTheoTen(String tenSP) {
        String hql = "FROM SanPhamEntity sp WHERE sp.tenSanPham LIKE :tenSP AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("tenSP", "%" + tenSP + "%");
        return query.list();
    }
    
    
    @Override
    public List<SanPhamEntity> laySanPhamTheoTens(String tenSP) {
        String hql = "FROM SanPhamEntity sp WHERE sp.trangThai = true";
        
        // Tách chuỗi tenSP thành một mảng các tên sản phẩm, cách nhau bằng dấu phẩy
        if (tenSP != null && !tenSP.trim().isEmpty()) {
            String[] tenSPArray = tenSP.split("\\s*,\\s*"); // Tách chuỗi theo dấu phẩy và loại bỏ khoảng trắng
            hql += " AND (";
            
            // Thêm các điều kiện LIKE cho từng tên sản phẩm
            for (int i = 0; i < tenSPArray.length; i++) {
                if (i > 0) {
                    hql += " OR "; // Nếu không phải tên đầu tiên thì thêm OR để nối các điều kiện
                }
                hql += "sp.tenSanPham LIKE :tenSP" + i; // Thêm tham số vào câu truy vấn
            }
            hql += ")"; // Đóng ngoặc cho điều kiện OR
        }

        // Tạo truy vấn và thiết lập các tham số
        Query query = sessionFactory.getCurrentSession().createQuery(hql);

        // Thiết lập các tham số tìm kiếm
        if (tenSP != null && !tenSP.trim().isEmpty()) {
            String[] tenSPArray = tenSP.split("\\s*,\\s*");
            for (int i = 0; i < tenSPArray.length; i++) {
                query.setParameter("tenSP" + i, "%" + tenSPArray[i].trim() + "%"); // Tìm kiếm với LIKE
            }
        }

        // Thực thi truy vấn và trả về kết quả
        return query.list();
    }
    
	@Override
	public List<CTDonHangEntity> laySanPhamPhoBien(int soLuongSanPham) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM CTDonHangEntity";
		Query query = session.createQuery(hql);
		List<CTDonHangEntity> sanPhamList = query.setMaxResults(soLuongSanPham).list();

		List<CTDonHangEntity> sortedSanPhamList = sanPhamList.stream()
			    .collect(Collectors.groupingBy(CTDonHangEntity::getMaSP, Collectors.summingInt(CTDonHangEntity::getSoLuong)))
			    .entrySet().stream()
			    .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
			    .flatMap(entry -> sanPhamList.stream()
			      .filter(sanPham -> sanPham.getMaSP().equals(entry.getKey())))
			    .collect(Collectors.toList());
		return sortedSanPhamList;
	}
    

    @Override
    public List<String> getDanhSachMauSac(String tenSanPham) {// AND sp.trangThai=true AND sp.soLuong > 0
        String hql = "SELECT DISTINCT sp.mauSac FROM SanPhamEntity sp WHERE sp.tenSanPham LIKE :tenSanPham AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("tenSanPham", tenSanPham);
        return query.list();  // Sử dụng query.list() để lấy danh sách kết quả
    }

    @Override
    public List<String> getDanhSachBoNho(String tenSanPham) {
        String hql = "SELECT DISTINCT sp.boNhoTrong FROM SanPhamEntity sp WHERE sp.tenSanPham LIKE :tenSanPham AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("tenSanPham", tenSanPham);
        return query.list();  // Sử dụng query.list() để lấy danh sách kết quả
    }
    
    @Override
    public SanPhamEntity findSanPhamByAttributes(String tenSanPham, String mauSac, String boNhoTrong) {
        String hql = "FROM SanPhamEntity sp WHERE sp.tenSanPham = :tenSanPham AND sp.mauSac = :mauSac AND sp.boNhoTrong = :boNhoTrong";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("tenSanPham", tenSanPham);
        query.setParameter("mauSac", mauSac);
        query.setParameter("boNhoTrong", boNhoTrong);
        return (SanPhamEntity) query.uniqueResult(); // Trả về null nếu không tìm thấy
    }
    
    public List<String> layDanhSachBoNhoTheoMauSac(String tenSanPham, String mauSac) {
        try {
            // Giải mã tên sản phẩm và màu sắc từ URL-encoded
            tenSanPham = URLDecoder.decode(tenSanPham, "UTF-8");
            mauSac = URLDecoder.decode(mauSac, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        
        // In giá trị sau khi giải mã để kiểm tra
        System.out.println("Tên sản phẩm (giải mã): " + tenSanPham);
        System.out.println("Màu sắc (giải mã): " + mauSac);
        
        // Thực hiện truy vấn HQL
        String hql = "SELECT DISTINCT sp.boNhoTrong FROM SanPhamEntity sp WHERE sp.tenSanPham = :tenSanPham AND sp.mauSac = :mauSac AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("tenSanPham", tenSanPham);
        query.setParameter("mauSac", mauSac);
        
        List<String> result = query.list();
        System.out.println("Kết quả truy vấn: " + result);
        
        return result; 
    }
    
    public List<String> layDanhSachMauSacTheoBoNho(String tenSanPham, String boNho) {
        try {
            // Giải mã các tham số từ URL-encoded
            tenSanPham = URLDecoder.decode(tenSanPham, "UTF-8");
            boNho = URLDecoder.decode(boNho, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        
		/*
		 * // In giá trị sau khi giải mã để kiểm tra
		 * System.out.println("Tên sản phẩm (giải mã): " + tenSanPham);
		 * System.out.println("Bộ nhớ (giải mã): " + boNho);
		 */
        
        // Thực hiện truy vấn HQL
        
        String hql = "SELECT DISTINCT sp.mauSac FROM SanPhamEntity sp WHERE sp.tenSanPham = :tenSanPham AND sp.boNhoTrong = :boNhoTrong AND sp.trangThai = true";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("tenSanPham", tenSanPham);
        query.setParameter("boNhoTrong", boNho);
        
        // Lấy danh sách màu sắc
        List<String> result = query.list();
        
        // In kết quả truy vấn để kiểm tra
		/* System.out.println("Kết quả truy vấn: " + result); */
        
        return result; 
    }
    
    
    
    @Override
    public boolean kiemTraMaSanPhamTonTai(String maSP) {
        String hql = "SELECT COUNT(sp) FROM SanPhamEntity sp WHERE sp.maSP = :maSP";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter("maSP", maSP);

        Long count = (Long) query.uniqueResult(); // Trả về số lượng kết quả tìm thấy
        return count > 0; // Nếu số lượng > 0, mã sản phẩm đã tồn tại
    }
    
    @Override
    public void updateSoLuongSP(String maSP, int soLuong) {
    	String hql = "UPDATE SanPhamEntity sp SET sp.soLuong = :soLuong WHERE sp.maSP = :maSP";
    	Query query = sessionFactory.getCurrentSession().createQuery(hql);
    	query.setParameter("maSP", maSP);
    	query.setParameter("soLuong", soLuong);

    	// Thực thi lệnh cập nhật
    	query.executeUpdate();
    }
    
    @Override
    public void updateSoSaoSP(String maSP, float soSaoTB) {
    	String hql = "UPDATE SanPhamEntity sp SET sp.soSaoTB = :soSaoTB WHERE sp.maSP = :maSP";
    	Query query = sessionFactory.getCurrentSession().createQuery(hql);
    	query.setParameter("maSP", maSP);
    	query.setParameter("soSaoTB", soSaoTB);

    	// Thực thi lệnh cập nhật
    	query.executeUpdate();
    }
    

}
