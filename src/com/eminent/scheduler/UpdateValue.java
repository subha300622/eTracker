/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.scheduler;

import pack.eminent.encryption.MakeConnection;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Job;

import java.sql.Connection;
import java.sql.Statement;
import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class UpdateValue implements Job {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("UpdateValue");
    }

    public void execute(JobExecutionContext arg0) throws JobExecutionException {

        Connection connection = null;
        Statement statement = null;
        try {

            int i;

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            i = statement.executeUpdate("update users set value=0");

        } catch (Exception s) {
            logger.error(s.getMessage());
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
    }

}
