<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="post-list-box">
	<table class="table text-center" id="post-list">
		<thead>
			<tr>
				<th class="col-2">No.</th>
				<th class="col-6">제목</th>
				<th class="col-2">작성일</th>
				<th class="col-2">수정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="post" items="${postList}" varStatus="status">
				<tr>
					<td class="col-2">${status.count}</td>
					<td class="col-6"><a href="#">${post.subject}</a></td>
					<td class="col-2">${post.createdAt}</td>
					<td class="col-2">${post.updatedAt}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="text-center py-3">
		<a href="#" id="prev-btn" class="pr-5"><< 이전</a>
		<a href="#" id="next-btn" class="pl-5">다음 >></a>
	</div>
	<button type="button" id="edit-btn" class="btn">글쓰기</button>
</div>