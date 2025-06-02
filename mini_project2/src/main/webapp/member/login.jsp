<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="member.MemberDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 로그인</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
$(function () {
    function loginAction() {
        let userid = $("input[name='userid']").val().trim();
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

        document.form1.action = "${pageContext.request.contextPath}/member_servlet/login.do";
        document.form1.submit();
    }

    $("input[name='userid'], input[name='pwd']").keyup(function (e) {
        if (e.keyCode === 13) {
            loginAction();
        }
    });

    $("#btn_login").click(loginAction);

    $("#btn_member").click(function () {
        document.form1.action = "${pageContext.request.contextPath}/member_servlet/member.do";
        document.form1.submit();
    });

    <c:if test="${not empty message}">
        alert("<c:out value='${message}'/>");
    </c:if>

    // Dark Mode
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
        <div class="col-md-6 col-lg-4">
            <div class="card shadow p-4">
                <h3 class="card-title text-center mb-4">로그인</h3>
                <form name="form1" method="post">
                    <div class="mb-3">
                        <label for="userid" class="form-label">아이디</label>
                        <input type="text" class="form-control" name="userid" id="userid"
                            value="<c:out value='${userid}' default=''/>"
                            maxlength="15">
                    </div>
                    <div class="mb-3">
                        <label for="pwd" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" name="pwd" id="pwd" maxlength="15">
                    </div>
                    <div class="d-grid gap-2">
                        <button type="button" id="btn_login" class="btn btn-primary">로그인</button>
                        <button type="button" id="btn_member" class="btn btn-outline-secondary">회원가입</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
