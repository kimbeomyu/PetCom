package selfGuide.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import common.JDBCTemplate;
import selfGuide.model.dao.SelfGuideDao;
import selfGuide.model.vo.SelfGuide;

public class SelfGuideService {
	
	public int insertSelfGuide(SelfGuide guideOne) {
		
		Connection conn = JDBCTemplate.getConnection();
		int result = new SelfGuideDao().insertSelfGuide(conn, guideOne);
		
		// 데이터베이스에 변경사항 적용
		if(result>0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		
		return result;
	}
	
	public int selfGuideListCount() {
		Connection conn = JDBCTemplate.getConnection();
		int total = new SelfGuideDao().selfGuideListCount(conn);
		JDBCTemplate.close(conn);
		return total;
	}
	
	public ArrayList<SelfGuide> selectMoreGuide(int start, int len) {
		
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<SelfGuide> guideList = new SelfGuideDao().selectMoreGuide(conn, start, len);
		JDBCTemplate.close(conn);
		return guideList;
	}
}
