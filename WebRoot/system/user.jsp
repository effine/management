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

	//ҳ��
	int pageno = pageObj.getPageno();
	
	//�ܼ�¼����
	int totalsize = pageObj.getTotalsize();
	
	//��ҳ��
	int pagecount = pageObj.getPagecount();
	
	//һҳ��ʾ�ļ�¼����
	int pagesize = pageObj.getPagesize();
	
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

	//��ҳ
	function goPage(pageno){
		document.location = "/servlet/pageQueryUser?pageno=" + pageno;
	}
	
	//��ת��ָ��ҳ
	function changePage(){
		//��ȡҳ��
		var pageno = document.getElementById("mypageno").value;
		//��֤pageno�Ƿ���һ�����֣�������֤�������Ƿ��ںϷ��ķ�Χ�У�����Ϸ�����ת
		var ok = validateNum(pageno);
		//��ת
		if(ok){
			goPage(pageno);	
		}
	}
	
	//У��ҳ��
	function validateNum(pageno){
		
		if(pageno=="" || isNaN(pageno)){
			alert("ҳ����������֣���������д");
			document.getElementById("mypageno").value = "";
			document.getElementById("mypageno").focus();
			return false;
		}
		
		//���ַ���������ת�����������͵�����
		pageno = parseInt(pageno);
		
		if(pageno<1 || pageno><%=pagecount%>){
			alert("ҳ�������[1-<%=pagecount%>]��Χ�У���������д");
			document.getElementById("mypageno").value = "";
			document.getElementById("mypageno").focus();
			return false;
		}
		
		return true;
	}
	
	//�����޸İ�ť��ɾ����ť
	function controlUpdateAndDelete(){
		
		//��ȡ��ǰҳ�����и�ѡ��
		var controlUpdateAndDeleteCheckboxs = document.getElementsByName("controlUpdateAndDeleteCheckbox");
		
		//�������еĸ�ѡ��ͳ�Ʊ�ѡ�еĸ�ѡ��ĸ���
		var checkedCount = 0;
		for(var i=0;i<controlUpdateAndDeleteCheckboxs.length;i++){
			if(controlUpdateAndDeleteCheckboxs[i].checked){
				checkedCount++;
			}
		}
		
		//��ȡɾ����ť���޸İ�ť
		var updateImg = document.getElementById("updateImg");
		var deleteImg = document.getElementById("deleteImg");
		
		//��ѡ�еĸ�������ô���������0��1��1+
		if(checkedCount==0){
			
			//ɾ����ť���޸İ�ť������ʹ��
			updateImg.src = "../images/update_disabled.jpg";
			deleteImg.src = "../images/delete_disabled.jpg";
			
			updateImg.disabled = true;
			deleteImg.disabled = true;
			
		}else if(checkedCount==1){
			//ɾ����ť���޸İ�ť����ʹ��
			updateImg.src = "../images/update.jpg";
			deleteImg.src = "../images/delete.jpg";
			
			updateImg.disabled = false;
			deleteImg.disabled = false;
			
		}else if(checkedCount>1){
			//ɾ����ť����ʹ�ã��޸İ�ť����ʹ��
			updateImg.src = "../images/update_disabled.jpg";
			deleteImg.src = "../images/delete.jpg";
			
			updateImg.disabled = true;
			deleteImg.disabled = false;
		}
	}
	
	//ȫѡ��ȡ��ȫѡ
	function checkOrCancelAll(){
		
		var controlUpdateAndDeleteCheckboxs = document.getElementsByName("controlUpdateAndDeleteCheckbox");
		
		//�����ܿظ�ѡ���״̬���ȫѡ����ȡ��ȫѡ
		var checkAll = document.getElementById("checkAll");
		
		if(checkAll.checked){
			//ȫѡ
			for(var i=0;i<controlUpdateAndDeleteCheckboxs.length;i++){
				controlUpdateAndDeleteCheckboxs[i].checked = true;
			}
		}else{
			//ȡ��ȫѡ
			for(var i=0;i<controlUpdateAndDeleteCheckboxs.length;i++){
				controlUpdateAndDeleteCheckboxs[i].checked = false;
			}
		}
		
		controlUpdateAndDelete();
		
	}
	
	//��ת���޸�ҳ��
	function goUpdate(){
		document.forms["userListForm"].submit();
	}
	
	//ɾ������û���Ϣ
	function doDelete(){
		var isDelete = window.confirm("��ȷ��Ҫɾ���û���Ϣ��");
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
        <td width="1101" background="../images/tab_05.gif"><img src="../images/311.gif" width="16" height="16" /> <span class="STYLE4">ϵͳ�û��б�</span></td>
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
            <td width="8%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">���</div></td>
            <td width="12%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">�û�����</div></td>
            <td width="24%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2">�û�����</div></td>
            <td width="38%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">��������</div></td>
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
            <td width="25%" height="29" nowrap="nowrap"><span class="STYLE1">��<%=totalsize %>����¼����ǰ��<%=pageno %>/<%=pagecount %>ҳ��ÿҳ<%=pagesize %>����¼</span></td>
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
                  <td width="59" height="22" valign="middle"><div align="right">ת����</div></td>
                  <td width="25" height="22" valign="middle"><span class="STYLE7">
                    <input name="mypageno" id="mypageno" type="text" class="STYLE1" style="height:14px; width:25px;text-align:right" size="5" />
                  </span></td>
                  <td width="23" height="22" valign="middle">ҳ</td>
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
