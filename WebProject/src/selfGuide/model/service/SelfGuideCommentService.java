package selfGuide.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import common.JDBCTemplate;
import selfGuide.model.dao.SelfGuideCommentDao;
import selfGuide.model.vo.SelfGuideComment;

public class SelfGuideCommentService {

	public SelfGuideComment commentWrite(String comment, int selfNo, String memberId) {
		
		Connection conn = JDBCTemplate.getConnection();
		int result = new SelfGuideCommentDao().commentWrite(conn, comment, selfNo, memberId);
		SelfGuideComment commentOne = new SelfGuideCommentDao().selectCommentList(conn, comment, selfNo, memberId);
		if(result>0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);	
		return commentOne;
	}
	
	public SelfGuideComment selectCommentList(int selfNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		SelfGuideComment commentList = new SelfGuideComment();
		commentList.setComment(new SelfGuideCommentDao().selectCommentList(conn, selfNo));
		JDBCTemplate.close(conn);
		return commentList;
	}
	
	
}
