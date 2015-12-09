package cn.effine.fe.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;

import cn.effine.util.DBUtil;

/**
 * �鿴Ͷ�ʱ���
 * @author Administrator
 */
public class ViewScaleServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//ʹ��jfreechart�����������̬���ɱ���ͼ��
		//���ҽ�����ͼ��Ӧ��������ͻ��ˡ�
		
		//������Ӧ���������ͣ����� "text/html;charset=GB1803"
		response.setContentType("image/jpeg");
		
		//׼�����ݼ�
		DefaultPieDataset dataset = new DefaultPieDataset();
		
		//�������ݿ⣬ͨ����֯���������ȡͶ���˵���Ϣ��Ͷ���˵����֡�Ͷ�ʵ��ʽ�
		String orgcode = request.getParameter("orgcode");
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DBUtil.getConnection();
			String sql = "select i.invname,ei.regcap from t_invest i join t_en_inv ei on i.invregnum=ei.invregnum where ei.orgcode=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, orgcode);
			rs = ps.executeQuery();
			while(rs.next()){
				dataset.setValue(rs.getString("invname"),rs.getInt("regcap"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtil.close(conn, ps, rs);
		}
		
		//����ͼ��
		JFreeChart chart = ChartFactory.createPieChart("Ͷ�ʱ���ͼ",
				dataset,
				true,
				false,
				false
		);
		
		//��ͼ����Ӧ��������ϡ�
		ChartUtilities.writeChartAsJPEG(response.getOutputStream(),1.0f,chart,400,300,null);
	}
	
}

