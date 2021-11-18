<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		session.removeAttribute("memid");
		session.setAttribute("memlogin", null);
		session.setAttribute("admin", null);
		response.sendRedirect("index.jsp");
%>
    