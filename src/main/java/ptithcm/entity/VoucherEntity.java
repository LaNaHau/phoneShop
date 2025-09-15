package ptithcm.entity;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="VOUCHER")
public class VoucherEntity {
	@Id
	@Column(name="MAVOUCHER")
	private String maVoucher;
	
	@Column(name="LOAI")
	private int loai;
	
	@Column(name="NOIDUNG")
	private float noiDung;
	
	@Column(name="SOLUONG")
	private int soLuong;
	
	@Column(name="TRANGTHAI")
	private int trangThai;

	public String getMaVoucher() {
		return maVoucher;
	}

	public void setMaVoucher(String maVoucher) {
		this.maVoucher = maVoucher;
	}

	public int getLoai() {
		return loai;
	}

	public void setLoai(int loai) {
		this.loai = loai;
	}

	public float getNoiDung() {
		return noiDung;
	}

	public void setNoiDung(float noiDung) {
		this.noiDung = noiDung;
	}

	public int getSoLuong() {
		return soLuong;
	}

	public void setSoLuong(int soLuong) {
		this.soLuong = soLuong;
	}

	public int getTrangThai() {
		return trangThai;
	}

	public void setTrangThai(int trangThai) {
		this.trangThai = trangThai;
	}
	
	
	
	
}

