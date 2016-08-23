package com.status.tracker.service;

import com.status.tracker.model.UserDetails;

public interface LoginService {
	public UserDetails getUserDetailsById(String userid);

	public Boolean isDuplicateUserId(String userId);
	
	void addUser(UserDetails userDetails) throws Exception;

}
