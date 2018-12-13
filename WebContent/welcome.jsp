<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link type="text/css" rel="stylesheet" href="/css/student.css"  />
    <style>
        .login {
            width:320px;
            background:#fff;
            margin: 30px auto;
            border:1px solid #e5e5e5;
            box-shadow: rgba(200,200,200,.7) 0 4px 10px -1px;
        }
        .login h1 a {
            height:47px;
            margin:0 auto 25px;
            padding:0;
            width:189px;
            text-indent:-9999px;
            overflow:hidden;
            display:block;
        }
        .login form {
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

        
 </style>
<script src="https://www.gstatic.com/firebasejs/5.5.9/firebase.js"></script>
</head>
<body>


<script>
  // Initialize Firebase
/*   var config = {
    apiKey: "AIzaSyBWVJjjZQEwcbVxSFy7KlV7L4tIU_-OrRo",
    authDomain: "test-5cfef.firebaseapp.com",
    databaseURL: "https://test-5cfef.firebaseio.com",
    projectId: "test-5cfef",
    storageBucket: "test-5cfef.appspot.com",
    messagingSenderId: "625155569"
  }; */
  
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
  function gosignup() {
      location.href="/UserServlet?type=firebase&action=joinform";
    }
  
  function mylogin() {
      var id = document.getElementById("id").value;
      var pw = document.getElementById("pwd").value;
	  var user_data = firebase.database().ref('user_data');
      user_data.once('value', function(snapshot) {
        snapshot.forEach(function(childSnapshot) {
          var tmp = childSnapshot.val();
          if(tmp.user_id==id){
            if(tmp.user_pwd==pw){
              alert("로그인 성공!");
              updateLoginTime(id, pw);
              location.href="Profile.html?user_id="+id;
            }else{
              alert("잘못된 비밀번호입니다");
            }
          }
          
        });
      });
    }
  
  function updateLoginTime(id, pw){
      var user_ref = firebase.database().ref("user_data/"+id);
      user_ref.set({
        user_id: id,
        user_pwd: pw,
        last_login : getTimeStamp()
      });
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
  
  function myjsplogin() {
      var id = document.getElementById("id").value;
      var pw = document.getElementById("pwd").value;
      
      if(id==""){
    	  alert("아이디를 입력해 주세요.");
    	  document.getElementById("id").focus();
    	  return;
      }
      
      if(pw==""){
    	  alert("비밀번호를 입력해 주세요.");
    	  document.getElementById("pwd").focus();
    	  return;
      }
      
	  var user_data = firebase.database().ref('user_data');
      
	  
	  user_data.once('value', function(snapshot) {
        snapshot.forEach(function(childSnapshot) {
          var tmp = childSnapshot.val();
          if(tmp.user_id==id){
            if(tmp.user_pwd==pw){
              alert("로그인 성공!");
              updateLoginTime(id, pw);
              var form = document.getElementById("form1");
              form.setAttribute("action", "./LoginServlet?id="+id+"&&pwd="+pw+"");
              form.submit();
              return;
            }else{
              alert("잘못된 비밀번호입니다");             
              return; 
            }
            
          }else{        	  
        	
          }

          
        });
      });
    }
  
  function myjsplogin2() {
      var id = document.getElementById("id").value;
      var pw = document.getElementById("pwd").value;
	  var user_data = firebase.database().ref('user_data');
	  var con = false;
      user_data.once('value', function(snapshot) {
        snapshot.forEach(function(childSnapshot) {
          var tmp = childSnapshot.val();
          alert("tmp.user_id"+tmp.user_id);
          if(tmp.user_id==id){
        	  console.log("패스워드  : " +  tmp.user_pwd);
            if(tmp.user_pwd==pw){
              updateLoginTime(id, pw);
              
              con=true;
            }
          }
        });
      });
	  alert("con:"+con);
      if(con==true){
          alert("로그인 성공!");
    	  var form = document.getElementById("form1");
          form.setAttribute("action", "./LoginServlet");
          alert(id + " " + pw);
          form.submit();
      }
      else alert("잘못된 비밀번호입니다");
    }
  </script>
 
 

 <div class="login">
 
<form id="form1" method="POST"  name="form1">
         <h1>로그인</h1>
         <h3 id="error"></h3>
   <p>
 	<label for="id">아이디:&nbsp;&nbsp;&nbsp;</label>
 	<input type="text" id="id" class="button-primary">   
	</p>

  <p>
   <label for="pwd">비밀번호: </label>
  <input type="password" id="pwd" class="button-primary">
  </p>   
  <input type="button" onclick="myjsplogin()" value="로그인" class="btn btn-welcome"> 
  
  <input type="button" onclick="gosignup()" value="회원가입" class="btn btn-welcome">
 
  </form> 
  </div>
<br>
</body>
</html>