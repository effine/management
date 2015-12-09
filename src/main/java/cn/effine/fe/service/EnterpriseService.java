package cn.effine.fe.service;

import java.util.List;

import cn.effine.bean.EnInv;
import cn.effine.bean.Enterprise;
import cn.effine.bean.Page;
import cn.effine.bean.PageQueryEnCondition;
import cn.effine.fe.dao.EnterpriseDao;

/**
 * ��ҵ����
 * @author Administrator
 *
 */
public class EnterpriseService {
	
	private EnterpriseDao dao = new EnterpriseDao();
	
	
	/**
	 * ������ҵ��Ϣ���Լ���ҵ��Ͷ���˵Ĺ�ϵ��Ϣ
	 * @param en ��ҵ��Ϣ
	 * @param enInvs ��ҵ��Ͷ���˵Ĺ�ϵ��Ϣ
	 * @return true��ʾ����ɹ�������false��ʾ����ʧ��
	 */
	public boolean saveEnterprise(Enterprise en,List<EnInv> enInvs){
		return dao.insertEnterprise(en, enInvs) == 1 + enInvs.size();
	}
	
	/**
	 * ���ݲ�ѯ������ѯ��ҵ��Ϣ
	 * @param condition ��ѯ����
	 * @return ��ҳ����
	 */
	public Page<Enterprise> pageQueryEnterprise(PageQueryEnCondition condition){
		return dao.pageQueryEnterprise(condition);
	}
	
	/**
	 * ͨ����ҵ��֯���������ȡ��ҵ��Ϣ
	 * @param orgcode ��֯��������
	 * @return ��ҵ����
	 */
	public Enterprise findEnterpriseByOrgcode(String orgcode){
		return dao.selectEnterpriseByOrgcode(orgcode);
	}
}
