package DBSecond;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// 테이블 만들기
////////////////////////////////////////////////////////////////////////
// # Basic Training(1) / 2021. 05. 25. / 2125341020안규원
// 실습 1) table 생성
////////////////////////////////////////////////////////////////////////
public class BT11Create {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 드라이버에 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 다이렉트로 꽂는다...
		Statement stmt = conn.createStatement();
		// stmt에 String 넣어서 실행시킬 거다...
		stmt.execute(" create table parking ("
				+ "number int NOT NULL, name varchar(500), longitude double, latitude double, division varchar(500), "
				+ "type varchar(500), location varchar(500), roadlocation varchar(500), size int, "
				+ "openday varchar(500), "
				+ "CONSTRAINT parking_PK PRIMARY KEY(number));");
		// table 만들기..
		stmt.close(); // 끝났으면 닫아 주자..
		conn.close(); // 끝났으면 닫아 주자..
	}
}

//"create table freewifi2(" +		// freewifi로 테이블 생성
//	"inst_place varchar(500), " +			// 설치장소명
//	"inst_place_detail varchar(500), " +		// 설치장소상세
//	"inst_city varchar(500), " +				// 설치시도명
//	"inst_country varchar(500), " +			// 설치시군구명
//	"inst_place_flag varchar(500), " +		// 설치시설구분
//	"service_provider varchar(500), " +		// 서비스제공사명
//	"wifi_ssid varchar(500), " +				// 와이파이 SSID
//	"inst_date varchar(500), " +				// 설치년월
//	"place_addr_road varchar(200), " +		// 소재지도로명주소
//	"place_addr_land varchar(200), " +		// 소재지지번주소
//	"manage_office varchar(500), " +			// 관리기관명
//	"manage_office_phone varchar(500), " +	// 관리기관전화번호
//	"latitue double, " +					// 위도
//	"longitude double, " +					// 경도
//	"write_date date);" 					// 데이터기준일자

// CONSTRAINT freewifi2_PK PRIMARY KEY(inst_place, inst_place_detail, " + "latitue, longitude)
						

