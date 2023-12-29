/*
 * MaxIssue.java
 *
 * Created on February 5, 2007, 5:08 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package dashboard;
import java.util.*;
import java.sql.*;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;
/**
 *
 * @author ganesh
 */
public class MaxIssue {
      static Logger logger=Logger.getLogger("Max Issue");
    /** Creates a new instance of MaxIssue */
    public MaxIssue() {
    }
    
    
    public static HashMap<String,Integer> getIssueCount(String projectVersion){
        
    TreeSet<Integer> ts        = new TreeSet<Integer>();
    HashMap<String,Integer> hm = new HashMap<String,Integer>();
    
 //   int issueMaxCount   = 0;

    
    ResultSet rs = null;
    Connection conn = null;
    PreparedStatement pstmt = null;

    ArrayList<Integer> al = new ArrayList<Integer>();
    
    
    int index = projectVersion.lastIndexOf(":");
    
    String project = projectVersion.substring(0,index);
    String version = projectVersion.substring((index+1));  
    
    try {
      conn         = MakeConnection.getConnection();
      String query = "select count(*) as total, s.status from issue i, issuestatus s, project p where pname = ? and version = ? and i.pid = p.pid and i.issueid = s.issueid group by s.status order by total";
      pstmt        = conn.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
      
            pstmt.setString(1,project);
            pstmt.setString(2,version);
        
      rs           = pstmt.executeQuery();
      
      String status = null;
      int totalRows = 0;
        
        if (rs.next()) {
          
          rs.last();
          totalRows = rs.getRow();
          
          
          rs.beforeFirst();
          boolean flag = false;
          int rowForClosed = 0;
          
          
          for(int row = 1; row <= totalRows; row++){
              
                    rs.next();
                    
                    status = rs.getString("status");
                    if(status != null){
                        
                        if(status.equalsIgnoreCase("Closed")){
                        
                            flag = true;
                            rowForClosed = row;
                            hm.put("closed",rs.getInt("total"));
                        
                        }
                    }
                    
                    
             
              
          }
          if(flag == false){
              
              hm.put("closed",0);
              
          }
          
          rs.beforeFirst();
          for(int row = 1; row <= totalRows; row++){
              
              rs.next();
              
              if(row != rowForClosed){
                  
                  al.add(rs.getInt("total"));
                  
              }
              
          }
          
          int altogether = 0;
          for(int x:al){
              
              ts.add(x);
              altogether = altogether + x;
              
          }
           hm.put("altogether",altogether);   
           
           int maximum = 0;
           
           for(int x : ts){
               
               maximum = x;
               
           }
           
           hm.put("maximum",maximum);
          
          
          
        }else{
          
          hm.put("closed",0);
          hm.put("maximum",0);
          hm.put("altogether",0);
          
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
       
       return hm;
    }
    
    public static HashMap<String,Integer> getProjectIssueCount(String projectId){

    TreeSet<Integer> ts        = new TreeSet<Integer>();
    HashMap<String,Integer> hm = new HashMap<String,Integer>();

 //   int issueMaxCount   = 0;


    ResultSet rs = null;
    Connection conn = null;
    PreparedStatement pstmt = null;

    ArrayList<Integer> al = new ArrayList<Integer>();



    try {
      conn         = MakeConnection.getConnection();
      String query = "select count(*) as total, s.status from issue i, issuestatus s, project p where p.pid = ? and i.pid = p.pid and i.issueid = s.issueid group by s.status order by total";
      pstmt        = conn.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

            pstmt.setString(1,projectId);


      rs           = pstmt.executeQuery();

      String status = null;
      int totalRows = 0;

        if (rs.next()) {

          rs.last();
          totalRows = rs.getRow();


          rs.beforeFirst();
          boolean flag = false;
          int rowForClosed = 0;


          for(int row = 1; row <= totalRows; row++){

                    rs.next();

                    status = rs.getString("status");
                    if(status != null){

                        if(status.equalsIgnoreCase("Closed")){

                            flag = true;
                            rowForClosed = row;
                            hm.put("closed",rs.getInt("total"));

                        }
                    }




          }
          if(flag == false){

              hm.put("closed",0);

          }

          rs.beforeFirst();
          for(int row = 1; row <= totalRows; row++){

              rs.next();

              if(row != rowForClosed){

                  al.add(rs.getInt("total"));

              }

          }

          int altogether = 0;
          for(int x:al){

              ts.add(x);
              altogether = altogether + x;

          }
           hm.put("altogether",altogether);

           int maximum = 0;

           for(int x : ts){

               maximum = x;

           }

           hm.put("maximum",maximum);



        }else{

          hm.put("closed",0);
          hm.put("maximum",0);
          hm.put("altogether",0);

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

       return hm;
    }

     public static HashMap<String,Integer> getIssueCountForUser(String userId,String currentUser){
        
    TreeSet<Integer> ts        = new TreeSet<Integer>();
    HashMap<String,Integer> hm = new HashMap<String,Integer>();
    
//    int issueMaxCount   = 0;

    String query = "";
    ResultSet rs = null;
    Connection conn = null;
    PreparedStatement pstmt = null;

    ArrayList<Integer> al = new ArrayList<Integer>();
    
    
    
    
    try {
      conn         = MakeConnection.getConnection();
     
      if(Integer.parseInt(currentUser)==104){
        query = "select count(*) as total,issuestatus.status from issue,issuestatus where issue.assignedto = ? and issue.issueid = issuestatus.issueid group by issuestatus.status order by total";
        pstmt        = conn.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY); 
        pstmt.setString(1,userId);
      }else{
         query = "select count(*) as total,issuestatus.status from issue,issuestatus where issue.assignedto = ? and issue.issueid = issuestatus.issueid and pid in (select pid from userproject where userid=? intersect select pid from userproject where userid=?) group by issuestatus.status order by total";
        pstmt        = conn.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
      
            pstmt.setString(1,userId);
            pstmt.setString(2,userId);
            pstmt.setString(3,currentUser);
      }
      logger.info("Query::"+query);
       
            
        
      rs           = pstmt.executeQuery();
      
      String status = null;
      int totalRows = 0;
        
        if (rs.next()) {
          
          rs.last();
          totalRows = rs.getRow();
          
          
          rs.beforeFirst();
          boolean flag = false;
          int rowForClosed = 0;
          
          
          for(int row = 1; row <= totalRows; row++){
              
                    rs.next();
                    
                    status = rs.getString("status");
                    if(status.equalsIgnoreCase("Closed")){
                        
                       flag = true;
                       rowForClosed = row;
                       hm.put("closed",rs.getInt("total"));
                        
                    }
                    
                    
             
              
          }
          if(flag == false){
              
              hm.put("closed",0);
              
          }
          
          rs.beforeFirst();
          for(int row = 1; row <= totalRows; row++){
              
              rs.next();
              
              if(row != rowForClosed){
                  
                  al.add(rs.getInt("total"));
                  
              }
              
          }
          
          int altogether = 0;
          for(int x:al){
              
              ts.add(x);
              altogether = altogether + x;
              
          }
           hm.put("altogether",altogether);   
           
           int maximum = 0;
           
           for(int x : ts){
               
               maximum = x;
               
           }
           
           hm.put("maximum",maximum);
          
          
          
        }else{
          
          hm.put("closed",0);
          hm.put("maximum",0);
          hm.put("altogether",0);
          
        }
          
        
       
    } catch (Exception e) {
      logger.error(e.getMessage());
    } finally { 
    
      try {
          
                rs.close();
          
      } catch (SQLException e) {
        logger.error(e.getMessage());
      }
      try {
      
                pstmt.close();
          
      
        
      } catch (SQLException e) {
        logger.error(e.getMessage());
      }
      try {
        if(!conn.isClosed()){
                conn.close();
          }

        
      } catch (SQLException e) {
        logger.error(e.getMessage());
      }
      } 
       
       return hm;
    }
    
    
    
    }
