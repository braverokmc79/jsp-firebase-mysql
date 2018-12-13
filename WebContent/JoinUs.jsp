<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="/css/student.css"  />
    <style>
        .join {
            width:480px;
            background:#fff;
            margin: 30px auto;
            border:1px solid #e5e5e5;
            box-shadow: rgba(200,200,200,.7) 0 4px 10px -1px;
        }
        .join h1 a {
            height:57px;
            margin:0 auto 25px;
            padding:0;
            width:189px;
            text-indent:-9999px;
            overflow:hidden;
            display:block;
        }
        .join form {
            margin:0px auto;
            border:none;                        
            margin-top:30px;
            padding-left:25px;
            padding-bottom:20px;
        }


        .button-primary{
            display:inline-block;
            text-decoration:none;
            font-size:13px;
            line-height:26px;
            height:28px;
            margin:0;
            padding:0 10px 1px;
            cursor:pointer;
            border:1px solid 
            border-radius:3px;
            box-sizing:border-box;
        }
        input[type="text"]:focus,input[type="password"]:focus{
            border:1px solid #aaa;
            color:#444;
            box-shadow:0 0 3px rgba(0,0,0,.2)
        }
    
        h1{
        	text-align: center;
        }
.btn-welcome{
	
	width: 100px;
	padding: 20px 20px;
	background-color: #999999;
	text-align: center;
	box-shadow: 2px 2px 2px #000000;
	height: 50px;
}

 .insert{
	border: 1px solid #666;
	height:30px ;
	width: 200px;
	
      display:inline-block;
       text-decoration:none;
       font-size:13px;
       line-height:26px;
       height:35px;
       margin:0;
       padding:0 10px 1px;
       cursor:pointer;
       border:1px solid ;
       border-radius:3px;
       box-sizing:border-box;
       box-shadow: 1px 1px 1px #666;
}
        
.span{
	margin-right: 40px;

} 

.span2{
	margin-right: 20px;

} 
.span3{
	margin-right: 50px;
}      
 </style>
<script src="https://www.gstatic.com/firebasejs/5.5.9/firebase.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
</head>
<body>




<script>
  // Initialize Firebase
/*    var config = {
    apiKey: "AIzaSyBWVJjjZQEwcbVxSFy7KlV7L4tIU_-OrRo",
    authDomain: "test-5cfef.firebaseapp.com",
    databaseURL: "https://test-5cfef.firebaseio.com",
    projectId: "test-5cfef",
    storageBucket: "test-5cfef.appspot.com",
    messagingSenderId: "625155569"
  };  */
  
  var config = {
		    apiKey: "AIzaSyCpyxgb1w-qRUDDNBs7Id123NmaGomQlGQ",
		    authDomain: "juhofcm.firebaseapp.com",
		    databaseURL: "https://juhofcm.firebaseio.com",
		    projectId: "juhofcm",
		    storageBucket: "juhofcm.appspot.com",
		    messagingSenderId: "462864433045"
		  };

  firebase.initializeApp(config);
</script>
<script>
    var user_data = firebase.database().ref('user_data');
	
    console.dir(user_data);
    var data = new Array();
    user_data.on('value', function(snapshot) {
      data.splice(0, data.length);
      snapshot.forEach(function(childSnapshot) {
        var childData = childSnapshot.val();
        data.push(childData.user_id);
      });
    });
    
    function signup() {
    	//alert("disable?:"+document.getElementById("id").disabled);
      var id = document.getElementById("id").value;
      var pw = document.getElementById("pwd").value;
      var sex= document.getElementById("sex").value;
      var name= document.getElementById("name").value;
//       var major= document.getElementById("major").value; 
      var grade= document.getElementById("grade").value; 
      var email= document.getElementById("email").value;
      
      if(id==""){
    	  alert("아이디를 입력하세요.");
    	  document.getElementById("id").focus();
    	  return ;
      }
      
      if(pw==""){
    	  alert("비밀번호를 입력하세요.");
    	  document.getElementById("pwd").focus();
    	  return ;
      }

      if(name==""){
    	  alert("이름을 입력하세요.");
    	  document.getElementById("name").focus();
    	  return ;
      }

      if(email==""){
    	  alert("이메일을 입력하세요.");
    	  document.getElementById("email").focus();
    	  return ;
      }
      
      //alert(id +" " + pw +" " + name +" " + sex +" : " + grade +" " + email);
      
      var user_data = firebase.database().ref('user_data/'+id);
      
      if(document.getElementById("id").disabled){
    	user_data.set({
          user_id: id,
          user_pwd: pw,
          last_join: getTimeStamp()
        });
    	myProfile(id, sex, name, email,grade, email);
    	
    	/* 자바 User 클래스의 필드값    	
        private Integer id;
    	private String name;
    	private String gender;
    	private String email;
    	private Integer clsId; // clsid 필드 추가 */
    	
    	//** mysql DB data 저장;    	

    	//jquery  ajax 를 통한 데이터 전송 
     	$.ajax({
    		url:"UserServlet?type=firebase&action=join",   // url 값을 입력
    		type:"post",   // post 방식으로 전송
			data:{
				fireBaseId:id,
				name:name,
				sex:sex,
				email:email,
				clsId:grade,
				pw:pw
				
			},
			dataType:"text",   //데이터 형식은 텍스트 
			success:function(result){ // ajax 전송이 성공시 result 데이터 반환 
				
		    	if($.trim(result)=="success"){  // jquery trim 을 사용해서 공백 제거 후 result 값이 success 인지 확인
			    	alert("회원가입이 완료되었습니다");
			        history.back();		    		
		    	}else{
		    		// success 가 아닌 경우 실패 처리
		    		alert("회원가입이 실패 했습니다.");
		    		console.log(result);	
		    	}
			},
			error:function(result){
				alert("회원가입이 실패 했습니다.");
				console.log(result);
			}    		    	
    	}); 
    	

      } else {
    	  
        alert("아이디 중복확인을 눌러주세요");
      }

    }
	
    function myProfile(id, sex, name, email,grade){
    	var user_ref = firebase.database().ref('user_profile/'+id);
      	//alert("myProfile");
      	user_ref.set({
      		user_id:id,
            user_sex: sex,
            user_name: name,
            user_email: email,      
            user_grade: grade
          });
    }

    function mycheck(){
        var id = document.getElementById("id").value;
        var checked = 0;
        if(id==""){
        	  alert("아이디를 입력하세요.");
        	  document.getElementById("id").focus();
        	  return ;
          }	
        data.forEach(function(tmp) {
          if(tmp==id){
            alert("이미 사용중인 아이디입니다");
            document.getElementById("id").value="";
            document.getElementById("id").focus();
            checked = 1;
          }
        });
        if(checked==0){
        
          alert("사용 가능한 아이디입니다");
          document.getElementById("id").disabled = true;
        }
    }
    
    function getTimeStamp() {
        var d = new Date();
        var s =
        leadingZeros(d.getFullYear(), 4) + '-' +
        leadingZeros(d.getMonth() + 1, 2) + '-' +
        leadingZeros(d.getDate(), 2) + ' ' +

        leadingZeros(d.getHours(), 2) + ':' +
        leadingZeros(d.getMinutes(), 2) + ':' +
        leadingZeros(d.getSeconds(), 2);

        return s;
      }
    
    function leadingZeros(n, digits) {
        var zero = '';
        n = n.toString();

        if (n.length < digits) {
          for (i = 0; i < digits - n.length; i++)
            zero += '0';
        }
        return zero + n;
      }
  </script>

 <div class="join">
 <h1 style="text-align: center;">회원 가입</h1>
<form name="form1" method="GET">   
<p> <span class="span" style="margin-right:35px; ">아이디 </span>
 <input type="text" id = "id" name="username" class="insert">
 &nbsp;&nbsp;&nbsp;<input type="button" onclick="mycheck()" id="check" value="중복 확인" class="btn btn-welcome">  
</p> 
<p> 
  <span class="span2">비밀번호</span>  <input type="password" id="pwd" name="pwd" class="insert">
</p>

<p><span class="span3">이름</span>
<input type="text" id="name" class="insert"></p>  
 
<p><span class="span3">성별 </span>
<select id="sex" class="insert">
<option value="M">男</option>
<option value="F">女</option>
</select>
</p>

<p><span  style="margin-right:34px; ">클래스 </span> 
<select name="clsId" class="insert" id="grade" >
		<c:forEach var="c" items="${clsList}">
			<option value="${c.id}">${c.name}</option>
		</c:forEach>
	</select>
</p>
<p><span class="span">이메일</span><input type="text" id="email" class="insert"></p>
<!-- <p><span class="span3">학년 </span><input type="text" id="grade" class="insert"> </p>
  
<p><span class="span">관심사</span><input type="text" id="email" class="insert"></p> -->
<div style="text-align: center">
 <input type="button" onclick="signup()" value="완료" class="btn btn-welcome">
 </div>
</form>  

</div>
</body>
</html>