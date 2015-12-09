package cn.effine.system.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.effine.bean.Page;
import cn.effine.bean.User;
import cn.effine.util.DBUtil;

/**
 * ��ҳ��ѯ�û���Ϣ�������ҳ
 * @author Administrator
 *
 */
public class PageQueryUserServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//������ҳ����
		Page<User> page = new Page<User>(request.getParameter("pageno"));
		
		
		//�������ݿ�ִ�з�ҳSQL���
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DBUtil.getConnection();
			
			//��ѯ���ݿ��ȡ�ܼ�¼����
			String sql = "select count(*) as totalsize from t_user";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				page.setTotalsize(rs.getInt("totalsize"));
			}
			
			String querySql = page.getSql("select usercode,username,userpswd,orgtype,regdate from t_user order by regdate desc");
			ps = conn.prepareStatement(querySql);
			
			//���ز�ѯ�����
			rs = ps.executeQuery();
			
			//���������������java���󣬴洢��List������
			while(rs.next()){
				User user = new User();
				user.setUsercode(rs.getString("usercode"));
				user.setUsername(rs.getString("username"));
				user.setUserpswd(rs.getString("userpswd"));
				user.setOrgtype(rs.getString("orgtype"));
				user.setRegdate(rs.getString("regdate"));
				
				page.getDataList().add(user);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, rs);
		}
			
		//��List���ϴ洢��request������
		request.setAttribute("page", page);
		
		//ת��
		request.getRequestDispatcher("/system/user.jsp").forward(request, response);
	}
	
}
