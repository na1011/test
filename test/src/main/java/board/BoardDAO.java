package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {

	private Connection conn;
	private ResultSet rs;
	
	public BoardDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "project302";
			String dbPassword = "1234";
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String sql = "SELECT to_char(sysdate, 'yyyy-mm-dd') FROM dual";
		
		try {
			PreparedStatement prep = conn.prepareStatement(sql);
			rs = prep.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {	// 새 게시물의 번호 (내림차순 정렬한 id의 +1번 부여)
		String sql = "SELECT id FROM board WHERE rownum <= 5 ORDER BY id DESC";
		
		try {
			PreparedStatement prep = conn.prepareStatement(sql);
			rs = prep.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String title, String userID, String content) {
		String sql = "INSERT INTO board VALUES(?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement prep = conn.prepareStatement(sql);
			prep.setInt(1, getNext());
			prep.setString(2, title);
			prep.setString(3, userID);
			prep.setString(4, getDate());
			prep.setString(5, content);
			prep.setInt(6, 1);
			return prep.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Board> getList(int pageNum) {
		ArrayList<Board> list = new ArrayList<>();
		String sql = "SELECT * FROM board WHERE id < ? AND able = 1 AND rownum <= 10 ORDER BY id DESC";
		
		try {
			PreparedStatement prep = conn.prepareStatement(sql);
			prep.setInt(1, getNext() - (pageNum-1)*10);
			rs = prep.executeQuery();
			while (rs.next()) {
				Board board = new Board();
				board.setId(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setDatetime(rs.getString(4));
				board.setContent(rs.getString(5));
				board.setAble(rs.getInt(6));
				list.add(board);
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public boolean nextPage(int pageNum) {
		String sql = "SELECT * FROM board WHERE id < ? AND able = 1";
		try {
			PreparedStatement prep = conn.prepareStatement(sql);
			prep.setInt(1, getNext() - (pageNum-1)*10);
			rs = prep.executeQuery();
			
			if(rs.next()) {
				return true;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
}
