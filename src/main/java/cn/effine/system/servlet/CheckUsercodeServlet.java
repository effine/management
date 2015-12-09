package cn.effine.system.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.effine.util.DBUtil;

/**
 * ��֤�û�������
 * @author Administrator
 *
 */
public class CheckUsercodeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String usercode = request.getParameter("usercode");
		boolean hasUser = false;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DBUtil.getConnection();
			String sql = "select * from t_user where usercode=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, usercode);
			rs = ps.executeQuery();
			hasUser = rs.next();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, rs);
		}
		
		response.setContentType("text/html;charset=GB18030");
		PrintWriter out = response.getWriter();
		
		if(hasUser){
			//�û��Ѿ�����
			out.print("<font color='red'>�û������Ѿ�����</font>");
		}else{
			//�û�������
			out.print("<font color='green'>�û��������ʹ��</font>");
		}
	}
	
}
