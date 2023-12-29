/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.ModelDAO;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class ErmQuerySave {

    static org.apache.log4j.Logger logger = null;

    static {
        logger = org.apache.log4j.Logger.getLogger("ErmQuerySave");
    }
    private String querystatus;
    private long queryId;
    private String queryname;
    private String description;
    private String queryString;
    private String buttonValue = "Save My Search";

    public String getQuerystatus() {
        return querystatus;
    }

    public void setQuerystatus(String querystatus) {
        this.querystatus = querystatus;
    }

    public String getQueryname() {
        return queryname;
    }

    public void setQueryname(String queryname) {
        this.queryname = queryname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getQueryString() {
        return queryString;
    }

    public void setQueryString(String queryString) {
        this.queryString = queryString;
    }

    public long getQueryId() {
        return queryId;
    }

    public void setQueryId(long queryId) {
        this.queryId = queryId;
    }

    public String getButtonValue() {
        return buttonValue;
    }

    public void setButtonValue(String buttonValue) {
        this.buttonValue = buttonValue;
    }

    public String toUpdateErmQuery(HttpServletRequest request) throws SQLException {
        String qid = request.getParameter("editQueryId");
        queryString = request.getParameter("querystring");
        if (qid != null) {
            queryId = Long.valueOf(qid);
            MyQuery myView = ERMUtil.findByQueryId(queryId);
            if (myView != null) {
                queryname = myView.getName();
                description = myView.getDescription();
                buttonValue = "Update My Search";
            }
        }
        return querystatus;
    }

    public String saveOrUpdateErmQuery(HttpServletRequest request) throws SQLException, UnsupportedEncodingException {
        HttpSession session = request.getSession();
        String mail = (String) session.getAttribute("theName");
        String qid = request.getParameter("editQueryId");
        queryname = request.getParameter("queryname");
        description = request.getParameter("description");
        queryString = request.getParameter("querystring");
        if (qid != null) {
            queryId = Long.valueOf(qid);
            MyQuery myView = ERMUtil.findByQueryId(queryId);
            if (myView != null) {
                myView.setName(queryname);
                myView.setDescription(description);
                myView.setQueryString(URLDecoder.decode(queryString, "UTF-8"));
                long flag = checkViewName(queryname.trim().toUpperCase(), mail);
                if (flag == 0) {
                   ModelDAO.Update(DAOConstants.ENTITY_MYQUERY, myView);

                } else {
                    if (queryId != flag) {
                        querystatus = "Search Name Already Exists!";
                    }else{
                        ModelDAO.Update(DAOConstants.ENTITY_MYQUERY, myView);
                    }
                }
            }

        } else {

            long flag = checkViewName(queryname.trim().toUpperCase(), mail);
            if (flag == 0) {
                Connection connection = null;
                PreparedStatement preparedStatement1 = null;
                try {
                    Timestamp ts = new Timestamp(new java.util.Date().getTime());
                    int qId = getQuerySeqId();
                    connection = MakeConnection.getConnection();
                    preparedStatement1 = connection.prepareStatement("insert into myquery(query_id,name,description,query_string,email,createdon,search_type) values(?,?,?,?,?,?,?)");
                    preparedStatement1.setInt(1, qId);
                    preparedStatement1.setString(2, queryname);
                    preparedStatement1.setString(3, description);
                    preparedStatement1.setString(4, URLDecoder.decode(queryString, "UTF-8"));
                    preparedStatement1.setString(5, mail);
                    preparedStatement1.setTimestamp(6, ts);
                    preparedStatement1.setString(7, "ERM");
                    preparedStatement1.executeUpdate();
                    connection.commit();
                } catch (Exception ex) {
                    logger.error("saveErmQuery" +ex.getMessage());
                } finally {
                    if (preparedStatement1 != null) {
                        preparedStatement1.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }

                }
            } else {
                querystatus = "Search Name Already Exists!";
            }
        }
        return querystatus;
    }

    public long checkViewName(String viewName, String mail) throws SQLException {
        Connection connection = null;
        Statement st = null;
        ResultSet rs_query = null;
        long queryd = 0l;

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement();
            rs_query = st.executeQuery("select query_Id  from myquery where email='" + mail + "' and upper(name)='" + viewName + "'");
            if (rs_query.next()) {
                queryd = rs_query.getLong("query_Id");
            }
        } catch (Exception ex) {
            logger.error("checkViewName" +ex.getMessage());
        } finally {

            if (st != null) {
                st.close();
            }
            if (rs_query != null) {
                rs_query.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return queryd;
    }

    public int getQuerySeqId() throws SQLException {
        Connection connection = null;
        Statement st = null;
        ResultSet rs_query = null;
        int st1 = 0;
        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement();
            rs_query = st.executeQuery("select queryid_seq.nextval from dual");
            if (rs_query.next()) {
                String st2 = rs_query.getString("nextval");
                st1 = Integer.parseInt(st2);
            }
        } catch (Exception ex) {
            logger.error("getQuerySeqId" +ex.getMessage());
        } finally {

            if (st != null) {
                st.close();
            }
            if (rs_query != null) {
                rs_query.close();
            }
            if (connection != null) {
                connection.close();
            }

        }
        return st1;
    }
}
