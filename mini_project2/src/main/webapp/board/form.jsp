<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 추가</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
$(function () {
    $("#btn_previous").click(function () {
        document.form1.action = "<%=request.getContextPath()%>/board_servlet/list.do";
        document.form1.submit();
    });

    $("#btn_logout").click(function () {
        if (confirm("로그 아웃할까요?")) {
            document.form1.action = "<%=request.getContextPath()%>/board_servlet/logout.do";
            document.form1.submit();
        }
    });

    $("#none_write").click(function () {
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

        document.form1.action = "<%=request.getContextPath()%>/board_servlet/join.do";
        document.form1.submit();
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
   		<h2>게시판 글쓰기</h2>
    </div>
    
    <div class="mb-3 d-flex justify-content-end gap-2">
	    <button type="button" id="btn_previous" class="btn btn-secondary">이전</button>
	    <button type="button" id="none_write" class="btn btn-primary">등록</button>
	    <button type="button" id="btn_logout" class="btn btn-warning text-white">로그 아웃</button>
    </div>

    <form name="form1" method="post">
        <table class="table table-bordered table-hover">
            <tr>
                <th class="table-light" style="width: 15%;">제목</th>
                <td><input type="text" name="title" maxlength="50" class="form-control"></td>
            </tr>
            <tr>
                <th class="table-light">내용</th>
                <td><textarea name="content" maxlength="5000" rows="10" class="form-control"></textarea></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
