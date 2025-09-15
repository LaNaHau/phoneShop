package ptithcm.service;

import java.util.List; // Required for List
import org.springframework.stereotype.Service; // Required for @Service annotation
import org.springframework.transaction.annotation.Transactional; // Required for @Transactional annotation

import ptithcm.entity.VoucherEntity; // Required for VoucherEntity class

@Service
@Transactional
public interface VoucherService {
	public VoucherEntity layVoucherTheoMa(String maVoucher) throws Exception;
	public List<VoucherEntity> layVoucher() throws Exception;
	
	public void themVoucher(VoucherEntity voucher);
	public void updateVoucher(VoucherEntity voucher);
	public void xoaVoucher(VoucherEntity voucher);
}
