/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

import java.util.HashMap;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class MailReceiverDetails {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("MailReceiverDetails");

    }

    public static ArrayList getDetails(String issueId) {
        HashMap<String, String> mailAddress = new HashMap<String, String>();
        ArrayList al = new ArrayList();
        ArrayList<String> users = null;

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String createdby = null;
        String PM = null;
        String sponsorer = null;
        String stakeholder = null;
        String coordinator = null;
        String amanager = null;
        String dmanager = null;
        String assignedto = null;
        String cOwner = null;
        String iOwner = null;
        String pid = null;
        String status = null;
        String rating = null;
        String alerts = "Yes";
        String assinedUser = "";
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select i.pid as pid,assignedto,email,rating,createdby,s.status as status,pmanager,sponsorer,stakeholder,coordinator,amanager,dmanager,customerowner,internalowner from issue i,project p,issuestatus s, modules m,users u  where i.issueid=s.issueid and p.pid=i.pid and i.module_id=m.moduleid and assignedto=u.userid and i.issueid='" + issueId + "' ");
            while (resultset.next()) {

                assignedto = resultset.getString("assignedto");
                createdby = resultset.getString("createdby");
                PM = resultset.getString("pmanager");
                sponsorer = resultset.getString("sponsorer");
                stakeholder = resultset.getString("stakeholder");
                coordinator = resultset.getString("coordinator");
                amanager = resultset.getString("amanager");
                dmanager = resultset.getString("dmanager");
                cOwner = resultset.getString("customerowner");
                iOwner = resultset.getString("internalowner");
                pid = resultset.getString("pid");
                status = resultset.getString("status");
                rating = resultset.getString("rating");
                assinedUser = resultset.getString("email");

            }
            if (Integer.parseInt(pid) == 10124) {
                mailAddress.put("assignedto", assignedto);
                mailAddress.put("PM", PM);
                mailAddress.put("amanager", amanager);
                mailAddress.put("dmanager", dmanager);

                if (!assinedUser.contains("eminentlabs")) {
                    mailAddress.put("createdby", createdby);
                    mailAddress.put("sponsorer", sponsorer);
                    mailAddress.put("stakeholder", stakeholder);
                    mailAddress.put("coordinator", coordinator);
                }

                logger.info("cOwner" + cOwner);
                if (!assinedUser.contains("eminentlabs")) {
                    if (cOwner != null) {

                        int cuOwner = Integer.parseInt(cOwner);
                        if (cuOwner != 0) {
                            if (GetProjectMembers.isUserActive(iOwner)) {
                                mailAddress.put("customerowner", cOwner);
                                if (!al.contains(cOwner)) {
                                    al.add(cOwner);
                                }
                            }
                        }
                    }
                }
                if (iOwner != null) {
                    int inOwner = Integer.parseInt(iOwner);
                    if (inOwner != 0) {
                        if (GetProjectMembers.isUserActive(iOwner)) {
                            mailAddress.put("internalowner", iOwner);
                            if (!al.contains(iOwner)) {
                                al.add(iOwner);
                            }
                        }
                    }
                }

                if (!al.contains(PM)) {
                    al.add(PM);
                }
                if (!assinedUser.contains("eminentlabs")) {
                    if (!al.contains(sponsorer)) {
                        if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, sponsorer))) {
                            al.add(sponsorer);
                        }
                    }
                    if (!al.contains(stakeholder)) {
                        if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, stakeholder))) {
                            al.add(stakeholder);
                        }
                    }
                    if (!al.contains(coordinator)) {
                        if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, coordinator))) {
                            al.add(coordinator);
                        }
                    }
                }
                if (!al.contains(amanager)) {
                    if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, amanager))) {
                        al.add(amanager);
                    }
                }
                if (!al.contains(dmanager)) {
                    if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, dmanager))) {
                        al.add(dmanager);
                    }
                }
                if (assinedUser.contains("eminentlabs")) {
                    if (GetProjectMembers.getMail(createdby).contains("eminentlabs")) {
                        if (!al.contains(createdby)) {
                            al.add(createdby);
                        }
                    }
                }
            } else {
                mailAddress.put("assignedto", assignedto);
                mailAddress.put("PM", PM);
                mailAddress.put("createdby", createdby);
                mailAddress.put("sponsorer", sponsorer);
                mailAddress.put("stakeholder", stakeholder);
                mailAddress.put("coordinator", coordinator);
                mailAddress.put("amanager", amanager);
                mailAddress.put("dmanager", dmanager);
                logger.info("cOwner" + cOwner);
                if (cOwner != null) {
                    logger.info("cOwner" + cOwner);
                    int cuOwner = Integer.parseInt(cOwner);
                    if (cuOwner != 0) {
                        mailAddress.put("customerowner", cOwner);
                        if (!al.contains(cOwner)) {
                            al.add(cOwner);
                        }
                    }
                }
                if (iOwner != null) {
                    int inOwner = Integer.parseInt(iOwner);
                    if (inOwner != 0) {
                        mailAddress.put("internalowner", iOwner);
                        if (!al.contains(iOwner)) {
                            al.add(iOwner);
                        }
                    }
                }

                if (!al.contains(PM)) {
                    al.add(PM);
                }
                if (!al.contains(sponsorer)) {
                    if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, sponsorer))) {
                        al.add(sponsorer);
                    }
                }
                if (!al.contains(stakeholder)) {
                    if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, stakeholder))) {
                        al.add(stakeholder);
                    }
                }
                if (!al.contains(coordinator)) {
                    if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, coordinator))) {
                        al.add(coordinator);
                    }
                }
                if (!al.contains(amanager)) {
                    if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, amanager))) {
                        al.add(amanager);
                    }
                }
                if (!al.contains(dmanager)) {
                    if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, dmanager))) {
                        al.add(dmanager);
                    }
                }
                if (!al.contains(createdby)) {
                    al.add(createdby);
                }
            }

            // Adding users who worked in this issue if issue status is closed
            if (status.equalsIgnoreCase("Closed")) {
                users = getWorkedUsers(issueId);
                if (users != null) {
                    if (users.size() > 0) {
                        for (String s : users) {
                            if (!al.contains(s)) {
                                al.add(s);
                            }
                        }
                    }
                }
                // if Rating is Need Improvement mail must be cc-ed to Gopal
                if (rating != null) {
                    if (rating.equalsIgnoreCase("Need Improvement")) {
                        String gopalUserId = "112";
                        if (!al.contains(gopalUserId)) {
                            al.add(gopalUserId);
                        }
                    }
                }
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
                    logger.info("Connection Closed");
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        logger.info("Mail Details" + al);
        return al;
    }

    public static ArrayList getCRMGoverners(String assignedTo, String pm, String updatedBy) {
        ArrayList al = new ArrayList<String>();

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        String PM = null;
        String sponsorer = null;
        String stakeholder = null;
        String coordinator = null;
        String amanager = null;
        String dmanager = null;
        String pid = "10075";
        String alerts = "Yes";

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pmanager,sponsorer,stakeholder,coordinator,amanager,dmanager from project p where p.pid='" + pid + "'");
            while (resultset.next()) {

                PM = resultset.getString("pmanager");
                sponsorer = resultset.getString("sponsorer");
                stakeholder = resultset.getString("stakeholder");
                coordinator = resultset.getString("coordinator");
                amanager = resultset.getString("amanager");
                dmanager = resultset.getString("dmanager");

            }
            if (!al.contains(pm)) {
                al.add(pm);
            }
            if (!al.contains(assignedTo)) {
                al.add(assignedTo);
            }
            if (!al.contains(updatedBy)) {
                al.add(updatedBy);
            }
            if (!al.contains(PM)) {
                al.add(PM);
            }
            if (!al.contains(sponsorer)) {
                if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, sponsorer))) {
                    al.add(sponsorer);
                }
            }
            if (!al.contains(stakeholder)) {
                if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, stakeholder))) {
                    al.add(stakeholder);
                }
            }
            if (!al.contains(coordinator)) {
                if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, coordinator))) {
                    al.add(coordinator);
                }
            }
            if (!al.contains(amanager)) {
                if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, amanager))) {
                    al.add(amanager);
                }
            }
            if (!al.contains(dmanager)) {
                if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pid, dmanager))) {
                    al.add(dmanager);
                }
            }

            logger.info("Project Governers" + al);

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
                    logger.info("Connection Closed");
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return al;
    }

    public static ArrayList getWorkedUsers(String issueid) {
        ArrayList<String> users = new ArrayList<String>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select distinct commentedby from issuecomments where issueid='" + issueid + "'");
            while (resultset.next()) {
                users.add(resultset.getString(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return users;
    }

    public static ArrayList getTestMailDetails(String pId) {
        HashMap<String, String> mailAddress = new HashMap<String, String>();
        ArrayList al = new ArrayList();
        ArrayList<String> users = null;

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String createdby = null;
        String PM = null;
        String sponsorer = null;
        String stakeholder = null;
        String coordinator = null;
        String amanager = null;
        String dmanager = null;

        String alerts = "Yes";
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pmanager,sponsorer,stakeholder,coordinator,amanager,dmanager from project p where p.pid='" + pId + "' ");
            while (resultset.next()) {

                PM = resultset.getString("pmanager");
                sponsorer = resultset.getString("sponsorer");
                stakeholder = resultset.getString("stakeholder");
                coordinator = resultset.getString("coordinator");
                amanager = resultset.getString("amanager");
                dmanager = resultset.getString("dmanager");

            }

            mailAddress.put("PM", PM);
            mailAddress.put("sponsorer", sponsorer);
            mailAddress.put("stakeholder", stakeholder);
            mailAddress.put("coordinator", coordinator);
            mailAddress.put("amanager", amanager);
            mailAddress.put("dmanager", dmanager);

            if (!al.contains(PM)) {
                al.add(PM);
            }
            if (!al.contains(sponsorer)) {
                if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pId, sponsorer))) {
                    al.add(sponsorer);
                }
            }
            if (!al.contains(stakeholder)) {
                if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pId, stakeholder))) {
                    al.add(stakeholder);
                }
            }
            if (!al.contains(coordinator)) {
                if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pId, coordinator))) {
                    al.add(coordinator);
                }
            }
            if (!al.contains(amanager)) {
                if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pId, amanager))) {
                    al.add(amanager);
                }
            }
            if (!al.contains(dmanager)) {
                if (alerts.equalsIgnoreCase(UpdateUserProject.isAlertActive(pId, dmanager))) {
                    al.add(dmanager);
                }
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
                    logger.info("Connection Closed");
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return al;
    }

}
