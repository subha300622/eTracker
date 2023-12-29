package com.pack;

import java.sql.*;
import java.util.Arrays;
import java.util.HashMap;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;

public class CRMIssueBean {

    static Logger logger = Logger.getLogger("CRMIssueBean");
    Statement st;
    ResultSet rs, rs1, rs2, rs3;
    PreparedStatement ps, ps1, ps2, ps3;

    public ResultSet getLead(Connection connection, int user) throws SQLException {
        logger.debug("Query()");
        String assignedto = String.valueOf(user);
        try {
            ps = connection.prepareStatement("SELECT LEADID,TITLE,FIRSTNAME, LASTNAME, COMPANY, STATE,PHONE,MOBILE,EMAIL,LEADSTATUS,RATING,DUEDATE,ASSIGNEDTO,CREATEDON,MODIFIEDON,LEAD_OWNER,DESCRIPTION  from lead where roleid=2 and assignedto=? order by duedate ASC", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
//            if (ps != null) {
//                ps.close();
//            }
        }

        return rs;
    }

    public ResultSet getContact(Connection connection, int user) throws SQLException {
        logger.debug("Query()");
        String assignedto = String.valueOf(user);
        try {
            ps = connection.prepareStatement("SELECT contactid,FIRSTNAME,LASTNAME,ACCOUNTNAME,TITLE,PHONE,MOBILE,EMAIL,CREATEDON,DUEDATE,ASSIGNEDTO,CONTACT_OWNER,MODIFIEDON,RATING,COMPANY,DESCRIPTION from CONTACT where roleid=2 and assignedto=? order by duedate ASC", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
//            if (ps != null) {
//                ps.close();
//            }
        }

        return rs;
    }

    public ResultSet getOpportunity(Connection connection, int user) throws SQLException {
        logger.debug("Query()");
        String assignedto = String.valueOf(user);
        try {
            ps = connection.prepareStatement("SELECT OPPORTUNITYID,OPPORTUNITYNAME, ASSIGNEDTO, AMOUNT, CLOSE_DATE,STAGE,DESCRIPTION,PROBABILITY from opportunity where roleid=2 and assignedto=? order by close_date ASC", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
//            if (ps != null) {
//                ps.close();
//            }
        }

        return rs;
    }

    public ResultSet getAccount(Connection connection, int user) throws SQLException {
        logger.debug("Query()");
        String assignedto = String.valueOf(user);
        try {
            ps = connection.prepareStatement("SELECT ACCOUNTID,ACCOUNTNAME,BILLINGSTATE,PHONE,TYPE,DESCRIPTION,DUEDATE,CREATEDON,ACCOUNT_AMOUNT from account where roleid=2 and assignedto=? order by DUEDATE ASC", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
//            if (ps != null) {
//                ps.close();
//            }
        }

        return rs;
    }

    public int getAPMIssues(Connection connection, int user) throws SQLException {
        int count = 0;
        logger.debug("Query()");
        String assignedto = String.valueOf(user);
        try {
            ps = connection.prepareStatement("SELECT count(*) as total from  project p, issue i, issuestatus s where i.issueid = s.issueid and i.pid = p.pid and s.status != 'Closed' and assignedto = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }

        return count;
    }

    public int getCRMIssues(Connection connection, int user) throws SQLException {
        int count = 0;
        logger.debug("Query()");
        String assignedto = String.valueOf(user);
        try {
            ps = connection.prepareStatement("SELECT count(*) as total from  contact where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
            if (rs.next()) {
                count = count + rs.getInt(1);
            }
            ps1 = connection.prepareStatement("SELECT count(*) as total from  lead where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps1.setString(1, assignedto);

            rs1 = ps1.executeQuery();
            if (rs1.next()) {
                count = count + rs1.getInt(1);
            }
            ps2 = connection.prepareStatement("SELECT count(*) as total from  opportunity where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps2.setString(1, assignedto);

            rs2 = ps2.executeQuery();
            if (rs2.next()) {
                count = count + rs2.getInt(1);
            }
            ps3 = connection.prepareStatement("SELECT count(*) as total from  account where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps3.setString(1, assignedto);

            rs3 = ps3.executeQuery();
            if (rs3.next()) {
                count = count + rs3.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (rs1 != null) {
                rs1.close();
            }
            if (rs2 != null) {
                rs2.close();
            }
            if (rs3 != null) {
                rs3.close();
            }

            if (ps != null) {
                ps.close();
            }
            if (ps1 != null) {
                ps1.close();
            }
            if (ps2 != null) {
                ps2.close();
            }
            if (ps3 != null) {
                ps3.close();
            }
        }

        return count;
    }

    public int getCRMIssues(int user) throws SQLException {
        int count = 0;
        logger.debug("Query()");
        String assignedto = String.valueOf(user);
        Connection connection = null;
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("SELECT count(*) as total from  contact where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
            if (rs.next()) {
                count = count + rs.getInt(1);
            }
            ps1 = connection.prepareStatement("SELECT count(*) as total from  lead where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps1.setString(1, assignedto);

            rs1 = ps1.executeQuery();
            if (rs1.next()) {
                count = count + rs1.getInt(1);
            }
            ps2 = connection.prepareStatement("SELECT count(*) as total from  opportunity where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps2.setString(1, assignedto);

            rs2 = ps2.executeQuery();
            if (rs2.next()) {
                count = count + rs2.getInt(1);
            }
            ps3 = connection.prepareStatement("SELECT count(*) as total from  account where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps3.setString(1, assignedto);

            rs3 = ps3.executeQuery();
            if (rs3.next()) {
                count = count + rs3.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (rs1 != null) {
                rs1.close();
            }
            if (rs2 != null) {
                rs2.close();
            }
            if (rs3 != null) {
                rs3.close();
            }

            if (ps != null) {
                ps.close();
            }
            if (ps1 != null) {
                ps1.close();
            }
            if (ps2 != null) {
                ps2.close();
            }
            if (ps3 != null) {
                ps3.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return count;
    }

    public String getHigestCRMIssues(Connection connection, int user, int currentUser) throws SQLException {
        int contact = 0;
        int lead = 0;
        int opportunity = 0;
        int account = 0;

        String highestIssue = "Lead";
        logger.debug("Query()");
        String assignedto = String.valueOf(user);

        try {
            ps = connection.prepareStatement("SELECT count(*) as total from  contact where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
            if (rs.next()) {
                contact = rs.getInt(1);
            }
            ps1 = connection.prepareStatement("SELECT count(*) as total from  lead where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps1.setString(1, assignedto);

            rs1 = ps1.executeQuery();
            if (rs1.next()) {
                lead = rs1.getInt(1);
            }
            ps2 = connection.prepareStatement("SELECT count(*) as total from  opportunity where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps2.setString(1, assignedto);

            rs2 = ps2.executeQuery();
            if (rs2.next()) {
                opportunity = rs2.getInt(1);
            }
            ps3 = connection.prepareStatement("SELECT count(*) as total from  account where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps3.setString(1, assignedto);

            rs3 = ps3.executeQuery();
            if (rs3.next()) {
                account = rs3.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (rs1 != null) {
                rs1.close();
            }
            if (rs2 != null) {
                rs2.close();
            }
            if (rs3 != null) {
                rs3.close();
            }

            if (ps != null) {
                ps.close();
            }
            if (ps1 != null) {
                ps1.close();
            }
            if (ps2 != null) {
                ps2.close();
            }
            if (ps3 != null) {
                ps3.close();
            }
        }
        int a[] = {contact, lead, opportunity, account};
        Arrays.sort(a);

        if (currentUser == 104) {
            if (a[a.length - 1] == contact) {
                highestIssue = "/MyCRM/adminContactView.jsp?currentUserId=" + user;
            }
            if (a[a.length - 1] == lead) {
                highestIssue = "/MyCRM/adminLeadView.jsp?currentUserId=" + user;
            }
            if (a[a.length - 1] == opportunity) {
                highestIssue = "/MyCRM/adminOppView.jsp?currentUserId=" + user;
            }
            if (a[a.length - 1] == account) {
                highestIssue = "/MyCRM/adminAccView.jsp?currentUserId=" + user;
            }
        } else {
            if (a[a.length - 1] == contact) {
                highestIssue = "/MyCRM/crmContactIssues.jsp";
            }
            if (a[a.length - 1] == lead) {
                highestIssue = "/MyCRM/crmLeadIssues.jsp";
            }
            if (a[a.length - 1] == opportunity) {
                highestIssue = "/MyCRM/crmOpportunityIssues.jsp";
            }
            if (a[a.length - 1] == account) {
                highestIssue = "/MyCRM/crmAccountIssues.jsp";
            }
        }
        return highestIssue;
    }

    public String getHigestCRMIssues(int user, int currentUser) throws SQLException {
        int contact = 0;
        int lead = 0;
        int opportunity = 0;
        int account = 0;
        Connection connection = null;
        String highestIssue = "Lead";
        logger.debug("Query()");
        String assignedto = String.valueOf(user);

        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("SELECT count(*) as total from  contact where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
            if (rs.next()) {
                contact = rs.getInt(1);
            }
            ps1 = connection.prepareStatement("SELECT count(*) as total from  lead where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps1.setString(1, assignedto);

            rs1 = ps1.executeQuery();
            if (rs1.next()) {
                lead = rs1.getInt(1);
            }
            ps2 = connection.prepareStatement("SELECT count(*) as total from  opportunity where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps2.setString(1, assignedto);

            rs2 = ps2.executeQuery();
            if (rs2.next()) {
                opportunity = rs2.getInt(1);
            }
            ps3 = connection.prepareStatement("SELECT count(*) as total from  account where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps3.setString(1, assignedto);

            rs3 = ps3.executeQuery();
            if (rs3.next()) {
                account = rs3.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (rs1 != null) {
                rs1.close();
            }
            if (rs2 != null) {
                rs2.close();
            }
            if (rs3 != null) {
                rs3.close();
            }

            if (ps != null) {
                ps.close();
            }
            if (ps1 != null) {
                ps1.close();
            }
            if (ps2 != null) {
                ps2.close();
            }
            if (ps3 != null) {
                ps3.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        int a[] = {contact, lead, opportunity, account};
        Arrays.sort(a);

        if (currentUser == 104) {
            if (a[a.length - 1] == contact) {
                highestIssue = "/MyCRM/adminContactView.jsp?currentUserId=" + user;
            }
            if (a[a.length - 1] == lead) {
                highestIssue = "/MyCRM/adminLeadView.jsp?currentUserId=" + user;
            }
            if (a[a.length - 1] == opportunity) {
                highestIssue = "/MyCRM/adminOppView.jsp?currentUserId=" + user;
            }
            if (a[a.length - 1] == account) {
                highestIssue = "/MyCRM/adminAccView.jsp?currentUserId=" + user;
            }
        } else {
            if (a[a.length - 1] == contact) {
                highestIssue = "/MyCRM/crmContactIssues.jsp";
            }
            if (a[a.length - 1] == lead) {
                highestIssue = "/MyCRM/crmLeadIssues.jsp";
            }
            if (a[a.length - 1] == opportunity) {
                highestIssue = "/MyCRM/crmOpportunityIssues.jsp";
            }
            if (a[a.length - 1] == account) {
                highestIssue = "/MyCRM/crmAccountIssues.jsp";
            }
        }
        return highestIssue;
    }

    public String getHigestCRMIssues(int user) throws SQLException {
        int contact = 0;
        int lead = 0;
        int opportunity = 0;
        int account = 0;
        Connection connection = null;
        String highestIssue = "Lead";
        logger.debug("Query()");
        String assignedto = String.valueOf(user);

        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("SELECT count(*) as total from  contact where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
            if (rs.next()) {
                contact = rs.getInt(1);
            }
            ps1 = connection.prepareStatement("SELECT count(*) as total from  lead where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps1.setString(1, assignedto);

            rs1 = ps1.executeQuery();
            if (rs1.next()) {
                lead = rs1.getInt(1);
            }
            ps2 = connection.prepareStatement("SELECT count(*) as total from  opportunity where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps2.setString(1, assignedto);

            rs2 = ps2.executeQuery();
            if (rs2.next()) {
                opportunity = rs2.getInt(1);
            }
            ps3 = connection.prepareStatement("SELECT count(*) as total from  account where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps3.setString(1, assignedto);

            rs3 = ps3.executeQuery();
            if (rs3.next()) {
                account = rs3.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (rs1 != null) {
                rs1.close();
            }
            if (rs2 != null) {
                rs2.close();
            }
            if (rs3 != null) {
                rs3.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (ps1 != null) {
                ps1.close();
            }
            if (ps2 != null) {
                ps2.close();
            }
            if (ps3 != null) {
                ps3.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        int a[] = {contact, lead, opportunity, account};
        Arrays.sort(a);

        if (a[a.length - 1] == contact) {
            highestIssue = "/MyCRM/crmContactIssues.jsp";
        }
        if (a[a.length - 1] == lead) {
            highestIssue = "/MyCRM/crmLeadIssues.jsp";
        }
        if (a[a.length - 1] == opportunity) {
            highestIssue = "/MyCRM/crmOpportunityIssues.jsp";
        }
        if (a[a.length - 1] == account) {
            highestIssue = "/MyCRM/crmAccountIssues.jsp";
        }
        return highestIssue;
    }

    public HashMap<String, Integer> getCRMIssuesCounts(Connection connection, int user) throws SQLException {
        int contact = 0;
        int lead = 0;
        int opportunity = 0;
        int account = 0;
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        PreparedStatement psa = null, psb = null, psc = null, psd = null;
        ResultSet rsa = null, rsb = null, rsc = null, rsd = null;

//		String highestIssue="Lead";
        logger.debug("Query()");
        String assignedto = String.valueOf(user);

        try {
            psa = connection.prepareStatement("SELECT count(*) as total from  contact where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            psa.setString(1, assignedto);

            rsa = psa.executeQuery();
            if (rsa.next()) {
                contact = rsa.getInt(1);
            }
            psb = connection.prepareStatement("SELECT count(*) as total from  lead where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            psb.setString(1, assignedto);

            rsb = psb.executeQuery();
            if (rsb.next()) {
                lead = rsb.getInt(1);
            }
            psc = connection.prepareStatement("SELECT count(*) as total from  opportunity where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            psc.setString(1, assignedto);

            rsc = psc.executeQuery();
            if (rsc.next()) {
                opportunity = rsc.getInt(1);
            }
            psd = connection.prepareStatement("SELECT count(*) as total from  account where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            psd.setString(1, assignedto);

            rsd = psd.executeQuery();
            if (rsd.next()) {
                account = rsd.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            if (rsa != null) {
                rsa.close();
            }
            if (rsb != null) {
                rsb.close();
            }
            if (rsc != null) {
                rsc.close();
            }
            if (rsd != null) {
                rsd.close();
            }
            if (psa != null) {
                psa.close();
            }
            if (psb != null) {
                psb.close();
            }
            if (psc != null) {
                psc.close();
            }
            if (psd != null) {
                psd.close();
            }
        }
        hm.put("Contact", contact);
        hm.put("Lead", lead);
        hm.put("Opportunity", opportunity);
        hm.put("Account", account);

        return hm;
    }

    public ResultSet getContactComment(Connection connection, int contactid) throws SQLException {

        ps = connection.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments,rating,to_char(duedate,'dd-Mon-yyyy') as duedate,commentedto from contact_comments where contactid=? order by comment_date asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setInt(1, contactid);

        rs = ps.executeQuery();

        return rs;
    }

    public ResultSet getLeadComment(Connection connection, int leadid) throws SQLException {

        ps = connection.prepareStatement("select commentedby,lead_status,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments,to_char(duedate,'dd-Mon-yyyy') as duedate,commentedto from lead_comments where leadid=? order by comment_date asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setInt(1, leadid);

        rs = ps.executeQuery();

        return rs;
    }

    public ResultSet getOpportunityComment(Connection connection, int opportunityid) throws SQLException {

        ps = connection.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,stage,comments,to_char(duedate,'dd-Mon-yyyy') as duedate,commentedto from opportunity_comments where opportunityid=? order by comment_date asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setInt(1, opportunityid);

        rs = ps.executeQuery();

        return rs;
    }

    public ResultSet getAccountComment(Connection connection, int accountid) throws SQLException {

        ps = connection.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments,commentedto,to_char(duedate,'dd-Mon-yyyy') as duedate from account_comments where accountid=? order by comment_date asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setInt(1, accountid);

        rs = ps.executeQuery();

        return rs;
    }

    public String getContactLastComment(Connection connection, int contactid) throws SQLException {
        String lastcomment = "NA";

        try {
            ps = connection.prepareStatement("select COMMENTS from contact_comments where contactid=? order by comment_date desc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setInt(1, contactid);

            rs = ps.executeQuery();
            if (rs.next()) {
                lastcomment = rs.getString("comments");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return lastcomment;
    }

    public String getLeadLastComment(Connection connection, int leadid) throws SQLException {

        String lastcomment = "NA";
        try {
            ps = connection.prepareStatement("select COMMENTS from lead_comments where leadid=?  order by comment_date desc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setInt(1, leadid);

            rs = ps.executeQuery();
            if (rs.next()) {
                lastcomment = rs.getString("comments");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return lastcomment;
    }

    public String getOpportunityReference(Connection connection, int accountid) throws SQLException {

        String opportunity_reference = "NA";
        try {
            ps = connection.prepareStatement("select opportunity_reference from account where accountid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setInt(1, accountid);

            rs = ps.executeQuery();
            if (rs.next()) {
                opportunity_reference = rs.getString("opportunity_reference");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return opportunity_reference;
    }

    public String getLeadReference(Connection connection, int opportunityid) throws SQLException {

        String lead_reference = "NA";
        try {
            ps = connection.prepareStatement("select lead_reference from opportunity where opportunityid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setInt(1, opportunityid);

            rs = ps.executeQuery();
            if (rs.next()) {
                lead_reference = rs.getString("lead_reference");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return lead_reference;
    }

    public String getContactReference(Connection connection, int leadid) throws SQLException {

        String contact_reference = "NA";
        try {
            ps = connection.prepareStatement("select contact_reference from lead where leadid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setInt(1, leadid);

            rs = ps.executeQuery();
            if (rs.next()) {
                contact_reference = rs.getString("contact_reference");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return contact_reference;
    }

    public String getOpportunityValue(Connection connection, int opportunityid) throws SQLException {

        String probability = "NA";
        String amount = "NA";
        int value = 0;
        try {
            ps = connection.prepareStatement("select probability,amount from opportunity where opportunityid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setInt(1, opportunityid);

            rs = ps.executeQuery();
            if (rs.next()) {
                probability = rs.getString("probability");
                amount = rs.getString("amount");
            }
            if (probability != null && amount != null) {
                value = Math.round((Long.parseLong(probability) * Long.parseLong(amount)) / 100);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return ((Integer) value).toString();
    }
}
