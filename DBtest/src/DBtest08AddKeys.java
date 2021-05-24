import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

////////////////////////////////////////////////////////////////////////
//#free wifi(2) / 2021. 05. 24. / 2125341020안규원
//실습3) 복합 프라이머리 키 구성, 재실습
////////////////////////////////////////////////////////////////////////

public class DBtest08AddKeys {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement();
	     
	     stmt.execute(  "create table freewifi2(" +		// freewifi로 테이블 생성
	    		 	"inst_place varchar(50) NOT NULL, " +			// 설치장소명
	    		 	"inst_place_detail varchar(500) NOT NULL, " +		// 설치장소상세
	    		 	"inst_city varchar(500), " +				// 설치시도명
	    		 	"inst_country varchar(500), " +			// 설치시군구명
	    		 	"inst_place_flag varchar(500), " +		// 설치시설구분
	    		 	"service_provider varchar(500), " +		// 서비스제공사명
	    		 	"wifi_ssid varchar(500), " +				// 와이파이 SSID
	    		 	"inst_date varchar(500), " +				// 설치년월
	    		 	"place_addr_road varchar(500), " +		// 소재지도로명주소
	    		 	"place_addr_land varchar(500), " +		// 소재지지번주소
	    		 	"manage_office varchar(500), " +			// 관리기관명
	    		 	"manage_office_phone varchar(500), " +	// 관리기관전화번호
	    		 	"latitue double NOT NULL, " +					// 위도
	    		 	"longitude double NOT NULL, " +					// 경도
	    		 	"write_date date, " +
	    		 	"CONSTRAINT freewifi2_PK PRIMARY KEY(inst_place, inst_place_detail, " +
	    		 	"latitue, longitude));"					// 데이터기준일자
	    		 	);
	     
	     stmt.close(); 
	     conn.close(); 
	}
}
