package cn.effine.fe.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.effine.bean.EnInv;
import cn.effine.bean.Enterprise;
import cn.effine.bean.User;
import cn.effine.fe.service.EnterpriseService;
import cn.effine.util.Const;
import cn.effine.util.DateUtil;
import cn.effine.util.WebUtil;

/**
 * ������ҵ��Ϣ�Լ���ҵ��Ͷ���˵Ĺ�ϵ��Ϣ
 * @author Administrator
 */
public class InsertEnterpriseServlet extends HttpServlet {

	private EnterpriseService service = new EnterpriseService();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//��ȡ��ҵ��Ϣ
		Enterprise en = new Enterprise();
		WebUtil.makeRequestToObject(request, en);
		
		//�����˱��
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String usercode = user.getUsercode();
		en.setUsercode(usercode);
		
		//�Ǽ�����
		String regdate = DateUtil.format(new Date(), Const.DATE_FORMAT_YMD);
		en.setRegdate(regdate);
		
		//��ȡ��ҵͶ���˵Ĺ�ϵ��Ϣ(������������ĳ�������ȵ�)
		String[] invregnums = request.getParameterValues("invregnum"); //Ͷ���˵ĵǼǱ�ţ������
		String[] regcaps = request.getParameterValues("regcapItem"); //ע���ʱ����ʶ�����
		String[] scales = request.getParameterValues("scale"); //�����������������
		
		List<EnInv> enInvs = new ArrayList<EnInv>();
		for(int i=0;i<invregnums.length;i++){
			EnInv enInv = new EnInv();
			enInv.setOrgcode(en.getOrgcode());
			enInv.setInvregnum(invregnums[i]);
			enInv.setRegcap(regcaps[i]);
			enInv.setScale(scales[i]);
			enInvs.add(enInv);
		}
		
		//����service��ɱ���
		boolean isSuccess = service.saveEnterprise(en, enInvs);
		
		//����ɹ��ض���
		if(isSuccess){
			response.sendRedirect("/foreignExchange/newInputOrg.jsp");
		}
		
	}
	
}
