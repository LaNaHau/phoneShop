package ptithcm.service;
import java.util.List; // Required for List
import org.springframework.beans.factory.annotation.Autowired; // Required for @Autowired annotation
import org.springframework.stereotype.Service; // Required for @Service annotation
import org.springframework.transaction.annotation.Transactional; // Required for @Transactional annotation

import ptithcm.dao.VoucherDAO; // Required for VoucherDAO
import ptithcm.entity.VoucherEntity; // Required for VoucherEntity

@Service
@Transactional
public class VoucherServiceIpml implements VoucherService{
	
	@Autowired
	VoucherDAO voucherDao;

	@Override
	public VoucherEntity layVoucherTheoMa(String maVoucher) throws Exception {
		return voucherDao.layVoucherTheoMa(maVoucher);
	}

	@Override
	public List<VoucherEntity> layVoucher() throws Exception {
		return voucherDao.layVoucher();
	}

	@Override
	public void themVoucher(VoucherEntity voucher) {
		voucherDao.themVoucher(voucher);
	}

	@Override
	public void updateVoucher(VoucherEntity voucher) {
		voucherDao.updateVoucher(voucher);
	}

	@Override
	public void xoaVoucher(VoucherEntity voucher) {
		voucherDao.xoaVoucher(voucher);	
	}

}
