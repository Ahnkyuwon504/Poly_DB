import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

////////////////////////////////////////////////////////////////////////
//#JDBC 기본 프로그램 / 2021. 05. 24. / 2125341020안규원
//기본 ResultSet 프로그램
////////////////////////////////////////////////////////////////////////
public class DBtest02 {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// jdbc 드라이버에 연결...
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 내 포트번호로 연결...
		Statement stmt = conn.createStatement();
		// stmt에 String을 때려 넣는다...
		ResultSet rset = stmt.executeQuery("show databases;");
		// stmt에서 String을 execute한 후, 그 결과를 rset으로 넣어준다...
		while (rset.next()) { // while문 이용해서 반복수행
			System.out.println("값 : " + rset.getString(1));
			// MySQL은 1부터 시작한다...
		}
		rset.close(); // 사용 끝났으면 닫아라...
		stmt.close(); // 사용 끝났으면 닫아라...
		conn.close(); // 사용 끝났으면 닫아라...
	}
}
