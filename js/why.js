function appendTextBox()
{
var newRollRow="<div class='row roll_row'><div class='input-field col s6'><input type='text' style='color:white' class='validate roll_name' placeholder='请输入合法字符串'><label for='first_name' class='active'></label></div><div class='input-field col s6'><input type='text' style='color:white' class='validate roll_weight' placeholder='请输入纯数字'><label for='last_name' class='active'></label></div></div>";              // 以 HTML 创建新元素
$(".roll_row").eq(-1).after(newRollRow);        // 追加新元素
}
function newTextBox()
{
var newRollRow="<div class='row roll_row'><div class='input-field col s6'><input type='text' style='color:white' class='validate roll_name' placeholder='请输入合法字符串'><label for='first_name' class='active'>选项名称</label></div><div class='input-field col s6'><input type='text' style='color:white' class='validate roll_weight' placeholder='请输入纯数字'><label for='last_name' class='active'>权重</label></div></div>";              // 以 HTML 创建新元素
$("#roll_rows").append(newRollRow);        // 追加新元素
}
function removeLastRow() {
    $(".roll_row").eq(-1).remove();
}
function pushThatF(){
	var Str=""
  var flag=1;
  var reg = /[0-9]*$/;
	if($(".roll_row").length>0){
		for (var i = 0; i < $(".roll_row").length && flag==1; i++) {
      if($(".roll_row").eq(i).find('.roll_name').val().indexOf("'")!=-1||$(".roll_row").eq(i).find('.roll_name').val().indexOf("\"")!=-1){
        flag=0;
        alert("fuck1");
      }
      if(!reg.test($(".roll_row").eq(i).find('.roll_weight').val())){
        flag=0;
        alert("fuck2");
      }
			Str += "name="+encodeURI($(".roll_row").eq(i).find('.roll_name').val())+"&weight="+$(".roll_row").eq(i).find('.roll_weight').val()+"&";
		}
	}
  if(flag==1)
	   $.ajax({ url: "pushTo.jsp", 
		data: Str,
		type:"Get",
		success: function(){
      alert("导入成功");
      }});
  else
    alert("输入不合法！");
}
function resetRollRows(){
	$("#roll_rows").empty();
	pullFromDB();
}
function pullFromDB(){
	$.get("conn.jsp", { dataType: 'json'},
  		function(response,status,xhr){
  			if(response!=null){
    			response=response.replace(/[\r\n]/g,"")
    			var json=$.parseJSON(response);
    			newTextBox();
    			for (var i = 0; i < json.length; i++) {
    				$(".roll_row").eq(-1).find('.roll_name').val(json[i].name);
    				$(".roll_row").eq(-1).find('.roll_weight').val(json[i].weight);
    				appendTextBox();
    			}
    			removeLastRow();
  			}
  	});
}