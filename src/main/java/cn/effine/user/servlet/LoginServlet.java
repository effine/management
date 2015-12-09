package cn.effine.user.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.effine.bean.User;
import cn.effine.util.DBUtil;

/**
 * ��¼ϵͳ
 * @author Administrator
 */
public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		boolean isSuccess = false;
		
		//��request�л�ȡ��¼��Ϣ
		String orgtype = request.getParameter("orgtype");
		String usercode = request.getParameter("usercode");
		String userpswd = request.getParameter("userpswd");
		
		//�������ݿ�
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DBUtil.getConnection();
			//ע��SQL����Ч�ʣ�����where�����������Ǹ����������ȹ��˵ġ��ܹ����˵�������¼�������������
			String sql = "select username,regdate from t_user where userpswd=? and orgtype=? and usercode=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userpswd);
			ps.setString(2,orgtype);
			ps.setString(3, usercode);
			
			//��ѯ�û���Ϣ���ز�ѯ�����
			rs = ps.executeQuery();
			
			//���������������ݣ����¼�ɹ�
			if(rs.next()){
				
				isSuccess = true;
				
				//����������װuser����
				User user = new User();
				user.setUsercode(usercode);
				user.setUserpswd(userpswd);
				user.setOrgtype(orgtype);
				user.setUsername(rs.getString("username"));
				user.setRegdate(rs.getString("regdate"));
				
				//���û�����洢��session��
				HttpSession session = request.getSession(true);
				session.setAttribute("user", user);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, rs);
		}
		
		//ת��
		if(isSuccess){
			response.sendRedirect("/main.html");
		}else{
			String msg = "�����֤ʧ�ܣ����µ�¼";
			request.setAttribute("errorMsg", msg);
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
	}
	
}
