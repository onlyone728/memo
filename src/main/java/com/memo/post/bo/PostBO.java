package com.memo.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.common.FileManagerService;
import com.memo.post.dao.PostDAO;
import com.memo.post.model.Post;

@Service
public class PostBO {

	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fms;
	
	public List<Post> getPostList() {
		return postDAO.selectPostList();
	}
	
	public void addPost(int userId, String userLoginId, String subject, String content, MultipartFile file) {
		String imagePath = null;
		
		if (file != null) {
			// TODO: 파일매니저 서비스 	input:MultipartFile		output:이미지의 주소
			imagePath = fms.saveFile(userLoginId, file);
		}
		
		// insert DAO
		postDAO.inserPost(userId, subject, content, imagePath);
	}
}
