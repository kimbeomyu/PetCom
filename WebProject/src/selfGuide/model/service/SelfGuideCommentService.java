package selfGuide.model.service;

import java.sql.Connection;

import common.JDBCTemplate;
import selfGuide.model.dao.SelfGuideCommentDao;

public class SelfGuideCommentService {

	public int commentWrite(String comment, int selfNo, String memberId) {
		
		Connection conn = JDBCTemplate.getConnection();
		int result = new SelfGuideCommentDao().commentWrite(conn, comment, selfNo, memberId);
		if(result>0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);	
		return result;
	}
	
	
}
