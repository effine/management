package cn.effine.fe.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.effine.util.DBUtil;

/**
 * ��ѯ��ҵ��Ϣ�Ƿ��Ѿ�¼��
 * @author Administrator
 */
public class SelectEnterpriseServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		boolean hasEnterprise = false;
		String orgcode = request.getParameter("orgcode");
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			conn = DBUtil.getConnection();
			String sql = "select * from t_enterprise where orgcode=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, orgcode);
			rs = ps.executeQuery();
			hasEnterprise = rs.next();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, rs);
		}
		
		if(hasEnterprise){
			String msg = "����ҵ����Ϣ�Ѿ�¼��";
			request.setAttribute("errorMsg", msg);
			request.getRequestDispatcher("/foreignExchange/newInputOrg.jsp").forward(request, response);
		}else{
			request.getRequestDispatcher("/foreignExchange/inputOrgInfo.jsp").forward(request, response);
		}
	}
	
}
