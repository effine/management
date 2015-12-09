package cn.effine.basicinfo.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.effine.bean.Investor;
import cn.effine.bean.Page;
import cn.effine.util.DBUtil;
import cn.effine.util.StringUtil;

/**
 * ��ҳ��ѯ��ҵͶ������Ϣ����̬������ѯ��
 * @author Administrator
 */
public class PageQueryInvServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//request.setCharacterEncoding("GB18030");
		
		//��ȡ��ѯ����
		String invregnum = request.getParameter("invregnum");
		String invname = request.getParameter("invname");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		
		//������ҳ����
		Page<Investor> page = new Page<Investor>(request.getParameter("pageno"));
		
		//ƴ��ҵ��SQL���
		StringBuilder sql = new StringBuilder("select i.*,u.username from t_invest i join t_user u on i.usercode=u.usercode where 1=1");
		StringBuilder totalsizeSql = new StringBuilder("select count(*) as totalsize from t_invest i join t_user u on i.usercode=u.usercode where 1=1");
		
		List<String> paramList = new ArrayList<String>();
		
		if(StringUtil.isNotEmpty(invregnum)){
			sql.append(" and i.invregnum=? ");
			totalsizeSql.append(" and i.invregnum=? ");
			paramList.add(invregnum); //invregnum��List���ϵ��±�0������һ���ˡ�
		}
		
		if(StringUtil.isNotEmpty(invname)){
			sql.append(" and i.invname like ? ");
			totalsizeSql.append(" and i.invname like ? ");
			paramList.add("%" + invname + "%"); //invname��List���ϵ��±�0����1������һ���ˡ�
		}

		if(StringUtil.isNotEmpty(startdate)){
			sql.append(" and i.regdate>=? ");
			totalsizeSql.append(" and i.regdate>=? ");
			paramList.add(startdate); //startdate��List���ϵ��±�0����1����2������һ���ˡ�
		}

		if(StringUtil.isNotEmpty(enddate)){
			sql.append(" and i.regdate<=? ");
			totalsizeSql.append(" and i.regdate<=? ");
			paramList.add(enddate); //enddate��List���ϵ��±�0����1����2����3������һ���ˡ�
		}
		
		//�������ݿ��ѯ�����
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			conn = DBUtil.getConnection();
			ps = conn.prepareStatement(page.getSql(sql.toString()));
			
			//�� ? ��ֵ
			for(int i=0;i<paramList.size();i++){
				
				//JDBC�����е��±궼�Ǵ�1��ʼ�ġ�
				ps.setString(i+1, paramList.get(i));
				
			}
			
			//��ѯ���ؽ����
			rs = ps.executeQuery();
			
			//�����������װjava����
			while(rs.next()){
				
				Investor inv = new Investor();
				
				inv.setInvregnum(rs.getString("invregnum"));
				inv.setInvname(rs.getString("invname"));
				inv.setCty(rs.getString("cty"));
				inv.setEmail(rs.getString("email"));
				inv.setContactman(rs.getString("contactman"));
				inv.setContacttel(rs.getString("contacttel"));
				inv.setRegdate(rs.getString("regdate"));
				inv.setRemark(rs.getString("remark"));
				inv.setUsername(rs.getString("username"));
				inv.setOrgcode(rs.getString("orgcode"));
				
				//��java����洢��List������
				page.getDataList().add(inv);
			}
			
			//��ѯ�ܼ�¼����
			ps = conn.prepareStatement(totalsizeSql.toString());
			
			//��?��ֵ
			for(int i=0;i<paramList.size();i++){
				ps.setString(i+1, paramList.get(i));
			}
			
			rs = ps.executeQuery();
			if(rs.next()){
				page.setTotalsize(rs.getInt("totalsize"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, rs);
		}
		
		//��page����洢��request������
		request.setAttribute("page", page);
		
		//ת��ҳ��
		request.getRequestDispatcher(request.getParameter("funtype")).forward(request, response);
		
	}
	
}
