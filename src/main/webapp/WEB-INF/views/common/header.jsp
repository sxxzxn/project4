<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="<c:url value='/resources/css/navbar_header.css'/>" rel="stylesheet">
</head>
<style>
/* 
#loginForm { z-index:99;position:fixed;top:0;right:0;bottom:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,0.5); }
#dialogLojin { z-index:999; }
#bgJoin { z-index:99;position:fixed;top:0;right:0;bottom:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,0.5); }
#dialogJoin { z-index:999; }
#bgFinguid { z-index:99;position:fixed;top:0;right:0;bottom:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,0.5); } 
#dialogFindUid { z-index:999; } 
#bgFindPwd { z-index:99;position:fixed;top:0;right:0;bottom:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,0.5); } 
#dialogFindPwd { z-index:999; } 
 */
</style>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>

		

     $(document).ready(function(){
    	 
    	 

    	 
    	 // 중복아이디 확인
    	 document.querySelector("#existUid").addEventListener("click", e => {
 		    if (join_id.value != "") {
	    		 const param = {uid: join_id.value};
	 		    fetch("<c:url value='/member/existUid.do'/>", {
	 		      method: "POST",
	 		      headers: {
	 		        "Content-Type": "application/json; charset=UTF-8",
	 		      },
	 		      body: JSON.stringify(param),
	 		    })
	 		    .then((response) => response.json())
	 		    .then((json) => {
	 		       alert(json.message);
	 		       if (json.status) {
	 		    	   join_id.value = "";
	 		    	   join_id.focus();
	 		  	       existUidChecked = false;
	 		       } else {
	 		    	   existUidChecked = true;
	 		       }
	 		    });
 		    } else {
 		    	alert("아이디값을 입력해주세요");
 		    }
 		});
    	 
    	 
    	 // 다이얼로그 열기   — 로그인 회원가입 열기 버튼 위치 다름 (로그인버튼 누르고 -> 로그인폼다이얼로그 활성화 -> 회원가입 버튼 누르면-> 회원가입폼 활성화라서)
       
    	 $('#loginButton').on("click", function (e) {
                e.preventDefault();
                $('#loginForm').dialog('open');
            }); //다이얼로그 열기 end
        
/*         
        	$('#findPwdButton').click(function() {
     	    $('#findPwdForm').dialog('open');
     	}); */
         
         /* 로그인  다이얼로그  */
        	loginForm = $('#loginForm').dialog({
             autoOpen: false, //자동열기X 
             modal: true, // 모달
             buttons: {
             	'로그인' : function() {
                     
                     const param = {
                     		uid : login_id.value,
                     		pwd : login_password.value
                     }

         			 $.ajax({ 

     				// ajax 기능 처리는 dialog안에 감싸주기
         			        url: "<c:url value='/member/login.do'/>", 
         			        type: "POST", 
         			        contentType: "application/json; charset=UTF-8",
         			        data: JSON.stringify(param),
         			        dataType: "JSON",
         			        success: function(json) {
        			           	//json .status / message 처리     			        
         			        	alert(json.message);
         			        	if(json.status) {
         			        		location.href="<c:url value=''/>";
         			        	} 
         			 		}   
         			 }); // ajax end
         			    
                     $(this).dialog('close'); // 다이얼로그 닫힘 
                 }, '회원가입' : function() {
           			  /* $('#joinForm').dialog('open');  */
                	 //  회원가입 다이얼로그 보내는 펑션
                 },   '닫기': function() {
                     $(this).dialog('close');
                 } //login function 
             }, // button
             // 취소
             closeText: '닫기',
             closeOnEscape: true  //——— 여기에 써야됨 ESC키로 닫기
            
         }); //end login 
         

         // 회원가입 시작
//          $('#joinButton').click(function() {
//              $('#joinForm').dialog('open');
//          }); //다이얼로그 열기 end
         
        	$('#joinForm').dialog({
        	    autoOpen: false,
        	    modal: true,
        	    buttons: {
        	        '회원가입': function() {
        	            // 회원가입 데이터를 수집하고 서버로 전송하는 코드를 작성
        	            const param = {
        	            		uid  : join_id.value,
        	            		name : join_uname.value,
        	            		pwd  : join_password.value,
                         		address : join_address.value,
                         		phone : join_phone.value,
                         		age  : join_age.value,
                         		gender : join_gender.value,
                         		email : join_email.value
        	           	 };
        	                
        	            

        	            // AJAX를 사용하여 회원가입 데이터를 서버로 전송
        	            $.ajax({
        	                url: "<c:url value='/member/insert.do'/>",
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

 
         $('#joinButton').click(function() {
        	    $('#joinForm').dialog('open');
        	});     
       //end join
       
       //아이디찾기
         $('#findUidButton').click(function() {
             $('#findUidForm').dialog('open');
         }); //다이얼로그 열기 end
         
        	$('#findUidForm').dialog({
        	    autoOpen: false,
        	    modal: true,
        	    buttons: {
        	        '아이디찾기': function() {
        	            // 회원가입 데이터를 수집하고 서버로 전송하는 코드를 작성
        	            const param = {
        	            		name : findUid_uname.value,
                         		age  : findUid_age.value
        	           	 };
        	                
        	            

        	            // AJAX를 사용하여 회원가입 데이터를 서버로 전송
        	            $.ajax({
        	                url: "<c:url value='/member/findUid.do'/>",
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

 
         $('#findUidButton').click(function() {
        	    $('#findUidForm').dialog('open');
        	});  // end findUid
         
        	
         //비밀번호 찾기
         $('#findFwdButton').click(function() {
             $('#findFwdForm').dialog('open');
         }); //다이얼로그 열기 end
         
        	$('#findFwdForm').dialog({
        	    autoOpen: false,
        	    modal: true,
        	    buttons: {
        	        '비밀번호 찾기': function() {
        	            const param = {
        	            		uid  : findFwd_uid.value,
        	            		name : finFwd_uname.value,
                         		age  : findFwd_age.value
        	           	 };
        	                
        	            
        	            $.ajax({
        	                url: "<c:url value='/member/findFwd.do'/>",
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

 
         $('#findFwdButton').click(function() {
        	    $('#findFwdForm').dialog('open');
        	}); // end findFwd 
         
        	
        	
        	//비밀번호 확인
            $('#checkFwdButton').click(function() {
                  $('#checkPwdForm').dialog('open');
              }); //다이얼로그 열기 end
              
             	$('#checkPwdForm').dialog({
             	    autoOpen: false,
             	    modal: true,
             	    buttons: {
             	        '비밀번호 확인': function() {
             	            const param = {
             	            		uid : checkpwd_uid.value,
             	            		pwd  : checkpwd_pwd.value
             	            		
             	           	 };
             	                
             	            
             	            $.ajax({
             	                url: "<c:url value='/member/checkFwd.do'/>",
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

              
    
            $('#updateMemberButton').click(function() {
           	    $('#updateMember').dialog('open');
           	}); // end checkFwd
         
        	$('#updateMember').dialog({
        	    autoOpen: false,
        	    modal: true,
        	    buttons: {
        	        '회원정보 수정': function() {
        	            // 회원가입 데이터를 수집하고 서버로 전송하는 코드를 작성
        	            const param = {
        	            		uid  : updateMember_uid.value,
        	            		name : updateMember_uname.value,
        	            		pwd  : updateMember_pwd.value,
                         		address : updateMember_address.value,
                         		phone : updateMember_phone.value,
                         		age  : updateMember_age.value,
                         		gender : updateMember_gender.value,
                         		email : updateMember_email.value
        	           	 };
        	                
        	            

        	            // AJAX를 사용하여 회원가입 데이터를 서버로 전송
        	            $.ajax({
        	                url: "<c:url value='/member/updateMember.do'/>",
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
        	        }, '탈퇴' : function() {
        	        	 if (confirm('정말로 회원 탈퇴하시겠습니까?')) {
        	        	        window.location.href = "<c:url value='/member/deleteMember.do?uid=${loginMember.uid}'/>";
        	        	    } else {
        	        	        // 취소 시 동작
        	        	    }
                   	 //  
                    },
        	        '닫기': function() {
        	            $(this).dialog('close');
        	        }
        	    },
        	    closeText: '닫기',
        	    closeOnEscape: true
        	});   	
           	
   
}); //ready 
		function logout() {
		    if (confirm("로그아웃 하시겠습니까?")) {
		        fetch("<c:url value='/member/logout.do'/>", {
		            method: "POST",
		            headers: {
		                "Content-Type": "application/json; charset=UTF-8",
		            },
		        })
		        .then((response) => response.json())
		        .then((json) => {
		            alert(json.message);
		            if (json.status) {
		                location.href = '<c:url value="/main.do"/>'; 
		            }
		        });
		    }
		}
         

     /* 
	     function login() {
	    	    $('#bgLojin').css('display', 'block');
	    	    $('#dialogLojin').css('display', 'block');
	    	  
	     }
	     
	     function join() {
	    	  $('#bgJoin').css('display', 'block');
	    	  $('#dialogJoin').css('display', 'block');
	    	  // 조인 버튼을 클릭할 때 필요한 추가 동작을 여기에 추가
	    	}
	     
	     function findUid() {
	    	  $('#bgFindUid').css('display', 'block');
	    	  $('#dialogFindUid').css('display', 'block');
	    	  // 조인 버튼을 클릭할 때 필요한 추가 동작을 여기에 추가
	    	}
	     
	     function finPwd() {
	    	  $('#bgFindFWd').css('display', 'block');
	    	  $('#dialogFindFWd').css('display', 'block');
	    	  // 조인 버튼을 클릭할 때 필요한 추가 동작을 여기에 추가
	    	}
	     
	     
	     
	    function closeDialog() {
	   	    $('#bgTest').css('display', 'none');
	   	    $('#dialogTest').css('display', 'none');
	   	  }
	
	   	  // 닫기 버튼 클릭 시 대화 상자 닫기
	   	  document.getElementById('closeButton').addEventListener('click', function() {
	   	    closeDialog();
	   	  });
    	
    	
        function viewProfile() {
            window.open("/project2/member/checkpwd.jsp");
        }

        function logout() {
            if (confirm("로그아웃 하시겠습니까?")) {
                fetch("<c:url value='/member/logout.do'/>", {
                    method: "GET",
                    headers: {
                        "Content-Type": "application/json; charset=UTF-8",
                    },
                     body: JSON.stringify(param), 
                })
                .then((response) => response.json())
                .then((json) => {
                    alert(json.message);
                    if (json.status) {
                        location.href = '<c:url value="/index.do"/>'; 
                    }
                });
            }
        }
          

        function goToLoginForm() {
            location.href = "loginForm";
        }
        function goToInsertTerms() {
           location.href = "insertTerms";
           console.log("확인용");
        }
 */

	</script>
<body>
  <!-- 페이지 노출되는 상단바 영역 -->
    <div class="navbar">
        <header>
            <a class="logo" href="<c:url value='/main.do'/>">Studio_Hani</a>
            <ul id="topMenu">
                <li><a href="#">ROOM<span></span></a>
                    <ul>
                        <li><a href="#">A Room</a></li>
                        <li><a href="#">B Room</a></li>
                        <li><a href="#">C Room</a></li>
                    </ul>
                </li>
                <li><a href="#">CONTACT <span></span></a>
                    <ul>
                        <li><a href="#">SCHEDULE</a></li>
                        <li><a href="#">RESERVATION</a></li>
                    </ul>
                </li>
                <li><a href="<c:url value='/board/info.do'/>">INFO<span></span></a>
                    <ul>
                        <li><a href="<c:url value='/notice/noticeList.do'/>">NOTICE</a></li>
                        <li><a href="<c:url value='/board/boardList.do'/>">Q&A</a></li>
                        <li><a href="#">GUIDE</a></li>
                    </ul>
                </li>
               <c:choose>
			  	  <c:when test="${sessionScope.loginMember != null}">
			        <li>
			            <a href="#">MEMBER<span></span></a>
			            <ul>
			                <li><a href="#" onclick="logout();">LOGOUT</a></li>
			                <li><a id="checkFwdButton">MEMBER INFO</a></li>
			                <li><a id="updateMemberButton">page</a></li>			                
			            </ul>
			        </li>
			   		 </c:when>
   				 <c:otherwise>
			        <li>
			            <a href="#">MEMBER<span></span></a> 
			            <ul>
			<%--                 <li><a href="<c:url value='/member/loginForm.do'/>">LOGIN</a></li> --%>
			<!--                 <li><button type= button id="loginButton">LOGIN</button></li> -->
			<!--                  <li><button type= button id="joinButton">JOIN</button></li>  -->
								<li><a id="loginButton">LOGIN</a></li>
								<li><a id="joinButton">JOIN </a></li>
			            </ul>
			        </li>
			    </c:otherwise>
			</c:choose>
            </ul>
        </header>
    </div>
    
   <!-- 다이얼로그 폼 시작 -->
    
   	<!-- 로그인 폼   --> 
		 <div id="loginForm" style="display: none;">
			<form autocomplete="off" onsubmit="return false;">
				<div class="input-box">
				   <input id="login_id" type="text" name="login_id" placeholder="아이디">
				   <label for="login_id">ID</label>
				</div>
				<div class="input-box">
				      <input id="login_password" type="password" name="login_password" placeholder="비밀번호">
				      <label for="login_password">PWD</label>
				 </div>
				  <div id="forgot">
				      <a id="findUidButton"> FORGOT ID / </a>
				      <a id="findFwdButton"> FORGOT PASSWORD</a>
				    </div> 
			 </form>
			</div>
			
		<!-- 아이디찾기 폼   -->
			<div id="findUidForm" style="display: none;">
				<form autocomplete="off" onsubmit="return false;">

				<div class="input-box">
					<input id="findUid_uname" type="text" name="findUid_uname" placeholder="이름"> <label
						for="findUid_uname">NAME</label>
				</div>
				<div class="input-box">
					<input id="findUid_age" type="text" name="findUid_age" placeholder="나이"> <label
						for="findUid_age">AGE</label>
				</div>
				<!-- 	<input type="submit" value="FIND ID"> -->
				</form>
    		</div>
    		
    	<!-- 비밀번호 찾기 폼 -->
			<div id="findFwdForm" style="display: none;">
				<form autocomplete="off" onsubmit="return false;">
						<div class="input-box">
							<input id="findFwd_uid" type="text" name="findFwd_uid" placeholder="아이디"> <label
								for="findFwd_uid">ID</label>
						</div>
						<div class="input-box">
							<input id="finFwd_uname" type="text" name="finFwd_uname" placeholder="이름"> <label
								for="finFwd_uname">NAME</label>
						</div>
						<div class="input-box">
							<input id="findFwd_age" type="text" name="findFwd_age" placeholder="나이"> <label
								for="findFwd_age">AGE</label>
						</div>
                  <!--  <input type="submit" value="FIND PWD"> -->
					</form>
    		</div>
    		
		<!-- 회원가입폼  -->		
	 		<span id="joinForm" style="display:none;">
					<!-- <form method="post" id="insert" > -->
					<form autocomplete="off" onsubmit="return false;">
					<div class="input-box">
						<input id="join_id" type="text" name="join_id" placeholder="아이디">
						<label for="join_id">ID</label>
					</div>
						<input type="button" id="existUid" value="중복확인"/>
					<br/>
					<div class="input-box">
						<input id="join_password" type="password" name="join_password" placeholder="비밀번호">
						<label for="join_password">PWD</label>
					</div>
		
					<div class="input-box">
						<input id="join_confirmPassword" type="password" name="join_confirmPassword"
							placeholder="비밀번호 확인"> <label for="join_confirmPassword">PWD
							CHECK</label>
					</div>
		
					<div class="input-box">
						<input id="join_uname" type="text" name="join_uname" placeholder="이름"> <label
							for="join_uname">NAME</label>
					</div>
		
					<div class="input-box">
						<input id="join_address" type="text" name="join_address" placeholder="주소">
						<label for="join_address">ADDRESS</label>
					</div>
		
					<div class="input-box">
						<input id="join_phone" type="text" name="join_phone" placeholder="전화번호">
						<label for="join_phone">NUMBER</label>
					</div>
		
					<div class="input-box">
						<input id="join_age" type="text" name="join_age" placeholder="나이"> <label
							for="join_age">AGE</label>
					</div>
		
					<div class="input-box">
						<input id="join_gender" type="text" name="join_gender" placeholder="성별">
						<label for="join_gender">GENDER</label>
					</div>
					
					<div class="input-box">
						<input id="join_email" type="text" name="join_email" placeholder="이메일">
						<label for="join_email">EMAIL</label>
					</div>
		
		
					<!-- <input type="submit" value="가입하기" class="input-box"> -->
					<div id="forgot">
						<input type="reset" value="다시입력" class="input-box"
							style="background: none; border: none; color: #000; text-decoration: underline; cursor: pointer;">
					</div>
				</form>
			</span>
			
			
			
<!-- 		    <div id="form_member">  이전 css 아이디-->
			<div id="checkPwdForm" style="display: none;">
				<form autocomplete="off" onsubmit="return false;">
					<h3>MEMBER INFO</h3>
					<h5>${loginMember.name}님 비밀번호 확인 후 정보 확인 및 수정이 가능합니다.</h5>
		
					<div class="input-box">
						<label for="checkpwd_pwd">비밀번호</label> 
						<input type="password" id="checkpwd_pwd" name="checkpwd_pwd">
						<input type="hidden" id="checkpwd_uid" name="checkpwd_uid" value="${loginMember.uid}">
					</div>
					
				</form>
			</div>
			
			<!-- 회원정보 -->
	
			<form method="post" id="updateMember" style="text-align: center; display: none;">
			 <h2>MY PAGE</h2>
			 <h3>${loginMember.name}님최근정보로 업데이트 해주세요.</h3>
	
				<div id="form_member">
		
					<div class="input-box">
						<input id="updateMember_uid" type="text" name="updateMember_uid"
							value="${loginMember.uid}" placeholder="아이디" readonly> <label
							for="updateMember_uid">ID</label>
					</div>
		
					<div class="input-box">
						<input id="updateMember_uname" type="text" name="updateMember_uname"
							value="${loginMember.name}" placeholder="이름"> <label
							for="updateMember_uname">NAME</label>
					</div>
		
					<div class="input-box">
						<input id="updateMember_pwd" type="text" name="updateMember_pwd"
							value="${loginMember.pwd}" placeholder="비밀번호"> <label
							for="updateMember_pwd">PWD</label>
					</div>
		
					<div class="input-box">
						<input id="updateMember_address" type="text" name="updateMember_address"
							value="${loginMember.address}" placeholder="주소"> <label
							for="updateMember_address">ADDRESS</label>
					</div>
		
					<div class="input-box">
						<input id="updateMember_phone" type="text" name="updateMember_phone"
							value="${loginMember.phone}" placeholder="전화번호"> <label
							for="updateMember_phone">PHONE</label>
					</div>
		
					<div class="input-box">
						<input id="updateMember_age" type="text" name="updateMember_age" value="${loginMember.age}"
							placeholder="나이"> <label for="updateMember_age">AGE</label>
					</div>
		
					<div class="input-box">
						<input id="updateMember_gender" type="text" name="updateMember_gender"
							value="${loginMember.gender}" placeholder="성별"> <label
							for="updateMember_gender">GENDER</label>
					</div>
					
					<div class="input-box">
						<input id="updateMember_email" type="text" name="updateMember_email"
							value="${loginMember.email}" placeholder="이메일"> <label
							for="updateMember_email">EAMIL</label>
					</div>
<!-- 					<button type="submit" onclick="showAlert()" class="submit-button">수정</button> -->
		
				</div>
		</form>

</body>
</html>
