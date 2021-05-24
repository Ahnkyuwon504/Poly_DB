import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// 테이블 읽기

public class DBtest09 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	     Statement stmt = conn.createStatement();
	     
	     double lat = 37.3860521; double lng = 127.1214038;
	     
	     String QueryTxt;
	     QueryTxt = String.format("select * from freewifi4 where "
	     		+ "SQRT( POWER( latitue-%f,2) + POWER (longitude-%f,2) ) = "
	     		+ "(select MIN( SQRT( POWER( latitue-%f,2) + POWER (longitude-%f,2) ) ) from freewifi4);",
	    		 lat, lng, lat, lng);
//	     QueryTxt = "select * from freewifi;";
//	     QueryTxt = "select * from freewifi where service_provider='SKT';";
//	     QueryTxt = "select * from freewifi where inst_country='수원시';";
	      
	     ResultSet rset = stmt.executeQuery(QueryTxt);
	     int iCnt=0;
	     
	     while (rset.next()) {
	    	 System.out.printf("*(%d)*************************************\n");
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("설치장소명       : %s\n", rset.getString(1));
	    	 System.out.printf("*(%d)*************************************\n");
	      } 
	     rset.close(); 
	     stmt.close(); 
	     conn.close(); 


	}

}
