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
			if (confirm("제목을 입력해 주세요.")) {
				$("input[name='title']").focus();
			}
			return;
		}

		if (content === "") {
			if (confirm("내용을 입력해 주세요.")) {
				$("textarea[name='content']").focus();
			}
			return;
		}

		// 입력값이 모두 있으면 form 전송
		document.form1.action = "<%=request.getContextPath()%>/board_servlet/join.do";
		document.form1.submit();
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
	
	<form name="form1" method="post">
		<div class="btn-r">
			<button type="button" id="btn_previous" onclick="">이전</button>
			<button type="button" id="none_write">등록</button>
			<button id="btn_logout" onclick="">로그 아웃</button>
		</div>
		
		<table id="table1">
			<tr>
				<th style="width:100px;">제목</th>
				<td style="padding:5px;"><input name="title"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td style="padding:5px;"><textarea name="content"></textarea></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>