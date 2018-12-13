<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
		<title>Students info System</title>
<link type="text/css" rel="stylesheet" href="/css/student2.css"  />
	</head>
	<script type="text/javascript">
	function 
	back() {
		var name = document.getElementById("name").value;
		var email = document.getElementById("email").value;
		if (name == "") {
			alert("can not be empty?");
			return false;
		} else if (email == "") {
			alert("can not be empty");
			return false;
		} else {
			return true;
		}
	}

	<c:if test="${not empty error}" >	
 		alert('${error}');
	</c:if>
</script>
	<body>

		<h2 align="center">
			Add-[
			<a href="UserServlet?type=all" class="btn-add">Return</a>]
		</h2>
		<form action="UserServlet?type=add" method="post">
		
			<table border="1" cellspacing="0" align="center">
				<tr>
					<th>Name</th>
					<td><input type="text" name="name" id="name" class="insert" /></td>
				</tr>
				<tr>
					<th>Gender</th>
					<td>
							<input type="radio" name="sex" value="M" checked="checked"  />M
							<input type="radio" name="sex" value="F"  />F
					</td>	
				</tr>
				<tr>
					<th>Mail</th>
					<td>
					<input type="text" name="email" id="email" class="insert" />
					</td>
				</tr>
				<tr>
					<th>Class</th>											
					<td>
						<select name="clsId" class="insert">
							<c:forEach var="c" items="${clsList}">
								<option value="${c.id}">${c.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"  class="submit-td">
						
						<input type="submit" value="submit" onclick="return back();" class="btn" />
						<input type="reset" value="reset"  class="btn" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
