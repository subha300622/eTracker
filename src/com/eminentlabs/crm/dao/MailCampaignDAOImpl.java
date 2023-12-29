/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm.dao;

import com.eminentlabs.crm.dto.MailCampaignDetails;
import com.eminentlabs.crm.persistence.MailCampaign;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class MailCampaignDAOImpl implements MailCampaignDAO {

    @Override
    public int getMailCountByDate(String date) {
        String year = date.substring(date.lastIndexOf("-") + 1, date.length());
        date = date.substring(0, date.lastIndexOf("-") + 1) + year.substring(2);

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        int count = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = statement.executeQuery("select count(*) from MAIL_CAMPAIGN where MAILDATE='" + date + "'");
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return count;
    }

    @Override
    public String findUserIdByMail(int contactId, String type) {
        String email = "";
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        String sql = "";
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (type.equalsIgnoreCase("Contact")) {
                sql = "select email from contact where contactid=" + contactId;
            } else if (type.equalsIgnoreCase("Lead")) {
                sql = "select email from lead where contactid=" + contactId;
            } else if (type.equalsIgnoreCase("Opportunity")) {
                sql = "select email from opportunity where contactid=" + contactId;
            } else if (type.equalsIgnoreCase("Account")) {
                sql = "select email from account where contactid=" + contactId;
            }
            rs = statement.executeQuery("select email from contact where contactid=" + contactId);
            while (rs.next()) {
                email = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return email;
    }

    @Override
    public List<MailCampaignDetails> findDetailsByMail(String email) {
        List<MailCampaignDetails> mailCampaignList = new ArrayList<MailCampaignDetails>();
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = statement.executeQuery("select *from MAIL_CAMPAIGN where MAILID='" + email + "'");
            while (rs.next()) {
                MailCampaignDetails mc = new MailCampaignDetails();
                mc.setCampaignid(rs.getInt("campaign_id"));
                mc.setMaildate(rs.getDate("Maildate"));
                mc.setSentby(getNameById(rs.getInt("sentby")));
                mc.setStatus(rs.getString("status"));
                mc.setSubject(rs.getString("subject"));
                mailCampaignList.add(mc);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return mailCampaignList;
    }

    public String getNameById(int userID) {
        String name = "";
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = statement.executeQuery("select firstname||' '||lastname as name from users where userid=" + userID);
            while (rs.next()) {
                name = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return name;

    }

}
