<%@ page import="java.util.List"%>
<%@ page import="com.kosa.app.notice.domain.Notice"%>
<%@ page import="com.kosa.app.notice.service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<link href="<c:url value='/resources/css/memberstyle.css'/>" rel="stylesheet" />
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
		<h2>NOTICE</h2>
		<h3>NOTICE LIST</h3>
		<form name="pageForm" id="pageForm"
			action="<c:url value='/notice/noticeList.do'/>" method="post">
			<input type="hidden" name="pageNo" id="pageNo"
				value="${result.notice.pageNo}" /> <input type="hidden"
				name="searchTitle" id="searchTitle"
				value="${result.notice.searchTitle}"> <input type="hidden"
				name="pageLength" id="pageLength" value="${result.notice.pageLength}">
		</form>
	
		<form name="mForm" id="mForm" action="<c:url value='/notice/list.do'/>"
			method="post">
			<input type="hidden" name="pageNo" id="pageNo"
				value="${result.notice.pageNo}" />
			<div style="margin: 0px auto;">
				<div
					style="display: flex; margin: 0px auto; width: 70%; justify-align: center">
					<label>건수: </label> <select name="pageLength" id="pageLength">
						<option value="10"
							${result.notice.pageLength == 10 ? 'selected="selected"' : ''}>10건</option>
						<option value="20"
							${result.notice.pageLength == 20 ? 'selected="selected"' : ''}>20건</option>
						<option value="50"
							${result.notice.pageLength == 50 ? 'selected="selected"' : ''}>50건</option>
						<option value="100"
							${result.notice.pageLength == 100 ? 'selected="selected"' : ''}>100건</option>
					</select> <label>제목 : </label> <input type="text" name="searchTitle"
						id="searchTitle" value="${result.notice.searchTitle}"
						style="flex: 1"> <input type="submit" value="검색" />
				</div>
			</div>
			<div class="btn-group">
 				<c:if test="${loginMember.uid eq 'admin'}">
					<!-- 등록 버튼 -->
					<a href="insertNoticeForm" class="button-new"
						style="height: 40px; = display: inline-block; = box-sizing: border-box;">등록</a>
	
					<!-- 삭제 버튼 -->
					<input style="height: 40px" type="button" value="삭제"
						onclick="deleteAllRows()" class="button-new">
					<input type="button" value="고정" onclick="fixAllRows()"
						class="button-new">
					<input type="button" value="고정 해제" onclick="unfixAllRows()"
						class="button-new">
	 			</c:if> 
			</div>
			<div class="form_wrap" >
				<form action="deleteNotice" method="post" style="width: 100%;">
					<!-- 공지사항 목록 테이블 -->
					<table>
						<tr>
							<th><input type="checkbox" id="selectAllCheckbox" onclick="selectAllRows()"></th>
							<th>글번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
							<th>고정</th>
							<!-- "Fix Notice" 버튼을 위한 새로운 열 제목 -->
						</tr>
						<c:forEach var="notice" items="${result.noticeList}">
							<tr>
								<td>
									<input type="checkbox" name="selectedNotices" value="${notice.noticeId}">
								</td>
								<td>
									<span style="font-weight: ${notice.fixedYN eq 'Y' ? 'bold' : 'normal'};">${notice.noticeId}</span>
								</td>
								<td>
								<span style="font-weight: ${notice.fixedYN eq 'Y' ? 'bold' : 'normal'};"></span>
									<a href="viewNotice?noticeId=${notice.noticeId}&title=${notice.title}">
										<span style="font-weight: ${notice.fixedYN eq 'Y' ? 'bold' : 'normal'};">${notice.title}</span>
									</a>
								</td>
								<td>
									<span style="font-weight: ${notice.fixedYN eq 'Y' ? 'bold' : 'normal'};">${notice.writerUid}</span>
								</td>
								<td>
									<span style="font-weight: ${notice.fixedYN eq 'Y' ? 'bold' : 'normal'};">${notice.regDate}</span>
								</td>
								<td>
									<span style="font-weight: ${notice.fixedYN eq 'Y' ? 'bold' : 'normal'};">${notice.viewCount}</span>
								</td>
								<td>
									<span style="font-weight: ${notice.fixedYN eq 'Y' ? 'bold' : 'normal'};">${notice.fixedYN}</span>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty result.noticeList}">
							<tr>
								<td colspan=7>검색결과가 없습니다</td>
							</tr>
						</c:if>
					</table>
					
				</form>
				<div style="text-align: center; margin-top: 20px; padding-bottom:250px;">
					<c:if test="${result.notice.navStart != 1}">
						<a href="javascript:jsPageNo(${result.notice.navStart-1})"
							style="padding: 10px; border: 1px rgb(101, 83, 69);"> &lt; </a>
					</c:if>
					<c:forEach var="item" begin="${result.notice.navStart}"
						end="${result.notice.navEnd}">
						<c:choose>
							<c:when test="${result.notice.pageNo != item }">
								<a href="javascript:jsPageNo(${item})"
									style="padding: 10px; border: 1px rgb(101, 83, 69);">${item}</a>
							</c:when>
							<c:otherwise>
								<strong style="font-size: 2rem">${item}</strong>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${result.notice.navEnd != result.notice.totalPageSize}">
						<a href="javascript:jsPageNo(${result.notice.navEnd+1})"
							style="padding: 10px; border: 1px rgb(101, 83, 69);"> &gt; </a>
					</c:if>
				</div>
			</div>
		</form>
	</div>

		<script>
		// 전체 선택 체크박스를 클릭하면 모든 공지사항의 체크박스가 선택되거나 해제됨
		function selectAllRows() {
			var selectAllCheckbox = document
					.getElementById('selectAllCheckbox');
			var checkboxes = document.getElementsByName('selectedNotices');
			for (var i = 0; i < checkboxes.length; i++) {
				checkboxes[i].checked = selectAllCheckbox.checked;
			}
		}
		// 선택 삭제
		function deleteAllRows() {
			if (confirm('선택한 게시글을 삭제하시겠습니까?')) {
				var checkboxes = document.getElementsByName('selectedNotices');
				var noticeIds = "";
				for (var i = 0; i < checkboxes.length; i++) {
					if (checkboxes[i].checked)
						noticeIds += checkboxes[i].value + ",";
				}
				if (noticeIds == "") {
					alert("삭제할 게시글을 선택해주세요.");
				} else {
					noticeIds = noticeIds.substr(0, noticeIds.length - 1);
					location.href = "deleteNotice.do?noticeIds=" + noticeIds;
				}
			}
		}

		// 공지사항 고정 함수
		function fixAllRows() {
			if (confirm('해당 공지사항을 고정하시겠습니까?')) {
				var checkboxes = document.getElementsByName('selectedNotices');
				var noticeIds = "";
				for (var i = 0; i < checkboxes.length; i++) {
					if (checkboxes[i].checked)
						noticeIds += checkboxes[i].value + ",";
				}
				if (noticeIds == "") {
					alert("고정할 공지사항을 선택해주세요.");
				} else {
					noticeIds = noticeIds.substr(0, noticeIds.length - 1);
					location.href = "fixNotice?noticeIds=" + noticeIds;
				}
			}
		}
		// 고정해제
		function unfixAllRows() {
			if (confirm('해당 공지사항을 고정 해제하시겠습니까?')) {
				var checkboxes = document.getElementsByName('selectedNotices');
				var noticeIds = "";
				for (var i = 0; i < checkboxes.length; i++) {
					if (checkboxes[i].checked)
						noticeIds += checkboxes[i].value + ",";
				}
				if (noticeIds == "") {
					alert("고정 해제할 공지사항을 선택해주세요.");
				} else {
					noticeIds = noticeIds.substr(0, noticeIds.length - 1);
					location.href = "unFixNotice?noticeIds=" + noticeIds;
				}
			}
		}
		// 페이징
		document.querySelector("#mForm").addEventListener("submit", e => {
			document.querySelector("#mForm > #pageNo").value = "1";
			return true;
		});
		
		function jsDetailView(noticeId) {
			document.querySelector("#noticeid").value = noticeId;
			mForm.submit();	
		}

		function jsPageNo(pageNo) {
			document.querySelector("#pageForm > #pageNo").value = pageNo;
			document.querySelector("#pageForm").submit(); 
		}
	</script>
</body>
</html>
