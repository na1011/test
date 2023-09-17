package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement prep;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String ID, String Pwd) {
		String sql = "SELECT user_password FROM user_db WHERE user_id = ?";
		try {
			prep = conn.prepareStatement(sql);
			prep.setString(1, ID);
			rs = prep.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(Pwd)) {
					return 1;
				} else {
					return 0;
				}
			}
			return -1;
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;
	}
	
	public int join(User user) {
		String sql = "INSERT INTO user_db VALUES(?, ?)";
		
		try {
			prep = conn.prepareStatement(sql);
			prep.setString(1, user.getUserID());
			prep.setString(2, user.getUserPWD());
			return prep.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
}
