package com.eminent.examples;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

public class IssueAge {

    static Logger logger = Logger.getLogger("iSSUE AGE");

    Connection connection = null;
    Statement statement = null;
    ResultSet resultset = null;

    public void getIssueAge() throws Exception {

        Connection connection = null;
        Statement statement, statementissue = null;
        ResultSet resultset = null, resultsetissue = null;
        int createdDate = 0;

        logger.setLevel(Level.DEBUG);

        try {

            Class.forName("oracle.jdbc.driver.OracleDriver");

            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");

            statementissue = connection.createStatement();
            resultsetissue = statementissue.executeQuery("select issue.issueid as issueid,severity,priority,assignedto,to_char(createdon) as createdon,subject,to_char(modifiedon) as modifiedon,issuestatus.status as status from issue, issuestatus where issue.issueid=issuestatus.issueid and issuestatus.status='Closed'");
            while (resultsetissue.next()) {

                String issueid = resultsetissue.getString("issueid");
//			String severity=resultsetissue.getString("severity");
//			String priority=resultsetissue.getString("priority");
//			String assignedto=resultsetissue.getString("assignedto");
                String createdon = resultsetissue.getString("createdon");
//			String subject=resultsetissue.getString("subject");
                String modifiedon = resultsetissue.getString("modifiedon");
                String status = resultsetissue.getString("status");

                statement = connection.createStatement();
                if (!status.equalsIgnoreCase("Closed")) {
                    resultset = statement.executeQuery("SELECT sysdate-to_date('" + createdon + "') FROM dual");
                } else {
                    resultset = statement.executeQuery("SELECT to_date('" + modifiedon + "')-to_date('" + createdon + "') FROM dual");
                }
                while (resultset.next()) {
                    createdDate = resultset.getInt(1);
                }
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        }

    }

    public static void main(String args[]) throws Exception {
        String file_name = "1234567890.111232.txt";

        String[] arr_filename = file_name.split("[.]");

        System.out.println(arr_filename.length);
        String file_ex = arr_filename[ arr_filename.length - 1];
        if (file_name.length() > 10) {
            file_name = file_name.substring(0, 9) + "." + file_ex;
        }
        System.out.println(file_name);

    }

}
