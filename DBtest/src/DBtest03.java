import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// 테이블 만들기

public class DBtest03 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement();
	     
	     stmt.execute( "create table examtable2(" +
	    		 		"name varchar(20)," +
	    		 		"studentid int not null primary key," +
	    		 		"kor int," +
	    		 		"eng int," +
	    		 		"mat int);");
	     
	     stmt.close(); 
	     conn.close(); 


	}

}
