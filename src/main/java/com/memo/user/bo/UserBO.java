package com.memo.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.memo.user.dao.UserDAO;
import com.memo.user.model.User;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	
	public User getUserById (String loginId) {
		return userDAO.selectUserById(loginId);
	}
	
	public int addUser (String loginId, String password, String name, String email) {
		return userDAO.insertUser(loginId, password, name, email);
	}
	
}
