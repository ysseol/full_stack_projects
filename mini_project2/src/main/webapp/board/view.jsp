<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function () {
    $("#btn_previous").click(function () {
        document.form1.action = "<%=request.getContextPath()%>/board_servlet/list.do";
        document.form1.submit();
    });

    $("#btnUpdate").click(function () {
        let title = $("input[name='title']").val().trim();
        let content = $("textarea[name='content']").val().trim();

        if (title === "") {
            alert("제목을 입력해 주세요.");
            $("input[name='title']").focus();
            return;
        }
        if (content === "") {
            alert("내용을 입력해 주세요.");
            $("textarea[name='content']").focus();
            return;
        }
        document.form1.action = "<%=request.getContextPath()%>/board_servlet/update.do";
        document.form1.submit();
    });

    $("#btnDelete").click(function () {
        if (confirm("삭제할까요?")) {
            document.form1.action = "<%=request.getContextPath()%>/board_servlet/delete.do";
            document.form1.submit();
        }
    });

    $("#btn_logout").click(function () {
        if (confirm("로그아웃 하시겠습니까?")) {
            document.form1.action = "<%=request.getContextPath()%>/board_servlet/logout.do";
            document.form1.submit();
        }
    });

    if (localStorage.getItem("theme") === "dark") {
        $("body").addClass("bg-dark text-light");
        $("#btn_darkmode").text("라이트 모드").removeClass("btn-outline-dark").addClass("btn-outline-light");
        $("table").addClass("table-dark");
    }

    $("#btn_darkmode").click(function () {
        $("body").toggleClass("bg-dark text-light");
        $("table").toggleClass("table-dark");
        
        if ($("body").hasClass("bg-dark")) {
            $(this).text("라이트 모드").removeClass("btn-outline-dark").addClass("btn-outline-light");
            localStorage.setItem("theme", "dark");
        } else {
            $(this).text("다크 모드").removeClass("btn-outline-light").addClass("btn-outline-dark");
            localStorage.setItem("theme", "light");
        }
    });
});
</script>

<style>
#btn_darkmode {
    position: fixed;
    top: 10px;
    left: 10px;
    z-index: 999;
}
</style>

</head>
<body>
<button type="button" id="btn_darkmode" class="btn btn-outline-dark">다크 모드</button>

<div class="container mt-5">
	<div class="text-center mb-4">
   		<h2>게시판 상세</h2>
    </div>
    
    <div class="mb-3 d-flex justify-content-end gap-2">
	    <button type="button" id="btn_previous" class="btn btn-secondary">이전</button>
	    <button type="button" id="btnUpdate" class="btn btn-primary">저장</button>
	    <button type="button" id="btnDelete" class="btn btn-danger">삭제</button>
	    <button type="button" id="btn_logout" class="btn btn-warning text-white">로그아웃</button>
    </div>
    
    <%
    BoardDTO dto = (BoardDTO) request.getAttribute("dto");
    %>
    <form name="form1" method="post">
        <table class="table table-bordered table-hover">
	            <tr>
	                <th class="table-light" style="width: 15%;">번호</th>
	                <td><%=dto.getNum()%></td>
	            </tr>
	            <tr>
	                <th class="table-light">제목</th>
	                <td><input type="text" name="title" class="form-control" maxlength="50" value="<%=dto.getTitle()%>"></td>
	            </tr>
	            <tr>
	                <th class="table-light">내용</th>
	                <td><textarea name="content" class="form-control" maxlength="5000" rows="10"><%=dto.getContent()%></textarea></td>
	            </tr>
	            <tr>
	                <th class="table-light">등록일자</th>
	                <td><%=dto.getReg_date()%></td>
	            </tr>
        </table>
        <input type="hidden" name="id" value="<%=dto.getId()%>">
    </form>
</div>
</body>
</html>
