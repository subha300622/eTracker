/*
 * Project.java
 *
 * Created on March 19, 2007, 5:00 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package dashboard;
import java.sql.*;
import java.util.*;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;
/**
 *
 * @author ganesh
 */
public class Project {
    static Logger logger=Logger.getLogger("Project");
    /** Creates a new instance of Project */
    public Project() {
    }
    
    public static ArrayList<String> getDetails(String projectVersion){
    
    int index=0;
    ResultSet rs = null;
    Connection conn = null;
    PreparedStatement pstmt = null;
    ArrayList<String> al = new ArrayList<String>();
    
    if(projectVersion != null){
    	index = projectVersion.lastIndexOf(":");
    }
    
    String project = projectVersion.substring(0,index);
    String version = projectVersion.substring((index+1));

       
    try {
      conn         = MakeConnection.getConnection();
      String query = "select pmanager,to_char(startdate,'dd-Mon-yy') as startingDate,to_char(enddate,'dd-Mon-yy') as endingDate,phase,status,customer from project where pname = ? and version = ?";
      pstmt        = conn.prepareStatement(query);
        
            pstmt.setString(1,project);
            pstmt.setString(2,version);
            
      
            rs           = pstmt.executeQuery();
            
        
        if (rs.next()) {
                
               al.add(rs.getString("pmanager"));
               al.add(rs.getString("phase"));
               al.add(rs.getString("startingDate"));
               al.add(rs.getString("endingDate"));
               al.add(rs.getString("status"));
               al.add(rs.getString("customer"));
                
        } else {
                
                al.add("Nil");
                al.add("Nil");
                al.add("Nil");
                al.add("Nil");
                al.add("Nil");
            
        }
    } catch (Exception e) {
      logger.error(e.getMessage());
    } finally {
    
      try {
        rs.close();
        pstmt.close();
        conn.close();
      } catch (SQLException e) {
        logger.error(e.getMessage());
      }
    }
    
    return al;
  } 
  
}
