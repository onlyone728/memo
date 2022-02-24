<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<div class="d-flex justify-content-center">
	<c:if test="${not empty userId}">
	<div class="w-50">
		<h1>글쓰기</h1>
		
		<input type="text" id="subject" class="form-control" placeholder="제목을 입력해주세요">
		<textarea id="content" class="form-control my-3" rows="10" placeholder="내용을 입력해주세요"></textarea>
		
		<div class="d-flex justify-content-end mb-3">
			<input type="file" id="file" accept=".jpg, .png, .gif, .jpeg" class="form-control w-50">
		</div>
		
		<div class="d-flex justify-content-between">
			<button type="button" id="postListBtn" class="btn btn-dark">목록</button>
			
			<div>
				<button type="button" id="clearBtn" class="btn btn-secondary mr-2">모두지우기</button>
				<button type="button" id="saveBtn" class="btn btn-primary">저장</button>
			</div>
		</div>
	</div>
	</c:if>
</div>
<script>
$(document).ready(function(){
	// 목록 버튼 클릭 => 글 목록으로 이동
	$('#postListBtn').on('click', function(){
		location.href = "/post/post_list_view";
	});
	
	// 모두 지우기
	$('#clearBtn').on('click', function() {
		// 제목과 내용 부분 빈칸으로 만든다.
		$('#subject').val('');
		$('#content').val('');
	});
	
	// 글 내용 저장
	$('#saveBtn').on('click', function() {
		let subject = $('#subject').val().trim();
		let content = $('#content').val();
		
		// validation - 제목만 필수
		if (subject == '') {
			alert("제목을 입력해주세요.");
			return;
		}
		
		let file = $('#file').val();	// 파일 경로만 가져온다.
		console.log(file);	// C:\fakepath\IMG_4238.JPG
		
		// 파일이 업로드 된 경우 확장자 체크
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
		
		// 폼태그를 자바스크립트에서 만든다. -> 파일 업로드시 폼태그가 필요
		let formData = new FormData();
		formData.append('subject', subject);
		formData.append('content', content);
		// $('#file')[0]은 첫번째 input file 태그를 의미, files[0]은 업로드 된 첫번째 파일
		formData.append('file', $('#file')[0].files[0]);	
		
		// AJAX form 데이터 전송
		$.ajax({
			type: "POST"
			, url: "/post/create"
			, data: formData
			, enctype: "multipart/form-data"	// 파일 업로드를 위한 필수 설정
			, processData: false	// 파일 업로드를 위한 필수 설정
			, contentType: false	// 파일 업로드를 위한 필수 설정
			, success: function(data) {
				if (data.result == "success") {
					alert("메모가 저장되었습니다.");
					location.href = "/post/post_list_view";
				} else {
					alert(data.errorMessage);
					location.href = "/user/sign_in_view";
				}
			}
			, error: function(e) {
				alert("메모 저장에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
});
</script>