package ptithcm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "CTGIOHANG")
public class GioHangEntity {
    @Id
    @GeneratedValue
    @Column(name = "MAGH")
    private int maGh;

    @ManyToOne
    @JoinColumn(name = "MAND")
    private NguoiDungEntity nguoiDung;

    @ManyToOne
    @JoinColumn(name = "MASP")
    private SanPhamEntity sanPham;

    @Column(name = "SOLUONG")
    private int soLuong;


    public int getMaGh() {
        return maGh;
    }

    public void setMaGh(int maGh) {
        this.maGh = maGh;
    }

    public NguoiDungEntity getNguoiDung() {
        return nguoiDung;
    }

    public void setNguoiDung(NguoiDungEntity nguoiDung) {
        this.nguoiDung = nguoiDung;
    }

    public SanPhamEntity getSanPham() {
        return sanPham;
    }

    public void setSanPham(SanPhamEntity sanPham) {
        this.sanPham = sanPham;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

}
