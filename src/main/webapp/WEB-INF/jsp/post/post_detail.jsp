<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="d-flex justify-content-center">
	<div id="post-card">
		<div class="subject-area">
			<div id="post-subject">제목</div>
			<div class="post-info d-flex justify-content-between">
				<div class="writerId">글쓴이</div>
				<div class="created-at">작성일</div>
			</div>
		</div>
		<div class="post-content-area d-flex justify-content-center">
			<div class="post-content">글 내용</div>
		</div>
		<div class="img-size">
			<div class="img-center">
				<img class="img" src="https://cdn.pixabay.com/photo/2020/11/25/14/14/cat-5775895_1280.jpg" width="720">
			</div>
		</div>
		<%-- 버튼 영역 --%>
		<div class="edit-option d-flex justify-content-between">
			<button type="button" id="delBtn" class="btn">삭제</button>
			<div>
				<a href="/post/post_list_view" id="listBtn" class="btn">목록으로</a>
				<button type="button" id="modifyBtn" class="btn">수정</button>
			</div>
		</div>
	
	</div>
	
</div>