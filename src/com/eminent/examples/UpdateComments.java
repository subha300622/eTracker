/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.util.Date;
import java.text.SimpleDateFormat;

/**
 *
 * @author Administrator
 */
public class UpdateComments {
    
    
    
    public static void main(String[] args) throws Exception{
        
                 Connection connection=null,conn=null;
                 Statement statement=null,st=null;
                 ResultSet resultset=null,rs=null;
                 PreparedStatement pt=null;
                 int rowcount;

		try{
		Class.forName("oracle.jdbc.driver.OracleDriver");

		connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");

		statement=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);


		resultset=statement.executeQuery("select commentedby,issueid,comment_date from issuecomments order by comment_date asc");
                resultset.last();

                rowcount=resultset.getRow();
                resultset.beforeFirst();

                int noOfLoop=rowcount/10000;
                int noOfLoop1=rowcount%10000;
                if(noOfLoop1>0){
                    noOfLoop=noOfLoop+1;
                }
                int minValue=1;
                int maxValue=10001;

                SimpleDateFormat sdt=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                String issueid=null;
                Timestamp date=null;

                String commented=null;
                String dt=null;
                pt=connection.prepareStatement("update issuecomments set commentid=? where issueid=? and commentedby=? and to_char(comment_date,'yyyy-MM-dd hh:mi:ss')=?");
                for(int k=1;k<=rowcount;k++){

                    if(resultset.next()){
                     issueid=resultset.getString("issueid");
//                     System.out.println("Issueid-->"+issueid+"minValue"+k);
                     date=resultset.getTimestamp("comment_date");
                     commented=resultset.getString("commentedby");
                    
                    
                    dt=sdt.format(date);

                    pt.setInt(1, k);
                    pt.setString(2, issueid);
                    pt.setString(3, commented);
                    pt.setString(4, dt);
                    pt.addBatch();
                    }else{
                    }
        }

     
       int x[]= pt.executeBatch();
   
		}
		catch(Exception e){
			e.printStackTrace();
		}
                finally{
                    if(connection!=null){
                        connection.close();
                    }
                    if(resultset!=null){
                        resultset.close();
                    }
                    
                    if(statement!=null){
                        statement.close();
                    }
                    if(pt!=null){
                        pt.close();
                    }
                }
                updateDuplicateRow();
    }
    public static void updateDuplicateRow() throws Exception{
        Connection connection=null,conn=null;
        Statement statement=null,st=null;
        ResultSet resultset=null,rs=null;
          PreparedStatement pt=null;
        try{
            int i=0;
            
            Class.forName("oracle.jdbc.driver.OracleDriver");
 	    connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
            statement=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            resultset=statement.executeQuery("select commentid from issuecomments  GROUP BY commentid having count(*)>1 order by commentid");
            resultset.last();
            int rowcount =resultset.getRow();
            int duplicateId[]=new int[rowcount];
            
            resultset.beforeFirst();
            while(resultset.next()){
                duplicateId[i]=resultset.getInt(1);
   //             System.out.println("CommentId-->"+duplicateId[i]);
                i++;
            }
            pt=connection.prepareStatement("UPDATE issuecomments SET commentid =? WHERE commentid = ? AND rowid = (SELECT max(rowid) FROM issuecomments WHERE commentid = ?)");
            for(int k=0;k<duplicateId.length;k++){

               
                    pt.setInt(1, duplicateId[k]-1);
                    pt.setInt(2, duplicateId[k]);
                    pt.setInt(3, duplicateId[k]);
                    pt.addBatch();
                
          }
          pt.executeBatch();
            
        }catch(Exception e){
            e.printStackTrace();
        }
        finally{
                    if(connection!=null){
                        connection.close();
                    }
                    if(resultset!=null){
                        resultset.close();
                    }

                    if(statement!=null){
                        statement.close();
                    }
                   
                }
        
    }
    
}
