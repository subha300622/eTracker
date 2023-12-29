/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminentlabs.dao.HibernateFactory;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Tamilvelan
 */
public class ERMUtil {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ERM Util");
    }

    public static String getID() throws Exception {
        String ERMIdFormat = null;
        Connection connection = null;
        Statement statement = null, dateCheck = null, dropSeqeunceSt = null, seqStatement = null;
        ResultSet resultset = null, dateCheckRs = null, dropSequence = null, seqResultSet = null;
        int day, month, year;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select extract(day from sysdate) as day,extract(month from sysdate) as month,extract(year from sysdate) as year,TO_CHAR(sysdate,'dd-mon-yyyy') as today from dual");
            resultset.next();
            day = resultset.getInt("day");
            month = resultset.getInt("month");
            year = resultset.getInt("year");

            if (day < 10) {
                ERMIdFormat = "E0" + day;
            } else {
                ERMIdFormat = "E" + day;
            }
            if (month < 10) {
                ERMIdFormat = ERMIdFormat + "0" + month + year;
            } else {
                ERMIdFormat = ERMIdFormat + month + year;
            }

            dateCheck = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            dateCheckRs = statement.executeQuery("select APPLICANT_ID from ERM_APPLICANT where to_char(REGISTEREDON,'dd-mm-yyyy') like (select to_char(sysdate,'dd-mm-yyyy') from dual)");

            if (dateCheckRs.next()) {
                seqStatement = connection.createStatement();
                seqResultSet = seqStatement.executeQuery("select APPLICANT_ID_SEQ.nextval as nextvalue from dual");

                seqResultSet.next();
                int nextValue = seqResultSet.getInt("nextvalue");
                if (nextValue < 10) {
                    ERMIdFormat = ERMIdFormat + "00" + nextValue;
                } else if (nextValue >= 10 && nextValue <= 99) {
                    ERMIdFormat = ERMIdFormat + "0" + nextValue;
                } else {
                    ERMIdFormat = ERMIdFormat + nextValue;
                }
                logger.info("Test case ID:\t" + ERMIdFormat);

            } else {
                dropSeqeunceSt = connection.createStatement();
                boolean b = dropSeqeunceSt.execute("drop sequence APPLICANT_ID_SEQ");
                logger.info("Sequence has been dropped:" + b);
                dropSequence = dropSeqeunceSt.executeQuery("create sequence APPLICANT_ID_SEQ start with 1 increment by 1 nocache nocycle");
                dropSequence = dropSeqeunceSt.executeQuery("select APPLICANT_ID_SEQ.nextval as nextvalue from dual");
                dropSequence.next();
                int nextValue = dropSequence.getInt("nextvalue");
                if (nextValue < 10) {
                    ERMIdFormat = ERMIdFormat + "00" + nextValue;
                } else if (nextValue >= 10 && nextValue <= 99) {
                    ERMIdFormat = ERMIdFormat + "0" + nextValue;
                } else {
                    ERMIdFormat = ERMIdFormat + nextValue;
                }
                logger.info("dropped ERM ID:\t" + ERMIdFormat);

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }

            if (statement != null) {
                statement.close();
            }
            if (dateCheckRs != null) {
                dateCheckRs.close();
            }

            if (dateCheck != null) {
                dateCheck.close();
            }
            if (dropSequence != null) {
                dropSequence.close();
            }

            if (dropSeqeunceSt != null) {
                dropSeqeunceSt.close();
            }
            if (seqResultSet != null) {
                seqResultSet.close();
            }

            if (seqStatement != null) {
                seqStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return ERMIdFormat;
    }

    public static int getCommentID() throws Exception {
        Connection connection = null;
        Statement seqStatement = null;
        ResultSet seqResultSet = null;
        int nextValue = 0;

        try {
            connection = MakeConnection.getConnection();

            seqStatement = connection.createStatement();
            seqResultSet = seqStatement.executeQuery("select APPLICANT_COMMENT_SEQ.nextval as nextvalue from dual");

            seqResultSet.next();
            nextValue = seqResultSet.getInt("nextvalue");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            if (seqResultSet != null) {
                seqResultSet.close();
            }

            if (seqStatement != null) {
                seqStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return nextValue;
    }

    public static void addERMComments(String comments, int commentedBy, int statusId, int userId, String appId, int assignedTo,int isfake) {
        Connection connection = null;
        PreparedStatement st = null;

        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {
            updateERMStatus(statusId, appId, assignedTo,isfake);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

        logger.info("ERM Assigned To" + assignedTo);
        try {
            connection = MakeConnection.getConnection();
            st = connection.prepareStatement("INSERT INTO ERM_APPLICANT_COMMENT(COMMENTID,COMMENTEDBY,COMMENTS,COMMENTEDON,COMMENTEDTO,APPLICANT_STATUS,APPLICANTID) values(?,?,?,?,?,?,?)");
            st.setInt(1, getCommentID());
            st.setInt(2, commentedBy);
            st.setString(3, comments);
            st.setTimestamp(4, date);
            st.setInt(5, assignedTo);
            st.setInt(6, statusId);
            st.setString(7, appId);
            st.execute();

        } catch (Exception e) {
            logger.error("Error while addERMComments" + e.getMessage());
        } finally {
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment" + ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection" + ex.getMessage());
            }
        }
    }

    public static void updateERMStatus(int statusId, String appId, int assignedTo,int isfake) {
        Connection connection = null;
        PreparedStatement st = null;

        Timestamp date = new Timestamp(new java.util.Date().getTime());

        try {
            connection = MakeConnection.getConnection();
            st = connection.prepareStatement("update erm_applicant set APPLICANT_STATUS=?,assignedto=?,ISFAKE=? where APPLICANT_ID=?");
            st.setInt(1, statusId);
            st.setInt(2, assignedTo);
            st.setInt(3, isfake);
            st.setString(4, appId);
            st.execute();

        } catch (Exception e) {
            logger.error("Error whileupdating last login" + e.getMessage());
        } finally {
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment" + ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection" + ex.getMessage());
            }
        }
    }

    public static int getAssignedApplicantCount(int assignedTo) {
        Connection connection = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        int count = 0;

        try {
            connection = MakeConnection.getConnection();
            st = connection.prepareStatement("select count(*) as count from erm_applicant where  assignedto=?");
            st.setInt(1, assignedTo);
            rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }

        } catch (Exception e) {
            logger.error("Error whileupdating last login" + e.getMessage());
        } finally {
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment" + ex.getMessage());
            }
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing resultset" + ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection" + ex.getMessage());
            }
        }
        return count;
    }

    public static Map getAssignedApplicantByStaus(int assignedTo) {
        Connection connection = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        Map<Integer, Integer> applicantByStatus = new HashMap();

        try {
            connection = MakeConnection.getConnection();
            st = connection.prepareStatement("select count(*) as count,APPLICANT_STATUS,assignedto from erm_applicant where assignedto=? group by APPLICANT_STATUS,assignedto");
            st.setInt(1, assignedTo);
            rs = st.executeQuery();
            while (rs.next()) {
                int count = rs.getInt("count");
                int applicantStatus = rs.getInt("APPLICANT_STATUS");
                applicantByStatus.put(applicantStatus, count);
            }

        } catch (Exception e) {
            logger.error("getAssignedApplicantDetails" + e.getMessage());
        } finally {
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment" + ex.getMessage());
            }
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing resultset" + ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection" + ex.getMessage());
            }
        }
        return applicantByStatus;
    }

    public static Map getCountsByStaus() {
        Connection connection = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        Map<Integer, Integer> applicantByStatus = new HashMap();

        try {
            connection = MakeConnection.getConnection();
            st = connection.prepareStatement("select count(*) as count,APPLICANT_STATUS from erm_applicant  group by APPLICANT_STATUS");
            rs = st.executeQuery();
            while (rs.next()) {
                int count = rs.getInt("count");
                int applicantStatus = rs.getInt("APPLICANT_STATUS");
                applicantByStatus.put(applicantStatus, count);
            }

        } catch (Exception e) {
            logger.error("getAssignedApplicantDetails" + e.getMessage());
        } finally {
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment" + ex.getMessage());
            }
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing resultset" + ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection" + ex.getMessage());
            }
        }
        return applicantByStatus;
    }

    public static List<ErmApplicant> findERMByAssignedToByStatus(int assignedTo, int applicantStatus) {
        List<ErmApplicant> ermAssignedToList = new ArrayList<ErmApplicant>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ErmApplicant.findByAssignedToAndStatus");
            query.setParameter("assignedto", assignedTo);
            query.setParameter("applicantStatus", applicantStatus);

            ermAssignedToList = (List<ErmApplicant>) query.list();

        } catch (Exception e) {
            logger.error("findERMByAssignedToByStatus" + e.getMessage());
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
        return ermAssignedToList;
    }

    public static List<ErmApplicant> findERMByStatus(int applicantStatus) {
        List<ErmApplicant> ermAssignedToList = new ArrayList<ErmApplicant>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ErmApplicant.findByStatus");
            query.setParameter("applicantStatus", applicantStatus);

            ermAssignedToList = (List<ErmApplicant>) query.list();

        } catch (Exception e) {
            logger.error("findERMByStatus" + e.getMessage());
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
        return ermAssignedToList;
    }

    public static List<ErmApplicant> findAll() {
        List<ErmApplicant> ermAssignedToList = new ArrayList<ErmApplicant>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ErmApplicant.findAll");

            ermAssignedToList = (List<ErmApplicant>) query.list();

        } catch (Exception e) {
            logger.error("findERMByAssignedToByStatus" + e.getMessage());
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
        return ermAssignedToList;
    }

    public static String findEmployee(String applicantId) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rsEmp = null;
        String employer = "";
        try {
            String sql = "select CURRENT_EMPLOYER from ERM_APPLICANT_EXPERIENCE where APPLICANT_ID=? ORDER BY EXPERIENCE_ID ASC";
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, applicantId);

            rsEmp = ps.executeQuery();
            if (rsEmp != null) {
                if (rsEmp.next()) {
                    employer = rsEmp.getString("CURRENT_EMPLOYER");
                } else {
                    employer = "NA";
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                ps.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                connection.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }

        }
        return employer;
    }

    public static ErmApplicant findByApplicantId(String applicantId) {
        ErmApplicant ermApplicant = new ErmApplicant();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ErmApplicant.findByApplicantId");
            query.setParameter("applicantId", applicantId);

            ermApplicant = (ErmApplicant) (query.uniqueResult());
        } catch (Exception e) {
            logger.error("findByApplicantId" + e.getMessage());
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
        return ermApplicant;
    }

    public static List<MyQuery> getMyViews(HttpServletRequest request) {
        List<MyQuery> myViews = new ArrayList<MyQuery>();
        HttpSession hsession = request.getSession();
        String email = (String) hsession.getAttribute("Name");

        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("MyQuery.findByEmail");
            query.setParameter("email", email);

            myViews = (List<MyQuery>) query.list();

        } catch (Exception e) {
            logger.error("getMyViews" + e.getMessage());
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

        return myViews;

    }

    public static MyQuery findByQueryId(long queryId) {
        MyQuery myView = new MyQuery();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("MyQuery.findByQueryId");
            query.setParameter("queryId", queryId);

            myView = (MyQuery) query.uniqueResult();

        } catch (Exception e) {
            logger.error("findByQueryId" + e.getMessage());
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

        return myView;

    }

    public static LinkedHashMap<Integer, String> ermApplicantStatus() {
        LinkedHashMap hm = new LinkedHashMap<Integer, String>();
        hm.put(new Integer(0), "Unscreened");
        hm.put(new Integer(1), "Screening");
        hm.put(new Integer(7), "On Hold");
        hm.put(new Integer(2), "Shortlisted");
        hm.put(new Integer(3), "Rejected");
        hm.put(new Integer(4), "Joined");
        hm.put(new Integer(5), "Offered");
        hm.put(new Integer(6), "Discontinued");
        return hm;
    }
    public static List<ErmApplicantExperience> findAllEmployer() {
        List<ErmApplicantExperience> ermAssignedToList = new ArrayList<ErmApplicantExperience>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ErmApplicantExperience.findAll");

            ermAssignedToList = (List<ErmApplicantExperience>) query.list();

        } catch (Exception e) {
            logger.error("ErmApplicantExperience" + e.getMessage());
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
        return ermAssignedToList;
    }
     public static List<ErmApplicantProject> findAllProjects() {
        List<ErmApplicantProject> ermAssignedToList = new ArrayList<ErmApplicantProject>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ErmApplicantProject.findAll");

            ermAssignedToList = (List<ErmApplicantProject>) query.list();

        } catch (Exception e) {
            logger.error("ErmApplicantProject" + e.getMessage());
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
        return ermAssignedToList;
    }
}
