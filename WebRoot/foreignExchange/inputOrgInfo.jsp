<%@page pageEncoding="GB18030"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
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
	function popWindow(){
		window.open('/foreignExchange/orgcodeSelect.jsp', 'selectinvestor', 'width=720, height=400, scrollbars=no');
	}
	
	//给投资人列表表格动态添加行
	function addTableRow(invregnum,invname,cty){
		//获取投资人表格
		var invTable = document.getElementById("invTable");
		
		//获取表格的总行数
		var index = invTable.rows.length;
		
		//添加新的行
		var tableRow = invTable.insertRow(index);
		tableRow.style.background = 'white';
		
		//设置TableRow的id
		tableRow.id = "invregnum" + invregnum;
		
		//给新行添加单元格
		var tableCell0 = tableRow.insertCell(0);
		var tableCell1 = tableRow.insertCell(1);
		var tableCell2 = tableRow.insertCell(2);
		var tableCell3 = tableRow.insertCell(3);
		var tableCell4 = tableRow.insertCell(4);
		
		//给每一个单元格添加内容
		tableCell0.innerHTML = '<div align="center" style="padding:5px" class="STYLE2 STYLE1"><input type="hidden" name="invregnum" value="'+invregnum+'" />'+invname+'</div>';
		tableCell1.innerHTML = '<div align="center" style="padding:2px" class="STYLE2"><input type="hidden" name="cty" value="'+cty+'"/>'+cty+'</div>';
		tableCell2.innerHTML = '<div align="center" style="padding:5px" class="STYLE2 STYLE1"><input type="text" name="regcapItem" onblur="computeCap();" style="width:90px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div>';
		tableCell3.innerHTML = '<div align="center" style="padding:2px" class="STYLE2"><input type="text" name="scale" style="width:90px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div>';
		tableCell4.innerHTML = '<div align="center" style="padding:2px" class="STYLE2"><img src="../images/delete.jpg" onclick="deleteRow('+invregnum+')"/></div>';
		
	}
	
	//删除一行
	function deleteRow(invregnum){
		
		//获取投资人表格
		var invTable = document.getElementById("invTable");
		
		//获取被删除的行
		var tableRow = document.getElementById("invregnum" + invregnum);
		
		//删除一行
		invTable.deleteRow(tableRow.rowIndex);
	}
	
	//动态计算注册总资金和外方注册资金
	function computeCap(){
		
		//获取所有的注册资本出资额
		var regcapItems = document.getElementsByName("regcapItem");
		var ctys = document.getElementsByName("cty");
		
		//遍历上面的数组，计算总资金
		var totalRegcap = 0;
		var outRegcap = 0;
		for(var i=0;i<regcapItems.length;i++){
			var regcapItem = regcapItems[i].value;
			if(regcapItem==""){
				regcapItem = 0;
			}
			totalRegcap += parseInt(regcapItem);
			if(ctys[i].value != '中国'){
				outRegcap += parseInt(regcapItem);	
			}
		}
		
		//将注册总资金显示在注册资金的文本框中
		var regcap = document.getElementById("regcap");
		regcap.value = totalRegcap;
		
		//将外方注册资金显示在外方注册资金的文本框中
		var outregcap = document.getElementById("outregcap");
		outregcap.value = outRegcap;
		
		//计算外方出资比例
		var outCapScale = document.getElementById("outCapScale");
		//js中任何一个数字都有一个toFixed方法，可以用来保留小数的位数
		outCapScale.innerHTML = ((outRegcap/totalRegcap)*100).toFixed(2);
	}
	
	//保存企业信息以及企业信息和投资人关系信息
	function doSave(){
		document.forms["enterpriseForm"].submit();
	}
	
</script>
</head>

<body>
<form action="/servlet/saveEnterprise" method="post" name="enterpriseForm">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="../images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="../images/tab_05.gif"><img src="../images/311.gif" width="16" height="16" /> <span class="STYLE4">新设外商企业登记-录入</span></td>
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
          <tr>
            <td width="100" height="26" class="STYLE1" colspan="4"><div align="center" style="padding:5px" class="STYLE2 STYLE1"><font color="#FFFFFF"><B>企业基本信息</B></font></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">组织机构代码:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="hidden" name="orgcode" id="orgcode" value="<%=request.getParameter("orgcode") %>"/><%=request.getParameter("orgcode") %></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">外汇登记证号:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="regno" id="regno" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">企业中文名称:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="cnname" id="cnname" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">企业英文名称:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="enname" id="enname" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">联系人:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="contactman" id="contactman" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">联系电话:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="contacttel" id="contacttel" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"></div></td>
          </tr>
          <tr>
            <td width="100" height="26" class="STYLE1" colspan="4"><div align="center" width="100%" style="padding:5px" class="STYLE2 STYLE1"><font color="#FFFFFF"><B>企业资金情况信息</B></font></div></td>
          </tr>        
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">注册资本:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" readonly name="regcap" id="regcap" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">注册币种:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2">
		      <select name="regcry" id="regcry" style="WIDTH:100px">
		        <option value=""></option>
		        <option value="000">人民币</option>
		        <option value="001">美元</option>
		        <option value="002">英镑</option>
		        <option value="003">日元</option>
		      </select> <font color="red">*</font></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">外方注册资本:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" readonly name="outregcap" id="outregcap" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">外方出资比例:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><span id="outCapScale">0</span>%</div></td>
          </tr>
          <tr>
            <td width="100" height="26" class="STYLE1" colspan="4"><div align="center" style="padding:5px" class="STYLE2 STYLE1"><font color="#FFFFFF"><B>投资者资金及利润分配</B></font></div></td>
          </tr> 
          <tr>
            <td width="100%" bgcolor="#FFFFFF" class="STYLE1" colspan="4">
                <table id="invTable" border="0" width="100%" height="100%" cellpadding="0" cellspacing="1" bgcolor="#0e6f68">
		          <tr>
		            <td width="20%" bgcolor="#CCCCCC" height="20" class="STYLE1"><div align="center" style="padding:5px" class="STYLE2 STYLE1">投资者名称</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:2px" class="STYLE2">国别</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:5px" class="STYLE2 STYLE1">注册资本出资额</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:2px" class="STYLE2">利润分配比例</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:2px" class="STYLE2"><img src="../images/query.jpg" onclick="popWindow();"/></div></td>
		          </tr>
		          
                </table>
            </td>
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
          <tr height="30"><td bgcolor="#FFFFFF" height="30" class="STYLE1" colspan="2" align="center"><img src="../images/ok.jpg" onclick="doSave();"/>&nbsp;&nbsp;<img src="../images/back.jpg" onclick="document.location='newInputOrg.html'"/></td></tr>
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
