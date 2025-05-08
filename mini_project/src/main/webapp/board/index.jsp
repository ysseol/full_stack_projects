<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 Index</title>
</head>
<body>
<%
response.sendRedirect(request.getContextPath() + "/board_servlet/list.do");
%>
</body>
</html>