package com.status.tracker.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.status.tracker.dao.TaskDetailsDao;
import com.status.tracker.model.CommentsDetails;
import com.status.tracker.model.TaskDescription;
import com.status.tracker.model.TaskDetails;
import com.status.tracker.model.TaskInfo;

public class TaskServiceImpl implements TaskService{
	
	private TaskDetailsDao taskDetailsDao;
	
	

	public TaskDetailsDao getTaskDetailsDao() {
		return taskDetailsDao;
	}



	public void setTaskDetailsDao(TaskDetailsDao taskDetailsDao) {
		this.taskDetailsDao = taskDetailsDao;
	}



	@Override
	@Transactional
	public List<TaskInfo> displayTask(String userId) {
		
		return this.taskDetailsDao.displayTask(userId);
	}



	@Override
	@Transactional
	public void addTask(String taskname, String userid, String status, String starttime, String endtime) {
		this.taskDetailsDao.addTask(taskname, userid, status, starttime, endtime);
		
	}



	@Override
	@Transactional
	public void addTask(TaskDetails taskDetails,TaskDescription taskDescription) {
		this.taskDetailsDao.addTask(taskDetails,taskDescription);
		
	}



	@Override
	@Transactional
	public void addComments(CommentsDetails commentsDetails) throws Exception {
		this.taskDetailsDao.addComments(commentsDetails);
		
	}



	@Override
	@Transactional
	public List<TaskInfo> searchTask(String searchkey) {
		return this.taskDetailsDao.searchTask(searchkey);
		
	}



	@Override
	@Transactional
	public TaskInfo displaySingleTask(String userid, String taskId) {
		
		return this.taskDetailsDao.displaySingleTask(userid,taskId);
	}



	@Override
	@Transactional
	public void editTask(TaskDetails task, TaskDescription desc) {
		this.taskDetailsDao.editTask(task,desc);
		
	}



	@Override
	@Transactional
	public void deleteTask(String taskid) {
		this.taskDetailsDao.deleteTask(taskid);
	}



	@Override
	@Transactional
	public void updateStatus(String taskid) {
		this.taskDetailsDao.updateStatus(taskid);
		
	}



	@Override
	@Transactional
	public String findTaskCreator(String taskid) {
		
		return this.taskDetailsDao.findTaskCreator(taskid);
	}

}
