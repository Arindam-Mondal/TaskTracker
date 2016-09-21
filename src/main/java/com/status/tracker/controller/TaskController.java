package com.status.tracker.controller;

import java.util.Date;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.status.tracker.model.CommentsDetails;
import com.status.tracker.model.TaskDescription;
import com.status.tracker.model.TaskDetails;
import com.status.tracker.model.TaskInfo;
import com.status.tracker.service.TaskService;

@Controller
@RequestMapping(value = "/application")
public class TaskController {

	private static final Logger logger = LoggerFactory.getLogger(TaskController.class);
	@Autowired
	private TaskService taskService;

	@RequestMapping(value = "/addTask")
	public String addTask(@RequestParam("taskname") String taskname, @RequestParam("starttime") String starttime,
			@RequestParam("endtime") String endtime, @RequestParam("taskdesc") String taskdesc, Model model,
			HttpSession session, HttpServletResponse response) {

		if (null == session.getAttribute("userid")) {
			return "login";
		}

		String name = session.getAttribute("name").toString();
		String userid = session.getAttribute("userid").toString();

		if (null == taskname || taskname.equals("") || taskname.trim().isEmpty() || null == starttime
				|| starttime.equals("") || starttime.trim().isEmpty() || null == endtime || endtime.equals("")
				|| endtime.trim().isEmpty() || null == taskdesc || taskdesc.equals("") || taskdesc.trim().isEmpty()) {

			model.addAttribute("name", name);

			List<TaskInfo> taskDetails = taskService.displayTask(userid);
			model.addAttribute("taskDetails", taskDetails);
			model.addAttribute("message", "All fields are mandatory");
			return "dashboard";

		}

		model.addAttribute("name", name);

		System.out.println(taskname);
		System.out.println(starttime);
		System.out.println(endtime);
		System.out.println(taskdesc);
		System.out.println(session.getAttribute("name"));
		String status = "Pending";

		TaskDetails task = new TaskDetails();
		/* task.setTaskid("TASK1002"); */
		task.setTaskname(taskname);
		task.setUserid(userid);
		task.setStatus("Pending");
		Date date = new Date();
		Timestamp timestamp = new Timestamp(date.getTime());
		task.setCreated(timestamp);
		task.setModified(timestamp);

		String dateStr = starttime;
		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		try {
			Date startDate = (Date) formatter.parse(dateStr);
			task.setStarttime(startDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		dateStr = endtime;
		try {
			Date endDate = (Date) formatter.parse(dateStr);
			task.setEndtime(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		TaskDescription desc = new TaskDescription();
		desc.setTaskdesc(taskdesc);
		taskService.addTask(task, desc);

		List<TaskInfo> taskDetails = taskService.displayTask(userid);
		model.addAttribute("taskDetails", taskDetails);

		return "dashboard";
	}

	/*
	 * @RequestMapping(value = "/addComments") public String
	 * addComments(@RequestParam("comments") String
	 * comments, @RequestParam("taskid") String taskid, Model model, HttpSession
	 * session, HttpServletResponse response) {
	 * 
	 * if (null == session.getAttribute("userid")) { return "login"; }
	 * 
	 * String userid = session.getAttribute("userid").toString();
	 * 
	 * if (null == comments || comments.equals("") || comments.trim().isEmpty())
	 * { String name = session.getAttribute("name").toString();
	 * model.addAttribute("name", name);
	 * 
	 * List<TaskInfo> taskDetails = taskService.displayTask(userid);
	 * model.addAttribute("taskDetails", taskDetails); return "dashboard"; }
	 * 
	 * CommentsDetails commentsDetails = new CommentsDetails();
	 * commentsDetails.setTaskid(taskid); commentsDetails.setUserid(userid);
	 * commentsDetails.setComments(comments); Date date = new Date(); Timestamp
	 * timestamp = new Timestamp(date.getTime());
	 * commentsDetails.setCreated(timestamp);
	 * 
	 * try { taskService.addComments(commentsDetails); } catch (Exception e) {
	 * e.printStackTrace(); return "error"; }
	 * 
	 * String name = session.getAttribute("name").toString();
	 * model.addAttribute("name", name);
	 * 
	 * List<TaskInfo> taskDetails = taskService.displayTask(userid);
	 * model.addAttribute("taskDetails", taskDetails);
	 * 
	 * return "dashboard"; }
	 */

	@RequestMapping(value = "/addComments", method = RequestMethod.POST)
	public @ResponseBody boolean addComments(@RequestParam("taskid") String taskid,
			@RequestParam("comments") String comments, HttpSession session) {
		// System.out.println("inside addcomments");

		try {
			String userid = session.getAttribute("userid").toString();
			System.out.println("comments:" + comments + " taskid:" + taskid + " userid:" + userid);
			CommentsDetails commentsDetails = new CommentsDetails();
			commentsDetails.setTaskid(taskid);
			commentsDetails.setUserid(userid);
			commentsDetails.setComments(comments);
			Date date = new Date();
			Timestamp timestamp = new Timestamp(date.getTime());
			commentsDetails.setCreated(timestamp);
			taskService.addComments(commentsDetails);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@RequestMapping(value = "/searchTask")
	public String searchTask(@RequestParam("searchkey") String searchkey, Model model, HttpSession session,
			HttpServletResponse response) {

		if (null == session.getAttribute("userid")) {
			return "login";
		}
		String name = session.getAttribute("name").toString();
		model.addAttribute("name", name);

		List<TaskInfo> taskDetails = taskService.searchTask(searchkey);
		model.addAttribute("taskDetails", taskDetails);

		return "dashboard";
	}

	@RequestMapping(value = "/displayTask")
	public String displayTask(Model model, HttpSession session, HttpServletResponse response) {

		if (null == session.getAttribute("userid")) {
			return "login";
		}
		String name = session.getAttribute("name").toString();
		String userid = session.getAttribute("userid").toString();
		model.addAttribute("name", name);
		

		List<TaskInfo> taskDetails = taskService.displayTask(userid);
		model.addAttribute("taskDetails", taskDetails);

		return "dashboard";
	}

	@RequestMapping(value = "/taskDetails/{taskId}")
	public String taskDetails(@PathVariable String taskId, Model model, HttpSession session,
			HttpServletResponse response) {

		if (null == session.getAttribute("userid")) {
			return "login";
		}

		System.out.println(taskId);
		String name = session.getAttribute("name").toString();
		String userid = session.getAttribute("userid").toString();
		model.addAttribute("name", name);
		
		String taskCreator = taskService.findTaskCreator(taskId);
		

		TaskInfo taskDetails = taskService.displaySingleTask(taskCreator, taskId);
		model.addAttribute("taskDetails", taskDetails);

		return "taskdetails";
	}

	// editTask
	@RequestMapping(value = "/editTask")
	public String editTask(@RequestParam("taskid") String taskid, @RequestParam("taskname") String taskname,
			@RequestParam("starttime") String starttime, @RequestParam("endtime") String endtime,
			@RequestParam("taskdesc") String taskdesc, @RequestParam("status") String status, Model model,
			HttpSession session, HttpServletResponse response) {

		System.out.println("inside editTask");

		if (null == session.getAttribute("userid")) {
			return "login";
		}
		String name = session.getAttribute("name").toString();
		String userid = session.getAttribute("userid").toString();

		if (null == taskid || taskid.equals("") || taskid.trim().isEmpty() || null == taskname || taskname.equals("")
				|| taskname.trim().isEmpty() || null == starttime || null == starttime || starttime.equals("")
				|| starttime.trim().isEmpty() || null == endtime || endtime.equals("") || endtime.trim().isEmpty()
				|| null == taskdesc || taskdesc.equals("") || taskdesc.trim().isEmpty() || null == status
				|| status.equals("") || status.trim().isEmpty()) {

			model.addAttribute("name", name);

			TaskInfo taskDetails = taskService.displaySingleTask(userid, taskid);
			model.addAttribute("taskDetails", taskDetails);
			model.addAttribute("message", "All fields are mandatory");

			return "taskdetails";
		}

		// Setting the values to update task details

		TaskDetails task = new TaskDetails();
		task.setTaskid(taskid);
		task.setTaskname(taskname);
		task.setUserid(userid);
		task.setStatus(status);
		Date date = new Date();
		Timestamp timestamp = new Timestamp(date.getTime());
		task.setCreated(timestamp);
		task.setModified(timestamp);

		String dateStr = starttime;
		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		try {
			Date startDate = (Date) formatter.parse(dateStr);
			task.setStarttime(startDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		dateStr = endtime;
		try {
			Date endDate = (Date) formatter.parse(dateStr);
			task.setEndtime(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		// calling the editTask method to update the task details
		TaskDescription desc = new TaskDescription();
		desc.setTaskid(taskid);
		desc.setTaskdesc(taskdesc);
		taskService.editTask(task, desc);

		// Returning back the control to taskdetails.jsp page with the task
		// details which has been updated
		TaskInfo taskDetails = taskService.displaySingleTask(userid, taskid);
		model.addAttribute("taskDetails", taskDetails);

		return "taskdetails";
	}

	@RequestMapping(value = "/taskDelete/{taskid}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public boolean deleteTask(@PathVariable String taskid) {
		try {
			taskService.deleteTask(taskid);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
	public @ResponseBody boolean updateStatus(@RequestParam("taskid") String taskid){
		try{
			taskService.updateStatus(taskid);
			return true;
		}catch(Exception e){
			return false;
		}
	}

}
