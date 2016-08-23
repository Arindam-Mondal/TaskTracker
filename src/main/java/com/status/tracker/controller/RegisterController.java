package com.status.tracker.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import com.status.tracker.model.UserDetails;
import com.status.tracker.service.LoginService;

@Controller
@RequestMapping(value="/application")
public class RegisterController {
	
	private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
	
	@Autowired
	LoginService loginService;
	
	@RequestMapping(value="/registerUser")
	public String registerUser(@ModelAttribute("userDetails") UserDetails userDetails,
							   Model model,
							   HttpSession session){
		
		System.out.println(userDetails.getDateOfBirth());
		
		if(userDetails.getDateOfBirth().equals(null)||
				null==userDetails.getEmail()||userDetails.getEmail().equals("")||userDetails.getEmail().trim().isEmpty()||
				null==userDetails.getName()||userDetails.getName().equals("")||userDetails.getName().trim().isEmpty()||
				null==userDetails.getPassword()||userDetails.getPassword().equals("")||userDetails.getPassword().trim().isEmpty()||
				null==userDetails.getUserId()||userDetails.getUserId().equals("")||userDetails.getUserId().trim().isEmpty()){
			
			model.addAttribute("registermessage","All fields are mandatory");
			model.addAttribute("userDetails", new UserDetails());
			return "register";
		}
		
		
		System.out.println(userDetails.getUserId());
		Boolean isDuplicateUserId = loginService.isDuplicateUserId(userDetails.getUserId());
		if(!isDuplicateUserId){
			try {
				loginService.addUser(userDetails);
				model.addAttribute("name", userDetails.getName());
				session.setAttribute("name", userDetails.getName());
				session.setAttribute("userid", userDetails.getUserId());
				return "dashboard";
			} catch (Exception e) {
				logger.error(e.getMessage());
				return "error";
			}
		}else{
			return "register";
		}
		
		
	}
}
