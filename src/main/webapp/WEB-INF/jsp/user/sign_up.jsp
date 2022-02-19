<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<table class="user-form">
		<tr>
			<th><label for="loginId" class="mr-2"><b>* 아이디</b></label></th>
			<td>
				<div class="form-inline">
					<input type="text" id="loginId" class="form-control" placeholder="아이디를 입력하세요.">
					<button type="button" id="duplication-btn" class="btn ml-2">중복확인</button>
				</div>
			</td>
		</tr>
		<tr class="id-check-row d-none">
			<th></th>
			<td>
				<small class="is-duplicated text-danger">중복된 아이디입니다.</small>
				<small class="is-not-duplicated text-success">사용가능한 아이디입니다.</small>	
			</td>
		</tr>	
		<tr>
			<th><label for="password" class="mr-2"><b>* 비밀번호</b></label></th>
			<td><input type="password" id="password" class="form-control" placeholder="비밀번호를 입력하세요."></td>
		</tr>
		<tr>
			<th><label for="confirmPw" class="mr-2"><b>* 비밀번호 확인</b></label></th>
			<td><input type="password" id="confirmPw" class="form-control" placeholder="비밀번호 확인"></td>
		</tr>
		<tr class="password-check-row d-none">
			<th></th>
			<td>
				<small class="text-danger">비밀번호가 일치하지않습니다.</small>
			</td>
		</tr>	
		<tr>
			<th><label for="name" class="mr-2"><b>* 이름</b></label></th>
			<td><input type="text" id="name" class="form-control" placeholder="이름을 입력하세요."></td>
		</tr>
		<tr>
			<th><label for="email" class="mr-2"><b>* 이메일 주소</b></label></th>
			<td><input type="text" id="email" class="form-control" placeholder="이메일 주소를 입력하세요."></td>
		</tr>
		<tr>
			<th colspan="2" class="text-center"><button type="button" id="join-btn" class="btn btn-block">회원가입</button></th>
		</tr>
	</table>
</div>

<script>
	$(document).ready(function() {
		// 아이디 중복 확인
		$('#duplication-btn').on('click', function() {
			let loginId = $('#loginId').val().trim();
			
			// vaildation check
			if (loginId == '') {
				alert("아이디를 입력해주세요.");
				return;
			}
			
			$.ajax({
				type: "POST"
				, url: "/user/is_duplicated_id"
				, data: {"loginId": loginId}
				, success: function(data) {
					$('.id-check-row').removeClass('d-none');
					if (data.result == true) {
						// 중복일때
						$('.is-duplicated').removeClass('d-none');
						$('.is-not-duplicated').addClass('d-none');
					} else {
						// 중복이 아닐때
						$('.is-duplicated').addClass('d-none');
						$('.is-not-duplicated').removeClass('d-none');
					}
				}
				, error: function(e){
					alert("관리자에게 문의해 주세요.");
				}
			});
		});
		
		// 비밀번호 확인
		$('#confirmPw').focusout(function() {
			let password = $('#password').val().trim();
			let confirmPw = $('#confirmPw').val().trim();
			
			console.log(password);
			console.log(confirmPw);
			
			if (password != confirmPw) {
				$('.password-check-row').removeClass('d-none');
				$('#password').focus();
			}
		});
		
		// 회원가입 버튼
		$('#join-btn').on('click', function() {
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val().trim();
			let confirmPw = $('#confirmPw').val().trim();
			let name = $('#name').val().trim();
			let email = $('#email').val().trim();
			
			// validation
			if (loginId == '') {
				alert("아이디를 입력해주세요.");
				return;
			}
			if ($('.id-check-row').hasClass('d-none')) {
				alert("아이디 중복확인을 해주세요.");
				return;
			}
			
			if (password == '') {
				alert("비밀번호를 입력해주세요.");
			}
			if (!$('.password-check-row').hasClass('d-none')) {
				alert("비밀번호를 확인해주세요.");
			} 
			
			if (name == '') {
				alert("이름을 입력해주세요.");
			}
			if (email == '') {
				alert("이메일 주소를 입력해주세요.");
			}
			
			$.ajax({
				type: "POST"
				, url: "/user/sign_up"
				, data: {"loginId": loginId, "password": password, "name": name, "email": email}
				, success: function(data) {
					if (data.result == "success") {
						alert(loginId + "님 회원가입이 완료되었습니다.");
						location.reload();
					}
				}
				, error: function(e) {
					alert("관리자에게 문의하세요.");
				}
			});
		});
	});
</script>
