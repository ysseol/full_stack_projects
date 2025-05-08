<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>

$(document).ready(function() {
	
	let rows = $('#table1 tbody tr');
	let total = rows.length;
	
	rows.each(function(index) {
		$(this).find('td.td1').text(total - index);
	});
	
	
	let currentPage = 1;
	var rowsPerPage = 10;
    var rows2 = $('#table1 tbody tr');
    var totalRows = rows2.length;
    var totalPages = Math.ceil(totalRows / rowsPerPage);

    for (var i = 1; i <= totalPages; i++) {
        $('#pagination').append('<button class="page-btn" data-page="' + i + '">' + i + '</button> ');
    }

    function showPage(page) {
        var start = (page - 1) * rowsPerPage;
        var end = start + rowsPerPage;

        rows.hide();
        rows.slice(start, end).show(); 
        
        rows.slice(start, end).each(function () {
            $(this).find('.checkbox').prop('checked', false);
        });
        
        $('#checkboxAll').prop('checked', false);
    }

    showPage(1);
    

    $('.page-btn').click(function() {
        var page = $(this).data('page');
        
        currentPage = page;
        
        showPage(page);
    });
    
    
    $('#checkboxAll').click(function() {
    	 const start = (currentPage - 1) * rowsPerPage;
         const end = start + rowsPerPage;
         const pageRows = rows2.slice(start, end);

         pageRows.each(function () {
             $(this).find('.checkbox').prop('checked', $('#checkboxAll').prop('checked'));
         });
    });
	
    $('.checkbox').click(function () {
        const start = (currentPage - 1) * rowsPerPage;
        const end = start + rowsPerPage;
        const pageRows = rows2.slice(start, end);

        const total = pageRows.find('.checkbox').length;
        const checked = pageRows.find('.checkbox:checked').length;

        $('#checkboxAll').prop('checked', total === checked);
    });
    
    
	$('#btn_modify').click(function() {
        var selectedCount = $('.checkbox:checked').length;
        if (selectedCount === 1) {
            $('#table1 tbody tr').each(function() {
                if ($(this).find('input[type="checkbox"]').prop('checked')) {
                    var rowData1 = [];
                    var rowData2 = [];
                    $(this).find('td').each(function(index) {
                        if (index == 1) {  
                            rowData1.push($(this).text());
                        }
                        else if(index == 2) {
                        	rowData2.push($(this).text());
                        }
                    });
                    $('#num').val(rowData1.join());
                    $('#id').val(rowData2.join());
                }
            });
            
            document.form1.action = "<%=request.getContextPath()%>/board_servlet/view.do";
			document.form1.submit();
            
        } else if (selectedCount === 0) {
            alert('게시글을 선택해주세요.');
        } else {
            alert('하나의 게시글만 선택해주세요.');
        }
    });
	
	
	$('#btn_delete').click(function() {
        var selectedCount = $('.checkbox:checked').length;
        if (selectedCount === 0) {
            alert('게시글을 선택해주세요.');
        } else {
			if(confirm(selectedCount + "개의 게시글을 삭제할까요?")){
				 var selectedData = [];
				$('#table1 tbody tr').each(function() {
	                if ($(this).find('input[type="checkbox"]').prop('checked')) {
	                    var rowData1 = [];
	                    $(this).find('td').each(function(index) {
	                        if (index == 2) {  
	                            rowData1.push($(this).text());
	                        }
	                    });
	                    selectedData.push(rowData1.join(','));
	                }
	            });
				$('#id').val(selectedData.join(','));
				
	            document.form1.action = "<%=request.getContextPath()%>/board_servlet/delete.do";
				document.form1.submit();
			}
        }
    });
	
	$("#btn_logout").click(function() {
		if(confirm("로그 아웃할까요?")){
			document.form1.action = "<%=request.getContextPath()%>/board_servlet/logout.do";
			document.form1.submit();
		}
	});
	
});

function view(id, clickedCell) {
	document.form1.id.value = id;
	var row = $(clickedCell).closest('tr');
	var cellText = row.find('td').eq(1).text().trim();
    $('#num').val(cellText);
	document.form1.submit();
}

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
th{
	height: 50px;
}
table{
	width: 100%;
}
a{
	text-decoration: none;
	color: black;
}
a:hover{
	text-decoration: underline;
}

</style>
</head>

<body>
<div class="main-pos">
	<h1 style="text-align: center;">게시판</h1>
	
	<div class="btn-r">
		<button type="button" onclick="location.href='<%=request.getContextPath()%>/board/form.jsp'">글쓰기</button>
		<button type="button" id="btn_modify">수정</button>
		<button type="button" id="btn_delete">삭제</button>
		<button type="button" id="btn_logout">로그아웃</button>
	</div>
	
	<table id="table1">
		<thead>
			<tr>
				<th><input id="checkboxAll" type="checkbox"></th>
				<th style="width:80px;">번호</th>
				<th>제목</th>
				<th>등록 일자</th>
			</tr>
		</thead>
	<%
	Map map = (Map)request.getAttribute("map");
	List<BoardDTO> items = (List)map.get("list");
	for(BoardDTO dto : items) {
	%>
		<tbody>
			<tr>
				<td style="text-align: center; width:40px;"><input class="checkbox" type="checkbox"></td>
				<td style="text-align: center; width: 100px;" id="td1" class="td1"></td>
				<td style="display: none;"><%=dto.getId()%></td>
				<td style="padding-left:5px;"><a href="#" onclick="view('<%=dto.getId()%>', this)"><%=dto.getTitle()%></td>
				<td style="width:200px; padding-left:5px;"><%=dto.getReg_date()%></td>
			</tr>
		</tbody>
	<%
	}
	%>
	</table>
	<div id="pagination" style="text-align: center; margin-top: 10px;"></div>
	<form name="form1" method="post" action="<%=request.getContextPath()%>/board_servlet/view.do">
		<input type="hidden" id="num" name="num">
		<input type="hidden" id="id" name="id">
	</form>
</div>
</body>
</html>