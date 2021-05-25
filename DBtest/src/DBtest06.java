import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

////////////////////////////////////////////////////////////////////////
//#examtable (4) / 2021. 05. 24. / 2125341020안규원
//테이블 읽기
////////////////////////////////////////////////////////////////////////
public class DBtest06 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 드라이버에 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 직통으로 꽂아준다...
		Statement stmt = conn.createStatement();
		// statement 실행할거다...
		ResultSet rset = stmt.executeQuery("select * from ;");
		// 결과를 rset에 담아준다...
		System.out.printf("  이름   학번   국어  영어  수학\n");
		// table name 먼저 출력..보기 쉽게...
		while (rset.next()) { // while문 이용한다...
			System.out.printf("%4s %6d   %3d   %3d   %3d \n", rset.getString(1), rset.getInt(2), rset.getInt(3),
					rset.getInt(4), rset.getInt(5));
			// 1부터 시작하는것 주의...
		}
		rset.close(); // 사용 끝났으면 닫아라...
		stmt.close(); // 사용 끝났으면 닫아라...
		conn.close(); // 사용 끝났으면 닫아라...

	}

}
