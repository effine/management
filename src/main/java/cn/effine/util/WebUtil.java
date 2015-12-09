package cn.effine.util;

import java.lang.reflect.Method;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

public class WebUtil {
	
	/**
	 * ����������е������������õ�Object������
	 * Ҫʹ�ø÷�����ǰ���ǣ��ύ�������еġ�name�������javabean��������һ�¡�
	 * 
	 * ���³�����ڵ�ȱ�ݣ�
	 * 		ȱ��һ��setter�����Ĳ���ֻ����String����
	 * 		ȱ�ݶ���javabean�����Զ����ַ������ͣ����Ҳ�֧�ֽ���checkbox
	 * @param request
	 * @param obj
	 */
	public static void makeRequestToObject(HttpServletRequest request,Object obj){
		
			Class c = obj.getClass();
			
			//��ȡrequest�������û��ύ���������ݵ�name
			Enumeration<String> parameterNames = request.getParameterNames();
			
			//�������еĲ��������֣�����ÿһ�����������ֶ���javabean��������һ�¡�
			while(parameterNames.hasMoreElements()){
				String propertyName = parameterNames.nextElement(); 
				String methodName = "set" + propertyName.toUpperCase().charAt(0) + propertyName.substring(1);
				try {
					Method setMethod = c.getDeclaredMethod(methodName,String.class);
					setMethod.invoke(obj, request.getParameter(propertyName));
				} catch (Exception e) {
					//e.printStackTrace();
				} 
			}
		
	}
}

/**
 * /servlet/register?username=admin&userpswd=123&interest=sport&interest=music&interest=food 
 * request����ײ����Map��ʽ�洢����
 * 		key���洢�����û�����������͵������еġ�name��
 * 		value:�洢�����û�����������͵������еġ�value��������value�����ж��������Map���ϵ�value�洢���ǡ�String[]���ַ���һά����
 */
