package cn.effine.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * ���ڹ�����
 * @author Administrator
 */
public class DateUtil {
	
	
	/**
	 * ��ʽ�����ڣ�����������ת����ָ����ʽ���ַ�����
	 * @param time ����
	 * @param pattern ���ڸ�ʽ
	 * @return �ַ�������
	 */
	public static String format(Date time,String pattern){
		
		/*
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		String str = sdf.format(time);
		return str;
		*/
		
		return new SimpleDateFormat(pattern).format(time);
	}
}
