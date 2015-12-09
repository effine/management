package cn.effine.auth.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

import cn.effine.bean.Auth;
import cn.effine.util.DBUtil;

public class AuthDao {
	
	/**
	 * 
	 * @param authMap
	 * @return
	 */
	public int insertAuth(Map<String,String> authMap){
		int count = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try{
			conn = DBUtil.getConnection();
			String sql = "insert into t_auth(orgcode,remark,contactman,contacttel,filename,fileremark,authno,usercode,feedback) values(?,?,?,?,?,?,seqAuth.nextval,?,'0')";
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, authMap.get("orgcode"));
			ps.setString(2, authMap.get("remark"));
			ps.setString(3, authMap.get("contactman"));
			ps.setString(4, authMap.get("contacttel"));
			ps.setString(5, authMap.get("filename"));
			ps.setString(6, authMap.get("fileremark"));
			ps.setString(7, authMap.get("usercode"));
			
			count = ps.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps,null);
		}
		return count;
	}
	
	/**
	 * ��ѯ��׼��Ϣͨ�����
	 * @param authno
	 * @return
	 */
	public Auth selectAuthByAuthno(String authno){
		Auth auth = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DBUtil.getConnection();
			String sql = "select a.*,e.regdate,e.regcry,e.regcap from t_auth a join t_enterprise e on a.orgcode=e.orgcode where a.authno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, authno);
			rs = ps.executeQuery();
			if(rs.next()){
				auth = new Auth();
				auth.setAuthno(authno);
				auth.setContactman(rs.getString("contactman"));
				auth.setContacttel(rs.getString("contacttel"));
				auth.setFeedback(rs.getString("feedback"));
				auth.setFilename(rs.getString("filename"));
				auth.setFileremark(rs.getString("fileremark"));
				auth.setOrgcode(rs.getString("orgcode"));
				auth.setRemark(rs.getString("remark"));
				auth.setUsercode(rs.getString("usercode"));
				auth.setRegdate(rs.getString("regdate"));
				auth.setRegcap(rs.getString("regcap"));
				auth.setRegcry(rs.getString("regcry"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps,rs);
		}
		return auth;
	}
	
	/**
	 * ���º�׼
	 * @param authno
	 * @return
	 */
	public int updateAuth(String authno){
		int count = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try{
			conn = DBUtil.getConnection();
			String sql = "update t_auth set feedback='1' where authno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, authno);
			count = ps.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps,null);
		}
		return count;
	}
}
