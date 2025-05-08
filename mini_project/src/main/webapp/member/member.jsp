<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 회원가입</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
	$("#btn_previous").click(function() {
		location.href = "<%=request.getContextPath()%>/member/login.jsp";
	});
	
	$("#btn_register").click(function() {
		
		let userid = $("input[name='userid']").val().trim();
		let name = $("input[name='name']").val().trim();
		let pwd = $("input[name='pwd']").val().trim();

		if (userid === "") {
			if (confirm("아이디를 입력해 주세요.")) {
				$("input[name='userid']").focus();
			}
			return;
		}

		if (name === "") {
			if (confirm("이름을 입력해 주세요.")) {
				$("input[name='name']").focus();
			}
			return;
		}
		
		if (pwd === "") {
			if (confirm("비밀번호를 입력해 주세요.")) {
				$("input[name='pwd']").focus();
			}
			return;
		}
		
		document.form1.action = "<%=request.getContextPath()%>/member_servlet/register.do";
		document.form1.target = "";
		document.form1.submit();
	});
	
	$("#btn_check").click(function() {
		let userid = $("input[name='userid']").val().trim();

		if (userid === "") {
			if (confirm("아이디를 입력해 주세요.")) {
				$("input[name='userid']").focus();
			}
			return;
		}
		
		document.form1.action = "<%=request.getContextPath()%>/member_servlet/check.do";
		document.form1.target = "checkFrame";
		document.form1.submit();
	});
	
	<% if (request.getAttribute("message") != null) { %>
    alert("<%= request.getAttribute("message") %>");
	<% } %>
});
</script>
</head>
<body>
	<button type="button" id="btn_previous">이전</button>
	<button type="button" id="btn_register">등록</button>
<form name="form1" method="post">
<table border="1">
 	<tr>
		<td style="text-align: center; width:80px;">아이디</td>
		<td style="width:260px;"><input name="userid">&nbsp;&nbsp;<button type="button" id="btn_check">중복 확인</button></td>
 	</tr>
 	<tr>
		<td style="text-align: center;">이름</td>
		<td><input name="name"></td>
 	</tr>
 	<tr>
		<td style="text-align: center;">비밀번호</td>
		<td><input type="password" name="pwd"></td>
 	</tr>
</table>
</form>
<iframe name="checkFrame" style="display:none;"></iframe>
</body>
</html>