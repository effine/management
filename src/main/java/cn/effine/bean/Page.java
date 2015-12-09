package cn.effine.bean;

import java.util.ArrayList;
import java.util.List;

import cn.effine.util.Const;

/**
 * ��ҳ���� ҳ�롢һҳ��ʾ�ļ�¼��������ҳ�����ܼ�¼�������洢���ݵļ���
 * 
 * @author Administrator
 */
public class Page<T> {
	
	/**
	 * ҳ��
	 */
	private Integer pageno;
	
	/**
	 * һҳ��ʾ�ļ�¼����
	 */
	private Integer pagesize = Const.PAGE_SIZE;
	
	/**
	 * �ܼ�¼����
	 */
	private Integer totalsize;
	
	/**
	 * ���ݼ���
	 */
	private List<T> dataList = new ArrayList<T>();
	

	public Page(String pageno) {
		super();
		if(pageno == null){
			this.pageno = 1;
			return;
		}
		this.pageno = Integer.parseInt(pageno);
	}

	public Integer getPageno() {
		return pageno;
	}

	public Integer getPagesize() {
		return pagesize;
	}

	public Integer getPagecount() {
		return totalsize%pagesize==0?totalsize/pagesize:totalsize/pagesize + 1;
	}

	public Integer getTotalsize() {
		return totalsize;
	}

	public void setTotalsize(Integer totalsize) {
		this.totalsize = totalsize;
	}

	public List<T> getDataList() {
		return dataList;
	}

	
	/**
	 * @param sql ҵ��SQL
	 * @return ��ҳSQL
	 */
	public String getSql(String sql) {
		return "select * from (select t.*,rownum as linenum from ("+sql+") t where rownum<=" + (pageno*pagesize) + ") where linenum>" + (pageno-1)*pagesize;
	}

}
