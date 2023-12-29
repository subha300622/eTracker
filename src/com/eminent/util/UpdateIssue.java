/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

import com.eminent.issue.URLMapper;
import static com.eminent.issue.controller.IssueImageURLController.checkGoogleURL;
import com.eminent.issue.dao.IssueDAOImpl;
import java.awt.image.BufferedImage;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.imageio.ImageIO;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Tamilvelan
 */
public class UpdateIssue {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("Update Issue");

    }

    public static void updateModifiedOn(String issueId) {
        Connection connection = null;
        PreparedStatement statement = null;
        Date d = new java.util.Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);

        try {

            connection = MakeConnection.getConnection();
            statement = connection.prepareStatement("update issue set modifiedon=? where issueid=?");

            statement.setDate(1, new java.sql.Date(cal.getTimeInMillis()));
            statement.setString(2, issueId);

            int x = statement.executeUpdate();
            logger.info("Modified On Updated:::" + x);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (Exception ex) {
                logger.error("Exception in Issue Update  Method" + ex.getMessage());
            }

            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Exception in Issue Update Method" + ex.getMessage());
            }
        }

    }

    public static void updateIssueImageURL(String issueId, String comments) {
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        String rowid = null;
        SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyyyHHmmss");
        String date = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "select rowid from issuecomments where issueid='" + issueId + "' and comments='" + comments + "'";
            rs = statement.executeQuery(query);
            while (rs.next()) {
                rowid = rs.getString(1);
            }
            List<String> urls = URLMapper.extractUrls(comments);
            int count = 0, status = 0;
            for (String url : urls) {
                if (url.contains("googleusercontent")) {
                    if (new IssueDAOImpl().getImageURLCountByURL(url, rowid) == 0) {
                        date = sdf.format(new Date());
                        count++;
                        if (checkGoogleURL(url)) {
                            status = 0;
                        } else {
                            status = 1;
                        }
                        String result = URLMapper.saveImage(url, count + "." + issueId + "_" + rowid.replaceAll("[^a-zA-Z0-9]", "") + "_" + date, issueId, rowid, status, 0l);
                        if (result.equalsIgnoreCase("success")) {
                            new IssueDAOImpl().updateLocalURLinComments(url, "\\eTracker\\Etracker_AttachedFiles\\images\\" + count + "." + issueId + "_" + rowid.replaceAll("[^a-zA-Z0-9]", "") + "_" + date + ".jpg", rowid);
                        }
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (Exception ex) {
                logger.error("Exception in updateIssueImageURL  Method" + ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Exception in updateIssueImageURL Method" + ex.getMessage());
            }
        }
    }
}
