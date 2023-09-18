<%@page import="java.io.PrintWriter"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.Board"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/board.css" />
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
		<p>ldh</p>
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
		int pageNumber = 1;
		if(request.getParameter("pageNum") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		BoardDAO dao = new BoardDAO(); // 인스턴스 생성
		ArrayList<Board> list = dao.getList(pageNumber);
%>

<section class="notice">
  <div class="page-title">
        <div class="container">
            <h2><%= logon %> 님 환영합니다.</h2>
            <br>
            <h4><a href="logoutAction.jsp">로그아웃</a></h4>
        </div>
    </div>

    <div id="board-search">
        <div class="container">
            <div class="search-window">
                <form action="">
                    <div class="search-wrap">
                        <label for="search" class="blind">공지사항 내용 검색</label>
                        <input id="search" type="search" name="" placeholder="검색어를 입력해주세요." value="">
                        <button type="submit" class="btn btn-dark">검색</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
   
  <!-- board list area -->
    <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
                <tr>
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">제목</th>
                    <th scope="col" class="th-date">등록일</th>
                </tr>
                </thead>
                <tbody>
                
                <% for(int i=0; i<list.size(); i++) { %>
                <tr>
                    <td><%= list.get(i).getId() %></td>
                    <th>
                      <a href="view.jsp?id=<%= list.get(i).getId() %>">
                      	<%= list.get(i).getTitle() %>
                      </a>
                    </th>
                    <td><%= list.get(i).getDatetime() %></td>
                </tr>
				<% } %>
                </tbody>
            </table>
            
            <%
				if(pageNumber != 1){
			%>
				<a href="index.jsp?pageNum=<%=pageNumber - 1 %>">이전</a>
			<%
				}if(dao.nextPage(pageNumber + 1)){
			%>
				<a href="index.jsp?pageNum=<%=pageNumber + 1 %>">다음</a>
			<%
				}
			%>
			
            <br>
            <a href="write.jsp" class="write">글쓰기</a>
        </div>
    </div>

</section>
<%
	}
%>
</body>
</html>