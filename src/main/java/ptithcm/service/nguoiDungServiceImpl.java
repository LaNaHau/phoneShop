package ptithcm.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.mindrot.jbcrypt.BCrypt;
import ptithcm.entity.NguoiDungEntity;
import ptithcm.dao.nguoiDungDao;

@Transactional
@Service

public class nguoiDungServiceImpl implements nguoiDungService{

	@Autowired
	nguoiDungDao nguoiDungDao;
	
	@Override
	public void addUser(NguoiDungEntity user) {
		nguoiDungDao.addUser(user);
		
	}

	@Override
	public void updateUser(NguoiDungEntity user) {
		nguoiDungDao.updateUser(user);
		
	}

	@Override
	public NguoiDungEntity findUserById(Integer maNd) throws Exception {
		return nguoiDungDao.findUserById(maNd);
	}

	@Override
	public NguoiDungEntity findUserByNameAndEmail(String userName, String email) throws Exception {
		return nguoiDungDao.findUserByNameAndEmail(userName, email);
	}

	@Override
	public String maHoaMatKhau(String str) {
	    String hashedPassword = BCrypt.hashpw(str, BCrypt.gensalt());
	    return hashedPassword;
	}
	
	@Override
	public boolean kiemTraMatKhau(String password, String hashedPassword) {
	    return BCrypt.checkpw(password, hashedPassword);
	}

	@Override
	public List<NguoiDungEntity> getAllUserByRole(Integer maQuyen) throws Exception {
		return nguoiDungDao.getAllUserByRole(maQuyen);
	}
	@Override
	public List<NguoiDungEntity> findUserByName(String hoTen) throws Exception{
		return nguoiDungDao.findUserByName(hoTen);
	}
	
	@Override
	public List<NguoiDungEntity> findUserByNames(String hoTen) throws Exception{
		return nguoiDungDao.findUserByNames(hoTen);
	}
	
	
	@Override
	public void updateTrangThaiUser(Integer maND, boolean trangThai) {
		nguoiDungDao.updateTrangThaiUser(maND, trangThai);
	}
}