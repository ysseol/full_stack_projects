<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 회원가입</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
$(function () {
    function registerAction() {
        let userid = $("input[name='userid']").val().trim();
        let name = $("input[name='name']").val().trim();
        let pwd = $("input[name='pwd']").val().trim();

        if (userid === "") {
            alert("아이디를 입력해 주세요.");
            $("input[name='userid']").focus();
            return;
        }
        if (pwd === "") {
            alert("비밀번호를 입력해 주세요.");
            $("input[name='pwd']").focus();
            return;
        }
        if (name === "") {
            alert("이름을 입력해 주세요.");
            $("input[name='name']").focus();
            return;
        }

        document.form1.action = "${pageContext.request.contextPath}/member_servlet/register.do";
        document.form1.target = "";
        document.form1.submit();
    }

    $("#btn_register").click(registerAction);
    $("#btn_previous").click(function () {
        location.href = "<%=request.getContextPath()%>/member/login.jsp";
    });

    $("#btn_check").click(function () {
        let userid = $("input[name='userid']").val().trim();
        if (userid === "") {
            alert("아이디를 입력해 주세요.");
            $("input[name='userid']").focus();
            return;
        }
        document.form1.action = "${pageContext.request.contextPath}/member_servlet/check.do";
        document.form1.target = "checkFrame";
        document.form1.submit();
    });

    $("input").keyup(function (e) {
        if (e.keyCode === 13) {
            registerAction();
        }
    });

<c:if test="${not empty message}">
	alert("<c:out value='${message}'/>");
</c:if>

    if (localStorage.getItem("theme") === "dark") {
        $("body").addClass("bg-dark text-light");
        $("#btn_darkmode").text("라이트 모드").removeClass("btn-outline-dark").addClass("btn-outline-light");
        $(".card").addClass("bg-dark text-light border-secondary");
    }

    $("#btn_darkmode").click(function () {
        $("body").toggleClass("bg-dark text-light");
        $(".card").toggleClass("bg-dark text-light border-secondary");

        if ($("body").hasClass("bg-dark")) {
            $("#btn_darkmode").text("라이트 모드").removeClass("btn-outline-dark").addClass("btn-outline-light");
            localStorage.setItem("theme", "dark");
        } else {
            $("#btn_darkmode").text("다크 모드").removeClass("btn-outline-light").addClass("btn-outline-dark");
            localStorage.setItem("theme", "light");
        }
    });
});
</script>

<style>
body {
    padding-top: 80px;
}
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

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow p-4">
                <h3 class="card-title text-center mb-4">회원가입</h3>
                <form name="form1" method="post">
                    <div class="mb-3">
                        <label for="userid" class="form-label">아이디</label>
                        <div class="input-group">
                            <input type="text" name="userid" id="userid" class="form-control"
                                   value="<c:out value='${userid}' default=''/>">
                            <button type="button" id="btn_check" class="btn btn-outline-secondary">중복 확인</button>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="pwd" class="form-label">비밀번호</label>
                        <input type="password" name="pwd" id="pwd" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">이름</label>
                        <input type="text" name="name" id="name" class="form-control"
                               value="<c:out value='${name}' default=''/>">
                    </div>
                    <div class="d-grid gap-2">
                        <button type="button" id="btn_register" class="btn btn-primary">등록</button>
                        <button type="button" id="btn_previous" class="btn btn-outline-secondary">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<iframe name="checkFrame" style="display:none;"></iframe>

</body>
</html>
