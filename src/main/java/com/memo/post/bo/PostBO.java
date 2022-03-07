package com.memo.post.bo;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.common.FileManagerService;
import com.memo.post.dao.PostDAO;
import com.memo.post.model.Post;

@Service
public class PostBO {

//	private Logger logger = LoggerFactory.getLogger(PostBO.class);
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fms;
	
	private static final int POST_MAX_SIZE = 3;
	
	public List<Post> getPostListByUserId(int userId, Integer prevId, Integer nextId) {
		// 10 9 8 | 7 6 5 | 4 3 2 | 1
		
		// 예를 들어  7 6 5 페이지에서
		// 1) 다음 눌렀을 때 : nextId - 5 => 5보다 작은 3개 => 4 3 2 order by DESC
		// 2) 이전 눌렀을 때 : prevId - 7 => 7보다 큰 3개 => 8 9 10 order by ASC => 코드에서 데이터를 reverse
		// 											   order by DESC로 받을 경우 DB에서 제일 최근 글을 가져온다.
		// 3) 첫 페이지로 들어왔을 때 : 10 9 8 order by DESC
		
		String direction = null;
		Integer standardId = null;
		
		if (nextId != null) { // 1) 다음 클릭
			direction = "next";
			standardId = nextId;
			
			return postDAO.selectPostListByUserId(userId, direction, standardId, POST_MAX_SIZE);
		} else if (prevId != null) {	// 2) 이전 클릭
			direction = "prev";
			standardId = prevId;
			
			List<Post> postList = postDAO.selectPostListByUserId(userId, direction, standardId, POST_MAX_SIZE);
			// 7보다 큰 3개 8 9 10이 나오므로 List를 reverse 정렬 시킨다.
			Collections.reverse(postList);
			return postList;
		}
		
		// 3) 첫페이지
		return postDAO.selectPostListByUserId(userId, direction, standardId, POST_MAX_SIZE);
	}
	
	public boolean isLastPage(int userId, int nextId) { // ASC limit 1
		return nextId == postDAO.selectPostListByUserIdAndSort(userId, "ASC");
	}
	
	public boolean isFirstPage(int userId, int prevId) {	// DEST limit 1
		return prevId == postDAO.selectPostListByUserIdAndSort(userId, "DESC");
	}
	
	public Post getPostById(int id) {
		return postDAO.selectPostById(id);
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
	
	public int updatePost(int postId, int userId, String userLoginId, 
			String subject, String content, MultipartFile file) {
		
		// postId에 해당하는 게시글이 있는지 DB에서 가져와본다.
		Post post = getPostById(postId);
		if (post == null) {
			logger.error("[update post] 수정할 메모가 존재하지 않습니다." + postId);
			return 0;
		}
		
		// 파일이 있는지 본 후 있으면 서버에 업로드하고 imagePath 받아온다.
		// 파일이 없으면 수정하지 않는다.
		String imagePath = null;
		if (file != null) {
			imagePath = fms.saveFile(userLoginId, file);	// 컴퓨터에 파일 업로드 후 url path를 얻어낸다.
			
			// 새로 업로드된 이미지가 성공하면 기존 이미지가 있을때는 기존 이미지 삭제
			if (post.getImagePath() != null && imagePath != null) {
				// 기존 이미지 삭제
				try {
					fms.deleteFile(post.getImagePath());
				} catch (IOException e) {
					logger.error("[update post] 이미지 삭제 실패 {}, {}", post.getId(), post.getImagePath());
				}
			}
		}
		
		// DB에서 update
		return postDAO.updatePostByUserIdAndPostId(userId, postId, subject, content, imagePath);
	}
	
	public int deletePostByPostIdAndUserId(int postId, int userId) {
		// 삭제 전에 게시글을 먼저 가져온다.(imagePath가 있을 수 있기 때문에)
		Post post = getPostById(postId);
		if (post == null) {
			logger.warn("[delete post] 삭제할 메모가 존재하지않습니다.");
			return 0;
		}
		
		// imagePath가 있는 경우 파일 삭제
		if (post.getImagePath() != null) {
			// 기존 이미지 삭제
			try {
				fms.deleteFile(post.getImagePath());
			} catch (IOException e) {
				logger.error("[delete post] 이미지 삭제 실패 {}, {}", post.getId(), post.getImagePath());
			}
		}
		
		// DB에서 post 삭제
		return postDAO.deletePostByUserIdAndPostId(userId, postId);
		
	}
	
}
