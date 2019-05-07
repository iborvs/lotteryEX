<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
response.setHeader("Content-Type","text/html;charset=utf-8");
try {  
            Class.forName("com.mysql.jdbc.Driver");  
            String url = "jdbc:mysql://iborvs.cn:3306/test"; 
            String username = "wpuser1";
            String password = "";
            Connection conn = DriverManager.getConnection(url, username, password); 
            if(conn != null){            
                Statement stmt = null;  
                ResultSet rs = null;  
                String sql = "SELECT *FROM roll;";  
                stmt = conn.createStatement();  
                rs = stmt.executeQuery(sql); 
                String str = "["; 
                while (rs.next()) {
                    str += "{\"name\":\""+rs.getString("name")+"\",\"weight\":"+rs.getInt("weight")+"},";    
                }
                if(str.length()!=1){
                str = str.substring(0,str.length()-1);
                str+="]";
                out.print(str);
            }

            }
            else{  
                //out.print("连接失败！");  
            }  
        }catch (Exception e) {        
            //out.print("数据库连接异常！");  
        }  	
out.flush();
out.close();
%>