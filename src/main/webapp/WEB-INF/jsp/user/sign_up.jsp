<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<form id="signUpForm" method="post" action="/user/sign_up">
		<table class="user-form">
			<tr>
				<th><label for="loginId" class="mr-2"><b>* 아이디</b></label></th>
				<td>
					<div class="form-inline">
						<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디를 입력하세요.">
						<button type="button" id="duplication-btn" class="btn ml-2">중복확인</button>
					</div>
				</td>
			</tr>
			<tr class="id-check-row d-none">
				<th></th>
				<td>
					<small id="idCheckLength" class="text-danger d-none">ID를 4자 이상 입력해주세요.</small>
					<small class="is-duplicated text-danger d-none">중복된 아이디입니다.</small>
					<small class="is-not-duplicated text-success d-none">사용가능한 아이디입니다.</small>	
				</td>
			</tr>	
			<tr>
				<th><label for="password" class="mr-2"><b>* 비밀번호</b></label></th>
				<td><input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요."></td>
			</tr>
			<tr>
				<th><label for="confirmPw" class="mr-2"><b>* 비밀번호 확인</b></label></th>
				<td><input type="password" id="confirmPw" name="confirmPw" class="form-control" placeholder="비밀번호 확인"></td>
			</tr>
			<tr class="password-check-row d-none">
				<th></th>
				<td>
					<small class="text-danger">비밀번호가 일치하지않습니다.</small>
				</td>
			</tr>	
			<tr>
				<th><label for="name" class="mr-2"><b>* 이름</b></label></th>
				<td><input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요."></td>
			</tr>
			<tr>
				<th><label for="email" class="mr-2"><b>* 이메일 주소</b></label></th>
				<td><input type="text" id="email" name="email" class="form-control" placeholder="이메일 주소를 입력하세요."></td>
			</tr>
			<tr>
				<th colspan="2" class="text-center"><button type="submit" id="join-btn" class="btn btn-block">회원가입</button></th>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript" src="/js/signUp.js"></script>
