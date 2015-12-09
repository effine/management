<%@page pageEncoding="GB18030"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script type="text/javascript" src="../clander/date.js"></script>
<script type="text/javascript" src="../clander/setday.js"></script>
<script>document.onclick=function() {}</script>
<title>无标题文档</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE1 {font-size: 12px}
.STYLE4 {
	font-size: 12px;
	color: #1F4A65;
	font-weight: bold;
}

a:link {
	font-size: 12px;
	color: #06482a;
	text-decoration: none;

}
a:visited {
	font-size: 12px;
	color: #06482a;
	text-decoration: none;
}
a:hover {
	font-size: 12px;
	color: #FF0000;
	text-decoration: underline;
}
a:active {
	font-size: 12px;
	color: #FF0000;
	text-decoration: none;
}
.STYLE7 {font-size: 12}

-->
</style>

<script>
	
	function doFeedback(){
		var authnox = document.getElementById("authnox").value;
		document.location = "/servlet/auth?funtype=update&authno=" + authnox;
	}
	
	//使用ajax向服务器发送请求查询核准件的详细信息
	var xRequest;
	
	function doQuery(){
		
		//创建AJAX的核心对象
		if(window.XMLHttpRequest){
			xRequest = new XMLHttpRequest();
		}else if(window.ActiveXObject){
			xRequest = new ActiveXObject("Microsoft.XMLHTTP");
		}
		//注册回调函数
		xRequest.onreadystatechange = callback;
		
		//开启通道
		var authno = document.getElementById("authno").value;
		var nowTime = new Date();
		xRequest.open("GET","/servlet/auth?funtype=select&timeStamp="+nowTime.getTime()+"&authno=" + authno,true);
		
		//发送请求
		xRequest.send();
	}
	
	
	function callback(){
		if(xRequest.readyState == 4){
			if(xRequest.status == 200){
				var authDiv = document.getElementById("authDiv");
				authDiv.innerHTML = xRequest.responseText;
			}else if(xRequest.status == 404){
				alert("404-资源未找到");
			}else if(xRequest.status == 500){
				alert("500-服务器内部错误");
			}else{
				alert(xRequest.status + "-未知错误");
			}
		}
	}
	
	
</script>

</head>

<body>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="../images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="../images/tab_05.gif"><img src="../images/311.gif" width="16" height="16" /> <span class="STYLE4">银行核准类信息列表</span></td>
        <td width="281" background="../images/tab_05.gif"><table border="0" align="right" cellpadding="0" cellspacing="0">
            <tr>
              <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"></td>
                  </tr>
              </table></td>
            </tr>
        </table></td>
        <td width="14"><img src="../images/tab_07.gif" width="14" height="30" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr height="5">
          <td width="9" background="../images/tab_12.gif">&nbsp;</td>
          <td bgcolor="#f3ffe3">&nbsp;</td>
          <td width="9" background="../images/tab_16.gif">&nbsp;</td>
      </tr>
      <tr>
        <td width="9" background="../images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3">
        	<table width="99%" border="0" align="center" cellpadding="0" cellspacing="1">
        	    <tr>
        	       <td width="90"  nowrap class="STYLE1" align="right">核准件编号:</td>
				    <td class="class1_td alignleft" nowrap><input type="text" name="authno" id="authno" style="width:100px; height:20px; border:solid 1px #035551; color:#000000"></td> 
        	    </tr>
        	    <tr>
        	        <td class="STYLE1" colspan="5" align="left">&nbsp;&nbsp;</td>
        	        <td nowrap class="STYLE1" align="right"><button style="width:68px;height:27px" onclick="doQuery();" ><img src="../images/query.jpg" /></button>&nbsp;&nbsp;<button style="width:68px;height:27px"><img src="../images/clear.jpg" /></button>&nbsp;&nbsp;</td>
        	    </tr>
        	</table>
        </td>
        <td width="9" background="../images/tab_16.gif">&nbsp;</td>
      </tr>
      <tr height="10">
          <td width="9" background="../images/tab_12.gif">&nbsp;</td>
          <td bgcolor="#f3ffe3">&nbsp;</td>
          <td width="9" background="../images/tab_16.gif">&nbsp;</td>
      </tr>
  </table>
  </tr>
  <tr>
    <td></td>
  </tr>
  <tr>
    <td height="29"></td>
  </tr>
</table>

<div id="authDiv"></div>

</body>
</html>
