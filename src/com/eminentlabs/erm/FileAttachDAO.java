/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminent.issue.controller.*;
import com.eminent.issue.formbean.FileAttachBean;
import com.eminent.util.GetProjectManager;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class FileAttachDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("FileAttachDAO");
    }

    public List<FileAttachBean> getFilesForApplicantId(String applicantId) {
        List<FileAttachBean> fileList = new ArrayList<FileAttachBean>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select * from ERM_APPLICANT_FILE where APPLICANT_ID='" + applicantId + "'order by FILE_ID desc");
            while (resultset.next()) {
                FileAttachBean bean = new FileAttachBean();
                if (resultset.getDate("ATTACHEDDATE") != null) {
                    bean.setDate(sdf.format(resultset.getDate("ATTACHEDDATE")));
                } else {
                    bean.setDate("NA");
                }

                bean.setFileName(resultset.getString("FILENAME"));
                bean.setOwner(resultset.getString("OWNER"));
                if (resultset.getString("OWNER") != null) {
                    bean.setOwner(
                            GetProjectManager.getUserName(Integer.parseInt(resultset.getString("OWNER"))));
                } else {
                    bean.setOwner("NA");
                }
                fileList.add(bean);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (statement != null) {
                    statement.close();
                }
                if (resultset != null) {
                    resultset.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return fileList;

    }

    public int saveFilesForIssue(String applicantId, String saveFile, int owner) {
        Connection connection = null;
        int fileId = 0;
        try {
            java.util.Date d = new java.util.Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(d);
            Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());

            connection = MakeConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement("insert into ERM_APPLICANT_FILE(APPLICANT_ID,FILENAME,owner,ATTACHEDDATE) values(?,?,?,?)");//CHANGED				
            ps.setString(1, applicantId);
            ps.setString(2, saveFile);
            ps.setInt(3, owner);
            ps.setTimestamp(4, ts);
            ps.executeUpdate();
            connection.commit();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return fileId;
    }

    public int findFileCountForApplicantId(String applicantId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int count = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from ERM_APPLICANT_FILE where APPLICANT_ID='" + applicantId + "'");
            while (resultset.next()) {
                count = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }
                if (resultset != null) {
                    resultset.close();
                }
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
