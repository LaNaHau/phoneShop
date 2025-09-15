package ptithcm.dto;

import java.math.BigDecimal;
import java.util.List;

public class SanPhamDTO {
    private String maSP;
    private String tenSanPham;
    private List<String> mauSacs; // Danh sách các màu
    private List<String> dungLuongs; // Danh sách các dung lượng (RAM/Bộ nhớ)
    private List<BigDecimal> giaBan; // Danh sách giá tương ứng
    private List<String> images; // List of all images for this product group
    private String randomImage; // Randomly selected image
    private Boolean trangThai;
    
    
    
    public String getRandomImage() {
        return randomImage;
    }

    public void setRandomImage(String randomImage) {
        this.randomImage = randomImage;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }
    
	public String getMaSP() {
		return maSP;
	}
	public void setMaSP(String maSP) {
		this.maSP = maSP;
	}
	public List<String> getMauSacs() {
		return mauSacs;
	}
	public void setMauSacs(List<String> mauSacs) {
		this.mauSacs = mauSacs;
	}
	public String getTenSanPham() {
		return tenSanPham;
	}
	public void setTenSanPham(String tenSanPham) {
		this.tenSanPham = tenSanPham;
	}
	public List<BigDecimal> getGiaBan() {
		return giaBan;
	}
	public void setGiaBan(List<BigDecimal> giaBan) {
		this.giaBan = giaBan;
	}
	public Boolean getTrangThai() {
		return trangThai;
	}
	public void setTrangThai(Boolean trangThai) {
		this.trangThai = trangThai;
	}
	public List<String> getDungLuongs() {
		return dungLuongs;
	}
	public void setDungLuongs(List<String> dungLuongs) {
		this.dungLuongs = dungLuongs;
	}

    // Getter và Setter
}
