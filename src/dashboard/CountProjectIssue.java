/*
 * CountProjectIssue.java
 *
 * Created on January 25, 2008, 9:49 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package dashboard;
import java.sql.*;
import org.apache.log4j.Logger;
//import java.util.*;
import pack.eminent.encryption.MakeConnection;
/**
 *
 * @author Balaguru Ramasamy
 */
public class CountProjectIssue {
    static Logger logger = Logger.getLogger("MOMMaxIssues");
    /** Creates a new instance of CountProjectIssue */
    public CountProjectIssue() {
    }
    
    public static int getCount(String projectVersion,String phase,String projectType){  
    ResultSet rs = null;
    Connection conn = null;
    Statement stmt = null;
    int total = 0;
    
   
    
    
    int index = projectVersion.lastIndexOf(":");
    
    String project = projectVersion.substring(0,index);
    String version = projectVersion.substring((index+1));  
    projectType = "issue_"+projectType;
    
    try {
      conn         = MakeConnection.getConnection();
      String query = "select count(*) as total from issue i, issuestatus s, project p, "+projectType+" where i.pid = p.pid and pname = '"+project+"' and version = '"+version+"' and  i.issueid= "+projectType+".issueid and "+projectType+".phase = '"+phase+"' and i.issueid = s.issueid and s.status != 'Closed'";
      stmt        = conn.createStatement();
      
            rs           = stmt.executeQuery(query);
            
        
        if (rs.next()) {
                
                total = rs.getInt("total");
                
        } else {
                
                total = 0;
            
        }
    } catch (Exception e) {
      logger.error(e.getMessage());
    } finally {
    
      try {
        rs.close();
        stmt.close();
        conn.close();
      } catch (SQLException e) {
        logger.error(e.getMessage());
      }
    }
  //  System.out.println("total"+total);
    return total;
  } 
    
}
