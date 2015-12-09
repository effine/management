package cn.effine.system.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.effine.bean.User;
import cn.effine.util.DBUtil;

/**
 * ��ѯ�û���Ϣ��Servlet����ת���û��޸�ҳ�棩
 * @author Administrator
 */
public class SelectUserServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		User user = null;
		
		//��ȡ�û�����
		String usercode = request.getParameter("controlUpdateAndDeleteCheckbox");
		
		//�������ݿ�
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DBUtil.getConnection();
			//����usercode��ѯ�û���Ϣ
			String sql = "select username,userpswd,orgtype from t_user where usercode=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, usercode);
			//���ز�ѯ�����
			rs = ps.executeQuery();
			//�������������������װ���û�����
			if(rs.next()){
				user = new User();
				user.setUsercode(usercode);
				user.setUsername(rs.getString("username"));
				user.setUserpswd(rs.getString("userpswd"));
				user.setOrgtype(rs.getString("orgtype"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, rs);
		}
		
		//���û�����洢��request������
		request.setAttribute("user", user);
		
		//ת��
		request.getRequestDispatcher("/system/userUpdate.jsp").forward(request, response);
	}
	
}
