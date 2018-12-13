<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Students Info Systsem</title>

<link type="text/css" rel="stylesheet" href="/css/student.css"  />
<style type="text/css">
.btn-welcome{
	
	width: 100px;
	padding: 20px 20px;
	background-color: #999999;
	text-align: center;
	box-shadow: 2px 2px 2px #000000;
}
table{
 width: 1200px;
}	

</style>
	</head>
	<body>
		<h2 align="center">
			Management-[
			<a href="UserServlet?type=add&stop=a" class="btn btn-add">Add</a>]
			
			&nbsp; <span style="font-size: 15px;">${sessionScope.id }님 환영합니다.</span>
			<a href="LoginPage.jsp" style="margin-left: 5px" class="btn btn-welcome">
			정보보기</a>
			<a href="UserServlet?type=logout" style="margin-left: 5px" class="btn btn-welcome">
			로그아웃 </a>	
		</h2>
		<table border="1" cellspacing="0" align="center" id="tables">
			<tr>
				<th>fireBaseId</th>		
				<th>ID</th>				
				<th>Name</th>
				<th>Gender</th>									
				<th>Mail</th>
				<th>Class</th>
				<th>Action</th>
			</tr>
			<c:forEach var="u" items="${page.list}">
				<tr>
					<td>${u.fireBaseId}</td>
					<td>${u.id}</td>										
					<td>${u.name}</td>
					<td>
					<c:out value="${ u.gender eq 'M' ? '男' : '女'}"></c:out>					
					</td>
					<td>${u.email}</td>
					<td>${u.cls.name}</td>
					<td style="display: inline; border:0px;">
						<a href="UserServlet?type=del&id=${u.id}" class="btn btn-danger">삭제</a>
						<a href="UserServlet?type=upd&stop=a&id=${u.id}" class="btn btn-update">수정</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<script type="text/javascript">
	function back() {
		var trs = document.getElementById("tables").getElementsByTagName("tr");
		for ( var i = 0; i < trs.length; i++) {
			
			if(i==0){
				trs[i].style.backgroundColor = "#C47135";
				trs[i].style.color = "#fff";
			}else if (i % 2 == 0) {
				trs[i].style.backgroundColor = "#F9F9F9";
			}
		}
	}
	back();
</script>
		<h5 align="center">
			<c:if test="${page.index > 1}">
				<a href="UserServlet?type=all&index=1" class="btn btn-move" >Home</a>&nbsp;<a
					href="UserServlet?type=all&index=${index - 1}" class="btn btn-move" >Up</a>&nbsp;
			</c:if>
			<c:if test="${page.index < sum}">
				<a href="UserServlet?type=all&index=${index + 1}" class="btn btn-move">Down</a>&nbsp;<a
					href="UserServlet?type=all&index=${sum}" class="btn btn-move">End</a>
			</c:if>
		</h5>
	</body>
</html>


