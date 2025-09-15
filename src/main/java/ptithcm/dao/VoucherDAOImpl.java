package ptithcm.dao;

import java.util.ArrayList;
import java.util.List; // Required for List
import org.hibernate.Session; // Required for Hibernate Session
import org.hibernate.SessionFactory; // Required for Hibernate SessionFactory
import org.hibernate.Transaction; // Required for Transaction handling
import org.springframework.beans.factory.annotation.Autowired; // Required for @Autowired annotation
import org.springframework.stereotype.Repository; // Required for @Repository annotation
import org.hibernate.Query;

import ptithcm.encrypt.AesEncrypt;
import ptithcm.entity.VoucherEntity; // Required for VoucherEntity class

@Repository
public class VoucherDAOImpl implements VoucherDAO {
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public VoucherEntity layVoucherTheoMa(String maVoucher) throws Exception {
		maVoucher = AesEncrypt.aesEncrypt(maVoucher, AesEncrypt.aesKey128);
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM VoucherEntity v WHERE v.maVoucher = :maVoucher";
		Query query = session.createQuery(hql);
		query.setParameter("maVoucher", maVoucher);
		VoucherEntity voucher = (VoucherEntity) query.uniqueResult();
		if (voucher == null) {
			return null;
		} else {
			VoucherEntity clonedVoucher = new VoucherEntity();
			clonedVoucher.setMaVoucher(AesEncrypt.aesDecrypt(voucher.getMaVoucher(), AesEncrypt.aesKey128));
			clonedVoucher.setLoai(voucher.getLoai());
			clonedVoucher.setNoiDung(voucher.getNoiDung());
			clonedVoucher.setSoLuong(voucher.getSoLuong());
			clonedVoucher.setTrangThai(voucher.getTrangThai());
			return clonedVoucher;	
		}
	}

	@Override
	public List<VoucherEntity> layVoucher() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM VoucherEntity ORDER BY maVoucher ASC";
		Query query = session.createQuery(hql);
	    List<VoucherEntity> listVoucher = query.list();
	    List<VoucherEntity> clonedList = new ArrayList<>();

		for (VoucherEntity voucher : listVoucher) {
			VoucherEntity clonedVoucher = new VoucherEntity();
			clonedVoucher.setMaVoucher(AesEncrypt.aesDecrypt(voucher.getMaVoucher(), AesEncrypt.aesKey128));
			clonedVoucher.setLoai(voucher.getLoai());
			clonedVoucher.setNoiDung(voucher.getNoiDung());
			clonedVoucher.setSoLuong(voucher.getSoLuong());
			clonedVoucher.setTrangThai(voucher.getTrangThai());

			clonedList.add(clonedVoucher);
		}
		return clonedList;
	}

	@Override
	public void themVoucher(VoucherEntity voucher) {
		Session session=sessionFactory.openSession();
		Transaction t = session.beginTransaction();
		try {
			voucher.setMaVoucher(AesEncrypt.aesEncrypt(voucher.getMaVoucher(), AesEncrypt.aesKey128));
			session.save(voucher);
			t.commit();

		} catch (Exception ex) {
			t.rollback();
			System.out.print("loi");

		} finally {
			session.close();
		}
	}

	@Override
	public void updateVoucher(VoucherEntity voucher) {
		Session session=sessionFactory.openSession();
		Transaction t = session.beginTransaction();
		try {
			voucher.setMaVoucher(AesEncrypt.aesEncrypt(voucher.getMaVoucher(), AesEncrypt.aesKey128));
			session.update(voucher);
			t.commit();

		} catch (Exception ex) {
			t.rollback();
			System.out.print("loi");

		} finally {
			session.close();
		}

	}

	@Override
	public void xoaVoucher(VoucherEntity voucher) {
		sessionFactory.getCurrentSession().delete(voucher);

	}

}
