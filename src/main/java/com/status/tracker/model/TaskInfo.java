package com.status.tracker.model;

import java.util.List;

public class TaskInfo {
	
	private TaskDetails taskDetails;
	private TaskDescription taskDescription;
	private List<CommentsDetails> commentsDetailsList;
	public TaskDetails getTaskDetails() {
		return taskDetails;
	}
	public void setTaskDetails(TaskDetails taskDetails) {
		this.taskDetails = taskDetails;
	}
	public TaskDescription getTaskDescription() {
		return taskDescription;
	}
	public void setTaskDescription(TaskDescription taskDescription) {
		this.taskDescription = taskDescription;
	}
	public List<CommentsDetails> getCommentsDetailsList() {
		return commentsDetailsList;
	}
	public void setCommentsDetailsList(List<CommentsDetails> commentsDetailsList) {
		this.commentsDetailsList = commentsDetailsList;
	}
	
	

}
