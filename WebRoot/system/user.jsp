<%@page pageEncoding="GB18030"%>
<%@page import="java.util.List"%>
<%@page import="cn.effine.bean.User"%>
<%@page import="cn.effine.util.StringUtil"%>
<%@page import="cn.effine.bean.Page"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="egov" uri="http://www.egov.com/functions" %>

<%
	Page<User> pageObj = (Page<User>)request.getAttribute("page");

	List<User> userList = pageObj.getDataList();

	//页码
	int pageno = pageObj.getPageno();
	
	//总记录条数
	int totalsize = pageObj.getTotalsize();
	
	//总页数
	int pagecount = pageObj.getPagecount();
	
	//一页显示的记录条数
	int pagesize = pageObj.getPagesize();
	
%>
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

	//翻页
	function goPage(pageno){
		document.location = "/servlet/pageQueryUser?pageno=" + pageno;
	}
	
	//跳转到指定页
	function changePage(){
		//获取页码
		var pageno = document.getElementById("mypageno").value;
		//验证pageno是否是一个数字，并且验证该数字是否在合法的范围中，如果合法则跳转
		var ok = validateNum(pageno);
		//跳转
		if(ok){
			goPage(pageno);	
		}
	}
	
	//校验页码
	function validateNum(pageno){
		
		if(pageno=="" || isNaN(pageno)){
			alert("页码必须是数字，请重新填写");
			document.getElementById("mypageno").value = "";
			document.getElementById("mypageno").focus();
			return false;
		}
		
		//将字符串的数字转换成数字类型的数字
		pageno = parseInt(pageno);
		
		if(pageno<1 || pageno><%=pagecount%>){
			alert("页码必须在[1-<%=pagecount%>]范围中，请重新填写");
			document.getElementById("mypageno").value = "";
			document.getElementById("mypageno").focus();
			return false;
		}
		
		return true;
	}
	
	//控制修改按钮和删除按钮
	function controlUpdateAndDelete(){
		
		//获取当前页的所有复选框
		var controlUpdateAndDeleteCheckboxs = document.getElementsByName("controlUpdateAndDeleteCheckbox");
		
		//遍历所有的复选框，统计被选中的复选框的个数
		var checkedCount = 0;
		for(var i=0;i<controlUpdateAndDeleteCheckboxs.length;i++){
			if(controlUpdateAndDeleteCheckboxs[i].checked){
				checkedCount++;
			}
		}
		
		//获取删除按钮和修改按钮
		var updateImg = document.getElementById("updateImg");
		var deleteImg = document.getElementById("deleteImg");
		
		//被选中的个数有这么几种情况：0、1、1+
		if(checkedCount==0){
			
			//删除按钮和修改按钮都不能使用
			updateImg.src = "../images/update_disabled.jpg";
			deleteImg.src = "../images/delete_disabled.jpg";
			
			updateImg.disabled = true;
			deleteImg.disabled = true;
			
		}else if(checkedCount==1){
			//删除按钮和修改按钮都能使用
			updateImg.src = "../images/update.jpg";
			deleteImg.src = "../images/delete.jpg";
			
			updateImg.disabled = false;
			deleteImg.disabled = false;
			
		}else if(checkedCount>1){
			//删除按钮可以使用，修改按钮不能使用
			updateImg.src = "../images/update_disabled.jpg";
			deleteImg.src = "../images/delete.jpg";
			
			updateImg.disabled = true;
			deleteImg.disabled = false;
		}
	}
	
	//全选和取消全选
	function checkOrCancelAll(){
		
		var controlUpdateAndDeleteCheckboxs = document.getElementsByName("controlUpdateAndDeleteCheckbox");
		
		//根据总控复选框的状态完成全选或者取消全选
		var checkAll = document.getElementById("checkAll");
		
		if(checkAll.checked){
			//全选
			for(var i=0;i<controlUpdateAndDeleteCheckboxs.length;i++){
				controlUpdateAndDeleteCheckboxs[i].checked = true;
			}
		}else{
			//取消全选
			for(var i=0;i<controlUpdateAndDeleteCheckboxs.length;i++){
				controlUpdateAndDeleteCheckboxs[i].checked = false;
			}
		}
		
		controlUpdateAndDelete();
		
	}
	
	//跳转到修改页面
	function goUpdate(){
		document.forms["userListForm"].submit();
	}
	
	//删除多个用户信息
	function doDelete(){
		var isDelete = window.confirm("您确定要删除用户信息吗？");
		if(isDelete){
			document.forms["userListForm"].action = "/servlet/doDelete";
			document.forms["userListForm"].submit();
		}
	}
	
</script>
</head>

<body>
<form action="/servlet/goUpdate" name="userListForm" method="post">
<input type="hidden" name="pagenoUpdate" value="<%=pageno %>"/>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="../images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="../images/tab_05.gif"><img src="../images/311.gif" width="16" height="16" /> <span class="STYLE4">系统用户列表</span></td>
        <td width="281" background="../images/tab_05.gif"><table border="0" align="right" cellpadding="0" cellspacing="0">
            <tr>
              <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"><div align="center"><img src="../images/add.jpg" style="cursor:hand" onclick="document.location='/system/userAdd.jsp'"/></div></td>
                  </tr>
              </table></td>
              <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"><div align="center"><img id="updateImg" src="../images/update_disabled.jpg" disabled style="cursor:hand" onclick="goUpdate();"/></div></td>
                  </tr>
              </table></td>
              <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="STYLE1"><div align="center"><img id="deleteImg" src="../images/delete_disabled.jpg" disabled style="cursor:hand" onclick="doDelete();"/></div></td>
                  </tr>
              </table></td>
            </tr>
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
            <td width="6%" height="26" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1"><input type="checkbox" name="checkAll" id="checkAll" onclick="checkOrCancelAll();"/></div></td>
            <td width="8%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">序号</div></td>
            <td width="12%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">用户代码</div></td>
            <td width="24%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2">用户姓名</div></td>
            <td width="38%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">机构类型</div></td>
          </tr>
          
          <c:forEach items="${requestScope.page.dataList}" var="user" varStatus="userStatus">
         		<tr>
		            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE1">
		              <input name="controlUpdateAndDeleteCheckbox" value="${user.usercode}" id="controlUpdateAndDeleteCheckbox" onclick="controlUpdateAndDelete();" type="checkbox" class="STYLE2" value="checkbox" />
		            </div></td>
		            <td height="18" bgcolor="#FFFFFF" class="STYLE2"><div align="center" class="STYLE2 STYLE1">${userStatus.count}</div></td>
		            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${user.usercode}</div></td>
		            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${user.username}</div></td>
		            <td height="18" bgcolor="#FFFFFF"><div align="center" ><a href="#">${egov:getTextByCode(user.orgtype)}</a></div></td>
	            </tr> 
          </c:forEach>
          
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
            <td width="25%" height="29" nowrap="nowrap"><span class="STYLE1">共<%=totalsize %>条纪录，当前第<%=pageno %>/<%=pagecount %>页，每页<%=pagesize %>条纪录</span></td>
            <td width="75%" valign="top" class="STYLE1"><div align="right">
            <%
            	boolean isNotFirstPage = pageno > 1;
            	boolean isNotLastPage = pageno < pagecount;
            %>
              <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="../images/firstPage<%=isNotFirstPage?"":"Disabled"%>.gif" <%=isNotFirstPage?"style='cursor:hand'":"" %> <%=isNotFirstPage?"onclick='goPage(1)'":"" %>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="../images/prevPage<%=isNotFirstPage?"":"Disabled"%>.gif"  <%=isNotFirstPage?"style='cursor:hand'":"" %> <%=isNotFirstPage?"onclick='goPage(" + (pageno-1) + ")'":"" %>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="../images/nextPage<%=isNotLastPage?"":"Disabled"%>.gif"  <%=isNotLastPage?"style='cursor:hand'":"" %> <%=isNotLastPage?"onclick='goPage(" + (pageno+1) + ")'":"" %>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="../images/lastPage<%=isNotLastPage?"":"Disabled"%>.gif" <%=isNotLastPage?"style='cursor:hand'":"" %> <%=isNotLastPage?"onclick='goPage(" + pagecount + ")'":"" %>/></div></td>
                  <td width="59" height="22" valign="middle"><div align="right">转到第</div></td>
                  <td width="25" height="22" valign="middle"><span class="STYLE7">
                    <input name="mypageno" id="mypageno" type="text" class="STYLE1" style="height:14px; width:25px;text-align:right" size="5" />
                  </span></td>
                  <td width="23" height="22" valign="middle">页</td>
                  <td width="30" height="22" valign="middle"><img src="../images/go.gif" style="cursor:hand" onclick="changePage();" width="37" height="15" /></td>
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
