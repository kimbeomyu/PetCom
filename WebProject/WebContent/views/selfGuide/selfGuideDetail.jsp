<%@page import="java.text.SimpleDateFormat"%>
<%@page import="selfGuide.model.vo.SelfGuideComment"%>
<%@page import="java.util.*"%>
<%@page import="member.vo.Member"%>
<%@page import="selfGuide.model.vo.SelfGuide"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	SelfGuide guideOne = (SelfGuide) request.getAttribute("guideOne");
	Member mOne = (Member) session.getAttribute("member");
	
	// request로는 객체를 받을도 형변환이 되지않음
	// 그걸 고쳐주기위해 사용하는 방법 심화과정임 알아두면 개꿀이덕
	SelfGuideComment commentList =	(SelfGuideComment)request.getAttribute("commentList");
	ArrayList<SelfGuideComment> commentList2 = commentList.getComment(); 
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<%-- ${guideOne.selfTitle} --%><%=guideOne.getSelfTitle()%></h2>
	<img src="/upload/photo/<%=guideOne.getPhotoRenameFilename()%>"
		width="300px" height="300px">

	<h6>
		글번호 :
		<%=guideOne.getSelfNo()%>
		/ 작성자 ID :
		<%=guideOne.getWriterId()%>
		/ 작성 날짜 :
		<%=guideOne.getSelfDate()%></h6>
		/ 내용 :
		<%=guideOne.getSelfContent() %> <br>
		/ 조회수 :
		<%=guideOne.getSelfViews()%>
		/ 좋아요 :

	<span id="like">
		<%=guideOne.getSelfLike()%>
	</span>
	<button onclick="fn_like()">좋아?</button>
	<hr>


	comment : <input type="textarea" id="comment" placeholder="댓글을 작성하세요" onkeyup="enterkey()">
	<input type="submit" value="등록" onclick="fn_commentAdd()"/>
	
	<a href="/logout">로그아웃</a> 
	<h2>댓글</h2>
	<table id="table-tr">
		<tr>
			<th>댓글</th>
			<th>작성자ID</th>
			<th>작성일자</th>
		</tr>
	<% for(SelfGuideComment comment : commentList2) {%>
		<tr>
			<input type='hidden' value='<%=comment.getScommentNo() %>' id='<%=comment.getScommentNo() %>'/>
			<td><%=comment.getScommentText() %></td>
			<td><%=comment.getMemberId() %></td>
			<td><%=comment.getScommentDate() %></td>

		<% if(comment.getMemberId().equals(mOne.getMember_ID())) { %>
			<td><button onclick="fn_commentDelete(<%=comment.getScommentNo() %>)">삭제</button></td>
		<%} %>
		</tr>
	<% } %>
	</table>

	<script>
	
	// 엔터키 누르면 실행될 이벤트를 인식시켜주는 함수
	function enterkey() {
		if (window.event.keyCode == 13) {
			fn_commentAdd()
       }
	}
		//좋아요 누르면 반응하는 함수
		function fn_like() {
			var param = {
				selfNo : <%=guideOne.getSelfNo()%>,
				memberId :"<%=mOne.getMember_ID()%>"
			}

			$.ajax({
				url : "/likesCount",
				data : param,
				type : "post",
				dataType : "json",
				success : function(data) {
					var total = data;
					$("#like").html(total);
				}
			});
		}

		//댓글 추가시 ALERT창뜨고 바로 적용
		function fn_commentAdd() {
			
			var param = {
				comment: $("#comment").val(),
				memberId: "<%=mOne.getMember_ID()%>",
				selfNo: <%=guideOne.getSelfNo()%>
			}
			
			
			$.ajax({
				url: "/guideCommentAdd",
				data: param,
				type: "post",
				dataType: "json",
				success : function(data) {
					var commentOne = data;
					var html="";

					html += "<tr><td>" +commentOne.scommentText +"</td>";
					html += "<input type='hidden' value='"+commentOne.scommentNo+"' id='"+commentOne.scommentNo+"'/>";
					html += "<td>"+commentOne.memberId+"</td>";
					html += "<td>"+commentOne.scommentDate.substr(8,4)+"-"+commentOne.scommentDate.substr(0,2)
					              +"-"+commentOne.scommentDate.substr(4,2)+"</td>";
					
					if(commentOne.memberId == "<%=mOne.getMember_ID() %>") {
						html +="<td><button onclick='fn_commentDelete("+commentOne.scommentNo+")'>삭제</button></td>";
					}
					html += "</tr>";
					$("#table-tr").append(html);
					$("#comment").val("");
				}
			});
		}
		
		function fn_textBox() {
			
			$
			
		}
		
		
		// 댓글 삭제
		function fn_commentDelete(scommentNo) {
			
			var param = {
					scommentNo: scommentNo,
					selfNo: <%=guideOne.getSelfNo()%>
			}
			
			$.ajax({
				url: "/commentDelete",
				data: param,
				type: "post",
				dataType: "json",
				success: function(data) {
					var guideCommentList = data;
					var html="";
					html +="<tr><th>댓글</th><th>작성자ID</th><th>작성일자</th></tr>";
					for(var i in guideCommentList ) {
						
						var commentOne = guideCommentList[i];
						
						
						html += "<tr><td>" +commentOne.scommentText +"</td>";
						html += "<input type='hidden' value='"+commentOne.scommentNo+"' id='"+commentOne.scommentNo+"'/>";
						html += "<td>"+commentOne.memberId+"</td>";
						html += "<td>"+commentOne.scommentDate+"</td>";
						
						if(commentOne.memberId == "<%=mOne.getMember_ID() %>") {
							html +="<td><button onclick='fn_commentDelete("+commentOne.scommentNo+")'>삭제</button></td>";
						}
						html += "</tr>";
					}
					$("#table-tr").html(html);
					$("#comment").val("");
				}
			});
		} 

	</script>
</body>
</html>