/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import static com.eminent.issue.controller.DesktopNotificationController.logger;
import com.google.gson.Gson;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class DueDateNotificationController {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("DueDateNotificationController");
    }

    public static int GetDueDateIssueCount(int userId) {
        int count =0;
         Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(i.issueid) as counts from issue i,issuestatus s,project p,users u where  i.pid=p.pid and p.STATUS='Work in progress' And pmanager = "+userId+" and i.issueid=s.issueid  and u.userid=p.pmanager and (select i.DUE_DATE - trunc(sysdate)  from dual) <=5 and s.status!='Closed' ");
            while (resultset.next()) {
               count = resultset.getInt("counts");
            }           
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
        return count;
    }
}
