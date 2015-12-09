package cn.effine.fe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cn.effine.bean.EnInv;
import cn.effine.bean.Enterprise;
import cn.effine.bean.Page;
import cn.effine.bean.PageQueryEnCondition;
import cn.effine.util.DBUtil;
import cn.effine.util.StringUtil;

/**
 * ��ҵ���ݷ��ʶ���
 * @author Administrator
 */
public class EnterpriseDao {
	
	/**
	 * ������ҵ��Ϣ�Լ���ҵ��Ͷ���˵Ĺ�ϵ��Ϣ
	 * @param en ��ҵ��Ϣ
	 * @param enInvs ��ҵͶ���˵Ĺ�ϵ��Ϣ
	 * @return 1+enInvs.size() ���ʾ�ɹ�������ֵ��ʾʧ��
	 */
	public int insertEnterprise(Enterprise en,List<EnInv> enInvs){
		Connection conn = null;
		PreparedStatement ps = null;
		int count = 0;
		try{
			conn = DBUtil.getConnection();
			String sql = "insert into t_enterprise(orgcode,regno,cnname,enname,contactman,contacttel,regcap,outregcap,regcry,usercode,regdate) values(?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, en.getOrgcode());
			ps.setString(2, en.getRegno());
			ps.setString(3, en.getCnname());
			ps.setString(4, en.getEnname());
			ps.setString(5, en.getContactman());
			ps.setString(6, en.getContacttel());
			ps.setInt(7, Integer.parseInt(en.getRegcap()));
			ps.setInt(8, Integer.parseInt(en.getOutregcap()));
			ps.setString(9, en.getRegcry());
			ps.setString(10, en.getUsercode());
			ps.setString(11, en.getRegdate());
			count = ps.executeUpdate();
			sql = "insert into t_en_inv(orgcode,invregnum,regcap,scale) values(?,?,?,?)";
			ps = conn.prepareStatement(sql);
			for(int i=0;i<enInvs.size();i++){
				EnInv enInv = enInvs.get(i);
				ps.setString(1, enInv.getOrgcode());
				ps.setString(2, enInv.getInvregnum());
				ps.setInt(3, Integer.parseInt(enInv.getRegcap()));
				ps.setInt(4, Integer.parseInt(enInv.getScale()));
				count += ps.executeUpdate();
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, null);
		}
		return count;
	}
	
	
	/**
	 * ���ݲ�ѯ������ҳ��ѯ��ҵ��Ϣ
	 * @param condition ����
	 * @return ��ҳ����
 	 */
	public Page<Enterprise> pageQueryEnterprise(PageQueryEnCondition condition){
		
		Page<Enterprise> page = new Page<Enterprise>(condition.getPageno());
		
		//ҵ��SQL
		StringBuilder serviceSql = new StringBuilder("select e.orgcode,e.cnname,e.regdate,u.username from t_enterprise e join t_user u on e.usercode=u.usercode where 1=1");
		
		//�ܼ�¼������SQL
		StringBuilder totalsizeSql = new StringBuilder("select count(*) as totalsize from t_enterprise e join t_user u on e.usercode=u.usercode where 1=1");
		
		List<String> paramList = new ArrayList<String>();
		
		//��ҵ��SQL����������
		if(StringUtil.isNotEmpty(condition.getOrgcode())){
			serviceSql.append(" and e.orgcode=? ");
			totalsizeSql.append(" and e.orgcode=? ");
			paramList.add(condition.getOrgcode());
		}
		if(StringUtil.isNotEmpty(condition.getCnname())){
			serviceSql.append(" and e.cnname like ? ");
			totalsizeSql.append(" and e.cnname like ? ");
			paramList.add("%" + condition.getCnname() + "%");
		}
		if(StringUtil.isNotEmpty(condition.getStartdate())){
			serviceSql.append(" and e.regdate >= ? ");
			totalsizeSql.append(" and e.regdate >= ? ");
			paramList.add(condition.getStartdate());
		}
		if(StringUtil.isNotEmpty(condition.getEnddate())){
			serviceSql.append(" and e.regdate <= ? ");
			totalsizeSql.append(" and e.regdate <= ? ");
			paramList.add(condition.getEnddate());
		}
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			conn = DBUtil.getConnection();
			
			//��ȡ��ҳSQL���
			ps = conn.prepareStatement(page.getSql(serviceSql.toString()));
			
			//��?��ֵ
			for(int i=0;i<paramList.size();i++){
				ps.setString(i+1, paramList.get(i));
			}
			
			//ִ�в�ѯ���ؽ����
			rs = ps.executeQuery();
			while(rs.next()){
				Enterprise en = new Enterprise();
				en.setOrgcode(rs.getString("orgcode"));
				en.setCnname(rs.getString("cnname"));
				en.setRegdate(rs.getString("regdate"));
				en.setUsername(rs.getString("username"));
				page.getDataList().add(en);
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
		
		return page;
	}
	
	/**
	 * ͨ����֯���������ȡ��ҵ��Ϣ
	 * @param orgcode
	 * @return
	 */
	public Enterprise selectEnterpriseByOrgcode(String orgcode){
		Enterprise en = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DBUtil.getConnection();
			String sql = "select * from t_enterprise where orgcode=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, orgcode);
			rs = ps.executeQuery();
			if(rs.next()){
				en = new Enterprise();
				en.setCnname(rs.getString("cnname"));
				en.setRegcry(rs.getString("regcry"));
				en.setOrgcode(rs.getString("orgcode"));
				en.setRegcap(rs.getString("regcap"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, rs);
		}
		return en;
	}
}

