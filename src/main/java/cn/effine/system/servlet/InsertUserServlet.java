package cn.effine.system.servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.effine.bean.User;
import cn.effine.system.service.UserService;
import cn.effine.util.Const;
import cn.effine.util.DateUtil;
import cn.effine.util.WebUtil;

/**
 * �����û���Ϣ��Servlet
 * @author Administrator
 */
public class InsertUserServlet extends HttpServlet {

	private UserService service = new UserService();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//��װ�û���ص�����
		User user = new User();
		WebUtil.makeRequestToObject(request, user);
		String regdate = DateUtil.format(new Date(), Const.DATE_FORMAT_ALL);
		user.setRegdate(regdate);
		
		//����service����ҵ��
		int count = service.saveUser(user);
		
		if(count==2){
			String errorMsg = "���û������Ѿ����ڣ���������д";
			request.setAttribute("errorMsg", errorMsg);
			request.getRequestDispatcher("/system/userAdd.jsp").forward(request, response);
		}else{
			if(count == 1){
				response.sendRedirect("/servlet/pageQueryUser?pageno=1");
			}
		}
	}
	
}
