<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <!--  CSS -->
  <link href="https://cdn.bootcss.com/font-awesome/5.8.0/css/all.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.css">
  <!--  JavaScript -->
  <script src="../js/jquery-2.1.4.min.js"></script>
  <script src="../js/materialize.js"></script>
  <script src="../js/why.js"></script>

  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>管理员</title>
  <style>
    html,
    body {
      display: flex;
      min-height: 100vh;
      flex-direction: column;
      margin: 0;
      padding: 0;
      height: 100%;
      background: url("../images/demo-1-bg.jpg");
    }

    .main {
      height: calc(100vh - 85px);
      flex: 1 0 auto;
    }

    .footer {
      height: 36px;
    }

    .header {
      height: 36px;
    }
    .brand-logo{
      margin-left: 10px;
    }

    * {
      margin: 0;
      padding: 0;
      font-family: 'montserrat', sans-serif;
      box-sizing: border-box;
    }

    .inner-width {
      width: 100%;
      max-width: 1200px;
      margin: auto;
      padding: 0 20px;
      overflow: hidden;
    }
    .section-title {
      text-align: center;
      color: #ddd;
      text-transform: uppercase;
      font-size: 30px;
    }
    .border {
      width: 160px;
      height: 2px;
      background: #82ccdd;
      margin: 40px auto;
    }
    .services-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
    }
    .service-box {
      max-width: 33.33%;
      padding: 10px;
      text-align: center;
      color: #ddd;
      cursor: pointer;
    }
    .service-icon {
      display: inline-block;
      width: 70px;
      height: 70px;
      border: 3px solid #82ccdd;
      color: #82ccdd;
      transform: rotate(45deg);
      margin-bottom: 30px;
      margin-top: 16px;
      transition: 0.3s linear;
    }
    .service-icon i {
      line-height: 70px;
      transform: rotate(-45deg);
      font-size: 26px;
    }
    .service-box:hover .service-icon {
      background: #82ccdd;
      color: #ddd;
    }
    .service-title {
      font-size: 18px;
      text-transform: uppercase;
      margin-bottom: 10px;
    }
    .service-desc {
      font-size: 14px;
    }
    @media screen and (max-width: 960px) {
      .service-box {
        max-width: 45%;
      }
    }
    @media screen and (max-width: 768px) {
      .service-box {
        max-width: 50%;
      }
    }
    @media screen and (max-width: 480px) {
      .service-box {
        max-width: 100%;
      }
    }


    .btn1 {
      display: inline-block;
      width: 90px;
      height: 90px;
      background: #f1f1f1;
      margin: 10px;
      border-radius: 30%;
      box-shadow: 0 5px 15px -5px #00000070;
      color: #3498db;
      overflow: hidden;
      position: relative;
      text-align: center;
    }
    .btn1 i {
      line-height: 90px;
      font-size: 26px;
      transition: 0.2s linear;
    }
    .btn1:hover i {
      transform: scale(1.3);
      color: #f1f1f1;
    }
    .btn1::before {
      content: '';
      position: absolute;
      width: 120%;
      height: 120%;
      background: #3498db;
      transform: rotate(45deg);
      left: -110%;
      top: 90%;
    }
    .btn1:hover::before {
      animation: flash 0.7s 1;
      top: -10%;
      left: -10%;
    }
    @keyframes flash {
      0% {
        left: -100%;
        top: 90%;
      }
      50% {
        left: 10%;
        top: -30%;
      }
      100% {
        left: -10%;
        top: -10%;
      }
    }
  </style>

</head>
<%
  if(session.getAttribute("isLogin")==null){
%>
<script type="text/javascript">
  window.location="login.jsp";
</script>
<%
}
else if(!(Boolean)session.getAttribute("isLogin")){
%>
<script type="text/javascript">
  window.location="login.jsp";
</script>
<%
  }
%>
<body>
<!--  头 -->
<header>
  <nav class="nav-extended">
    <nav>
      <div class="nav-wrapper blue darken-4" id="head">
        <div class="brand-logo">管理员</div>
      </div>
    </nav>
  </nav>
</header>
<!-- 中 -->
<style>
</style>
<main class="main">

  <div class="inner-width">
    <h1 class="section-title">转盘系统</h1>
    <div class="border"></div>
    <div class="services-container">
      <div class="service-box">
        <a style="color:inherit" href="roll.jsp">
          <div class="service-icon">
            <i class="fas fa-circle-notch"></i>
          </div>
          <div class="service-title">转盘</div>
        </a>
        <div class="service-desc">
          &lceil;&nbsp;点击转盘开始转动&nbsp;&rfloor;<br>
          &lceil;&nbsp;看看你能转到什么&nbsp;&rfloor;
        </div>
      </div>

    </div>
  </div>



  <br/>
  <br/>

  <div class="container">
    <label style="font-size:inherit;color:#ddd;">转盘</label>
    <div id="roll_rows">
      <div class="roll_row row" id="1st_row_roll">
        <div class="input-field col s6">
          <input style="color:#fff" placeholder="请输入合法字符串" type="text" class="validate roll_name">
          <label for="first_name">选项名称</label>
        </div>
        <div class="input-field col s6">
          <input style="color:#fff" id="last_name" type="text" class="validate roll_weight" placeholder="请输入纯数字">
          <label for="last_name">权重</label>
        </div>
      </div>
    </div>
    <a class="waves-effect waves-light btn" onclick="appendTextBox()">新增</a>
    <a class="waves-effect waves-light btn" onclick="removeLastRow()">删除</a>
    <a class="waves-effect waves-light btn" onclick="pushThatF()">保存</a>
    <a class="waves-effect waves-light btn" onclick="resetRollRows()">重置</a>
  </div>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
</main>
<div class="fixed-action-btn horizontal">
  <a href="../roll.jsp" class="btn-floating btn-large red tooltipped" data-position="top" data-delay="50" data-tooltip="回到上一级">
    <i class="large material-icons" >replay</i>
  </a>
</div>
<div class="hiddendiv common"></div>
<script type="text/javascript">
  resetRollRows();
</script>
</body>
</html>
