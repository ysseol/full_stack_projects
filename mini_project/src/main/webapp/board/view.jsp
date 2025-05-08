<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
	$("#btn_previous").click(function() {
		document.form1.action = "<%=request.getContextPath()%>/board_servlet/list.do";
		document.form1.submit();
	});
	
	$("#btnUpdate").click(function() {
		let title = $("input[name='title']").val().trim();
		let content = $("textarea[name='content']").val().trim();

		if (title === "") {
			if (alert("제목을 입력해 주세요.")) {
				$("input[name='title']").focus();
			}
			return;
		}

		if (content === "") {
			if (alert("내용을 입력해 주세요.")) {
				$("textarea[name='content']").focus();
			}
			return;
		}

		document.form1.action = "<%=request.getContextPath()%>/board_servlet/update.do";
		document.form1.submit();
	});
	
	$("#btnDelete").click(function() {
		if(confirm("삭제할까요?")){
			document.form1.action = "<%=request.getContextPath()%>/board_servlet/delete.do";
			document.form1.submit();
		}
	});
	
	$("#btn_logout").click(function() {
		if(confirm("로그 아웃할까요?")){
			document.form1.action = "<%=request.getContextPath()%>/board_servlet/logout.do";
			document.form1.submit();
		}
	});
});
</script>
<style>
.main-pos{
	position: absolute;
	left: 20%;
	width:60%;
}
.btn-r{
	text-align: right;
	margin-bottom: 5px;
}
table, td, th {
	border-collapse: collapse;
	border: 1px solid black;
	height: 30px;
}
table{
	width: 100%;
}
td{
	 padding-left:5px;
}
textarea{
	font-size:15px;
	height:400px; width:100%;
	resize:none;
	box-sizing:border-box;
	overflow-y:auto;
}
input{
	width:100%; height:100%;
	box-sizing:border-box;
	font-size:15px;
}
</style>
</head>
<body>
<div class="main-pos">
	<h1 style="text-align: center;">게시판</h1>
	
	<div class="btn-r">
		<button type="button" id="btn_previous" onclick="">이전</button>
		<button type="button" id="btnUpdate">저장</button>
		<button type="button" id="btnDelete">삭제</button>
		<button type="button" id="btn_logout">로그 아웃</button>
	</div>
	<%
	BoardDTO dto = (BoardDTO) request.getAttribute("dto");
	%>
	<form name="form1" method="post">
	<table>
		<tr>
			<th style="width:100px;">번호</th>
			<td><%=dto.getNum()%></td>
		</tr>
	 	<tr>
			<th>제목</th>
			<td style="padding:5px;"><input name="title" value="<%=dto.getTitle()%>"></td>
	 	</tr>
	 	<tr>
			<th>내용</th>
			<td style="padding:5px;"><textarea name="content"><%=dto.getContent()%></textarea></td>
	 	</tr>
	 	<tr>
			<th>등록일자</th>
			<td><%=dto.getReg_date()%></td>
	 	</tr>
<!-- 	 	<tr> -->
<!-- 			<td colspan="2" align="center"> -->
<%-- 				<input type="hidden" name="id" value="<%=dto.getId()%>"> --%>
<!-- 			</td> -->
<!-- 	 	</tr> -->
	 	<input type="hidden" name="id" value="<%=dto.getId()%>">
	</table>
	</form>
</div>
</body>
</html>