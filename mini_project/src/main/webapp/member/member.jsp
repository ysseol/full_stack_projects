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
			if (alert("아이디를 입력해 주세요.")) {
				$("input[name='userid']").focus();
			}
			return;
		}
		
		if (pwd === "") {
			if (alert("비밀번호를 입력해 주세요.")) {
				$("input[name='pwd']").focus();
			}
			return;
		}

		if (name === "") {
			if (alert("이름을 입력해 주세요.")) {
				$("input[name='name']").focus();
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
			if (alert("아이디를 입력해 주세요.")) {
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
	
	if (localStorage.getItem("theme") === "dark") {
		$("body").addClass("dark-mode");
		$("#btn_darkmode").text("라이트 모드");
	}
	
	$("#btn_darkmode").click(function() {
		$("body").toggleClass("dark-mode");
		
		if ($("body").hasClass("dark-mode")) {
	        $("#btn_darkmode").text("라이트 모드");
	        localStorage.setItem("theme", "dark");
	    } else {
	        $("#btn_darkmode").text("다크 모드");
	        localStorage.setItem("theme", "light");
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

#btn_darkmode {
	position: fixed;
	top: 10px;
	left: 10px;
	padding: 10px 15px;
	background-color: #eee;
	border: 1px solid #ccc;
	cursor: pointer;
	z-index: 999;
}
body.dark-mode {
	background-color: #121212;
	color: #ffffff;
}
body.dark-mode input {
	background-color: #333;
	color: #fff;
	border: 1px solid #555;
}
body.dark-mode table,
body.dark-mode th,
body.dark-mode td {
	border-color: #444;
}
body.dark-mode button {
	background-color: #555;
	color: #fff;
	border: 1px solid #888;
}
body.dark-mode #btn_darkmode {
	background-color: #444;
	color: #fff;
	border: 1px solid #888;
}
</style>

</head>


<body>
<button type="button" id="btn_darkmode">다크 모드</button>

<div class="main-pos">
	<h1 style="text-align: center;">회원가입</h1>
	
	<form name="form1" method="post">
	<table border="1">
		<tr>
			<th>아이디</th>
			<td><input name="userid" value="<%= request.getAttribute("userid") != null ? request.getAttribute("userid") : "" %>"><button type="button" id="btn_check">중복 확인</button></td>
	 	</tr>
	 	<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pwd"></td>
	 	</tr>
		<tr>
			<th>이름</th>
			<td><input name="name" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"></td>
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