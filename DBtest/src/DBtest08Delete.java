import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

////////////////////////////////////////////////////////////////////////
//#free wifi(1) / 2021. 05. 24. / 2125341020안규원
//테이블 지우기
////////////////////////////////////////////////////////////////////////
public class DBtest08Delete {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// jdbc 드라이버로 연결...
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 내 포트번호 입력하여 다이렉트로 꽂아준다..
		Statement stmt = conn.createStatement();
		// stmt에 문장을 꽂을 거다...
		stmt.execute("drop table freewifi5final;");
		// 이 문장을 execute할 거다...
		stmt.close(); // 사용 끝났으면 닫아라..
		conn.close(); // 사용 끝났으면 닫아라...
	}
}
