package DBStock;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
////////////////////////////////////////////////////////////////////////
// # Training / 2021. 05. 26. / 2125341020안규원
// 실습 1) table 지움
// 단축코드, 일자, 시가, 고가, 저가, 종가, 거래량, 거래대금
// 복합 P-KEY : 일자, 단축코드
////////////////////////////////////////////////////////////////////////
public class DBStockDeleteTable {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 드라이버에 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/stock", "root", "kopoctc");
		// 다이렉트로 꽂는다...
		Statement stmt = conn.createStatement();
		// stmt에 String 넣어서 실행시킬 거다...
		stmt.execute("drop table stockdailyprice;");
		// 테이블 지우기...
		stmt.close(); // 끝났으면 닫아 주자..
		conn.close(); // 끝났으면 닫아 주자..

	}

}
