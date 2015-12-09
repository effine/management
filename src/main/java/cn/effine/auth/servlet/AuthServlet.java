package cn.effine.auth.servlet;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.effine.auth.service.AuthService;
import cn.effine.bean.Auth;
import cn.effine.bean.User;
import cn.effine.common.CommonServlet;

public class AuthServlet extends CommonServlet {

	private AuthService service = new AuthService();

	protected void doInsert(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String filepath = null;
		boolean saveFileSuccess = true;
		Map<String, String> authMap = new HashMap<String, String>();

		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1024 * 4);
		factory.setRepository(new File(this.getServletContext().getRealPath(
				"/temp")));

		ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
		try {
			List<FileItem> fileItems = servletFileUpload.parseRequest(request);

			// ��ȡ��֯��������
			String orgcode = null;
			for (FileItem fileItem : fileItems) {
				if (fileItem.isFormField()
						&& "orgcode".equals(fileItem.getFieldName())) {
					orgcode = fileItem.getString();
					break;
				}
			}

			for (FileItem fileItem : fileItems) {
				if (fileItem.isFormField()) {
					// ��ͨform��Ԫ��
					String fieldName = fileItem.getFieldName();
					String fieldValue = fileItem.getString("GB18030"); // ��ȡvalue��ʱ�����������⡣
					authMap.put(fieldName, fieldValue);
				} else {
					// �ļ�
					String filename = fileItem.getName();
					filename = orgcode
							+ filename.substring(filename.lastIndexOf("."));
					authMap.put("filename", filename);
					filepath = this.getServletContext().getRealPath(
							"/upload/" + filename);
					fileItem.write(new File(filepath));
				}
			}
		} catch (Exception e) {
			saveFileSuccess = false;
			e.printStackTrace();
		}

		// ��������ļ��ɹ�����ִ��insert��䱣������
		if (saveFileSuccess) {

			// ��session�л�ȡusercode
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("user");
			String usercode = user.getUsercode();
			authMap.put("usercode", usercode);

			boolean saveAuthSuccess = service.saveAuth(authMap);

			if (saveAuthSuccess) {
				// �������ݳɹ�����ת��inputOrg.jspҳ��
				response.sendRedirect("/auth/inputOrg.jsp");
			} else {
				// ��������ʧ�ܣ�ɾ��ԭ���ϴ����ļ�
				if (filepath != null) {
					File deletedFile = new File(filepath);
					deletedFile.delete();
				}
			}
		}
	}

	protected void doSelect(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// ��ȡ��׼�����
		String authno = request.getParameter("authno");

		// ����service���غ�׼����
		Auth auth = service.findAuthByAuthno(authno);

		// ����׼����洢��request������
		request.setAttribute("auth", auth);

		// ת��
		request.getRequestDispatcher("/authresponse/authResponseView.jsp")
				.forward(request, response);
	}

	protected void doUpdate(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String authno = request.getParameter("authno");

		boolean isSuccess = service.feedbackAuth(authno);

		if (isSuccess) {
			response.sendRedirect("/authresponse/authResponseList.jsp");
		}
	}

}
