
/*
 * 定义一个javascript类，该类包括两个属性：
 * 		1、form表单中input标签的id
 * 		2、form表单中input标签前边的label
 */
FormItem = function(x,y){
	
	//id属性
	this.id = x;
	
	//label属性
	this.label = y;
	
}

//我们可以将下面这个类当做工具类，该工具类提供一个方法校验非空，再提供一个方法校验是否一致。
EGOV = function(){
	
	//该函数完成非空校验
	this.isNotEmpty = function(formItemArray){
		
		for(var i=0;i<formItemArray.length;i++){
			var id = formItemArray[i].id;
			var label = formItemArray[i].label;
			var domObj = document.getElementById(id);
			if(domObj.value == ""){
				alert(label + "不能为空，请填写");
				domObj.focus();
				return false;
			}
		}
		
		return true;
		
	}
	
	//该函数完成一致性校验
	this.isSame = function(formItem1,formItem2){
		var id1 = formItem1.id;
		var label1 = formItem1.label;
		
		var id2 = formItem2.id;
		var label2 = formItem2.label;
		
		var domObj1 = document.getElementById(id1);
		var domObj2 = document.getElementById(id2);
		
		if(domObj1.value != domObj2.value){
			alert(label1 + "和" + label2 + "不一致，请重新填写");
			domObj1.value = "";
			domObj2.value = "";
			domObj1.focus();
			return false;
		}
		
		return true;
	}
}

var $ = new EGOV();
