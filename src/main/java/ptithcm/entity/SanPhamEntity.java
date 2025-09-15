package ptithcm.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "SANPHAM")
public class SanPhamEntity {
	@Id
	@Column(name = "MASP")
	private String maSP;

	@Column(name = "TENSANPHAM")
	private String tenSanPham;

	@Column(name = "MOTA")
	private String moTa;

	@Column(name = "SOLUONG")
	private Integer soLuong;

	@Column(name = "DONGIA")
	private BigDecimal donGia;

	@Column(name = "TRANGTHAI")
	private Boolean trangThai;

	@Column(name = "SOSAOTB")
	private float soSaoTB;

	@Column(name = "GIAM_GIA")
    private Integer giamGia;
	
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "NGAYTHEM")
	private Date ngayThem;

	@Column(name = "MANHINH")
	private String manHinh;

	@Column(name = "KICHTHUOC_MANHINH")
	private String kichThuocManHinh;

	@Column(name = "DO_PHAN_GIAI")
	private String doPhanGiai;

	@Column(name = "CAMERA_SAU")
	private String cameraSau;

	@Column(name = "CAMERA_TRUOC")
	private String cameraTruoc;

	@Column(name = "CPU")
	private String cpu;

	@Column(name = "RAM")
	private String ram;

	@Column(name = "BO_NHO_TRONG")
	private String boNhoTrong;

	@Column(name = "PIN")
	private String pin;

	@Column(name = "HE_DIEU_HANH")
	private String heDieuHanh;

	@Column(name = "MAU_SAC")
	private String mauSac;

	@Column(name = "CONG_KET_NOI")
	private String congKetNoi;

	@Column(name = "KET_NOI_KHAC")
	private String ketNoiKhac;

	@Column(name = "KICH_THUOC")
	private String kichThuoc;

	@Column(name = "TRONG_LUONG")
	private String trongLuong;

	@ManyToOne
	@JoinColumn(name = "MAKIEU")
	private KieuSanPhamEntity maKieu;

	@ManyToOne
	@JoinColumn(name = "MAHINHANH")
	private HinhAnhEntity hinhAnh;

	@OneToMany(mappedBy = "sanPham", fetch = FetchType.LAZY)
	private List<GioHangEntity> gioHangs;

	@OneToMany(mappedBy = "sanPham", fetch = FetchType.LAZY)
	private List<DanhGiaEntity> danhGiaList;

	@OneToMany(mappedBy = "sanPham", fetch = FetchType.LAZY)
	private List<YeuThichEntity> yeuThichList;

	// Getters và Setters
	
	public Integer getGiamGia() {
		return giamGia;
	}

	public void setGiamGia(Integer giamGia) {
		this.giamGia = giamGia;
	}
	
	public String getMaSP() {
		return maSP;
	}

	public void setMaSP(String maSP) {
		this.maSP = maSP;
	}

	public String getTenSanPham() {
		return tenSanPham;
	}

	public void setTenSanPham(String tenSanPham) {
		this.tenSanPham = tenSanPham;
	}

	public String getMoTa() {
		return moTa;
	}

	public void setMoTa(String moTa) {
		this.moTa = moTa;
	}

	public Integer getSoLuong() {
		return soLuong;
	}

	public void setSoLuong(Integer soLuong) {
		this.soLuong = soLuong;
	}

	public BigDecimal getDonGia() {
		return donGia;
	}

	public void setDonGia(BigDecimal donGia) {
		this.donGia = donGia;
	}

	public Boolean getTrangThai() {
		return trangThai;
	}

	public void setTrangThai(Boolean trangThai) {
		this.trangThai = trangThai;
	}

	public float getSoSaoTB() {
		return soSaoTB;
	}

	public void setSoSaoTB(float soSaoTB) {
		this.soSaoTB = soSaoTB;
	}

	public Date getNgayThem() {
		return ngayThem;
	}

	public void setNgayThem(Date ngayThem) {
		this.ngayThem = ngayThem;
	}

	public String getManHinh() {
		return manHinh;
	}

	public void setManHinh(String manHinh) {
		this.manHinh = manHinh;
	}

	public String getKichThuocManHinh() {
		return kichThuocManHinh;
	}

	public void setKichThuocManHinh(String kichThuocManHinh) {
		this.kichThuocManHinh = kichThuocManHinh;
	}

	public String getDoPhanGiai() {
		return doPhanGiai;
	}

	public void setDoPhanGiai(String doPhanGiai) {
		this.doPhanGiai = doPhanGiai;
	}

	public String getCameraSau() {
		return cameraSau;
	}

	public void setCameraSau(String cameraSau) {
		this.cameraSau = cameraSau;
	}

	public String getCameraTruoc() {
		return cameraTruoc;
	}

	public void setCameraTruoc(String cameraTruoc) {
		this.cameraTruoc = cameraTruoc;
	}

	public String getCpu() {
		return cpu;
	}

	public void setCpu(String cpu) {
		this.cpu = cpu;
	}

	public String getRam() {
		return ram;
	}

	public void setRam(String ram) {
		this.ram = ram;
	}

	public String getBoNhoTrong() {
		return boNhoTrong;
	}

	public void setBoNhoTrong(String boNhoTrong) {
		this.boNhoTrong = boNhoTrong;
	}

	public String getPin() {
		return pin;
	}

	public void setPin(String pin) {
		this.pin = pin;
	}

	public String getHeDieuHanh() {
		return heDieuHanh;
	}

	public void setHeDieuHanh(String heDieuHanh) {
		this.heDieuHanh = heDieuHanh;
	}

	public String getMauSac() {
		return mauSac;
	}

	public void setMauSac(String mauSac) {
		this.mauSac = mauSac;
	}

	public String getCongKetNoi() {
		return congKetNoi;
	}

	public void setCongKetNoi(String congKetNoi) {
		this.congKetNoi = congKetNoi;
	}

	public String getKetNoiKhac() {
		return ketNoiKhac;
	}

	public void setKetNoiKhac(String ketNoiKhac) {
		this.ketNoiKhac = ketNoiKhac;
	}

	public String getKichThuoc() {
		return kichThuoc;
	}

	public void setKichThuoc(String kichThuoc) {
		this.kichThuoc = kichThuoc;
	}

	public String getTrongLuong() {
		return trongLuong;
	}

	public void setTrongLuong(String trongLuong) {
		this.trongLuong = trongLuong;
	}

	public KieuSanPhamEntity getMaKieu() {
		return maKieu;
	}

	public void setMaKieu(KieuSanPhamEntity maKieu) {
		this.maKieu = maKieu;
	}

	public HinhAnhEntity getHinhAnh() {
		return hinhAnh;
	}

	public void setHinhAnh(HinhAnhEntity hinhAnh) {
		this.hinhAnh = hinhAnh;
	}

	public List<GioHangEntity> getGioHangs() {
		return gioHangs;
	}

	public void setGioHangs(List<GioHangEntity> gioHangs) {
		this.gioHangs = gioHangs;
	}

	public List<DanhGiaEntity> getDanhGiaList() {
		return danhGiaList;
	}

	public void setDanhGiaList(List<DanhGiaEntity> danhGiaList) {
		this.danhGiaList = danhGiaList;
	}

	public List<YeuThichEntity> getYeuThichList() {
		return yeuThichList;
	}

	public void setYeuThichList(List<YeuThichEntity> yeuThichList) {
		this.yeuThichList = yeuThichList;
	}

	@Override
	public String toString() {
		return "SanPhamEntity{" + "maSP='" + maSP + '\'' + ", tenSanPham='" + tenSanPham + '\'' + ", moTa='" + moTa
				+ '\'' + ", soLuong=" + soLuong + ", donGia=" + donGia + ", trangThai=" + trangThai + ", soSaoTB="
				+ soSaoTB + ", ngayThem=" + ngayThem + ", manHinh='" + manHinh + '\'' + ", kichThuocManHinh='"
				+ kichThuocManHinh + '\'' + ", doPhanGiai='" + doPhanGiai + '\'' + ", cameraSau='" + cameraSau + '\''
				+ ", cameraTruoc='" + cameraTruoc + '\'' + ", cpu='" + cpu + '\'' + ", ram='" + ram + '\''
				+ ", boNhoTrong='" + boNhoTrong + '\'' + ", pin='" + pin + '\'' + ", heDieuHanh='" + heDieuHanh + '\''
				+ ", mauSac='" + mauSac + '\'' + ", congKetNoi='" + congKetNoi + '\'' + ", ketNoiKhac='" + ketNoiKhac
				+ '\'' + ", kichThuoc='" + kichThuoc + '\'' + ", trongLuong='" + trongLuong + '\'' + ", maKieu="
				+ (maKieu != null ? maKieu.getMaKieu() + " - " + maKieu.getTenKieu() : "null") + ", hinhAnh="
				+ (hinhAnh != null ? hinhAnh.getLink() : "null") + '}';
	}

}
