/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import org.apache.log4j.Logger;

import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Tamilvelan
 */
public class CommentHistoryReference {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("CommentHistoryReference");
    }

    public static HashMap<String, Integer> getReferences(String crm, int id) {
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Connection connection = null;
        ResultSet resultset = null,rs1=null,rs2=null;
        PreparedStatement ps = null,ps1=null,ps2=null;
        int contact_reference = 0;
        int lead_reference = 0;
        int opportunity_reference = 0;
        int account_reference = 0;

        try {

            connection = MakeConnection.getConnection();
            if (crm.equalsIgnoreCase("account")) {

                account_reference = id;
                ps = connection.prepareStatement("select opportunity_reference from account where accountid=?");
                ps.setInt(1, id);
                resultset = ps.executeQuery();
                if (resultset.next()) {
                    String reference = resultset.getString(1);
                    if (reference != null) {
                        opportunity_reference = Integer.parseInt(reference);
                    }
                }
            }
            if (crm.equalsIgnoreCase("opportunity") || opportunity_reference > 0) {

                if (opportunity_reference > 0) {
                    id = opportunity_reference;
                } else {
                    opportunity_reference = id;
                }

                ps1 = connection.prepareStatement("select lead_reference from opportunity where opportunityid=?");
                ps1.setInt(1, id);
                rs1 = ps1.executeQuery();
                if (rs1.next()) {
                    String reference = rs1.getString(1);
                    if (reference != null) {
                        lead_reference = Integer.parseInt(reference);
                    }
                }

            }
            if (crm.equalsIgnoreCase("lead") || lead_reference > 0) {
                if (lead_reference > 0) {
                    id = lead_reference;
                } else {
                    lead_reference = id;
                }

                ps2 = connection.prepareStatement("select contact_reference from lead where leadid=?");
                ps2.setInt(1, id);
                rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    String reference = rs2.getString(1);
                    if (reference != null) {
                        contact_reference = Integer.parseInt(reference);
                    }
                }

            }
            if (crm.equalsIgnoreCase("contact")) {

                contact_reference = id;

            }
            hm.put("contact", contact_reference);
            hm.put("lead", lead_reference);
            hm.put("opportunity", opportunity_reference);
            hm.put("account", account_reference);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (rs1 != null) {
                    rs1.close();
                }
                if (rs2 != null) {
                    rs2.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
            try {
                if (ps != null) {
                    ps.close();
                }
                if (ps1 != null) {
                    ps1.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return hm;
    }

}
