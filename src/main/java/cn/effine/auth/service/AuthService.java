package cn.effine.auth.service;

import java.util.Map;

import cn.effine.auth.dao.AuthDao;
import cn.effine.bean.Auth;

public class AuthService {
	
	private AuthDao dao = new AuthDao();
	
	
	/**
	 * �����׼
	 * @param authMap ��׼��Ϣ
	 * @return true��ʾ����ɹ�
	 */
	public boolean saveAuth(Map<String,String> authMap){
		return dao.insertAuth(authMap) == 1;
	}
	
	/**
	 * ͨ����׼����Ų�ѯ��׼��Ϣ
	 * @param authno
	 * @return
	 */
	public Auth findAuthByAuthno(String authno){
		return dao.selectAuthByAuthno(authno);
	}
	
	/**
	 * ������׼
	 * @param authno
	 * @return
	 */
	public boolean feedbackAuth(String authno){
		return dao.updateAuth(authno) == 1;
	}
	
}
