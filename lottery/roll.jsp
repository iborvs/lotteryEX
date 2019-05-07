<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>大转盘</title>
    <style>

    </style>
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <link rel="stylesheet" href="../css/gbfstyle.css" type="text/css" />
	<link rel="stylesheet" href="../css/gbf-origin.css" type="text/css" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="../css/roll.css" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/css/materialize.min.css">
    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/js/materialize.min.js"></script>
</head>
<body class="text-center">
<!--<h2 class="text-center title">抽奖</h2>-->
<div style="position: absolute;width: 100%">
<div style="width:1200px;height:1200px;margin:50px auto;zoom: 0.5;position: relative;" class="text-center div">
    <canvas id="canvas" style="z-index: -1"></canvas>
    <img src="../images/assets/roll.png" usemap="#letsroll" id="roulette"/>
    <map name="letsroll">
        <area id="roll-map" shape="circle" coords="480,650,120" alt="Venus" onclick="go()">
    </map>
</div>
</div>

  <!-- Modal Trigger -->
  <!-- Modal Structure -->
  <a class="waves-effect waves-light btn" href="#modal1" style="display:none">模态</a>
  <div id="modal1" class="modal">
    <div class="modal-content">
      <h4 style="color:white">抽奖结果</h4>
      <p id="roll-result">啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊</p>
    </div>
    <div class="modal-footer" id="modal-btns" style="background-color:transparent;">
	<a href="login.jsp" class=" modal-action modal-close waves-effect btn-gbf">前往登录</a>
      <a href="#" class=" modal-action modal-close waves-effect btn-gbf" onclick="roulette_reload()">当做无事发生</a>
    </div>
  </div>
  <div class="fixed-action-btn horizontal">
    <a href="login.jsp" class="btn-floating btn-large red tooltipped" data-position="top" data-delay="50" data-tooltip="回到上一级">
        <i class="large material-icons" >replay</i>
    </a>
    </div>
</body>


<script>
    var canvas = document.getElementById('canvas');//转盘所在画布
    canvas.width = 1200;
    canvas.height = 1200;

    var sector = canvas.getContext("2d");

    var colors = ['#33ACB5', '#DF5C5D', '#B4D966', '#5450B3', '#FFD457', '#3A97EA', '#FAA167', '#63CA97', '#9A50B3'];
    var data = [
        {name: '10', color: colors[0],weight:30},
        {name: '20', color: colors[1],weight:25},
        {name: '30', color: colors[2],weight:10},
        {name: '40', color: colors[3],weight:10},
        {name: '50', color: colors[4],weight:5},
        {name: '100', color: colors[5],weight:3}
    ];
    var repsData=[];
    var texture_list=new Array();
    var tex_num=5; //定义纹理数量
    for(var i=0;i<tex_num;i++){
        var tex_img=new Image();
        tex_img.src='../images/assets/texture/tex_'+i+'.jpg';
        var pattern = sector.createPattern(tex_img,"repeat");
        texture_list.push(tex_img);
    }
    $.get("conn.jsp", { dataType: 'json'},
  		function(response,status,xhr){
  			if(response!=null){
    			response=response.replace(/[\r\n]/g,"")
    			var json=$.parseJSON(response);
    			for (var i = 0; i < json.length; i++) {
    				repsData.push({name: json[i].name, color: colors[i],weight:json[i].weight})
    			}
    			if(json.length!=0){
    				data=repsData;
    			}
  			}
  			paintName(data);
  	});
    var w = canvas.width;
    var h = canvas.height;
    const ang=Math.PI/180;
    var lastArc=0; //记录转盘上一次的指针角度
    window.onload = function() {
        //paintName(data);
    };
    function roulette_reload(){
        lastArc=0;
        canvas.height=canvas.height;
        paintName(data);
    }
    function paintName(adata) {
        var len = adata.length;
        var totalWeit=0;
        for(var i=0;i<len;i++){
            totalWeit+=adata[i].weight;
        }
        var angle = Math.PI * 2 / totalWeit;
        for (var i = 0; i < len; i++) {
            var item = adata[i];
            sector.beginPath();
            sector.moveTo(w / 2, h / 2);
            sector.lineTo(w - 3, h / 2);
            sector.arc(w / 2, h / 2, h / 3 - 50, 0, angle*item.weight);
            sector.lineTo(w / 2, h / 2);
            if(texture_list.length>1){
                var pattern = sector.createPattern(texture_list[i%tex_num],"repeat");
                if(i==len-1){
                    if( (i)%tex_num == 0 )
                        var pattern = sector.createPattern(texture_list[(i+1)%tex_num],"repeat");
                }
                sector.fillStyle = pattern;
            }
            else{
                sector.fillStyle = item.color;
            }
            sector.fill();
            sector.translate(600, 600); // 设置原点为画布中心
            sector.rotate(angle*item.weight/2);
            //drawCircularText(item.name,0,textAngel);
            sector.save();
            //绘制项目文字
            sector.translate(500, 90)
            var k = 155/40; //建立字符串长度和字体大小的关系
            var jmz = {};
            jmz.GetLength = function(str) {
                    return item.name.replace(/[\u0391-\uFFE5]/g,"aa").length;  //先把中文替换成两个字节的英文，在计算长度
            };
            var fontSize = 77.5 - k*jmz.GetLength();
            sector.font = fontSize+"px Impact";
            sector.fillStyle = "white";
            var padding = -360;
            s = item.name.substring(0,1);
            if( !/^[a-zA-Z]+$/.test(s)){
            padding += -15
            }
            sector.fillText(item.name, padding, -70);
            sector.restore();

            sector.rotate(angle*item.weight/2); //旋转画布
            sector.translate(-600, -600); // 恢复画布中心到（0，0）
        }
    }
    function price(arc){
        var len = data.length;
        var totalWeit=0
        for(var i=0;i<len;i++){
            totalWeit+=data[i].weight;
        }
        var angle = Math.PI * 2 / totalWeit;
        arc=(-arc-Math.PI/2)%(Math.PI*2);
        if(arc<0)
            arc+=Math.PI*2;
        var sec=0;
        var end=0;
        for(var i=0;i<data.length;i++){
            end+=data[i].weight*angle;
            if(arc>=sec && arc<=end){
                $('#roll-result').text(data[i].name+"！");
                $('#modal1').modal('open');
                break;
            }
            sec+=data[i].weight*angle;
        }
    }
    function go() {
        $('#roll-map').attr("onclick","");
        var time = 6000;
        var a0 = (Math.random()*2+1) / 100;
        var clock = 20;
        var pos=0;
        var interval = setInterval(function () {
            var a = time >= 3000 ? a0:-a0;
            var v = time>=3000 ? a * (6000-time) : a0*3000 + a * (3000-time);
            sector.translate(600,600);
            pos+=ang * v;
            sector.rotate(ang * v);
            sector.translate(-600,-600);
            sector.clearRect(0,0,1200,1200);
            paintName(data);
            time -= clock;
            if(time == 0){
                window.clearInterval(interval);
                lastArc+=pos;
                price(lastArc);
                $('#roll-map').attr("onclick","go()");
            }
        },clock)
    }
    $(document).ready(function(){
        $('.modal').modal();
    });
</script>
</html>