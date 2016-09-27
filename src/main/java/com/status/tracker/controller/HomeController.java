package com.status.tracker.controller;


import java.io.IOException;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.status.tracker.model.TaskInfo;
import com.status.tracker.model.UserDetails;
import com.status.tracker.service.LoginService;
import com.status.tracker.service.TaskService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private LoginService loginService;
	@Autowired
	private TaskService taskService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpSession session,HttpServletResponse response,HttpServletRequest request) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		if(null!=session.getAttribute("userid")){
			
			try {
				response.sendRedirect(request.getContextPath()+"/application/displayTask");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return "login";
	}
	
	@RequestMapping(value="/register")
	public String register(Model model){
		model.addAttribute("userDetails", new UserDetails());
		return "register";
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session){
		session.removeAttribute("userid");
		session.removeAttribute("name");
		return "login";
	}
	
}
