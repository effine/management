package cn.effine.basicinfo.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.effine.bean.Investor;
import cn.effine.bean.User;
import cn.effine.util.Const;
import cn.effine.util.DBUtil;
import cn.effine.util.DateUtil;
import cn.effine.util.WebUtil;

/**
 * ������ҵͶ������Ϣ
 * @author Administrator
 *
 */
public class InsertInvServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//�����ˣ�
		//request.setCharacterEncoding("GB18030");
		
		//��ȡ��ҵͶ������Ϣ
		//��ǰ��Ŀ�Ĺ�������ˣ����ڵ�ȱ���ǣ���������������ظ��Դ��룬�����ǹ����Դ����ظ�������ҵ���߼������ظ���
		//������ҵ���߼�������ظ����ǲ��ܼ򵥵�ʹ��������DBUtil�����Ĺ����ദ��DBUtil�������װ���ظ��ԵĹ����Դ��롣
		//ҵ���߼������ظ����ص㣺��һ���ִ�������ͬ�ģ���һ���ִ���;����ҵ���߼�������أ��Ǳ仯��.
		//Ϊ�˽��ҵ���߼���������࣬����Ҳ�����ṩ��Ӧ�Ĺ�����ﵽ������ظ�����������������б���ͨ����java���Եķ�����ơ��ﵽ����ĸ��á�
		Investor inv = new Investor();
		WebUtil.makeRequestToObject(request, inv);
		
		//��session�����л�ȡ�û����루�����ˣ���
		HttpSession session = request.getSession(false);
		User user = (User)session.getAttribute("user");
		String usercode   = user.getUsercode();
		inv.setUsercode(usercode);
		
		//�Ǽ�����(��ҵͶ������Ϣ�ı���ʱ�䣬�������ʱ��û��Ҫ��ȷ��ʱ����)
		String regdate    = DateUtil.format(new Date(), Const.DATE_FORMAT_YMD);
		inv.setRegdate(regdate);
		
		//�������ݿ�
		int count = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try{
			conn = DBUtil.getConnection();
			String sql = "insert into t_invest(invregnum,invname,cty,orgcode,contactman,contacttel,email,remark,usercode,regdate) values(seqInv.nextval,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, inv.getInvname() );
			ps.setString(2, inv.getCty()     );
			ps.setString(3, inv.getOrgcode()   );
			ps.setString(4, inv.getContactman());
			ps.setString(5, inv.getContacttel());
			ps.setString(6, inv.getEmail()     );
			ps.setString(7, inv.getRemark()    );
			ps.setString(8, inv.getUsercode()  );
			ps.setString(9, inv.getRegdate()   );
			
			//ִ��insert��䣬����ִ�н��
			count = ps.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, null);
		}
		
		//�ض���
		if(count==1){
			response.sendRedirect("/basicinfo/exoticOrgList.jsp");
		}
	}
	
}
