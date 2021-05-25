import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// #examtable (1) / 2021. 05. 24. / 2125341020안규원
// 테이블 만들기
////////////////////////////////////////////////////////////////////////
public class DBtest03 {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// jdbc 드라이버로 연결...
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 내 포트번호 통해 직통으로...
		Statement stmt = conn.createStatement();
		// stmt 통해 execute 할거다...
		stmt.execute("create table examtable2(" + "name varchar(20)," + "studentid int not null primary key,"
				+ "kor int," + "eng int," + "mat int);");
		// 테이블 만들거다... 인자와 속성 정하는 것..
		stmt.close();  // 사용 끝났으면 닫아라...
		conn.close(); // 사용 끝났으면 닫아라...
	}
}
