package cn.effine.fe.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.effine.bean.Enterprise;
import cn.effine.bean.Page;
import cn.effine.bean.PageQueryEnCondition;
import cn.effine.fe.service.EnterpriseService;
import cn.effine.util.WebUtil;

/**
 * ��ҳ��ѯ��ҵ��Ϣ��Servlet
 * @author Administrator
 */
public class PageQueryEnterpriseServlet extends HttpServlet {

	private EnterpriseService service = new EnterpriseService();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//��ȡ��ѯ����
		PageQueryEnCondition condition = new PageQueryEnCondition();
		WebUtil.makeRequestToObject(request, condition);
		
		//����service��ɷ��ط�ҳ����
		Page<Enterprise> pageObj = service.pageQueryEnterprise(condition);
		
		//����ҳ����洢��request������
		request.setAttribute("page", pageObj);
		
		//ת������ҳ��ѯҳ��
		request.getRequestDispatcher("/auth/orgcodeSelect.jsp").forward(request, response);
		
	}
	
}
