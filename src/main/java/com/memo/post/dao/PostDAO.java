package com.memo.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.memo.post.model.Post;

@Repository
public interface PostDAO {

	public List<Post> selectPostListByUserId(
			@Param("userId") int userId,
			@Param("direction") String direction,	 
			@Param("standardId") Integer standardId, 
			@Param("limit") int limit);
	
	public int selectPostListByUserIdAndSort(
			@Param("userId") int userId,
			@Param("sort") String sort);
	
	public Post selectPostById(int id);
	
	// int userId, String userLoginId, String subject, String content, MultipartFile file
	public void inserPost(
			@Param("userId") int userId, 
			@Param("subject") String subject, 
			@Param("content") String content,
			@Param("imagePath") String imagePath);
	
	public int updatePostByUserIdAndPostId(
			@Param("userId") int userId, 
			@Param("postId") int postId, 
			@Param("subject") String subject, 
			@Param("content") String content, 
			@Param("imagePath") String imagePath);
	
	public int deletePostByUserIdAndPostId(
			@Param("userId") int userId, 
			@Param("postId") int postId);
}
