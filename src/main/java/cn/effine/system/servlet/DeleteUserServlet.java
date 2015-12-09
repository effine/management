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
 * ɾ������û���Ϣ
 * @author Administrator
 *
 */
public class DeleteUserServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//��ʹ��������
		/*
		int count = 0;
		String[] usercodes = request.getParameterValues("controlUpdateAndDeleteCheckbox");
		Connection conn = null;
		PreparedStatement ps = null;
		try{
			conn = DBUtil.getConnection();
			String sql = "delete from t_user where usercode=?";
			ps = conn.prepareStatement(sql);
			for(String usercode:usercodes){
				ps.setString(1, usercode);
				count += ps.executeUpdate();
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, null);
		}
		
		if(count == usercodes.length){
			response.sendRedirect("/servlet/pageQueryUser?pageno=1");
		}
		*/
		
		//ʹ��������
		boolean isSuccess = true;
		String[] usercodes = request.getParameterValues("controlUpdateAndDeleteCheckbox");
		Connection conn = null;
		PreparedStatement ps = null;
		try{
			conn = DBUtil.getConnection();
			
			//��������
			DBUtil.beginTransaction(conn);
			
			String sql = "delete from t_user where usercode=?";
			ps = conn.prepareStatement(sql);
			for(String usercode:usercodes){
				ps.setString(1, usercode);
				ps.addBatch();
			}
			ps.executeBatch();
			
			//�ύ����
			DBUtil.commitTransaction(conn);
			
		}catch(Exception e){
			isSuccess = false;
			
			//�ع�����
			DBUtil.rollbackTransaction(conn);
			
			e.printStackTrace();
		}finally{
			
			//��������
			DBUtil.endTransaction(conn);
			
			DBUtil.close(conn, ps, null);
		}
		
		if(isSuccess){
			response.sendRedirect("/servlet/pageQueryUser?pageno=1");
		}
	}
	
}
