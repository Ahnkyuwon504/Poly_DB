import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// # freewifi (3) / 2021. 05. 24. / 2125341020안규원
// 2. 전부 보기
////////////////////////////////////////////////////////////////////////
public class DBtest09 {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 드라이버에 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 다이렉트로 꽂아준다... 
		Statement stmt = conn.createStatement();
		// stmt에 String 넣어서 실행시킬 거다..
		double lat = 37.3860521; // 내 위도
		double lng = 127.1214038; // 내 경도

		String QueryTxt; // 실행시킬 String을 담아줄 Query
//		QueryTxt = String.format( // format 해야 편하게 쓴다...
//				"select * from freewifi6 where " + "SQRT( POWER( latitude-%f,2) + POWER (longitude-%f,2) ) = "
//				// select가 두번 등장한다..
//				// 두번째 나온 select는 MIN을 뽑아주는 select이고, 첫번째 select는 그 MIN에 대해 모든 column을 뽑는 것
//						+ "(select MIN( SQRT( POWER( latitude-%f,2) + POWER (longitude-%f,2) ) ) from freewifi6);",
//				// 조건 헷갈리지 말자...
//				lat, lng, lat, lng);
	     QueryTxt = "select * from freewifi8;";
//	     QueryTxt = "select * from freewifi6 where service_provider='SKT';";
//	     QueryTxt = "select * from freewifi6 where inst_country='수원시';";
		ResultSet rset = stmt.executeQuery(QueryTxt);
		// 결과에 담아주고...
		int iCnt = 1;
		// 몇 행인지 세어줄 iCnt...
		while (rset.next()) { // while문 이용해서 반복문 수행
			System.out.printf("*(%d)***************************************************************\n", iCnt++);
			// 항목 별 구분해줄 줄
			System.out.printf("설치장소명         : %s\n", rset.getString(1));
			// 설치장소명... DB는 0이 아닌 1부터 시작한다...
			System.out.printf("설치장소상세       : %s\n", rset.getString(2));
			// 설치장소 상세...
			System.out.printf("설치시도명         : %s\n", rset.getString(3));
			// 설치시도명...
			System.out.printf("설치시군구명       : %s\n", rset.getString(4));
			// 설치시군구명...
			System.out.printf("설치시설구분       : %s\n", rset.getString(5));
			// 설치시설 구분...
			System.out.printf("서비스제공사명     : %s\n", rset.getString(6));
			// 서비스제공사명 ...
			System.out.printf("와이파이SSID       : %s\n", rset.getString(7));
			// 와이파이 SSID...
			System.out.printf("설치년월           : %s\n", rset.getString(8));
			// 설치년월...
			System.out.printf("소재지도로명주소   : %s\n", rset.getString(9));
			// 소재지도로명주소...
			System.out.printf("소재지지번주소     : %s\n", rset.getString(10));
			// 소재지지번주소
			System.out.printf("관리기관명         : %s\n", rset.getString(11));
			// 관리기관명
			System.out.printf("관리기관전화번호   : %s\n", rset.getString(12));
			// 관리기관전화번호...
			System.out.printf("위도               : %s\n", rset.getString(13));
			// 위도 출력...
			System.out.printf("경도               : %s\n", rset.getString(14));
			// 경도 출력...
			System.out.printf("데이터기준일자     : %s\n", rset.getString(15));
			// 데이터 기준일자...
			System.out.printf("**********************************************************************\n");
		}
		rset.close(); // 종료했으면 닫아 준다...
		stmt.close(); // 종료했으면 닫아 준다...
		conn.close(); // 종료했으면 닫아 준다...
	}
}
