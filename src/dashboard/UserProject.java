/*
 * UserProject.java
 *
 * Created on April 26, 2007, 12:46 PM
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
 * @author ttamilvelan
 */
public class UserProject {
    static Logger logger    =   Logger.getLogger("UserProject");
    /** Creates a new instance of UserProject */
    public UserProject() {
    }
    public static ArrayList<String> getProject(String userId){
      
      ResultSet rs=null;
      Connection connection=null;
      PreparedStatement pt=null;
      ArrayList<String> project = new ArrayList<String>();
      
      try{
                connection         = MakeConnection.getConnection();
                String query = " select pname from project,userproject where project.pid=userproject.pid and project.status!='Finished' and userid=?";
                pt        = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                pt.setString(1,userId);
                rs=pt.executeQuery();
                rs.last();
                int i=rs.getRow();
 //               System.out.println("Total no of projects involved"+i);
                rs.beforeFirst();
                if(i>0)
                {
                    while(rs.next()){
                        project.add(rs.getString("pname"));
                    }
                }
                else
                {
                    project.add("Nil");
                }
      }
      catch(Exception e){
           logger.error(e.getMessage());
      }
      finally{
          try{
              rs.close();
              pt.close();
              connection.close();
          }
          catch(SQLException e){
              logger.error(e.getMessage());
          }
      }
      
      return project;
      
  }
    
}
