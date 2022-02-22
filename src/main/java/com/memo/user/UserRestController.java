package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.common.EncryptUtils;
import com.memo.user.bo.UserBO;
import com.memo.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	/**
	 * 회원가입시 아이디 중복 확인
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		
		// DB select
		boolean existId = userBO.existLoginId(loginId);
		
		// return map
		Map<String, Object> result = new HashMap<>();
		result.put("result", existId);	// id가 존재하면 true
		
		return result;
	}
	
	/**
	 * 회원가입 - ajax 호출
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return
	 */
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email) {
		
		// 비밀번호 암호화
		String encryptPassword = EncryptUtils.md5(password);
		
		// TODO: DB insert 
		int count = userBO.addUser(loginId, encryptPassword, name, email);
		
		// return map
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		if (count < 1) {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request) {
		
		// 비밀번호 암호화
		String encryptPassword = EncryptUtils.md5(password);
		
		// TODO: loginId와 암호화된 비밀번호로 DB select
		User user = userBO.getUserByLoginIdAndPassword(loginId, encryptPassword);
		
		// return json
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");

		// 로그인이 성공하면 세션에 user정보를 담는다.
		if (user != null) {
			// 로그인 - 세션에 저장(로그인 상태를 유지한다)
			HttpSession session = request.getSession();
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());
		} else {
			result.put("result", "error");
			result.put("errorMessage", "존재하지 않는 사용자입니다. 관리자에게 문의해주세요.");
		}
		
		return result;
	}
	
}
