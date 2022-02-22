<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header">
	<div class="logo">
		<h1 class="text-white font-weight-bold">
			<a href="/post/post_list_view">메모 게시판</a>
		</h1>
	</div>
	
	<div class="login-info">
		<%-- session 정보가 있을 때만 출력 --%>
		<c:if test="${not empty userName}">
		<div class="mt-3">
			<span class="text-white">${userName}님 안녕하세요</span>
			<a href="/user/sign_out" class="ml-2 text-white font-weight-bold">로그아웃</a>
		</div>
		</c:if>
	</div>
</div>