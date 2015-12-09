package cn.effine.util;

import java.util.ResourceBundle;

/**
 * �ַ�����������
 * @author Administrator
 */
public class StringUtil {
	
	
	private static final String lString = "cn.effine.resource.Message_CN";
	
	private static ResourceBundle bundle = ResourceBundle.getBundle(lString);
	
	
	/**
	 * ͨ��key��ȡ����Դ��value
	 * @param code ����Դ��key
	 * @return ����Դ��value
	 */
	public static String getTextByCode(String code){
		return bundle.getString(code);
	}
	
	public static String getTextByCode(String str,String code){
		return bundle.getString(str + code);
	}
	
	/**
	 * �ж��ַ����Ƿ�Ϊ��
	 * @param str �ַ���
	 * @return true��ʾ���ǿ��ַ�����false��ʾ���ַ�����
	 */
	public static boolean isNotEmpty(String str){
		return (str!=null && str.trim().length()!=0);
	}
}
