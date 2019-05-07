<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>登录</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/css/materialize.min.css">
	<link rel="stylesheet" href="../css/l.css" type="text/css" />
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/js/materialize.min.js"></script>
</head>
<%
  if(session.getAttribute("isLogin")==null){
%>
<script type="text/javascript">
  
</script>
<%
}
else if((Boolean)session.getAttribute("isLogin")){
%>
<script type="text/javascript">
  window.location="admin.jsp";
</script>
<%
  }
%>
<body>
	<div class="container">
		<div class="row loginPanel">
        <div class="col s12 m6 offset-m3">
          <div class="card red darken-2">
            <div class="card-content white-text">
              <span class="card-title">登录</span>
              
	<div class="row">
    <form class="col s12" id="loginForm">
      <div class="row">
        <div class="input-field col s6">
          <input placeholder="管理员账号" id="usrname" name="usr" type="text" class="validate"  autocomplete="off">
          <label for="first_name">账号</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="password" type="password" name="pwd" class="validate">
          <label for="password">密码</label>
        </div>
      </div>
      <a class="waves-effect waves-light btn orange darken-2" onclick="login()">登录</a>
    </form>
  </div>
            </div>
            <div class="card-action">
              <a href="roll.jsp">返回转盘</a>
            </div>
          </div>
        </div>
      </div>   
	</div>
</body>
</html>
<script type="text/javascript">
	function login(){
		var reg=/^\w+$/;
		if(reg.test($('#usrname').val()))
			rePost();
		else{
			alert("输入格式异常");
		}
	}
	function rePost(){
            $.ajax({
                type: "POST",//方法类型
                dataType: "text",//预期服务器返回的数据类型
                url: "connLg.jsp" ,//url
                data: $('#loginForm').serialize(),
                async: false,
                success: function (result) {
                	result=result.replace(/[\r\n]/g,"")
                    console.log(result);//打印服务端返回的数据(调试用)
                    if (result=="Succeed") {
                    	window.location="admin.jsp";
                    }
                },
                error : function() {
                    alert("登录失败！");
                }
            });
	}
</script>