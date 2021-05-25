package DBSecond;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// 테이블 만들기
////////////////////////////////////////////////////////////////////////
// # Basic Training(1) / 2021. 05. 25. / 2125341020안규원
// 실습 1) table 지움
////////////////////////////////////////////////////////////////////////
public class BT11Delete {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 드라이버에 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 다이렉트로 꽂는다...
		Statement stmt = conn.createStatement();
		// stmt에 String 넣어서 실행시킬 거다...
		stmt.execute("drop table parking;");
		// 테이블 지우기...
		stmt.close(); // 끝났으면 닫아 주자..
		conn.close(); // 끝났으면 닫아 주자..
	}
}
