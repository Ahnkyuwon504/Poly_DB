import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// 테이블 이름 출력

public class DBtest02 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement(); 
	     ResultSet rset = stmt.executeQuery("show databases;");
	     
	     while (rset.next()) {
	    	 System.out.println("값 : " + rset.getString(1));
	      } 
	     rset.close(); 
	     stmt.close(); 
	     conn.close(); 


	}

}
