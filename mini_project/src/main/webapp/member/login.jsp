<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 로그인</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
	
	$("#btn_login").click(function() {
		document.form1.action = "<%=request.getContextPath()%>/member_servlet/login.do";
		document.form1.submit();
	});
	
	<% if (request.getAttribute("message") != null) { %>
    alert("<%= request.getAttribute("message") %>");
	<% } %>
	
	$("#btn_member").click(function() {
		document.form1.action = "<%=request.getContextPath()%>/member_servlet/member.do";
		document.form1.submit();
	});
	
});
</script>
</head>
<body>
	<button type="button" id="btn_login">로그인</button> 
	<button type="button" id="btn_member">회원가입</button> 
<form name="form1" method="post">
<table border="1">
 	<tr>
		<td style="text-align: center; width:80px;">아이디</td>
		<td style="width:260px;"><input name="userid"></td>
 	</tr>
 	<tr>
		<td style="text-align: center;">비밀번호</td>
		<td><input type="password" name="pwd"></td>
 	</tr>
</table>
</form>
</body>
</html>