import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//테이블 지우기
////////////////////////////////////////////////////////////////////////
//#examtable (2) / 2021. 05. 24. / 2125341020안규원
//테이블 지우기
////////////////////////////////////////////////////////////////////////
public class DBtest04 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement();
	     
	     stmt.execute( "drop table examtable2;");
	     
	     stmt.close(); 
	     conn.close(); 


	}

}
