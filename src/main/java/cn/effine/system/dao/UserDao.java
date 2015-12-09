package cn.effine.system.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cn.effine.bean.User;
import cn.effine.util.DBUtil;

/**
 * �û�  ���ݷ��ʶ���
 * @author Administrator
 */
public class UserDao {
	
	/**
	 * ͨ���û������ѯ�û���Ϣ
	 * @param usercode �û�����
	 * @return �û���Ϣ������û���Ϣ�������򷵻�null
	 */
	public User selectUserByUsercode(String usercode){
		User user = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DBUtil.getConnection();
			String sql = "select * from t_user where usercode=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, usercode);
			rs = ps.executeQuery();
			if(rs.next()){
				user = new User();
				user.setUsercode(usercode);
				user.setUsername(rs.getString("username"));
				user.setUserpswd(rs.getString("userpswd"));
				user.setRegdate(rs.getString("regdate"));
				user.setOrgtype(rs.getString("orgtype"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, rs);
		}
		return user;
	}
	
	/**
	 * �����ݿ��в����û���Ϣ
	 * @param user �û���Ϣ
	 * @return 1��ʾ�ɹ�������ֵ��ʾʧ��
	 */
	public int insertUser(User user){
		int count = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try{
			conn = DBUtil.getConnection();
			String sql = "insert into t_user(usercode,username,userpswd,orgtype,regdate) values(?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUsercode());
			ps.setString(2, user.getUsername());
			ps.setString(3, user.getUserpswd());
			ps.setString(4, user.getOrgtype());
			ps.setString(5, user.getRegdate());
			count = ps.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, null);
		}
		return count;
	}
}
