package com.status.tracker.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.status.tracker.model.UserDetails;

public class UserDetailsDaoImpl implements UserDetailsDao{
	
	private static final Logger logger = LoggerFactory.getLogger(UserDetailsDaoImpl.class);
	
	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sessionFactory){
		this.sessionFactory = sessionFactory;
	}

	@Override
	public UserDetails getUserDetailsById(String userid) {
		
		Session session = this.sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(UserDetails.class);
		criteria.add(Restrictions.eq("userId",userid));
		List<UserDetails> userDetails = criteria.list();
		
		if(userDetails.isEmpty()){
			return new UserDetails();
		}else{
			logger.info("User info retrieved successfully"+ userDetails.get(0));
			return userDetails.get(0);
		}
		/*UserDetails userDetails = (UserDetails) session.load(UserDetails.class, new String(userid));
		logger.info("User info retrieved successfully"+ userDetails);
		return userDetails;*/
	}

	@Override
	public Boolean isDuplicateUserId(String userId) {
		
		Session session = this.sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(UserDetails.class);
		criteria.add(Restrictions.eq("userId",userId));
		List<UserDetails> userDetails = criteria.list();
		
		if(userDetails.isEmpty()){
			return false;
		}else{
			logger.info("User info retrieved successfully"+ userDetails.get(0));
			return true;
		}
	}

	@Override
	public void addUser(UserDetails userDetails) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		//Transaction tx = session.beginTransaction();
		try{
			
			session.save(userDetails);
			session.flush();
			//tx.commit();
			
		}catch(Exception e){
			//tx.rollback();
			throw new Exception(e);
		}
		
	}

}
