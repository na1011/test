<%@page import="java.io.PrintWriter"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page" />
<jsp:setProperty name="board" property="title" />
<jsp:setProperty name="board" property="content" />
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
	
	if(logon == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
	} else {
		
		if(board.getTitle() == null || board.getContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			
			BoardDAO dao = new BoardDAO();
			int result = dao.write(board.getTitle(), logon, board.getContent());
			
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글이 등록되었습니다')");
				script.println("location.href='index.jsp'");
				script.println("</script>");
			}
			
		}
		
	}
%>
</body>
</html>