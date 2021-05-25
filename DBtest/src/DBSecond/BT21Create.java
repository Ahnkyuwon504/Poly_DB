package DBSecond;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

////////////////////////////////////////////////////////////////////////
// # Basic Training(2) / 2021. 05. 25. / 2125341020안규원
// 실습 1) table 생성 - 학번(P-KEY), 이름, 국어, 영어, 수학
////////////////////////////////////////////////////////////////////////
public class BT21Create {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 드라이버에 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 다이렉트로 꽂는다...
		Statement stmt = conn.createStatement();
		// stmt에 String 넣어서 실행시킬 거다...
		stmt.execute(" create table goodjob (studentid varchar(20), name varchar(20), "
				+ "kor int, eng int, mat int, \r\n" + "constraint goodjob_PK primary key(studentid));");
		// 테이블 만들기...
		stmt.close(); // 끝났으면 닫아 주자..
		conn.close(); // 끝났으면 닫아 주자..
	}
}
