package cn.effine.system.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.effine.util.DBUtil;

/**
 * �޸��û���Ϣ
 * @author Administrator
 */
public class UpdateUserServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		/*
		 * �����ˣ����Ǻ�ҵ���߼�û���κι�ϵ�Ĵ��룬��ÿһ��Servlet��
		 * �󲿷ֶ�����Ҫ��д������ģ�����û�еõ��ظ�ʹ�ã������������ǡ�
		 */
		//request.setCharacterEncoding("GB18030");
		
		int count = 0;
		
		//��request�л�ȡ�û���Ϣ
		String usercode = request.getParameter("usercode");
		String username = request.getParameter("username");
		String userpswd = request.getParameter("userpswd");
		String orgtype = request.getParameter("orgtype");
		
		//�������ݿ�ִ��update����������
		Connection conn = null;
		PreparedStatement ps = null;
		
		try{
			conn = DBUtil.getConnection();
			String sql = "update t_user set username=?,userpswd=?,orgtype=? where usercode=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, userpswd);
			ps.setString(3, orgtype);
			ps.setString(4, usercode);
			
			//����ִ�н��
			count = ps.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, null);
		}
		
		//���³ɹ��ض���ȥ��ҳ��ѯ�û���Ϣ
		if(count == 1){
			response.sendRedirect("/servlet/pageQueryUser?pageno=" + request.getParameter("pageno"));
		}
	}
	
}
