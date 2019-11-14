package selfGuide.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import common.JDBCTemplate;
import selfGuide.model.vo.SelfGuideComment;

public class SelfGuideCommentDao {
	
	public int commentWrite(Connection conn, String comment, int selfNo, String memberId) {
		
		String query = "INSERT INTO SELF_GUIDE_COMMENT VALUES(?, ?, SYSDATE, ?)";
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberId);
			pstmt.setString(2, comment);
			pstmt.setInt(3, selfNo);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
}
