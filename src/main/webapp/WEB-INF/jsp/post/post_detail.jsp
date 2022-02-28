<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="d-flex justify-content-center">
	<div id="post-card">
		<div class="subject-area">
			<div id="post-subject">${post.subject}</div>
			<div class="post-info d-flex justify-content-between">
				<div class="writerId">${post.userId}</div>
				<div class="created-at">
					<fmt:formatDate value="${post.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
				</div>
			</div>
		</div>
		<div class="post-content-area d-flex justify-content-center">
			<div class="post-content">${post.content}</div>
		</div>
		<%-- 이미지가 있을때만 이미지 영역 추가 --%>
		<c:if test="${not empty post.imagePath}">
		<div class="img-size">
			<div class="img-center">
				<img class="img" src="${post.imagePath}" width="720">
			</div>
		</div>
		</c:if>
		<%-- 버튼 영역 --%>
		<div class="edit-option d-flex justify-content-between">
			<button type="button" id="postDelBtn" class="btn">삭제</button>
			<div>
				<a href="/post/post_list_view" id="listBtn" class="btn">목록으로</a>
				<button type="button" id="postModifyBtn" class="btn">수정</button>
			</div>
		</div>
	
	</div>
</div>
<script>
$(document).ready(function() {
	// 수정 링크
	$('#postModifyBtn').on('click', function() {
		location.href = "/post/update";
	});
});
</script>