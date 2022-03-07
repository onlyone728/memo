<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="d-flex justify-content-center">
	<div id="post-list-box">
		<table class="table table-hover text-center" id="post-list">
			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>작성일</th>
					<th>수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="post" items="${postList}">
					<tr>
						<td class="col-2">${post.id}</td>
						<td class="col-6"><a href="/post/post_detail_view?postId=${post.id}">${post.subject}</a></td>
						<td class="col-2">
							<fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td class="col-2">
							<fmt:formatDate value="${post.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<%-- 페이징 --%>
		<div class="d-flex justify-content-center py-3">
			<c:if test="${prevId != 0}">
				<div>
					<a href="/post/post_list_view?prevId=${prevId}" id="prev-btn" class="pr-5">&lt;&lt; 이전</a>
				</div>
			</c:if>
			<c:if test="${nextId != 0}">
				<div>
					<a href="/post/post_list_view?nextId=${nextId}" id="next-btn" class="pl-5">다음 &gt;&gt;</a>
				</div>
			</c:if>
			</div>
		
		<a href="/post/post_create_view" id="edit-btn" class="btn">글쓰기</a>
	</div>
</div>