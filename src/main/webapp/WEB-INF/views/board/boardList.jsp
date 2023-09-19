<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Q&A</title>
<link href="<c:url value='/resources/css/memberstyle.css'/>" rel="stylesheet" />
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
</head>
<body id="fixed">
	<div class="listStyle">
		<div id="bottomMenu">
			<ul>
				<li><a href="<c:url value='/board/info.do'/>">INFO</a></li>
				<li><a href="<c:url value='/notice/noticeList.do'/>">NOTICE</a></li>
				<li><a href="<c:url value='/board/boardList.do'/>">Q&A</a></li>
			</ul>
		</div>
		<h2>Q&A</h2>
		<h3>Q&A LIST</h3>
		<div class="btn-group" style="text-align: right; margin-bottom: 10px;">
			<c:if test="${sessionScope.loginMember != null}"></c:if>
			<!-- 등록 버튼 -->
			<a id="insertBtn" class="button-new">등록</a>

			<c:if test="${loginMember.uid eq 'admin'}"> 
			<!-- 삭제 버튼 -->
			<input type="button" value="삭제" onclick="deleteAllRows()"
				class="button-new">
			</c:if>
		</div>
		<div id="exForm" style="display: none;">등록글</div>
		<div class="form_wrap">
			<form action="deleteBoard" method="post"></form>
			<!-- 게시글 목록 테이블 -->
			<table>
				<tr id="boardItem" style="display:none">
					<c:if test="${loginMember.uid eq 'admin'}"> 
						<td><input type="checkbox" id="check" name="selectedBoards"
							value="{boardId}"></td>
					</c:if>
	                <td id="boardId"></td>
	                <td ><a href="viewBoard.do?boardId={boardId}" id="title"></a></td>
	                <td id="writerUid"></td>
	                <td id="regDate"></td>
	                <td id="viewCount"></td>  
	            </tr>  
			    <tbody id="boardList">
					<tr>
						<c:if test="${loginMember.uid eq 'admin'}"> 
							<th><input type="checkbox" id="selectAllCheckbox"
								onclick="selectAllRows()"></th>
						</c:if>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
					<c:forEach var="board" items="${boardList}">
						<tr>
							<c:if test="${loginMember.uid eq 'admin'}"> 
								<td><input type="checkbox" class="selectedBoards" name="selectedBoards"
									value="${board.boardId}"></td>
							</c:if>
							<td>${board.boardId}</td>
							<td><a href="#" id ="viewBoardButton" data-boardId="${board.boardId}">${board.title}</a></td>
							<td>${board.writerUid}</td>
							<td>${board.regDate}</td>
							<td>${board.viewCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div style="text-align: center; margin-top: 10px">
				<input type="button" id="moreBtn" value="더보기" />
			</div>
		</div>
	</div>
<%-- 	<%@ include file="../../../other.jsp"%> --%>
	
<!-- 게시글 등록 폼 -->	
		<div id="insertBoardForm" class="custom-form-wrap">
<!-- 		<div class="custom-form-wrap"></div> -->
<!-- 			css 클래스값 -->
			<form style="text-align: center;">
				<h2>Q&A</h2>
					<input type="hidden" id="insertBoard_writerUid" name="insertBoard_writerUid"
							value="<c:out value='${loginMember.uid}' />"> 
<!-- 							<input type="submit" value="글 등록"> -->
						<table>
							<tr>
								<td><label for="insertBoard_title">Title</label></td>
								<td><input type="text" id="insertBoard_title" name="insertBoard_title" required></td>
							</tr>
							<tr>
								<td><label for="insertBoard_contents">Contents</label></td>
								<td><textarea id="insertBoard_contents" name="insertBoard_contents" rows="6" required></textarea></td>
							</tr>
						</table>
			</form>
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
	
<!-- 게시글 수정하기 폼 -->	
	<div id = "updateboard">	
		<h2>Q&A</h2>
		<h3>게시글 수정</h3>
		<h4></h4>
	
<!-- 		<div class="custom-form-wrap"> -->
			<c:set var="boardId" value="${param.boardId}" />
			<c:set var="title" value="${param.title}" />
			<c:set var="contents" value="${param.contents}" />
	
			<%-- <c:set var="board" value="${BoardService.getBoardById(boardId)}" /> --%>
			<form class="form-btn" id="updateBoard" method="post">
<!-- 				<input type="submit" value="수정" style="margin: 0 20px;"> -->
			</form>
	
			<form class="form-btn" method="post">
				<input type="hidden" id="boardId" value="${board.boardId}">
				<table>
					<tr>
						<td><label for="update_title">Title</label></td>
						<td><input type="text" name="update_title" id="update_title"
							value="${board.title}"><br></td>
					</tr>
					<tr>
						<td><label for="update_contents">Contents</label><br></td>
						<td><textarea name="update_contents" id="update_contents" cols="30"
								rows="10">${board.contents}</textarea></td>
					</tr>
				</table>
	
			
<!-- 		</div> -->
	</div>
	
	
	<div id = "deleteBoard">
	<h2>게시글을 삭제하시겠습니까?</h2>
	</div>
	
 <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
	$(document).ready(function() {
	    $("#goBoardForm").click(function() {
	        $("#bForm").css("display","block");
	    });
	   
	    $("#closePop").click(function() {
	        $("#bForm").css("display","none");
	    });
	    

    	$('#insertBoardForm').dialog({
    	    autoOpen: false,
    	    modal: true,
    	    buttons: {
    	        '등록': function() {
    	            // 게시글 정보를 수집하고 서버로 전송하는 코드를 작성
    	            const param = {
    	            		writerUid  : insertBoard_writerUid.value,
    	            		title : insertBoard_title.value,
    	            		contents  : insertBoard_contents.value
                     		
    	           	 };
    	                
    	            

    	            // AJAX를 사용하여 회원가입 데이터를 서버로 전송
    	            $.ajax({
    	                url: "<c:url value='/board/insertBoard.do'/>",
    	                type: "POST",
    	                contentType: "application/json; charset=UTF-8",
    	                data: JSON.stringify(param),
    	                dataType: "JSON",
    	                success: function(json) {
    	                    alert(json.message);
    	                    if (json.status) {
    	                        location.href = "<c:url value=''/>";
    	                    }
    	                }
    	            });

    	            $(this).dialog('close');
    	        },
    	        '닫기': function() {
    	            $(this).dialog('close');
    	        }
    	    },
    	    closeText: '닫기',
    	    closeOnEscape: true
    	});


     $('#insertBtn').click(function() {
    	    $('#insertBoardForm').dialog('open');
    	});     //end insert
	    
    	
    	
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
    		                    $("#viewBoard_boardId").val(json.boardId);
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
                        '수정하기': function() {
                        	$("#update_title").val($("#viewBoard_title").val());
                        	$("#update_contents").val($("#viewBoard_contents").val());
                        	$('#updateboard').dialog('open');
                        },
                        
                        '삭제' : function () {
                        	$('#deleteBoard').dialog('open');
                        	
//                         	 if (confirm('게시글을 삭제하시겠습니까?')) {
//                         		 var boardId = $("#viewBoard_boardId").val();
//                         	        window.location.href = "<c:url value='/board/deleteBoard.do?boardId=" + boardId + "'/>";
//          	        	    } else {
//          	        	        // 취소 시 동작
//          	        	    }
                    	 //  
                     },
    		        },
    		        closeText: '닫기',
    		        closeOnEscape: true
    		    });// end viewBoard	
    		    
    		    
    		    $('#deleteBoard').dialog({
    	     		width: 800,
    		    	height: 600,
    	       	    autoOpen: false,
    	       	    modal: true,
    	       	    buttons: {
    	       	        '게시글 삭제': function() {
    	       	            const param = {
    	       	            		boardId: $("#viewBoard_boardId").val(),
    	       	            		
    	       	           	 };
    	       	                
    	       	            $.ajax({
    	       	                url: "<c:url value='/board/deleteBoard.do'/>",
    	       	                type: "POST",
    	       	                contentType: "application/json; charset=UTF-8",
    	       	                data: JSON.stringify(param),
    	       	                dataType: "JSON",
    	       	                success: function(json) {
    	       	                    alert(json.message);
    	       	                    if (json.status) {
    	       	                        location.href = "<c:url value=''/>";
    	       	                    }
    	       	                }
    	       	            });

    	       	            $(this).dialog('close');
    	       	        }, 
    	       	        '닫기': function() {
    	       	            $(this).dialog('close');
    	       	        }
    	       	    },
    	       	    closeText: '닫기',
    	       	    closeOnEscape: true
    	       	});   		    	    
    		    
    		    
    		    
    		    
     	$('#updateboard').dialog({
     		width: 800,
	    	height: 600,
       	    autoOpen: false,
       	    modal: true,
       	    buttons: {
       	        '게시글 수정': function() {
       	            const param = {
       	            		boardId: $("#viewBoard_boardId").val(),
       	            		title : update_title.value,
       	            		contents  : update_contents.value
       	           	 };
       	                
       	            $.ajax({
       	                url: "<c:url value='/board/updateBoard.do'/>",
       	                type: "POST",
       	                contentType: "application/json; charset=UTF-8",
       	                data: JSON.stringify(param),
       	                dataType: "JSON",
       	                success: function(json) {
       	                    alert(json.message);
       	                    if (json.status) {
       	                        location.href = "<c:url value=''/>";
       	                    }
       	                }
       	            });

       	            $(this).dialog('close');
       	        }, 
       	        '닫기': function() {
       	            $(this).dialog('close');
       	        }
       	    },
       	    closeText: '닫기',
       	    closeOnEscape: true
       	});   		    
    	
    	
    	
}); //ready end
	
	
	

	
	
	
// 	이전 기본 스크립트들

		// 전체 선택 체크박스를 클릭하면 모든 게시글의 체크박스가 선택되거나 해제됨
		function selectAllRows() {
			var selectAllCheckbox = document
					.getElementById('selectAllCheckbox');
			var checkboxes = document.getElementsByName('selectedBoards');
			for (var i = 0; i < checkboxes.length; i++) {
				checkboxes[i].checked = selectAllCheckbox.checked;
			}
		}
		function deleteAllRows() {
		    if (confirm('선택한 게시글을 삭제하시겠습니까?')) {
// 		        var checkboxes = document.getElementsByName('selectedBoards');
		        var checkboxes = document.querySelectorAll('.selectedBoards:checked');
		        var boardIds = [];
		        for (var i = 0; i < checkboxes.length; i++) {
	                boardIds.push(checkboxes[i].value);
		        }
		        if (boardIds.length > 0) {
		            const requestData = {
		                boardIds: boardIds,
		            };

		            fetch("/project2/board/deleteBoards.do", {
		                method: "POST",
		                headers: {
		                    "Content-Type": "application/json; charset=UTF-8",
		                },
		                body: JSON.stringify(requestData),
		            })
		            .then((response) => response.json())
		            .then((json) => {
		                alert(json.message);
		                if (json.status) {
		                	checkboxes.forEach(checkbox => {
		                		checkbox.parentElement.parentElement.remove();
		                	});
		                	
		                    var boardId;
		        			if (${loginMember.uid eq 'admin'}) boardId = document.querySelector("#boardList tr:last-child td:nth-child(2)").textContent;
		        			else boardId = document.querySelector("#boardList tr:last-child td:first-child").textContent;
		        			
		        			const param = {
		        			        boardId: boardId,
		    		                moreNum: boardIds.length
		        			      };

		        			      fetch("<c:url value='/board/ajaxList2.do'/>", {
		        			        method: "POST",
		        			        headers: {
		        			          "Content-Type": "application/json; charset=UTF-8",
		        			        },
		        			        body: JSON.stringify(param),
		        			      })
		        			      .then((response) => response.json())
		        			      .then((json) => {
		        			    	  let html = "";
		        			          if (json.status) {
		        			        	  const boardList = json.boardList;
		        			        	  const boardItem = document.querySelector("#boardItem");
		        			        	  const boardListHTML = document.querySelector("#boardList");
		        			        	  
		        			        	  for (let i=0;i<boardList.length;i++) {
		        				        	  const board = boardList[i];
		        				        	  const newBoardItem = boardItem.cloneNode(true);
		        							  const title = newBoardItem.querySelector("#title");
		        							  const check = newBoardItem.querySelector("#check");
		        							  
		        							  if (${loginMember.uid eq 'admin'}) check.value = board.boardId;
		        				        	  newBoardItem.querySelector("#boardId").innerText = board.boardId; 
		        				        	  
		        				        	  title.innerText = board.title;
		        				        	  title.href = title.href.replace("{boardId}", board.boardId);
		        				        	  
		        				        	  newBoardItem.querySelector("#writerUid").innerText = board.writerUid; 
		        				        	  newBoardItem.querySelector("#regDate").innerText = board.regDate; 
		        				        	  newBoardItem.querySelector("#viewCount").innerText = board.viewCount; 

		        				        	  newBoardItem.style.display = "";
		        				        	  boardListHTML.appendChild(newBoardItem);
		        			        	  }


		        			          }
		        			      });
		        	      
		                }
		            });
		        }
		    }
		}
		
		document.querySelector("#moreBtn").addEventListener("click", e => {
			//이벤트 핸들러의 기본 동작을 취소한다
			e.preventDefault();
			var boardId;
			if (${loginMember.uid eq 'admin'}) boardId = document.querySelector("#boardList tr:last-child td:nth-child(2)").textContent;
			else boardId = document.querySelector("#boardList tr:last-child td:first-child").textContent;
			
			const param = {
			        boardId: boardId,
	                moreNum: 10
			      };

			      fetch("<c:url value='/board/ajaxList2.do'/>", {
			        method: "POST",
			        headers: {
			          "Content-Type": "application/json; charset=UTF-8",
			        },
			        body: JSON.stringify(param),
			      })
			      .then((response) => response.json())
			      .then((json) => {
			    	  let html = "";
			          if (json.status) {
			        	  const boardList = json.boardList;
			        	  const boardItem = document.querySelector("#boardItem");
			        	  const boardListHTML = document.querySelector("#boardList");
			        	  
			        	  for (let i=0;i<boardList.length;i++) {
				        	  const board = boardList[i];
				        	  const newBoardItem = boardItem.cloneNode(true);
							  const title = newBoardItem.querySelector("#title");
							  const check = newBoardItem.querySelector("#check");
							  
							  if (${loginMember.uid eq 'admin'}) check.value = board.boardId;
				        	  newBoardItem.querySelector("#boardId").innerText = board.boardId; 
				        	  
				        	  title.innerText = board.title;
				        	  title.href = title.href.replace("{boardId}", board.boardId);
				        	  
				        	  newBoardItem.querySelector("#writerUid").innerText = board.writerUid; 
				        	  newBoardItem.querySelector("#regDate").innerText = board.regDate; 
				        	  newBoardItem.querySelector("#viewCount").innerText = board.viewCount; 

				        	  newBoardItem.style.display = "";
				        	  boardListHTML.appendChild(newBoardItem);
			        	  }


			          }
			      });
	      });
	</script>
</body>
</html>
