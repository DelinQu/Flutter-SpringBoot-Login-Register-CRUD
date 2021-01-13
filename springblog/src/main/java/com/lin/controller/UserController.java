package com.lin.controller;

import com.lin.entity.User;
import com.lin.service.LoginService;
import com.lin.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/user")
public class UserController {
	@Autowired
	LoginService loginService;
	@Autowired
	RegisterService registerService;


	//发送验证码
	@PostMapping(value="/send")
	public String send(@RequestBody User user) {
		return registerService.send(user);
	}

	//注册
	@PostMapping(value="/register")
	public String registerUser(@RequestBody User user,@RequestParam("token") String token) {
		return registerService.registerUser(user,token);
	}

	// Login
	@PostMapping(value="/login")
	public String loginUser(@RequestBody User user) {
		return loginService.loginUser(user);
	}
}
