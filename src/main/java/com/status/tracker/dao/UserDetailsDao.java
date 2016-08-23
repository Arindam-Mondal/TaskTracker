package com.status.tracker.dao;

import com.status.tracker.model.UserDetails;

public interface UserDetailsDao {
	
	public UserDetails getUserDetailsById(String userid);

	public Boolean isDuplicateUserId(String userId);
	
	public void addUser(UserDetails userDetails) throws Exception;

}
