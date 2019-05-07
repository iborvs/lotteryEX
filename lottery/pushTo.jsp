<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
	if(session.getAttribute("isLogin")!=null){
		if((Boolean)session.getAttribute("isLogin")){
            String url = "jdbc:mysql://iborvs.cn:3306/test"; 
            String username = "wpuser1";
            String password = "";
            Connection conn = DriverManager.getConnection(url, username, password);
            if(conn != null){            
                Statement stmt = null;  
                ResultSet rs = null;  
                String sql = "DELETE FROM roll;";  
                stmt = conn.createStatement();  
                stmt.executeUpdate(sql); 
                String requestURI=request.getQueryString();
                requestURI = java.net.URLDecoder.decode(requestURI,"UTF-8");
                int id = 0; 
                out.print(requestURI);
                while(requestURI.indexOf("name")!=-1){
                	int posAnd = requestURI.indexOf("&");
                	String name = requestURI.substring(requestURI.indexOf("name")+5,posAnd);
                	requestURI = requestURI.substring(posAnd+1);
                	posAnd = requestURI.indexOf("&");
                	String weight = requestURI.substring(requestURI.indexOf("weight")+7,posAnd);
                	requestURI = requestURI.substring(posAnd+1);
                	sql = "INSERT INTO roll VALUES ('"+name+"','"+weight+"');";
                    out.print(sql+"\n");
                	stmt.executeUpdate(sql);
                	id++;
            }
            }
	}
	}
%>
