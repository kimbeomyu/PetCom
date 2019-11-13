package selfGuide.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.JDBCTemplate;
import selfGuide.model.vo.SelfGuide;

public class SelfGuideDao {
	
	public int insertSelfGuide(Connection conn, SelfGuide guideOne) {
		
		String query = "INSERT INTO SELF_GUIDE VALUES(DEFAULT, ?, ?, DEFAULT, DEFAULT, SEQ_SELF_NO.NEXTVAL, ?, ?, ?)";
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, guideOne.getWriterId());
			pstmt.setString(2, guideOne.getSelfContent());
			pstmt.setString(3, guideOne.getSelfTitle());
			pstmt.setString(4, guideOne.getPhotoOriginalFilename());
			pstmt.setString(5, guideOne.getPhotoRenameFilename());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	public int selfGuideListCount(Connection conn) {
		
		String query = "SELECT COUNT(*) AS TOTAL FROM SELF_GUIDE";
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int total = 0;
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			rset.next();
			total = rset.getInt("TOTAL");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return total;
		
	}

	public ArrayList<SelfGuide> selectMoreGuide(Connection conn, int start, int len) {
		
		ArrayList<SelfGuide> guideList = new ArrayList<SelfGuide>();
		String query = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY SELF_DATE DESC) AS RNUM, SELF_GUIDE.* FROM SELF_GUIDE) WHERE RNUM BETWEEN ? AND ?";
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, start);
			pstmt.setInt(2, len);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				SelfGuide guideOne = new SelfGuide();
				guideOne.setSelfDate(rset.getDate("SELF_DATE"));
				guideOne.setWriterId(rset.getString("WRITER_ID"));
				guideOne.setSelfContent(rset.getString("SELF_CONTENT"));
				guideOne.setSelfViews(rset.getInt("SELF_VIEWS"));
				guideOne.setSelfLike(rset.getInt("SELF_LIKE"));
				guideOne.setSelfNo(rset.getInt("SELF_NO"));
				guideOne.setPhotoOriginalFilename(rset.getString("PHOTO_ORIGINAL_FILENAME"));
				guideOne.setPhotoRenameFilename(rset.getString("PHOTO_RENAME_FILENAME"));
				guideList.add(guideOne);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return guideList;
	}
}
