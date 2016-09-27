package com.status.tracker.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.status.tracker.model.TaskDetails;
import com.status.tracker.model.TaskInfo;
import com.status.tracker.model.UserDetails;
import com.status.tracker.service.LoginService;
import com.status.tracker.service.TaskService;

@Controller
@RequestMapping(value="/application")
@SessionAttributes("username")
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService loginService;
	@Autowired
	private TaskService taskService;
	
	@RequestMapping(value="/login"/*, method=RequestMethod.POST*/)
	public String validateUser(@RequestParam("username") String username,
							   @RequestParam("password") String password,
							   Model model,
							   HttpSession session,
							   HttpServletResponse response,HttpServletRequest request){
		
		logger.info("In loggin controller");
		try{
			UserDetails userDetails = loginService.getUserDetailsById(username);
			if(userDetails.getPassword()== null){
				model.addAttribute("errormsg", "Wrong username or password.");
				return "login";
			}
			if(userDetails.getPassword().equals(password)){
				
				model.addAttribute("name", userDetails.getName());
				session.setAttribute("name", userDetails.getName());
				session.setAttribute("userid", userDetails.getUserId());
				System.out.println(request.getContextPath());
				response.sendRedirect(request.getContextPath()+"/application/displayTask");
				
				/*List<TaskInfo> taskDetails = taskService.displayTask(username);
				model.addAttribute("name", userDetails.getName());
				session.setAttribute("name", userDetails.getName());
				session.setAttribute("userid", userDetails.getUserId());
				model.addAttribute("taskDetails", taskDetails);*/
				return "dashboard";
			}else{
				model.addAttribute("errormsg", "Wrong username or password.");
				return "login";
			}
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
			return "login";
		}
		
	}

}
