
/*
 * ����һ��javascript�࣬��������������ԣ�
 * 		1��form����input��ǩ��id
 * 		2��form����input��ǩǰ�ߵ�label
 */
FormItem = function(x,y){
	
	//id����
	this.id = x;
	
	//label����
	this.label = y;
	
}

//���ǿ��Խ���������൱�������࣬�ù������ṩһ������У��ǿգ����ṩһ������У���Ƿ�һ�¡�
EGOV = function(){
	
	//�ú�����ɷǿ�У��
	this.isNotEmpty = function(formItemArray){
		
		for(var i=0;i<formItemArray.length;i++){
			var id = formItemArray[i].id;
			var label = formItemArray[i].label;
			var domObj = document.getElementById(id);
			if(domObj.value == ""){
				alert(label + "����Ϊ�գ�����д");
				domObj.focus();
				return false;
			}
		}
		
		return true;
		
	}
	
	//�ú������һ����У��
	this.isSame = function(formItem1,formItem2){
		var id1 = formItem1.id;
		var label1 = formItem1.label;
		
		var id2 = formItem2.id;
		var label2 = formItem2.label;
		
		var domObj1 = document.getElementById(id1);
		var domObj2 = document.getElementById(id2);
		
		if(domObj1.value != domObj2.value){
			alert(label1 + "��" + label2 + "��һ�£���������д");
			domObj1.value = "";
			domObj2.value = "";
			domObj1.focus();
			return false;
		}
		
		return true;
	}
}

var $ = new EGOV();
