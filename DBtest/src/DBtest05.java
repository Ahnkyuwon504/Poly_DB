import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//테이블에 레코드 집어넣기
////////////////////////////////////////////////////////////////////////
//#examtable (3) / 2021. 05. 24. / 2125341020안규원
//테이블 레코드 집어넣기
////////////////////////////////////////////////////////////////////////
public class DBtest05 {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// jdbc 드라이버 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 직통으로 꽂는다
		Statement stmt = conn.createStatement();
		// 쿼리 실행할거다..
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('효민', 209901, 95, 100, 95);");
		// 효민에 대한 레코드 삽입...
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('보람', 209902, 90, 100, 90);");
		// 보람에 대한 레코드 삽입...
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('은정', 209903, 95, 80, 95);");
		// 은정에 대한 레코드 삽입...
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('지연', 209904, 95, 100, 95);");
		// 지연에 대한 레코드 삽입...
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('소연', 209905, 95, 100, 95);");
		// 소연에 대한 레코드 삽입...
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('큐리', 209906, 95, 100, 95);");
		// 큐리에 대한 레코드 삽입...
		stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) values ('화영', 209907, 95, 100, 95);");
		// 화영에 대한 레코드 삽입...
		stmt.close(); // 사용 끝났으면 닫아라... 
		conn.close(); // 사용 끝났으면 닫아라...
	}
}
