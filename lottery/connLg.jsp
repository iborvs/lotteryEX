<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
out.flush();
  try {  
  			request.setCharacterEncoding("utf-8");
            Class.forName("com.mysql.jdbc.Driver");  
            String url = "jdbc:mysql://iborvs.cn:3306/test"; 
            String username = "wpuser1";
            String password = "";
            Boolean flag=false;
            Connection conn = DriverManager.getConnection(url, username, password); 
            if(conn != null){            
                Statement stmt = null;  
                ResultSet rs = null;  
                String sql = "SELECT *FROM rollusr WHERE name='"+request.getParameter("usr")+"'";  
                stmt = conn.createStatement();  
                rs = stmt.executeQuery(sql); 
                while (rs.next()) {
                	if(request.getParameter("pwd").equals(rs.getString("pwd"))){
                		session.setAttribute("isLogin",true);
                		flag=true;
                		break;
                	}
                }
                if(!flag){
                	out.print("Fail");
            	}
            	else
            		out.print("Succeed");
            }
            else{  
                //out.print("连接失败！");  
            }  
        }catch (Exception e) {        
            //out.print("数据库连接异常！");  
        }  
%>