/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.projectuser;

import static com.eminentlabs.userBPM.BPMUtil.logger;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class DetailsDAO {

    public String findUsersByPId(BigDecimal pid) throws Exception {
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        String users = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            rs = statement.executeQuery("select u.userid,u.FIRSTNAME||' ' ||u.LASTNAME as name,u.MOBILE as contacts,p.SHOWDETAILS,p.pmanager,p.coordinator from users u,project p where u.userid in(p.pmanager,p.coordinator) and p.pid=" + pid);
            while (rs.next()) {
                String showdetails = rs.getString("showdetails");
                if ((showdetails == null) || (showdetails.equals("false"))) {
                } else {
                    int manager = rs.getInt("PMANAGER");
                    long userId = Long.valueOf(rs.getString("userid"));
                    int coordinator = rs.getInt("coordinator");
                    if (userId == manager) {
                        users = "PM:" + rs.getString("name") + "," + rs.getString("contacts");
                    } else if (userId == coordinator) {
                        users = users + ", PC:" + rs.getString("name") + "," + rs.getString("contacts");
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                logger.error(ex.getMessage());
            }
        }
        return users;
    }
    public String getShowDetails(BigDecimal pid) throws Exception {
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        String showdetails = "";
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            rs = statement.executeQuery("select p.SHOWDETAILS from project p where p.pid=" + pid);
            while (rs.next()) {
                showdetails = rs.getString("SHOWDETAILS");
            }
            if ((showdetails == null) || (showdetails.equals("true") == false)) {
                showdetails = "false";
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                logger.error("error in DAO is"+ex.getMessage());
            }
        }
        return showdetails;
    }
}
