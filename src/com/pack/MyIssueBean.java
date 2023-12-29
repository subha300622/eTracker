package com.pack;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.util.GetAge;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.MoMUtil;
import dashboard.dao.MydashboardDAO;
import dashboard.dao.MydashboardDAOImpl;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

public class MyIssueBean {

    static Logger logger = Logger.getLogger("MyIssueBean");

    Statement st = null;
    ResultSet rs = null;
    String user, user2, user3;
    PreparedStatement ps = null;

    public ResultSet Query(Connection connection, int user) throws SQLException {
        logger.debug("Query()");
        String createdby = String.valueOf(user);
        ps = connection.prepareStatement("select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and createdby = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setString(1, createdby);
        //rs = st.executeQuery("select project,issueid, type, severity, priority, subject, modifiedon,createdby,assignedto from issue where createdby="+user+"  ORDER  BY createdon desc");
        rs = ps.executeQuery();
        return rs;
    }

    public ResultSet Query1(Connection connection, String theissno) throws SQLException {
        logger.debug("Query1()");
        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);//ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        rs = st.executeQuery("select status from issuestatus where issueid='" + theissno + "' ");//changed

        return rs;
    }

    public ResultSet Query2(Connection connection, String theissno) throws SQLException {
        logger.debug("Query2()");
        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);//ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        rs = st.executeQuery("select fileid,filename,attacheddate,owner,issuestatus from fileattach where issueid='" + theissno + "' ");//changed
        return rs;
    }

    public ResultSet ReQuery(Connection connection, String query_id) throws SQLException {
        logger.debug("ReQuery()");
        int queryid = Integer.parseInt(query_id);
        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = st.executeQuery("select QUERY_STRING from MYQUERY where query_id = " + queryid);
        String query_string = "";
        if (rs != null) {
            rs.next();
            query_string = (String) rs.getString("query_string");
            logger.info("QueryString:" + query_string);

            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery(query_string);
        }
        return rs;
    }

    public ResultSet Query6(Connection connection, int userid) throws SQLException {
        logger.debug("Query6()");
        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);//ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        rs = st.executeQuery("SELECT FIRSTNAME,LASTNAME FROM USERS where USERID = '" + userid + "'");
        return rs;
    }

    public HashMap<Integer, String> getUser(Connection connection) throws SQLException {
        HashMap<Integer, String> hm = new HashMap<Integer, String>();
        logger.debug("getUser()");
        PreparedStatement psa = null;
        ResultSet rsa = null;
        int count = 1;

        try {
            psa = connection.prepareStatement("Select userid,firstname, lastname from users where firstname is not NULL", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            //ps.setInt(1,assignedTo);
            rsa = psa.executeQuery();
            while (rsa.next()) {
                String firstname = rsa.getString("firstname");
                String lastname = rsa.getString("lastname");
                lastname = lastname.substring(0, 1);
                lastname = lastname.toUpperCase();
                int userid = rsa.getInt("userid");
                hm.put(userid, firstname + " " + lastname);
                count++;
            }
            logger.debug("getUserCounter:" + count);
        } catch (Exception e) {
            logger.error("Exception in getUser:" + e.getMessage());
        } finally {
            if (rsa != null) {
                rsa.close();
            }
            if (psa != null) {
                psa.close();
            }
        }
        return hm;
    }

    public ResultSet QueryForUser(Connection connection, String userId, String currentUser, String status, String priority) throws SQLException {
        logger.debug("Query()");
        String query = "";

        if (Integer.parseInt(currentUser) == 104) {
            query = "select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and s.status = ? and assignedto = ? and priority = ?  and i.pid = p.pid order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            ps = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, status);
            ps.setString(2, userId);
            ps.setString(3, priority);

        } else {
            ps = connection.prepareStatement("select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and s.status = ? and assignedto = ? and priority = ?  and i.pid = p.pid and i.pid in (select u.pid from userproject u where u.userid=? intersect select k.pid from userproject k where k.userid=?) order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, status);
            ps.setString(2, userId);
            ps.setString(3, priority);
            ps.setString(4, userId);
            ps.setString(5, currentUser);
        }

        rs = ps.executeQuery();
        return rs;
    }

    public ResultSet QueryForProject(Connection connection, String projectVersion, String status, String priority) throws SQLException {
        logger.debug("Query()");
        //               System.out.println("Project version"+projectVersion);
        int index = projectVersion.lastIndexOf(":");

        String project = projectVersion.substring(0, index);
        String version = projectVersion.substring((index + 1));

        ps = connection.prepareStatement("select  issue.issueid, severity, subject, description, createdby, assignedto, modifiedon, type, due_date, createdon from issue ,issuestatus where issue.project = ? and issue.found_version = ? and issue.priority = ? and issue.issueid = issuestatus.issueid and issuestatus.status = ? ", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setString(1, project);
        ps.setString(2, version);
        ps.setString(3, priority);
        ps.setString(4, status);

        rs = ps.executeQuery();
        return rs;
    }

    public ResultSet QueryForModuleOpenIssue(Connection connection, String pId, String mid) throws SQLException {
        logger.debug("Query()");
        //               System.out.println("Project version"+projectVersion);

        ps = connection.prepareStatement("select issue.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, issuestatus.status,ceil(to_number(sysdate-to_date(createdon)))as age from issue ,issuestatus,modules,project where issue.pid = ? and issue.module_id = ? and issue.pid=project.pid and issue.module_id=modules.moduleid and issue.issueid = issuestatus.issueid and issuestatus.status !='Closed' ", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setString(1, pId);
        ps.setString(2, mid);

        rs = ps.executeQuery();
        return rs;
    }

    public ResultSet QueryForProjectGraph(Connection connection, String projectVersion, String status, String priority) throws SQLException {
        logger.debug("Query()");
        //               System.out.println("Project version"+projectVersion);
        int index = projectVersion.lastIndexOf(":");

        String project = projectVersion.substring(0, index);
        String version = projectVersion.substring((index + 1));

        ps = connection.prepareStatement("select i.issueid, pname as project,module, subject, description, severity, type, createdon,  due_date,  modifiedon, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and pname = ? and version = ? and priority = ? and s.status = ? and p.pid = i.pid order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setString(1, project);
        ps.setString(2, version);
        ps.setString(3, priority);
        ps.setString(4, status);

        rs = ps.executeQuery();
        return rs;
    }

    public ResultSet QueryForSAPProject(Connection connection, String projectVersion, String projectType, String phase, String subPhase, String priority) throws SQLException {
        logger.debug("Query()");
        //              System.out.println("Project version"+projectVersion);
        int index = projectVersion.lastIndexOf(":");

        String project = projectVersion.substring(0, index);
        String version = projectVersion.substring((index + 1));

        String issueTableName = "Issue_" + projectType;

        ps = connection.prepareStatement("select  i.issueid , module, severity, subject, description, type, createdby, assignedto, createdon, due_date, modifiedon, s.status,ceil(to_number(sysdate-to_date(createdon)))as age from issue i, issuestatus s,modules m, project p, " + issueTableName + " where i.pid = p.pid and i.module_id=m.moduleid and pname = ? and version = ? and priority = ? and i.issueid = " + issueTableName + ".issueid and " + issueTableName + ".phase = ? and " + issueTableName + ".subphase = ? and i.issueid = s.issueid and s.status != 'Closed' and i.pid = p.pid order by due_date asc, modifiedon asc, type asc,  severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setString(1, project);
        ps.setString(2, version);
        ps.setString(3, priority);
        ps.setString(4, phase);
        ps.setString(5, subPhase);
        rs = ps.executeQuery();
        return rs;
    }

    public ResultSet QueryForSAPSupportProject(Connection connection, String projectVersion, String phase) throws SQLException {
        logger.debug("Query()");
        int index = projectVersion.lastIndexOf(":");

        String project = projectVersion.substring(0, index);
        String version = projectVersion.substring((index + 1));

        ps = connection.prepareStatement("select  i.issueid , module, severity, priority, type, subject, description, createdby, assignedto, createdon, due_date, modifiedon, s.status from issue i, issuestatus s,modules m, project p, issue_support where i.pid = p.pid and i.module_id=m.moduleid and pname = ? and version = ? and i.issueid = issue_support.issueid and issue_support.phase = ? and i.issueid = s.issueid and s.status != 'Closed' order by due_date asc, modifiedon asc, type asc,  severity asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setString(1, project);
        ps.setString(2, version);
        ps.setString(3, phase);

        rs = ps.executeQuery();
        return rs;
    }

    public void close() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (st != null) {
            st.close();
        }
        if (ps != null) {
            ps.close();
        }
        logger.debug("Closing JDBC resources in close()");
    }

    public List<IssueFormBean> getAllIssueByQuery(String sql, HashMap<Integer, String> userMap) {

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        List<IssueFormBean> issueFormBeanList = new ArrayList<>();
        IssueFormBean issueFormBean;
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();

            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                issueFormBean = new IssueFormBean();
                for (int col = 0; col < row.length; col++) {

                    if (col == 0) {
                        issueFormBean.setIssueId((row[col].toString()));
                    } else if (col == 1) {
                        issueFormBean.setpName(row[col].toString());
                    } else if (col == 2) {
                        issueFormBean.setmName(row[col].toString());
                    } else if (col == 3) {
                        issueFormBean.setSubject(row[col].toString());
                    } else if (col == 4) {
                        issueFormBean.setDescription(row[col].toString());
                    } else if (col == 5) {
                        issueFormBean.setPriority((String) row[col]);

                    } else if (col == 6) {
                        issueFormBean.setSeverity(row[col].toString());

                    } else if (col == 7) {
                        issueFormBean.setType(row[col].toString());
                    } else if (col == 8) {
                        issueFormBean.setCreated((java.util.Date) row[col]);
                    } else if (col == 9) {
                        issueFormBean.setDuedateOn((java.util.Date) row[col]);
                    } else if (col == 10) {
                        issueFormBean.setModifiedDate((java.util.Date) row[col]);
                    } else if (col == 11) {
                        if (userMap.get(MoMUtil.parseInteger((String) (row[col]), 0)) == null) {
                        } else {
                            issueFormBean.setCreatedBy(userMap.get(MoMUtil.parseInteger((String) (row[col]), 0)));
                        }
                    } else if (col == 12) {
                        if (userMap.get(MoMUtil.parseInteger((String) (row[col]), 0)) == null) {
                        } else {
                            issueFormBean.setAssignto(userMap.get(MoMUtil.parseInteger((String) (row[col]), 0)));
                        }
                    } else if (col == 13) {
                        issueFormBean.setStatus((String) (row[col]));
                    } else if (col == 14) {
                        if (row[col] == null) {
                            issueFormBean.setRating("");
                        } else {
                            issueFormBean.setRating(row[col].toString());
                        }
                    } else if (col == 15) {
                        issueFormBean.setFeedback((String) row[col]);
                    }
                }
                issueFormBean.setCreatedOn(sdf.format(issueFormBean.getCreated()));
                issueFormBean.setModifiedOn(sdf.format(issueFormBean.getModifiedDate()));

                issueFormBean.setAge(GetAge.getIssueAge(issueFormBean.getCreatedOn(), issueFormBean.getStatus(), issueFormBean.getModifiedOn()));
                issueFormBeanList.add(issueFormBean);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return issueFormBeanList;
    }

    /*Edit by mukesh ReQuery*/

    public void ReQueryRequest(Connection connection, String query_id, HttpServletRequest request) throws SQLException {

        String query_string = "";
        String issueHistory = "no";
        String issueRating = "no";
        try {
            int queryid = MoMUtil.parseInteger(query_id, 0);

            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select QUERY_STRING,ISSUEDAYHISTORY,ISSUERATING from MYQUERY where query_id = " + queryid);

            if (rs != null) {
                rs.next();
                query_string = (String) rs.getString("query_string");
                issueHistory = (String) rs.getString("ISSUEDAYHISTORY");
                if (issueHistory == null || issueHistory.isEmpty() || issueHistory.equalsIgnoreCase("")) {
                    issueHistory = "no";
                }
                issueRating = (String) rs.getString("ISSUERATING");
                if (issueHistory == null || issueHistory.isEmpty() || issueHistory.equalsIgnoreCase("")) {
                    issueHistory = "no";
                }

            }
            request.getSession().setAttribute("issueRating", issueHistory);
            request.getSession().setAttribute("IssuedayHistory", issueHistory);
            request.getSession().setAttribute("IssueSummaryQuery", query_string);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            close();
        }
    }
}
