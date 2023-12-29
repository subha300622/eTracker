/*
 * CountIssue.java
 *
 * Created on February 3, 2007, 8:19 PM
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
 * @author Balaguru Ramasamy
 */
public class CountIssue {
    
    static Logger logger=Logger.getLogger("Count Issue");
    
  public static int getCount(String projectVersion,String status,String priority){  
    ResultSet rs = null;
    Connection conn = null;
    PreparedStatement pstmt = null;
    int total = 0;
    int index = projectVersion.lastIndexOf(":");
    
    String project = projectVersion.substring(0,index);
    String version = projectVersion.substring((index+1));  
    
    logger.info("Status"+status);
    if(status.equalsIgnoreCase("Customizing Req")){
        status  =   "Customizing Request";
    }
    if(status.equalsIgnoreCase("Workbench Req")){
        status  =   "Workbench Request";
    }
    
    logger.info("Priority"+priority);
    try {
      conn         = MakeConnection.getConnection();
      String query = "select count(*) as total, priority from issue i, issuestatus s, project p where i.pid = p.pid and pname = ? and version = ? and priority = ? and i.issueid = s.issueid and s.status = ? group by priority order by priority";
      pstmt        = conn.prepareStatement(query);
        
            pstmt.setString(1,project);
            pstmt.setString(2,version);
            pstmt.setString(3,priority);
            pstmt.setString(4,status);
      
            rs           = pstmt.executeQuery();
            
        
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
        pstmt.close();
        conn.close();
      } catch (SQLException e) {
        logger.error(e.getMessage());
      }
    }
    logger.info("Total Issues::::"+total);
    return total;
  } 
  
  
  public static ArrayList<String> getAllProject(){  
    ResultSet rs = null;
    Connection conn = null;
    Statement stmt = null;
//    int numberOfRows = 0;
    ArrayList<String> al = new ArrayList<String>();
    try {
      conn         = MakeConnection.getConnection();
      String query = "select distinct version,pname as project from project where status != 'Finished' order by upper(project) asc, version asc";
      stmt        = conn.createStatement();
        
           rs           = stmt.executeQuery(query);
        
        if (rs.next()) {
                do{
                    
                    
                    al.add(rs.getString("project")+":"+rs.getString("version"));
                    
                }while(rs.next());
        
        }else{
//               System.out.println("There is no project");
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
    
    return al;
    }
  public static ArrayList<String> getAllSAPProject(){  
    ResultSet rs = null;
    Connection conn = null;
    Statement stmt = null;
//    int numberOfRows = 0;
    ArrayList<String> al = new ArrayList<String>();
    try {
      conn         = MakeConnection.getConnection();
      String query = "select distinct version,pname as project from project where status != 'Finished' and category='SAP Project' order by upper(project) asc, version asc";
      stmt        = conn.createStatement();
        
           rs           = stmt.executeQuery(query);
        
        if (rs.next()) {
                do{
                    
                    
                    al.add(rs.getString("project")+":"+rs.getString("version"));
                    
                }while(rs.next());
        
        }else{
//               System.out.println("There is no project");
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
    
    return al;
    }
  
  public static ArrayList<String> getProjectForUser(int userId){  
    ResultSet rs = null;
    Connection conn = null;
    Statement stmt = null;
//    int numberOfRows = 0;
    ArrayList<String> al = new ArrayList<String>();
    try {
      conn         = MakeConnection.getConnection();
//edit by mukesh query only
      String query = "select distinct version, pname as project from project p, userproject up where p.pid = up.pid and up.userid = "+userId+" and status in('Work in progress','To be started') and pmanager!=104  order by upper(project) asc,version asc";
      stmt        = conn.createStatement();

      rs           = stmt.executeQuery(query);
        
        if (rs.next()) {
                do{
                    
                    
                    al.add(rs.getString("project")+":"+rs.getString("version"));
                    
                }while(rs.next());
        
        }else{
 //              System.out.println("There is no project");
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
    
    return al;
    }
  public static ArrayList<String> getSAPProjectForUser(int userId){  
    ResultSet rs = null;
    Connection conn = null;
    Statement stmt = null;
//    int numberOfRows = 0;
    ArrayList<String> al = new ArrayList<String>();
    try {
      conn         = MakeConnection.getConnection();
      String query = "select distinct version, pname as project from project p, userproject up where p.pid = up.pid and up.userid = "+userId+" and status != 'Finished' and category='SAP Project' order by upper(project) asc,version asc";
      stmt        = conn.createStatement();

           rs           = stmt.executeQuery(query);
        
        if (rs.next()) {
                do{
                    
                    
                    al.add(rs.getString("project")+":"+rs.getString("version"));
                    
                }while(rs.next());
        
        }else{
 //              System.out.println("There is no project");
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
    
    return al;
    }
  
  
  
   public static ArrayList<String> getSpecificUsers(String userId){  
    ResultSet rs = null;
    Connection conn = null;
    Statement stmt = null;
    
    ArrayList<String> al = new ArrayList<String>();
    try {
      conn         = MakeConnection.getConnection();
      String query = "select userid, firstname, lastname from users where userid in ("+
                     "select distinct userid from userproject where pid in  (select up.pid from userproject up,"+
                     "project p where userid = '"+ userId +"' and p.pid = up.pid and "+
                     "status != 'Finished')) and roleid >0 order by "+
                     "upper(firstname) asc, upper(lastname) asc";
      stmt         = conn.createStatement();
        
           rs      = stmt.executeQuery(query);
        
        if (rs.next()) {
                do{
                    
                    al.add(rs.getString("userid"));
                    al.add(rs.getString("firstname")+" "+rs.getString("lastname"));
                    
                }while(rs.next());
        
        }else{
//               System.out.println("There is no user");
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
    
    return al;
    } 
   
   
   public static ArrayList<String> getAllUsers(){  
    ResultSet rs = null;
    Connection conn = null;
    Statement stmt = null;
    
    ArrayList<String> al = new ArrayList<String>();
    try {
      conn         = MakeConnection.getConnection();
      String query = "select userid,firstname,lastname from users  where roleid>0 order by upper(firstname) asc, upper(lastname) asc";
      stmt        = conn.createStatement();
        
           rs           = stmt.executeQuery(query);
        
        if (rs.next()) {
                do{
                    
                    al.add(rs.getString("userid"));
                    al.add(rs.getString("firstname")+" "+rs.getString("lastname"));
                    
                }while(rs.next());
        
        }else{
 //              System.out.println("There is no user");
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
    
    return al;
    } 
   
    public static int getCountForUser(String userId,String currentUser,String status,String priority){
    ResultSet rs = null;
    Connection conn = null;
    PreparedStatement pstmt = null;
    int total = 0;
    String query = "";
    if (status.equalsIgnoreCase("Customizing Req")) {
        status = "Customizing Request";
    }
    if (status.equalsIgnoreCase("Performance QA")) {
        status = "Performance Testing";
    }
   
    
    
    
    
    
    try {
      conn         = MakeConnection.getConnection();
            if(Integer.parseInt(currentUser)==104){
            query = "select count(*) as total,issue.priority from issue,issuestatus where issue.assignedto = ? and issue.priority = ? and issue.issueid=issuestatus.issueid and issuestatus.status = ? group by issue.priority order by issue.priority";
            pstmt        = conn.prepareStatement(query); 
            pstmt.setString(1,userId);
            pstmt.setString(2,priority);
            pstmt.setString(3,status);
      }else{
          query = "select count(*) as total,issue.priority from issue,issuestatus where issue.assignedto = ? and  pid in (select pid from userproject where userid=? intersect select pid from userproject where userid=?) and issue.priority = ? and issue.issueid=issuestatus.issueid and issuestatus.status = ? group by issue.priority order by issue.priority";
          pstmt        = conn.prepareStatement(query);
        
            pstmt.setString(1,userId);
            pstmt.setString(2,userId);
            pstmt.setString(3,currentUser);
            pstmt.setString(4,priority);
            pstmt.setString(5,status);
      }
     
      
            rs           = pstmt.executeQuery();
            
        
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
        pstmt.close();
        conn.close();
      } catch (SQLException e) {
        logger.error(e.getMessage());
      }
    }
    
    return total;
  } 
   
    public static ArrayList<String> getCurrentUser(String name){
        
        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        ArrayList<String> al = new ArrayList<String>();
        
            try{
            
                        conn         = MakeConnection.getConnection();
		
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs   =stmt.executeQuery("SELECT USERID,FIRSTNAME,LASTNAME FROM USERS WHERE EMAIL='"+name+ "' ");
                        
                        if(rs.next()){
                            
                                String fName = rs.getString("firstname");
				String lName = rs.getString("lastname");
				
				Integer userId      = rs.getInt("userid");
				al.add(userId.toString());
                                al.add(fName);
                                al.add(lName);
                            
                        }
			
                        
		}catch (Exception e) {
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
    
    return al;
    }
}
