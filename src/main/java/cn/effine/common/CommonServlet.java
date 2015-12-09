package cn.effine.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * ���Ŀ����������еĿ�����Ӧ�ü̳�������Ŀ���������Ҫ��ȥ�̳�HttpServlet��
 * ����һ��ģ���ࡣ
 */
public abstract class CommonServlet extends HttpServlet {

	//ģ�巽��
	@Override
	protected final void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String funtype = request.getParameter("funtype");
		if("insert".equals(funtype)){
			doInsert(request,response);
		}else if("select".equals(funtype)){
			doSelect(request,response);
		}else if("update".equals(funtype)){
			doUpdate(request,response);
		}
	}
	
	//���ӷ���
	protected abstract void doInsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	protected abstract void doSelect(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	protected abstract void doUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
