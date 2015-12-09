package cn.effine.basicinfo.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.effine.bean.Investor;
import cn.effine.util.DBUtil;

/**
 *  �鿴��ҵͶ������ϸ��Ϣ
 * @author Administrator
 */
public class SelectInvServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String invregnum = request.getParameter("invregnum");
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean hasInv = false;
		try{
			conn = DBUtil.getConnection();
			String sql = "select * from t_invest where invregnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, invregnum);
			rs = ps.executeQuery();
			
			if(rs.next()){
				
				hasInv = true;
				
				Investor inv = new Investor();
				inv.setUsercode(rs.getString("usercode"));
				inv.setOrgcode(rs.getString("orgcode"));
				inv.setInvregnum(rs.getString("invregnum"));
				inv.setRemark(rs.getString("remark"));
				inv.setRegdate(rs.getString("regdate"));
				inv.setInvname(rs.getString("invname"));
				inv.setEmail(rs.getString("email"));
				inv.setCty(rs.getString("cty"));
				inv.setContacttel(rs.getString("contacttel"));
				inv.setContactman(rs.getString("contactman"));
				
				request.setAttribute("investor", inv);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, rs);
		}
		
		if(hasInv){
			request.getRequestDispatcher("/basicinfo/exoticOrgView.jsp").forward(request, response);
		}
	}
	
}
