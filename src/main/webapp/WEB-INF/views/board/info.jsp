<%@ page import="java.util.List"%>
<%@ page import="com.kosa.app.board.domain.Board"%>
<%@ page import="com.kosa.app.notice.domain.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>INFO</title>
</head>
<body id="fixed">
<style>
	.custom-table {
		width: 100%;
		border-collapse: collapse;
	}
	
	.custom-table th, .custom-table td {
		padding: 10px;
		text-align: center;
	}
	
	.custom-table th {
		border-bottom: 1px solid #ccc;
	}
	
	.custom-table .center-divider {
		border-left: 1px solid #ccc;
		border-right: 1px solid #ccc;
		width: 20px;
	}
	
	.custom-table ul {
		list-style: none;
		padding: 0;
		margin: 0;
		text-align: left;
	}
	
	.custom-table ul li {
		margin-bottom: 10px;
	}
	
	.list_ul li:first-child {
		text-align: right;
		margin-bottom: 30px;
		text-decoration: underline;
		font-size: 12px;
		color: gray;
	}
	
	.list_ul li {
		text-align: center;
	}
</style>
	<link href="<c:url value='/resources/css/memberstyle.css'/>" rel="stylesheet" />
	<div id="bottomMenu">
		<ul>
			<li><a href="<c:url value='/board/info.do'/>">INFO</a></li>
			<li><a href="<c:url value='/notice/noticeList.do'/>">NOTICE</a></li>
			<li><a href="<c:url value='/board/boardList.do'/>">Q&A</a></li>
		</ul>
	</div>
	<div class="form_wrap">
		<h2>INFO</h2>

			<table class="custom-table">
				<thead>
					<tr>
						<th>공지사항</th>
						<th class="center-divider"></th>
						<th>게시판</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="align-center">
							<ul class="list_ul">
								<li><a href="<c:url value='/notice/noticeList.do'/>">전체보기</a></li>
								<c:forEach items="${notices}" var="notice">
<%-- 									<li><a href="viewNotice?noticeId=${notice.noticeId}">${notice.title}</a></li> --%>
									<li><a href="#" id = "viewNoticeButton" data-noticeId="${notice.noticeId}">${notice.title}</a></li>
								</c:forEach>
							</ul>
						</td>
						<td class="center-divider"></td>
						<td class="align-center">
							<ul class="list_ul">
								<li><a href="<c:url value='/board/boardList.do'/>">전체보기</a></li>
								<c:forEach items="${boards}" var="board">
<%-- 									<li><a href="viewBoard?boardId=${board.boardId}">${board.title}</a></li> --%>
									<li><a href="#" id ="viewBoardButton" data-boardId="${board.boardId}">${board.title}</a></li>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
			
			
			
			
<!--  게시판 상세보기 폼  -->
	<div id="viewBoardForm">
	<!-- title = "상세보기" 이거 안에 적으면 회색 부분에 들어감-->
		<form style="text-align: center;">
				<h2>Q&A</h2>
					<h3>문의글확인</h3>
					<div class="custom-form-wrap">
						<c:set var="boardId" value="${param.boardId}" />
						<c:set var="title" value="${param.title}" />
						<c:set var="contents" value="${param.contents}" />
						<c:set var="writerUid" value="${board.writerUid}" />
						
							<input type="hidden" id="viewBoard_boardId" value="${board.boardId}">
							<table>
								<tr>
									<td><label for="viewBoard_title">Title</label></td>
									<td><input type="text" name="viewBoard_title" id="viewBoard_title"
										value="${board.title}" readonly></td>
								</tr>
								<tr>
									<td><label for="viewBoard_contents">Contents</label></td>
									<td><textarea name="viewBoard_contents" id="viewBoard_contents" cols="30"
											rows="10" readonly>${board.contents}</textarea></td>
								</tr>
							</table>
					</div>
				</form>
			</div> 
	
	<!-- 공지사항 상세보기 폼 -->
	<div id="viewNoticeForm">
	<!-- title = "상세보기" 이거 안에 적으면 회색 부분에 들어감-->
		<form style="text-align: center;">
				<h2>NOTICE</h2>
					<h3>공지사항 확인</h3>
					<div class="custom-form-wrap">
						<c:set var="noticeId" value="${param.noticeId}" />
						<c:set var="title" value="${param.title}" />
						<c:set var="contents" value="${param.contents}" />
			
						<input type="hidden" name="viewNotice_noticeId" value="${notice.noticeId}">
							<table>
								<tr>
									<td><label for="viewNotice_title">Title</label></td>
									<td><input type="text" name="viewNotice_title" id="viewNotice_title"
										value="${notice.title}" readonly></td>
								</tr>
								<tr>
									<td><label for="viewNotice_contents">Contents</label></td>
									<td><textarea name="viewNotice_contents" id="viewNotice_contents" cols="30"
											rows="10" readonly>${notice.contents}</textarea></td>
								</tr>
							</table>
					</div>
			</form>
		</div>
						
			
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>	
	 <script>
	 
	 $(document).ready(function(){
		 //QNA 게시글 확인
		   $(document).on("click", '#viewBoardButton', function(e) {
		        var boardid = $(this).data('boardid');
		        const param  = { boardId: boardid };
		        
		        $.ajax({
		            url: "<c:url value='/board/viewBoard.do'/>",
		            type: "POST",
		            contentType: "application/json; charset=UTF-8",
		            data: JSON.stringify(param),
		            dataType: "JSON",
		            success: function(json) {
		                if (json.status) {
		                    $("#viewBoard_title").val(json.title);
		                    $("#viewBoard_contents").val(json.contents);
		                    $("#writerUid").val(json.writerUid);
		                    
		                    $("#viewBoardForm").dialog('open');
		                    
		                }
		            }
		        }); //ajax 끝

		    }); // 버튼온클릭 끝

		    $('#viewBoardForm').dialog({
		    	width: 800,
		    	height: 600,
		        autoOpen: false,
		        modal: true,
		        buttons: {
		        },
		        closeText: '닫기',
		        closeOnEscape: true
		    });
     
		    
		    
		    //공지사항 게시글 확인
			   $(document).on("click", '#viewNoticeButton', function(e) {
			        var noticeid = $(this).data('noticeid');
			        const param  = { noticeId: noticeid };
			        
			        $.ajax({
			            url: "<c:url value='/notice/viewNotice.do'/>",
			            type: "POST",
			            contentType: "application/json; charset=UTF-8",
			            data: JSON.stringify(param),
			            dataType: "JSON",
			            success: function(json) {
			                if (json.status) {
			                    $("#viewNotice_title").val(json.title);
			                    $("#viewNotice_contents").val(json.contents);
			                    $("#writerUid").val(json.writerUid);
			                    
			                    $("#viewNoticeForm").dialog('open');
			                    
			                }
			            }
			        }); //ajax 끝

			    }); // 버튼온클릭 끝

			    $('#viewNoticeForm').dialog({
			    	width: 800,
			    	height: 600,
			        autoOpen: false,
			        modal: true,
			        buttons: {
			           
			        },
			        closeText: '닫기',
			        closeOnEscape: true
			    });
	 
}); //ready 	 
</script>
</body>
</html>
