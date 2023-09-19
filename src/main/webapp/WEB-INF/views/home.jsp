<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<!-- 헤더영역  -->
<link href="<c:url value='/resources/css/styles.css'/>" rel="stylesheet" />
	<!-- 메인 배너 이미지 삽입 -->
	<div id="slideShow">
		<div id="slides">
			<img src="<c:url value='/resources/images/main1.jpg'/>"> 
			<img src="<c:url value='/resources/images/main2.jpg'/>">  
			<img src="<c:url value='/resources/images/main3.jpg'/>"> 
			<button id="prev">&lang;</button>
			<button id="next">&rang;</button>
		</div>
	</div>
	<!-- 상세페이지 메인  -->
	<h1>Room Photo</h1>
	<div class="products">
		<a href="#"> <img src="<c:url value='/resources/images/Aroom.jpg'/>"> 
			<p>A Room</p> 
		</a> 
		<a href="#"> <img src="<c:url value='/resources/images/Broom.jpg'/>"> 
			<p>B Room</p>
		</a> 
		<a href="#"> <img src="<c:url value='/resources/images/Croom.jpg'/>"> 
			<p>C Room</p>
		</a>
		<div class="clearfix"></div>


	</div>

	<!--메인 배너 이미지 넘기기 -->
	<script src="<c:url value='/resources/js/slideshow.js'/>"></script>

</body>
</html>
