/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.google.gson.Gson;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class DesktopNotificationController {
 static Logger logger = null;

    static {
        logger = Logger.getLogger("DesktopNotificationController");
    }

    public String  GetNotifyIssues(int userId) {
        Map<String, String> noOfIssues = new LinkedHashMap<String, String>();
        String ajaxResponse="";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select i.issueid,subject,firstname from issue i,issuecomments ic,issuestatus s,users u where i.issueid=ic.issueid and i.issueid=s.issueid and u.userid=ic.commentedby and ic.commentedby<>'"+userId+"' and comments not like 'Due date is realigned because of issue#%'  and commentedto='"+userId+"' and TO_TIMESTAMP (to_char(COMMENT_DATE,'dd-Mon-yyyy HH24:MI:SS'),'dd-Mon-yyyy HH24:MI:SS')  >= to_date (to_char(SYSDATE - 5/(24*60*60),'dd-mm-yyyy HH24:MI:SS'),'dd-mm-yyyy HH24:MI:SS') ");
            while (resultset.next()) {
                String issueid=resultset.getString("firstname")+":"+resultset.getString("issueid");
                String subject=resultset.getString("subject");
                noOfIssues.put(issueid, subject);
            }
            ajaxResponse = new Gson().toJson(noOfIssues);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return ajaxResponse;
    }
}
