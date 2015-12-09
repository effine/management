package cn.effine.system.service;

import cn.effine.bean.User;
import cn.effine.system.dao.UserDao;

/**
 * �û�ҵ���
 * @author Administrator
 *
 */
public class UserService {

	private UserDao dao = new UserDao();
	
	
	/**
	 * �����û���Ϣ
	 * @param user �û���Ϣ
	 * @return 1��ʾ�ɹ���2��ʾʧ�ܣ��û������Ѿ����ڶ����µ�ʧ�ܣ���0��ʾʧ�ܣ��������ݿ��ʱ��ʧ�ܣ�
	 */
	public int saveUser(User user){
		
		//��ѯ�û��Ƿ��Ѿ�����
		User u = dao.selectUserByUsercode(user.getUsercode());
		
		//�û������Ѿ�����
		if(u!=null){
			return 2;
		}
		
		return dao.insertUser(user);
	}
}
