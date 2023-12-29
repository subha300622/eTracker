/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.sql.*;

/**
 *
 * @author Administrator
 */
public class StatusCheck {
public static void main(String []args){
        Connection connection=null;
	Statement statement=null;
	ResultSet resultset=null;
        int userId =250;
        int count =0;
        String issueID = null;
        String dueDate = null;


            try{
//		connection=MakeConnection.getConnection();
                Class.forName("oracle.jdbc.driver.OracleDriver");

               
		connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
                statement = connection.createStatement();
                resultset = statement.executeQuery("select issue.issueid as issueid,issue.due_date from issue,issuestatus where status='Verified' and assignedto="+userId+" and issue.issueid=issuestatus.issueid and (select sysdate- due_date from dual )> 0 order by modifiedon desc");
      //          resultset = statement.executeQuery("select issue.issueid as issueid,issue.due_date from issue,issuestatus where status='Verified' and assignedto="+userId+" and issue.issueid=issuestatus.issueid and (select sysdate- due_date from dual )> 0 order by modifiedon desc");
                while(resultset.next()){
                    issueID = resultset.getString("issueid");
                    dueDate = resultset.getString("due_date");
                   
                }
 //               System.out.println("No of issues in verified status"+count);
	}
	catch(Exception e){
		e.printStackTrace();
	}
    finally{
            try{
                 if(resultset!=null) {
					resultset.close();
				}

            }catch(Exception ex){
                ex.printStackTrace();
            }
            try{
                 if(statement!=null) {
					statement.close();
				}

            }catch(Exception ex){
                ex.printStackTrace();
            }
            try{
                if(connection!=null) {
					connection.close();
				}

            }catch(Exception ex){
                ex.printStackTrace();
            }
        }
 }
}
