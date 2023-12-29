/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.formbean.FileAttachBean;
import com.eminent.util.GetProjectManager;
import java.sql.Connection;
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

    public List<FileAttachBean> getFilesForIssue(String issueId) {
        List<FileAttachBean> fileList = new ArrayList<FileAttachBean>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select fileid,filename,attacheddate,owner,issuestatus from fileattach where issueid='" + issueId + "'order by fileid desc");
            while (resultset.next()) {
                FileAttachBean bean = new FileAttachBean();
                if (resultset.getTimestamp("attacheddate") != null) {
                    bean.setDate(sdf.format(resultset.getTimestamp("attacheddate")));
                } else {
                    bean.setDate("NA");
                }
                if (resultset.getString("issuestatus") != null) {
                    bean.setStatus(resultset.getString("issuestatus"));
                } else {
                    bean.setStatus("NA");
                }
                bean.setFileName(resultset.getString("fileName"));
                bean.setOwner(resultset.getString("owner"));
                if (resultset.getString("owner") != null) {
                    bean.setOwner(
                            GetProjectManager.getUserName(Integer.parseInt(resultset.getString("owner"))));
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

    public int getFilesIdIssue() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int fileId = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select fid_seq.nextval from dual");
            while (resultset.next()) {
                fileId = resultset.getInt("nextval");
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

        return fileId;

    }

    public int saveFilesForIssue(int fileid, String issueId, String saveFile, int owner, String status) {
        Connection connection = null;
        int fileId = 0;
        try {
            java.util.Date d = new java.util.Date();

            Calendar cal = Calendar.getInstance();
            cal.setTime(d);
            Timestamp ts = new Timestamp(d.getYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getSeconds());
            connection = MakeConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement("insert into fileattach(fileid,issueid,filename,owner,attacheddate,issuestatus) values(?,?,?,?,?,?)");//CHANGED				
            ps.setInt(1, fileid);
            ps.setString(2, issueId);
            ps.setString(3, saveFile);
            ps.setInt(4, owner);
            ps.setTimestamp(5, ts);
            ps.setString(6, status);
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
public int findFileCountForIssue(String issueId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int count =0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from fileattach where issueid='" + issueId + "'order by fileid desc");
            while (resultset.next()) {
                count=resultset.getInt(1);
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
