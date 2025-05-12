<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 추가</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
	$("#btn_previous").click(function() {
		document.form1.action = "<%=request.getContextPath()%>/board_servlet/list.do";
		document.form1.submit();
	});
	
	$("#btn_logout").click(function() {
		if(confirm("로그 아웃할까요?")){
			document.form1.action = "<%=request.getContextPath()%>/board_servlet/logout.do";
			document.form1.submit();
		}
	});
	
	$("#none_write").click(function() {
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

		// 입력값이 모두 있으면 form 전송
		document.form1.action = "<%=request.getContextPath()%>/board_servlet/join.do";
		document.form1.submit();
	});
	
	if (localStorage.getItem("theme") === "dark") {
		$("body").addClass("dark-mode");
		$("#btn_darkmode").text("라이트 모드");
	}
	
	$("#btn_darkmode").click(function () {
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
	text-align: right;
	margin-bottom: 5px;
}
td, th {
	border: 2px solid black;
	height: 30px;
}
table{
	border-collapse: collapse;
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
body.dark-mode table, 
body.dark-mode th, 
body.dark-mode td {
	border-color: #444;
}
body.dark-mode textarea,
body.dark-mode input {
	background-color: #333;
	color: #fff;
	border: 1px solid #555;
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
	<h1 style="text-align: center;">게시판</h1>
	
	<form name="form1" method="post">
		
		<table id="table1">
			<tr>
				<td colspan="2" style="border: none;">
					<div class="btn-r">
						<button type="button" id="btn_previous" onclick="">이전</button>
						<button type="button" id="none_write">등록</button>
						<button id="btn_logout" onclick="">로그 아웃</button>
					</div>
				</td>
			</tr>
			<tr>
				<th style="width:100px;">제목</th>
				<td style="padding:5px;"><input name="title" maxlength='50'></td>
			</tr>
			<tr>
				<th>내용</th>
				<td style="padding:5px;"><textarea name="content" maxlength='5000'></textarea></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>