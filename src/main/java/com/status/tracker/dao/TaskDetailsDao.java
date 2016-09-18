package com.status.tracker.dao;

import java.util.List;

import com.status.tracker.model.CommentsDetails;
import com.status.tracker.model.TaskDescription;
import com.status.tracker.model.TaskDetails;
import com.status.tracker.model.TaskInfo;

public interface TaskDetailsDao {
	
	public void addTask(TaskDetails taskDetails,TaskDescription desc);
	public void addTask(String taskname,String userid,String status,String starttime,String endtime);
	public List<TaskInfo> searchTask(String keyword);
	public List<TaskInfo> displayTask(String userId);
	public void addComments(CommentsDetails commentsDetails) throws Exception;
	public TaskInfo displaySingleTask(String userid, String taskId);
	public void editTask(TaskDetails task, TaskDescription desc);

}
