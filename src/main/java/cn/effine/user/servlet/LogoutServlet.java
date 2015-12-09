package cn.effine.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * �˳�ϵͳ
 * @author Administrator
 *
 */
public class LogoutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		
		if(session!=null){
			session.invalidate();
		}
		
		//ע��·����ͨ���ԡ�
		response.sendRedirect("/");
	}
	
}
