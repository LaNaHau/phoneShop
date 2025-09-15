package ptithcm.dao;

import java.util.List;

import ptithcm.entity.NguoiDungEntity;

public interface nguoiDungDao{
	
	public void addUser(NguoiDungEntity user);
	public void updateUser(NguoiDungEntity user);
	public List<NguoiDungEntity>  getAllUserByRole(Integer maQuyen) throws Exception;
	public NguoiDungEntity findUserById(Integer maNd) throws Exception;
	public NguoiDungEntity findUserByNameAndEmail(String userName, String email) throws Exception;
	public List<NguoiDungEntity> findUserByName(String hoTen) throws Exception;
	public List<NguoiDungEntity> findUserByNames(String hoTen) throws Exception;
	public void updateTrangThaiUser(Integer maND, boolean trangThai);
}