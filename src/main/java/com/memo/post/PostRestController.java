package com.memo.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.memo.post.bo.PostBO;

@RestController
@RequestMapping("/post")
public class PostRestController {

	@Autowired
	private PostBO postBO;
	
	/**
	 * 글 등록
	 * @param subject
	 * @param content
	 * @param file
	 * @param request
	 * @return
	 */
	@PostMapping("/create")
	public Map<String, Object> createPost(
			@RequestParam("subject") String subject,
			@RequestParam(value="content", required=false) String content,
			@RequestParam(value="file", required=false) MultipartFile file,
			HttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");

		// TODO: 작성자 정보를 가져온다 (session에서)
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId");
		String userLoginId = (String)session.getAttribute("userLoginId");
		
		if (userId == null) {
			// 로그인 되어있지 않음
			result.put("result", "error");
			result.put("errorMessage", "로그인 후 사용 가능합니다.");
			return result;
		}
		
		// TODO: userId, userLoginId, subject, content, file => BO insert 요청
		postBO.addPost(userId, userLoginId, subject, content, file);
		
		return result;
	}
	
	/**
	 * 글 수정
	 * @param postId
	 * @param subject
	 * @param content
	 * @param file
	 * @param request
	 * @return
	 */
	@PutMapping("/update")
	public Map<String, Object> updatePost(
			@RequestParam("postId") int postId,
			@RequestParam("subject") String subject,
			@RequestParam(value="content", required=false) String content,
			@RequestParam(value="file", required=false) MultipartFile file,
			HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		int userId = (int) session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		int row = postBO.updatePost(postId, userId, userLoginId, subject, content, file);
		if (row < 1) {
			result.put("result", "error");
			result.put("errorMessage", "메모 수정에 실패했습니다.");
		}
		
		return result;
	}
	
	@DeleteMapping("/delete")
	public Map<String, Object> deletePost(
			@RequestParam("postId") int postId,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		int userId = (int) session.getAttribute("userId");
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		int row = postBO.deletePostByPostIdAndUserId(postId, userId);
		if (row < 1) {
			result.put("result", "fail");
			result.put("errorMessage", "삭제하는데 실패했습니다.");
		}
		
		return result;
	}
}
