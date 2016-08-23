package com.status.tracker.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.status.tracker.dao.UserDetailsDao;
import com.status.tracker.model.UserDetails;

@Service
public class LoginServiceImpl implements LoginService{
	
	private UserDetailsDao userDetailsDao;

	public UserDetailsDao getUserDetailsDao() {
		return userDetailsDao;
	}

	public void setUserDetailsDao(UserDetailsDao userDetailsDao) {
		this.userDetailsDao = userDetailsDao;
	}

	@Override
	@Transactional
	public UserDetails getUserDetailsById(String userid) {
		
		return this.userDetailsDao.getUserDetailsById(userid);
	}

	@Override
	@Transactional
	public Boolean isDuplicateUserId(String userId) {
		return this.userDetailsDao.isDuplicateUserId(userId);
	}

	@Override
	@Transactional
	public void addUser(UserDetails userDetails) throws Exception {
		this.userDetailsDao.addUser(userDetails);
		
	}
}
