package cn.effine.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * JDBC�����ࣺ������JDBC�����࣬��װ���ǡ������Դ��롱��
 * @author Administrator
 */
public class DBUtil {
	
	
	/**
	 * ��ȡ���ݿ����Ӷ���
	 * @return ���ݿ����Ӷ���
	 */
	public static Connection getConnection() throws Exception{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.100:1521:bjpowernode","egov","bjpowernode");
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/wenju", "root", "aichuan");
		return conn;
	}
	
	/**
	 * �ͷ���Դ����С�����ͷţ��ֱ����쳣��
	 * @param conn ���Ӷ���
	 * @param ps ���ݿ��������
	 * @param rs �����
	 */
	public static void close(Connection conn,Statement ps,ResultSet rs){
		if(rs!=null){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(ps!=null){
			try {
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * ��������
	 * @param conn
	 * @throws SQLException
	 */
	public static void beginTransaction(Connection conn) throws SQLException{
		conn.setAutoCommit(false);
	}
	
	/**
	 * �ύ����
	 * @param conn
	 * @throws SQLException
	 */
	public static void commitTransaction(Connection conn) throws SQLException{
		conn.commit();
	}
	
	/**
	 * �ع�����
	 * @param conn
	 */
	public static void rollbackTransaction(Connection conn){
		try {
			conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * ��������
	 * @param conn
	 */
	public static void endTransaction(Connection conn){
		try {
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
