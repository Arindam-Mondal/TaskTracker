package com.status.tracker.service;

import java.util.List;

import com.status.tracker.model.CommentsDetails;
import com.status.tracker.model.TaskDescription;
import com.status.tracker.model.TaskDetails;
import com.status.tracker.model.TaskInfo;

public interface TaskService {
	
	public List<TaskInfo> displayTask(String userId);
	public void addTask(TaskDetails taskDetails,TaskDescription taskDescription);
	public void addTask(String taskname,String userid,String status,String starttime,String endtime);
	public void addComments(CommentsDetails commentsDetails) throws Exception;
	public List<TaskInfo> searchTask(String searchkey);
	public TaskInfo displaySingleTask(String userid, String taskId);
	public void editTask(TaskDetails task, TaskDescription desc);
	public void deleteTask(String taskid);
	public void updateStatus(String taskid);
	public String findTaskCreator(String taskId);

}
