<%@page pageEncoding="GB18030"%>

<%
	Object errorMsg = request.getAttribute("errorMsg");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>
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
	
	function pageLoad(){
		<%
			if(errorMsg!=null){
		%>
				alert("<%=errorMsg%>");
		<%
			}
		%>
	}
	

	//�����û���Ϣ
	function doSave(){
		//������е����ݣ�������ݺϷ����ύ��
		var ok = validationForm();
		
		if(ok){
			//�ύ��
			//document.forms[0].submit();
			document.forms["userForm"].submit();
		}
	}
	
	//У��form�е����ݲ���Ϊ��
	function validationForm(){
		//usercode�ı������
		var usercode = document.getElementById("usercode");
		
		//if(usercode.value.length == 0){}
		
		//��javascript���ַ���û��null��һ˵�����ַ���ָ���� ""
		if(usercode.value == ""){
			alert("�û����벻��Ϊ�գ�����д");
			usercode.focus();
			return false;
		}
		
		//username�ı������
		var username = document.getElementById("username");
		if(username.value == ""){
			alert("�û���������Ϊ�գ�����д");
			username.focus();
			return false;
		}
		
		var userpswd = document.getElementById("userpswd");
		if(userpswd.value == ""){
			alert("�û����벻��Ϊ�գ�����д");
			userpswd.focus();
			return false;
		}
		
		var checkpswd = document.getElementById("checkpswd");
		if(checkpswd.value == ""){
			alert("ȷ�����벻��Ϊ�գ�����д");
			checkpswd.focus();
			return false;
		}
		
		if(userpswd.value != checkpswd.value){
			alert("�û������ȷ�����벻һ�£���������д");
			userpswd.value = "";
			checkpswd.value = "";
			userpswd.focus();
			return false;
		}
		
		var orgtype = document.getElementById("orgtype");
		if(orgtype.value == ""){
			alert("�������Ͳ���Ϊ�գ�����д");
			orgtype.focus();
			return false;
		}
		
		return true;
		
	}
	
	//ʹ��ajax��֤�û������Ƿ����
	var xRequest;
	
	function checkUsercode(usercode){
	
		if(window.XMLHttpRequest){
			xRequest = new XMLHttpRequest();
		}else if(window.ActiveXObject){
			xRequest = new ActiveXObject("Microsoft.XMLHTTP");
		}
		
		xRequest.onreadystatechange = callback;
		
		var sysTime = new Date();
		xRequest.open("GET","/servlet/checkUsercode?timeStamp="+sysTime.getTime()+"&usercode="+usercode,true);
		
		xRequest.send();
	}
	
	function callback(){
		if(xRequest.readyState==4){
			if(xRequest.status==200){
				var tipMsg = document.getElementById("tipMsg");
				tipMsg.innerHTML = xRequest.responseText;
			}else if(xRequest.status==404){
				alert("404");
			}else if(xRequest.status==500){
				alert("500");
			}else{
				alert(xRequest.status);
			}
		}
	}
	
	function clearInfo(){
		var tipMsg = document.getElementById("tipMsg");
		tipMsg.innerHTML = "";
	}
	
</script>
</head>

<%--
	load ��HTMLҳ������¼���
	onload ��ҳ������¼������
	
	ע����onload�¼���������js����������HTMLҳ�������ϵ�ʱ��ִ�С�
--%>
<body onload="pageLoad();">
<form action="/servlet/insertUser" method="post" name="userForm">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="../images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="../images/tab_05.gif"><img src="../images/311.gif" width="16" height="16" /> <span class="STYLE4">����ϵͳ�û�</span></td>
        <td width="281" background="../images/tab_05.gif"><table border="0" align="right" cellpadding="0" cellspacing="0">
        </table></td>
        <td width="14"><img src="../images/tab_07.gif" width="14" height="30" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" background="../images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68" >
          <tr height="26"></tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">�û�����</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2">
            <input onblur="checkUsercode(this.value);" onfocus="clearInfo();" type="text" name="usercode" id="usercode" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;
            <font color='red'>*</font>
            <span id="tipMsg"></span>
            </div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">�û�����</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="username" id="username" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">�û�����</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="password" name="userpswd" id="userpswd" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">ȷ������</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="password" name="checkpswd" id="checkpswd" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
          </tr>
          <tr>
            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">��������</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2">
            <select name="orgtype" id="orgtype" style="width:105px; height:20px; border:solid 1px #035551; color:#000000">
              <option value=""></option>
              <option value="0">�������</option>
              <option value="1">����</option>
            </select>&nbsp;<font color='red'>*</font></div></td>
          </tr>
        </table></td>
        <td width="9" background="../images/tab_16.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" background="../images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68">
          <tr height="26"><td bgcolor="#FFFFFF" height="26" class="STYLE1" colspan="2" style="padding-top:5px;padding-left:200px"><img src="../images/save.jpg" style="cursor:hand" onclick="doSave();" />&nbsp;&nbsp;<img src="../images/clear.jpg" style="cursor:hand" /></td></tr>
        </table></td>
        <td width="9" background="../images/tab_16.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="29"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="29"><img src="../images/tab_20.gif" width="15" height="29" /></td>
        <td background="../images/tab_21.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="75%" valign="top" class="STYLE1"><div align="left">
              <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="62" height="22" valign="middle"></td>
                  <td width="50" height="22" valign="middle"></td>
                </tr>
              </table>
            </div></td>
          </tr>
        </table></td>
        <td width="14"><img src="../images/tab_22.gif" width="14" height="29" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
