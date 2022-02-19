package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.user.bo.UserBO;
import com.memo.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	@RequestMapping("/is_duplicated_id")
	public Map<String, Boolean> isDuplication(
			@RequestParam("loginId") String loginId) {
		
		// DB select
		User is_duplication = userBO.getUserById(loginId);
		
		// return map
		Map<String, Boolean> result = new HashMap<>();
		result.put("result", false);
		
		if (is_duplication != null) {
			result.put("result", true);
		}
		
		return result;
	}
	
	@PostMapping("/sign_up")
	public Map<String, String> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email) {
		
		// insert DB
		int count = userBO.addUser(loginId, password, name, email);
		
		// return map
		Map<String, String> result = new HashMap<>();
		result.put("result", "success");
		
		if (count < 1) {
			result.put("result", "fail");
		}
		
		return result;
	}
	
}
