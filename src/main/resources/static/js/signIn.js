/**
 * 
 */
 $(document).ready(function() {
	$('#loginForm').on('submit', function(e) {
		e.preventDefault();	// submit 기능 중단
		
		// validation
		let loginId = $('#loginId').val().trim();
		if (loginId.length < 1) {
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		let password = $('#password').val();
		if (password.length < 1) {
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		
		// ajax 호출
		let url = $(this).attr('action');	// form tag에 있는 action value를 가져옴
		let params = $(this).serialize();	// form tag에 있는 name 값들을 쿼리스트링으로 구성
		
		$.post(url, params)
		.done(function(data) {
			if (data.result == 'success') {
				location.href = "/post/post_list_view";	// 로그인이 성공하면 글 목록으로 이동
			} else {
				alert(data.errorMessage);
				location.reload();
			}
		});
	});
});