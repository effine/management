package cn.effine.fe.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.effine.bean.Enterprise;
import cn.effine.fe.service.EnterpriseService;

/**
 * ��ѯ��ҵ��Ϣ
 * @author Administrator
 */
public class QueryEnterpriseServlet extends HttpServlet {

	private EnterpriseService service = new EnterpriseService();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//��ȡ��֯��������
		String orgcode = request.getParameter("orgcode");
		
		//����service
		Enterprise en = service.findEnterpriseByOrgcode(orgcode);
		
		//������洢��request������
		request.setAttribute("enterprise", en);
		
		//ת��
		request.getRequestDispatcher("/auth/openAccountAuthDetail.jsp").forward(request, response);
	}
	
}
