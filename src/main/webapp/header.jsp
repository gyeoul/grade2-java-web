<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
 <%
	String memlogin = (String)session.getAttribute("memlogin");
 	String memid = (String)session.getAttribute("memid");
     String admin = (String)session.getAttribute("admin");


 %>
<style>
	header a, input[type="submit"]{
      	    all: unset;
      }
      #profile input {
	   color: white; }
	#profile input:hover{
		text-decoration: underline;
        text-decoration-color: white;    
    }
</style>
<header>
    <nav>
        <ul>
            <li>
                <a href="index.jsp">
                    <img src="./outline_sports_baseball_white_24dp.png" alt="home">
                </a>
            </li>
            <li>
                <a href="#">공지사항</a>
            </li>
            <li>
                <a href="#">추천 게시판</a>
            </li>
            <li>
                <a href="#">게시판</a>
            </li>
        </ul>
        <div id="profile" class="navicon">
            <a href="#">
                <img src="./outline_account_circle_white_24dp.png" alt="account">
            </a>
            <ul>
                <li> <%if (memlogin == null) { %>
                	<a href="javascript:alert('로그인하세요');">마이페이지</a>
                <% }
                else {
                	%> <form action="mypage.jsp?id=<%=memid%>" method="post" >
					<input type="submit" value="마이페이지">
				</form>
				<% } %></li>
                <li>
                <%if (admin == null) { %>
                	<a href="javascript:alert('열람권한이 없습니다');">관리자 페이지</a>
                <% }
                else {
                	%> <form action="admin.jsp" method="post" >
					<input type="submit" value="관리자 페이지">
				</form>
				<% } %>
                </li>
                <li> 
                	<% if(memlogin==null){ %>
 					<form action="loginform.jsp">
 						<input type="submit" value="로그인">
 					</form>
 					<%
                	}
                	else {
 					%> <form action="logout.jsp" method="post" >
						<input type="submit" value="로그아웃">
					</form>
					<% } %>
                </li>
            </ul>
        </div>
    </nav>
    <div class="floating_menu">
    </div>
</header>