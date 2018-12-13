<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<base href="<%=basePath%>">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="/css/student.css"  />
<style type="text/css">
table{
	width: 500px;
	border: 1px solid #666666;
}

.btn-welcome{
	
	width: 100px;
	padding: 20px 20px;
	background-color: #999999;
	text-align: center;
	box-shadow: 2px 2px 2px #000000;
}

th{
	background-color: #C47135;
	color:#fff;
	
}
</style>
</head>
<body>

<h2 align="center">
			관리자 화면 -[
			<a href="UserServlet?type=all" class="btn btn-add">Go</a>]				
</h2>

<% String id = (String) session.getAttribute("id"); %>

<div>
<table border="1" align="center">
	<tr>
	 <th>아이디</th>
	 <td id="login_id"></td>
	</tr>
	
	<tr>
	 <th>이름</th>
	 <td id="name"></td>
	</tr>
	
	<tr>
	 <th>이메일</th>
	 <td  id="email"></td>
	</tr>
	
	<tr>
	 <th>학급</th>
	 <td id="grade"></td>
	</tr>
	
	<tr>
	 <th>성별</th>
	 <td id="sex"></td>
	</tr>				
	
	
	<tr>
	 <th>접속일</th>
	 <td id="last"></td>
	</tr>
</table>


</div>
<script src="https://www.gstatic.com/firebasejs/5.5.9/firebase.js"></script>
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
  var id = "<%=id %>";
  document.getElementById("login_id").innerHTML = id;

var user_data = firebase.database().ref('user_data/');

user_data.once('value', function(snapshot) {
    snapshot.forEach(function(childSnapshot) {
      var tmp = childSnapshot.val();
      if(tmp.user_id==id)
        document.getElementById("last").innerHTML = tmp.last_login;
    });
  });

var user_ref = firebase.database().ref('user_profile/'+id);
user_ref.once('value', function(snapshot) {
		    var tmp = snapshot.val();
			    document.getElementById("name").innerHTML = tmp.user_name;
			    
			    if(tmp.user_sex=='M'){
			    	document.getElementById("sex").innerHTML = '男';	
			    }else{
			    	document.getElementById("sex").innerHTML = '女';
			    }
			    
  			    document.getElementById("email").innerHTML = tmp.user_email;
  			    
  			    if( tmp.user_grade=='1'){
  			    	document.getElementById("grade").innerHTML = 'S1';	
  			    }else if(tmp.user_grade=='2'){
  			    	document.getElementById("grade").innerHTML = 'S2';
  			    }else{
  			    	document.getElementById("grade").innerHTML = 'S3';
  			    }
  			    
		  });

  </script> 
</body>
</html>