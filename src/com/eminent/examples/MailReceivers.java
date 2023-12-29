/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.util.*;
import java.sql.*;
/**
 *
 * @author ADAL
 */
public class MailReceivers {
     public static HashMap getDetails(){
        HashMap<String,String> mailAddress  =   new HashMap<String, String>();

        Connection connection   =   null;
        Statement  statement    =   null;
        ResultSet   resultset   =   null;
        String      createdby   =   null;
        String      PM          =   null;
        String      sponsorer   =   null;
        String      stakeholder =   null;
        String      coordinator =   null;
        String      amanager    =   null;
        String      dmanager    =   null;
        String      assignedto  =   null;

        try{
                 Class.forName("oracle.jdbc.driver.OracleDriver");

                connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
                statement   =   connection.createStatement();
                resultset   =   statement.executeQuery("select assignedto,createdby,pmanager,sponsorer,stakeholder,coordinator,amanager,dmanager from issue i,project p where p.pid=i.pid and issueid='E16032010004'");
                while(resultset.next()){

                    assignedto  =   resultset.getString("assignedto");
                    createdby   =   resultset.getString("createdby");
                    PM          =   resultset.getString("pmanager");
                    sponsorer   =   resultset.getString("sponsorer");
                    stakeholder =   resultset.getString("stakeholder");
                    coordinator =   resultset.getString("coordinator");
                    amanager    =   resultset.getString("amanager");
                    dmanager    =   resultset.getString("dmanager");

                }
                mailAddress.put("assignedto", assignedto);
                mailAddress.put("PM", PM);
                mailAddress.put("createdby", createdby);
                mailAddress.put("sponsorer", sponsorer);
                mailAddress.put("stakeholder", stakeholder);
                mailAddress.put("coordinator", coordinator);
                mailAddress.put("amanager", amanager);
                mailAddress.put("dmanager", dmanager);


                ArrayList al = new ArrayList();
                if(!al.contains(assignedto)){
                    al.add(assignedto);
                }
                 if(!al.contains(PM)){
                    al.add(PM);
                }
                 if(!al.contains(createdby)){
                    al.add(createdby);
                }
                 if(!al.contains(sponsorer)){
                    al.add(sponsorer);
                }
                 if(!al.contains(stakeholder)){
                    al.add(stakeholder);
                }
                 if(!al.contains(coordinator)){
                    al.add(coordinator);
                }
                 if(!al.contains(amanager)){
                    al.add(amanager);
                }
                 if(!al.contains(dmanager)){
                    al.add(dmanager);
                }

        }catch(Exception e){
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


        return mailAddress;
    }
     public static void main(String args[]){
            HashMap map =   getDetails();
     }

}
