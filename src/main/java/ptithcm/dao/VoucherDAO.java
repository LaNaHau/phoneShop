package ptithcm.dao;

import java.util.List;

import ptithcm.entity.VoucherEntity;

public interface VoucherDAO {
	public VoucherEntity layVoucherTheoMa(String maVoucher) throws Exception;
	public List<VoucherEntity> layVoucher() throws Exception;
	
	public void themVoucher(VoucherEntity voucher);
	public void updateVoucher(VoucherEntity voucher);
	public void xoaVoucher(VoucherEntity voucher);
}