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
	
	$("input[name=userid]").keyup(function(key){
		if(key.keyCode == 13) {
			$("#btn_register").click();
		}
	});
	
	$("input[name=pwd]").keyup(function(key){
		if(key.keyCode == 13) {
			$("#btn_register").click();
		}
	});
	
	$("input[name=name]").keyup(function(key){
		if(key.keyCode == 13) {
			$("#btn_register").click();
		}
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

<style>
.main-pos{
	position: absolute;
	left: 20%;
	width:60%;
}
.btn-r{
	text-align: center;
	margin-top: 10px;
}
#btn_check{
	margin-left: 20px;
}
table, td, th {
	border-collapse: collapse;
	border: 0px solid black;
	margin: auto;
}
th{
	width: 80px;
	height: 50px;
}
td{
	width:250px;
}
input{
	width:150px; height:40px;
	box-sizing:border-box;
	font-size:15px;

	margin-bottom: 0px;
    border-radius: 0px;
}
</style>

</head>


<body>
<div class="main-pos">
	<h1 style="text-align: center;">회원가입</h1>
	
	<form name="form1" method="post">
	<table border="1">
		<tr>
			<th>아이디</th>
			<td><input name="userid"><button type="button" id="btn_check">중복 확인</button></td>
	 	</tr>
	 	<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pwd"></td>
	 	</tr>
		<tr>
			<th>이름</th>
			<td><input name="name"></td>
	 	</tr>
	 	
	</table>
	</form>
		
	<div class="btn-r">
		<button type="button" id="btn_previous">취소</button>
		<button type="button" id="btn_register">등록</button>
	</div>
	
	<iframe name="checkFrame" style="display:none;"></iframe>
</div>
</body>
</html>