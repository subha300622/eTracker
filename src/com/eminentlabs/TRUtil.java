/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Tamilvelan
 */
public class TRUtil {
 static Logger logger=Logger.getLogger("TRUtil");
    public static void createTR(String tr, String description, long userId) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("insert into TR_DETAILS(TR_ID,description,User_Id,created_on) values(?,?,?,?)");
            ps.setString(1, tr);
            ps.setString(2, description);
            ps.setLong(3, userId);
            ps.setTimestamp(4, date);
            ps.executeUpdate();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
               logger.error(e.getMessage());
            }
        }

    }

}
