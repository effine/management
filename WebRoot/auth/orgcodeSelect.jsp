<%@page pageEncoding="GB18030"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script type="text/javascript" src="../clander/date.js"></script>
<script type="text/javascript" src="../clander/setday.js"></script>
<script>document.onclick=function() {}</script>
<title>����Ͷ����ҵѡ��</title>
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

	//��ҳ��ѯ��ҵ��Ϣ
	function doQuery(){
		document.forms["enterpriseForm"].submit();
	}
	
	//�鿴��ҵ��Ͷ�ʱ���
	function viewScale(orgcode){
		//��ʾdiv
		var scaleDiv = document.getElementById("scaleDiv");
		
		//��ȡͼƬimg
		var scaleImg = document.getElementById("scaleImg");
		
		//��������������������������Ӧһ��ͼƬ
		//�ص㣺img��ǩ��src��������·����ʱ�����WEB��������������
		scaleImg.src = "/servlet/viewScale?orgcode=" + orgcode;
		
		//����div����ʽ��������ʾ����
		scaleDiv.style.display = "block";
	}
	
	
	function hiddenScale(){
		var scaleDiv = document.getElementById("scaleDiv");
		scaleDiv.style.display = "none";
	}
</script>
</head>

<body>

<div id="scaleDiv" style="display:none;position:absolute;top:75px;left:150px">

	<%--
		�����ͼƬ�����ǹ̶��ģ�Ӧ���Ǵ�web�������˶�̬��Ӧ������ͼƬ,���ǿ���ʹ��jfreechart��������������ͼƬ������
	--%>
	<img id="scaleImg" alt="Ͷ����Ͷ�ʱ���ͼ" src="" />
	
</div>

<form action="/servlet/pageQueryEnterprise" method="post" name="enterpriseForm">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="../images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="../images/tab_05.gif"><img src="../images/311.gif" width="16" height="16" /> <span class="STYLE4">����Ͷ����ҵ�б�</span></td>
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
        	        <td width="120" class="STYLE1">��֯��������:</td>
        	        <td width="140" class="STYLE1"><input type="text" name="orgcode" id="orgcode" style="width:100px; height:20px; border:solid 1px #035551; color:#000000"></td>
        	        <td width="90" class="STYLE1">��ҵ��������:</td>
        	        <td width="130" class="STYLE1" ><input type="text" name="cnname" id="cnname" style="width:100px; height:20px; border:solid 1px #035551; color:#000000"></td>
				    <td width="60"  nowrap class="STYLE1">�Ǽ�����:</td>
				    <td class="class1_td alignleft" nowrap>
				        <input type="text" name="startdate" id="startdate" style="width:75px; height:20px; border:solid 1px #035551; color:#000000" readonly>
				        <input onclick="setday(document.all.startdate);" type="image" value=" ѡ������ " name="button004" src="../clander/clander.gif" align="top"/>
				  ��
				  <input type="text" name="enddate" id="enddate" style="width:75px; height:20px; border:solid 1px #035551; color:#000000" readonly>
				  <input onclick="setday(document.all.enddate);" type="image" value=" ѡ������ " name="button004" src="../clander/clander.gif" align="top"/>
				      </td> 
        	    </tr>
        	    <tr>
        	        <td class="STYLE1" colspan="5" align="left"></td>
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
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" background="../images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3"><table width="99%" id="dataTable" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68" >
        <thead class="class1_thead">
          <tr>
            <td width="8%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">���</div></td>
            <td width="20%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">��֯��������</div></td>
            <td width="24%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2">��ҵ��������</div></td>
            <td width="10%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">�Ǽ�����</div></td>
            <td width="8%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">������</div></td>
            <td width="8%" height="18" background="../images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">Ͷ�ʱ���</div></td>
          </tr>
          </thead>
          <tbody id="dataTableBody">
          
          <c:forEach items="${page.dataList}" var="enterprise" varStatus="enterpriseStatus">
          <tr>
            <td height="18" bgcolor="#FFFFFF" class="STYLE2"><div align="center" class="STYLE2 STYLE1">${enterpriseStatus.count}</div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"  style="cursor:hand" onclick="window.opener.document.all.orgcode.value='${enterprise.orgcode}';window.close();">${enterprise.orgcode}</div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${enterprise.cnname}</div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${enterprise.regdate}</div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${enterprise.username}</div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1" style="cursor:hand" onmouseout="hiddenScale();" onmouseover="viewScale('${enterprise.orgcode}');">��ϸ</div></td>
          </tr>
          </c:forEach>
          
          </tbody>
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
            <td width="25%" height="29" nowrap="nowrap"><span class="STYLE1">��3����¼����ǰ��1/1ҳ��ÿҳ3����¼</span></td>
            <td width="75%" valign="top" class="STYLE1"><div align="right">
              <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="../images/firstPageDisabled.gif" /></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="../images/prevPageDisabled.gif"  /></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="../images/nextPageDisabled.gif" /></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="../images/lastPageDisabled.gif" /></div></td>
                  <td width="59" height="22" valign="middle"><div align="right" class="STYLE2 STYLE1">ת����</div></td>
                  <td width="25" height="22" valign="middle"><span class="STYLE7">
                    <input name="textfield" type="text" class="STYLE1" style="height:20px; width:25px;text-align:right" size="5" />
                  </span></td>
                  <td width="23" height="22" valign="middle" class="STYLE2 STYLE1">ҳ</td>
                  <td width="30" height="22" valign="middle"><img src="../images/go.gif" width="37" height="15" /></td>
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