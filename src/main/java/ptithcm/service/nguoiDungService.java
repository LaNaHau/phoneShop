package ptithcm.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ptithcm.entity.NguoiDungEntity;


@Service
@Transactional
public interface nguoiDungService{
	
	public void addUser(NguoiDungEntity user);
	public void updateUser(NguoiDungEntity user);
	public NguoiDungEntity findUserById(Integer maNd) throws Exception;
	public NguoiDungEntity findUserByNameAndEmail(String userName, String email) throws Exception;
	public List<NguoiDungEntity>  getAllUserByRole(Integer maQuyen) throws Exception;
	public String maHoaMatKhau(String str) ;
	public boolean kiemTraMatKhau(String password, String hashedPassword) ;
	public List<NguoiDungEntity> findUserByName(String hoTen) throws Exception;
	public List<NguoiDungEntity> findUserByNames(String hoTen) throws Exception;
	public void updateTrangThaiUser(Integer maND, boolean trangThai);
}