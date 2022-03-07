<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="d-flex justify-content-center">
	<div id="post-card">
		<div class="subject-area">
			<%-- <div id="post-subject">${post.subject}</div> --%>
			<input  name="subject" type="text" class="form-control text-center mb-2" placeholder="제목을 입력해주세요." value="${post.subject}">
			<div class="post-info d-flex justify-content-between">
				<div class="writerId">${post.userId}</div>
				<div class="created-at">
					<fmt:formatDate value="${post.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
				</div>
			</div>
		</div>
		<div class="post-content-area d-flex justify-content-center">
			<%-- <div class="post-content">${post.content}</div> --%>
			<textarea name="content" class="form-control mb-2" rows="10" placeholder="내용을 입력해주세요.">${post.content}</textarea>
		</div>
		<div class="file-upload-btn clearfix mb-2">
			<input id="file" type="file" class="float-right" accept=".jpg,.jpeg,.png,.gif">
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
			<button type="button" id="postDelBtn" class="btn" data-post-id="${post.id}">삭제</button>
			<div>
				<a href="/post/post_list_view" id="listBtn" class="btn">목록</a>
				<button type="button" id="postModifyBtn" class="btn" data-post-id="${post.id}">수정</button>
			</div>
		</div>
	
	</div>
</div>
<script>
$(document).ready(function() {
	// 수정 링크
	$('#postModifyBtn').on('click', function() {
		// validation
		let subject = $('input[name=subject]').val().trim();
		if (subject == '') {
			alert("제목을 입력해주세요.");
			return;
		}
		let content = $('textarea[name=content]').val();
		
		// 파일이 업로드 된 경우 확장자 체크
		let file = $('#file').val();	// 파일 경로만 가져온다.
		if (file != '') {
			// 파일 경로를 .으로 나누고 - spilt
			// 확장자가 있는 마지막 문자열을 가져온 후 - pop 
			// 모두 소문자로 변경 - toLowerCase
			let ext = file.split('.').pop().toLowerCase();
			if ($.inArray(ext, ['jpg', 'gif', 'png', 'jpeg']) == -1) {
				alert("gif, jpg, jpeg, png 파일만 업로드 할 수 있습니다.");
				$('#file').val('');	// 선택된 파일을 비운다.
				return;
			}
		}
		
		// 폼태그 객체를 자바스크립트에서 만든다.
		let formData = new FormData();
		let postId = $(this).data('post-id');
		console.log(postId);
		formData.append('postId', postId);
		formData.append('subject', subject);
		formData.append('content', content);
		formData.append('file', $('#file')[0].files[0]);
		
		// AJAX
		$.ajax({
			type: "PUT"
			, url: "/post/update"
			, data: formData
			, enctype: "multipart/form-data"	// 파일 업로드 필수 설정
			, processData: false	// 파일 업로드 필수 설정
			, contentType: false	// 파일 업로드 필수 설정
			, success: function(data) {
				if (data.result == "success") {
					alert("메모가 수정되었습니다.");
					location.reload();
				} else {
					alert(data.errorMessage);
				}
			}
			, error: function(e) {
				alert("메모 저장에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
	
	// 삭제
	$('#postDelBtn').on('click', function() {
		let postId = $(this).data('post-id');
		//console.log(postId);
		
		$.ajax({
			type: "DELETE"
			, url: "/post/delete"
			, data: {"postId": postId}
			, success: function(data) {
				if (data.result == "success") {
					alert("메모가 삭제되었습니다.");
					location.href = "/post/post_list_view";
				} else {
					alert(data.errorMessage);
				}
			}
			, error: function(e) {
				alert("메모를 삭제하는데 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
});
</script>