import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// freewifi(1) 와이파이 테이블 만들기

public class DBtest07 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement();
	     
	     stmt.execute(    "create table freewifi(" +		// freewifi로 테이블 생성
	    		 	"inst_place varchar(50), " +			// 설치장소명
	    		 	"inst_place_detail varchar(50), " +		// 설치장소상세
	    		 	"inst_city varchar(50), " +				// 설치시도명
	    		 	"inst_country varchar(50), " +			// 설치시군구명
	    		 	"inst_place_flag varchar(50), " +		// 설치시설구분
	    		 	"service_provider varchar(50), " +		// 서비스제공사명
	    		 	"wifi_ssid varchar(50), " +				// 와이파이 SSID
	    		 	"inst_date varchar(50), " +				// 설치년월
	    		 	"place_addr_road varchar(200), " +		// 소재지도로명주소
	    		 	"place_addr_land varchar(200), " +		// 소재지지번주소
	    		 	"manage_office varchar(50), " +			// 관리기관명
	    		 	"manage_office_phone varchar(50), " +	// 관리기관전화번호
	    		 	"latitue double, " +					// 위도
	    		 	"longitude double, " +					// 경도
	    		 	"write_date date );"					// 데이터기준일자
	    		 	);
	     
	     stmt.close(); 
	     conn.close(); 
	}
}
