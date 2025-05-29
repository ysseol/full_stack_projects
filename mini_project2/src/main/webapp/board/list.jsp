<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function () {
    let rows = $('#table1 tbody tr');
    let total = rows.length;

    rows.each(function (index) {
        $(this).find('td.td1').text(total - index);
    });

    let currentPage = 1;
    let rowsPerPage = 10;
    let totalPages = Math.ceil(rows.length / rowsPerPage);

    for (let i = 1; i <= totalPages; i++) {
        $('#pagination').append(
            '<button class="btn btn-outline-primary btn-sm mx-1 page-btn" data-page="' + i + '">' + i + '</button>'
        );
    }

    function showPage(page) {
        let start = (page - 1) * rowsPerPage;
        let end = start + rowsPerPage;

        rows.hide();
        rows.slice(start, end).show();
        rows.slice(start, end).find('.checkbox').prop('checked', false);
        $('#checkboxAll').prop('checked', false);

        $('.page-btn').removeClass('active');
        $('.page-btn[data-page="' + page + '"]').addClass('active');
    }

    showPage(1);

    $('.page-btn').click(function () {
        let page = $(this).data('page');
        currentPage = page;
        showPage(page);
    });

    $('#checkboxAll').click(function () {
        let start = (currentPage - 1) * rowsPerPage;
        let end = start + rowsPerPage;
        rows.slice(start, end).find('.checkbox').prop('checked', this.checked);
    });

    $('.checkbox').click(function () {
        let pageRows = rows.slice((currentPage - 1) * rowsPerPage, currentPage * rowsPerPage);
        let allChecked = pageRows.find('.checkbox').length === pageRows.find('.checkbox:checked').length;
        $('#checkboxAll').prop('checked', allChecked);
    });

    $('#btn_modify').click(function () {
        let checked = $('.checkbox:checked');
        if (checked.length === 1) {
            let row = checked.closest('tr');
            $('#num').val(row.find('td.td1').text().trim());
            $('#id').val(row.find('td:hidden').text().trim());
            document.form1.action = "<%=request.getContextPath()%>/board_servlet/view.do";
            document.form1.submit();
        } else {
            alert(checked.length === 0 ? "게시글을 선택해주세요." : "하나의 게시글만 선택해주세요.");
        }
    });

    $('#btn_delete').click(function () {
        let checked = $('.checkbox:checked');
        if (checked.length === 0) {
            alert('게시글을 선택해주세요.');
            return;
        }

        if (confirm(checked.length + "개의 게시글을 삭제할까요?")) {
            let ids = [];
            checked.closest('tr').each(function () {
                ids.push($(this).find('td:hidden').text().trim());
            });
            $('#id').val(ids.join(','));
            document.form1.action = "<%=request.getContextPath()%>/board_servlet/delete.do";
            document.form1.submit();
        }
    });

    $('#btn_logout').click(function () {
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

function view(id, clickedCell) {
    document.form1.id.value = id;
    let row = $(clickedCell).closest('tr');
    $('#num').val(row.find('td.td1').text().trim());
    document.form1.submit();
}
</script>

<style>
#btn_darkmode {
    position: fixed;
    top: 10px;
    left: 10px;
    z-index: 999;
}
.page-btn.active {
    background-color: #0d6efd;
    color: white;
}
</style>

</head>
<body>
<button type="button" id="btn_darkmode" class="btn btn-outline-dark">다크 모드</button>

<div class="container mt-5">
    <div class="text-center mb-4">
        <h2>게시판</h2>
    </div>

    <div class="mb-3 d-flex justify-content-end gap-2">
        <button type="button" class="btn btn-success" onclick="location.href='<%=request.getContextPath()%>/board/form.jsp'">글쓰기</button>
        <button type="button" id="btn_modify" class="btn btn-primary">수정</button>
        <button type="button" id="btn_delete" class="btn btn-danger">삭제</button>
        <button type="button" id="btn_logout" class="btn btn-warning text-white">로그아웃</button>
    </div>

    <table id="table1" class="table table-bordered table-hover">
        <thead class="table-light">
            <tr>
                <th style="width:5%;"><input type="checkbox" id="checkboxAll"></th>
                <th style="width:10%;">번호</th>
                <th>제목</th>
                <th style="width:20%;">등록 일자</th>
            </tr>
        </thead>
        <tbody>
            <%
            Map map = (Map) request.getAttribute("map");
            List<BoardDTO> items = (List) map.get("list");
            for (BoardDTO dto : items) {
            %>
            <tr>
                <td class="text-center"><input type="checkbox" class="checkbox form-check-input"></td>
                <td class="text-center td1"></td>
                <td style="display: none;"><%=dto.getId()%></td>
                <td><a href="#" onclick="view('<%=dto.getId()%>', this)" class="text-decoration-none"><%=dto.getTitle()%></a></td>
                <td><%=dto.getReg_date()%></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <div id="pagination" class="text-center my-3"></div>

    <form name="form1" method="post" action="<%=request.getContextPath()%>/board_servlet/view.do">
        <input type="hidden" id="num" name="num">
        <input type="hidden" id="id" name="id">
    </form>
</div>
</body>
</html>
