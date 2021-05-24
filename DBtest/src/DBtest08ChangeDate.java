import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

////////////////////////////////////////////////////////////////////////
//#free wifi(2) / 2021. 05. 24. / 2125341020안규원
//실습4) 설치년월 Date로 바꿔 정제
////////////////////////////////////////////////////////////////////////

public class DBtest08ChangeDate {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement();
	     
	     stmt.execute("update freewifi2 set inst_date='1970-1-1';");
	     stmt.execute( "alter table freewifi2 change inst_date inst_date date;");
	     //
	     //"update freewifi2 set inst_date='1970-1-1';"
	     
	     stmt.close(); 
	     conn.close(); 
	}
}
