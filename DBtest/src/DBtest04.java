import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// #examtable (2) / 2021. 05. 24. / 2125341020안규원
// 테이블 지우기
////////////////////////////////////////////////////////////////////////
public class DBtest04 {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 드라이버에 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 내 포트번호로 직통 연결
		Statement stmt = conn.createStatement();
		// stmt에 String 넣을거다
		stmt.execute("drop table examtable2;");
		// examtable2 를 없애는 쿼리...
		stmt.close(); // 사용 끝났으면 닫아라... 
		conn.close(); // 사용 끝났으면 닫아라...
	}
}
