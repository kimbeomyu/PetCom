<%@page import="member.vo.Member"%>
<%@page import="selfGuide.model.vo.SelfGuide"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% SelfGuide guideOne =  (SelfGuide)request.getAttribute("guideOne"); %>
<% Member mOne = (Member)session.getAttribute("member"); %>
<!DOCTYPE html>
<html>
<head>
<script src="../../js/jquery-2.0.0.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>
		제목 :
		<%=guideOne.getSelfTitle() %></h2>
		<img src="/upload/photo/<%=guideOne.getPhotoRenameFilename() %>" width="300px" height="300px">
		
	<h6>
		글번호 :
		<%=guideOne.getSelfNo()%>
		/ 작성자 ID :
		<%=guideOne.getWriterId() %>
		/ 작성 날짜 :
		<%=guideOne.getSelfDate() %></h6>
		/ 조회수 :
		<%=guideOne.getSelfViews() %>
		/ 좋아요 : 
		
		<div id="like"> <%=guideOne.getSelfLike() %> </div>
		<button onclick="fn_like()">좋아?</button>
	<hr>
	

	
	<form action="/guideCommentAdd" method="post">
		comment : <input type="text" name="comment" placeholder="댓글을 작성하세요">
		<input type="hidden" name="memberId" value="<%=mOne.getMember_ID() %>">
		<input type="hidden" name="selfNo" value="<%=guideOne.getSelfNo() %>">
		<input type="submit" value="등록">
	</form>
	
	<a href="/logout">로그아웃</a>
	<h2>댓글</h2>
	<table>
		<tr>
			<th>댓글</th>
			<th>작성자ID</th>
			<th>작성일자</th>
		</tr>
		<%-- 
		
		<% for(NoticeComment comment : ncList) {%>
		<tr>
			<td><%=comment.getContent() %></td>
			<td><%=comment.getUserId() %></td>
			<td><%=comment.getRegDate() %></td>
		</tr>
		<% } %>
		 
		--%>
	</table>
	
	
	
	
	
	<script>
		function fn_like() {
			var param = {
					selfNo : <%=guideOne.getSelfNo()%>,
					memberId : <%=mOne.getMember_ID()%>	
			}
			
			$.ajax({
				url: "/likesCount",
				data : param,
				type: "post",
				dataType: "json",
				success: function(data) {
					var total = data;
					$("#like").html(total);
					
				}
				
			});
		}
	</script>
</body>
</html>