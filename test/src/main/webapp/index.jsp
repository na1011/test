<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String logon = null;
	if(session.getAttribute("loginON") != null) {
		logon = (String)session.getAttribute("loginON");
	}
%>

<%
	if(logon == null) {
%>
	<form action="joinAction.jsp" method="post">
		<h3>회원가입</h3>
		<label for="userID">사용할 아이디</label>
		<input type="text" name="userID" id="userID">
		<label for="userPWD">사용할 비밀번호</label>
		<input type="password" name="userPWD" id="userPWD">
		<input type="submit" value="회원가입">
	</form>
	<br>
	<form action="loginAction.jsp" method="post">
		<h3>로그인</h3>
		<label for="userID">아이디</label>
		<input type="text" name="userID" id="userID">
		<label for="userPWD">비밀번호</label>
		<input type="password" name="userPWD" id="userPWD">
		<input type="submit" value="로그인">
	</form>
<%
	} else {
%>
	<h2><%= logon %> 님 환영합니다.</h2>
	<h3><a href="logoutAction.jsp">로그아웃</a></h3>
<%
	}
%>
</body>
</html>