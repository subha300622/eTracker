/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import com.eminent.issue.PlanStatus;
import com.eminent.util.GetProjectMembers;
import com.eminentlabs.dao.DAOFactory;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.formbean.FineAmountBean;
import com.eminentlabs.mom.formbean.FinePaymentBean;
import com.eminentlabs.mom.formbean.FineReportBean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author RN.Khans
 */
public class FineUtil {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("FineUtil");
    }

    public static List<Fine> getFineAmount() {
        Session session = null;
        List<Fine> fineAmtList = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Fine.findAll");
            fineAmtList = (List<Fine>) query.list();

        } catch (Exception e) {
            logger.error("getFineAmount" + e.getMessage());
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
        return fineAmtList;
    }

    public static Fine getFineAmountById(long reasonId) {
        Session session = null;
        Fine fineAmt = new Fine();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Fine.findById");
            query.setParameter("id", reasonId);
            fineAmt = (Fine) query.uniqueResult();
        } catch (Exception e) {
            logger.error("getFineAmountById" + e.getMessage());
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
        return fineAmt;
    }

    public static Fine getReasonId(String reason) {
        Session session = null;
        Fine fineAmt = new Fine();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("Fine.findByReason");
            query.setParameter("reason", reason);
            fineAmt = (Fine) query.uniqueResult();
        } catch (Exception e) {
            logger.error("getReasonId" + e.getMessage());
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
        return fineAmt;
    }

    public static FineAmountUsers getId(FineAmountUsers fau) {
        Session session = null;
        FineAmountUsers fineAmtid = new FineAmountUsers();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("FineAmountUsers.findByUniuqeReasonID");
            query.setParameter("userid", fau.getUserid());
            query.setParameter("reasonid", fau.getReasonid());
            query.setParameter("fineDate", fau.getFineDate());
            fineAmtid = (FineAmountUsers) query.uniqueResult();
        } catch (Exception e) {
            logger.error("getId" + e.getMessage());
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
        return fineAmtid;
    }

    public static String addFineAmtForUser(FineAmountUsers fineAmountUsers) {
        String result;
        long id = 0l;
        FineAmountUsers fau = getId(fineAmountUsers);
        if (fau != null) {
            id = fau.getId();
        }
        if (id == 0l) {
            DAOFactory.addFineAmtUser(fineAmountUsers);
            result = "add";
        } else {
            fineAmountUsers.setId(id);
            DAOFactory.updateFineAmtUser(fineAmountUsers);
            result = "update";
        }
        return result;
    }

    public static String fineAmtRevoke(FineAmountUsers fau) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String result = null;
        try {
            connection = MakeConnection.getConnection();
            String query = "update FINE_AMOUNT_USERS set addedby = '" + fau.getAddedby() + "',addedon=(select sysdate from dual),status =' " + fau.getStatus() + "',comments = '" + fau.getComments() + "'  where id=" + fau.getId();
            logger.info("Update Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            statement.executeUpdate(query);
            result = "success";
        } catch (Exception e) {
            logger.error("fineAmtRevoke" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return result;
    }

    public static long addReason(Fine reason) {
        long id = 0l;
        Fine rid = getReasonId(reason.getReason());
        if (rid == null) {
            id = 0l;
        } else {
            id = rid.getId();
        }
        if (id == 0l) {
            DAOFactory.addReason(reason);
        }
        return id;
    }

    public static long checkReason(Fine reason) {
        long id = 0l;
        Fine rid = getReasonId(reason.getReason());
        if (rid == null) {
            id = 0l;
        } else {
            id = rid.getId();
        }

        logger.info("reason id : " + id);
//        if (id == 0l) {
//            DAOFactory.addReason(reason);
//        }
        return id;
    }

    public static long updateReason(Fine reason) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        long id = reason.getId();
        try {
            connection = MakeConnection.getConnection();
            String query = "update fine set amount = " + reason.getAmount() + ",addedby = " + reason.getAddedby() + " ,addedon=(select sysdate from dual)  where id=" + reason.getId();
            logger.info("Update Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            statement.executeUpdate(query);
        } catch (Exception e) {
            logger.error("updateReason" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return id;
    }

    public static List<FineAmountBean> getFineAmtUsers(String fromDate, String toDate) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<FineAmountBean> fineAmtList = new ArrayList<FineAmountBean>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String status = PlanStatus.ACTIVE.getStatus();
        try {
            connection = MakeConnection.getConnection();
            String query = "select a.id as id,a.userid as userid,c.firstname||' '||substr(c.lastname,0,1) as name,b.reason as reason,a.fine_date as fdate,a.amount as amount from FINE_AMOUNT_USERS a,fine b,users c where a.userid=c.userid and a.reasonid=b.id and a.status= '" + status + "' and a.fine_date between '" + fromDate + "' and '" + toDate + "' order by fdate";
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                FineAmountBean fab = new FineAmountBean();
                fab.setFineId(resultset.getString("id"));
                fab.setName(resultset.getString("name"));
                fab.setReason(resultset.getString("reason"));
                fab.setDate(sdf.format(resultset.getDate("fdate")));
                fab.setAmount(resultset.getString("amount"));
                fineAmtList.add(fab);
            }
        } catch (Exception e) {
            logger.error("getFineAmtUsers" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getFineAmtUsers" + ex.getMessage());
            }
        }
        return fineAmtList;

    }

    public static List<FineAmountBean> getFineAmtForMonth(int userId, String fromDate, String toDate) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<FineAmountBean> fineAmtList = new ArrayList<FineAmountBean>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String status = PlanStatus.ACTIVE.getStatus();

        try {
            connection = MakeConnection.getConnection();
            String query = "select c.firstname||' '||substr(c.lastname,0,1) as name,b.reason as reason,a.fine_date as fdate,a.amount as amount from FINE_AMOUNT_USERS a,fine b,users c where a.userid=c.userid and a.reasonid=b.id and a.status='" + status + "' and a.userid=" + userId + " and a.fine_date between '" + fromDate + "' and '" + toDate + "' order by fdate";
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                FineAmountBean fab = new FineAmountBean();
                fab.setName(resultset.getString("name"));
                fab.setReason(resultset.getString("reason"));
                fab.setDate(sdf.format(resultset.getDate("fdate")));
                fab.setAmount(resultset.getString("amount"));
                fineAmtList.add(fab);
            }
        } catch (Exception e) {
            logger.error("getFineAmtForMonth" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getFineAmtForMonth" + ex.getMessage());
            }
        }
        return fineAmtList;
    }

    public static List<FineAmountBean> getFineAmtForDate(String fineDate, String teamType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<FineAmountBean> fineAmtList = new ArrayList<FineAmountBean>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String status = PlanStatus.ACTIVE.getStatus();

        try {
            connection = MakeConnection.getConnection();
            String query = "select c.firstname||' '||substr(c.lastname,0,1) as name,b.reason as reason,a.fine_date as fdate,a.amount as amount from FINE_AMOUNT_USERS a,fine b,users c, MOM_Maintanance mm where a.userid=mm.userid and mm.team in(" + teamType + ") and a.userid=c.userid and a.reasonid=b.id and a.status='" + status + "' and a.fine_date = '" + fineDate + "' order by name";
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                FineAmountBean fab = new FineAmountBean();
                fab.setName(resultset.getString("name"));
                fab.setReason(resultset.getString("reason"));
                fab.setDate(sdf.format(resultset.getDate("fdate")));
                fab.setAmount(resultset.getString("amount"));
                fineAmtList.add(fab);
            }
        } catch (Exception e) {
            logger.error("getFineAmtForMonth" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getFineAmtForMonth" + ex.getMessage());
            }
        }
        return fineAmtList;
    }

    public static int getTotalFineAmt(String userId, long paymentId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int fineAmount = 0;
        int paidAmount = 0;
        int balanceAmount = 0;
        try {
            String status = PlanStatus.ACTIVE.getStatus();
            int user = MoMUtil.parseInteger(userId, 0);
            connection = MakeConnection.getConnection();
            String query = "select sum(amount) from fine_amount_users where status='" + status + "' and userid=" + user;
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                fineAmount = resultset.getInt(1);
            }
            String querya = "";
            if (paymentId == 0l) {
                querya = "select sum(amount) from erm_fine_paid where status='" + status + "' and userid=" + user;
            } else {
                querya = "select sum(amount) from erm_fine_paid where status='" + status + "' and userid=" + user + "and id !=" + paymentId;
            }
            logger.info(" Query1 :" + querya);
            resultset = statement.executeQuery(querya);
            while (resultset.next()) {
                paidAmount = resultset.getInt(1);
            }
            balanceAmount = fineAmount - paidAmount;
        } catch (Exception e) {
            logger.error("getTotalFineAmt" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getTotalFineAmt" + ex.getMessage());
            }
        }
        return balanceAmount;
    }

    public static void addFinePayment(ErmFinePaid payment) {
        DAOFactory.addFinePayment(payment);
        long paymentId = getlastPaymentId();
        if (paymentId != 0l) {
            payment.setId(paymentId);
            addFinePaymnentHistory(payment);
        }

    }

    public static HashMap<Integer, String> getUsers() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<Integer, String> userList = new HashMap<Integer, String>();
        String status = PlanStatus.ACTIVE.getStatus();
        try {
            connection = MakeConnection.getConnection();
            String query = "select distinct(a.userid),b.firstname||' '||b.lastname as name from fine_amount_users a,users b where a.userid=b.userid and a.status=" + status + " order by name";
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                int id = resultset.getInt(1);
                String name = resultset.getString(2);
                userList.put(id, name);
            }
        } catch (Exception e) {
            logger.error("getUsers" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getUsers" + ex.getMessage());
            }
        }
        return userList;
    }

    public static List<FinePaymentBean> getPaymentList() {
        List<FinePaymentBean> paymentList = new ArrayList<FinePaymentBean>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        try {
            String status = PlanStatus.ACTIVE.getStatus();
            connection = MakeConnection.getConnection();
            String query = "select a.id,a.userid,b.firstname||' '||b.lastname as name,a.PAID_DATE,a.amount,c.firstname||' '||c.lastname as cname,a.comments from erm_fine_paid a,users b,users c where a.userid=b.userid and a.collectedby=c.userid and a.status='" + status + "' order by PAID_DATE desc";
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                FinePaymentBean bean = new FinePaymentBean();
                bean.setPaymentId(resultset.getLong(1));
                bean.setUserId(resultset.getInt(2));
                bean.setName(resultset.getString(3));
                bean.setDate(sdf.format(resultset.getDate(4)));
                bean.setAmount(resultset.getInt(5));
                bean.setCollectedby(resultset.getString(6));
                bean.setComments(resultset.getString(7));
                paymentList.add(bean);
            }
        } catch (Exception e) {
            logger.error("getPaymentList" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getPaymentList" + ex.getMessage());
            }
        }
        return paymentList;
    }

    public static FinePaymentBean getPaymentId(String paymentId) {
        long id = Long.valueOf(paymentId);
        FinePaymentBean bean = new FinePaymentBean();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        try {
            connection = MakeConnection.getConnection();
            String query = "select a.id,a.userid,b.firstname||' '||b.lastname as name,a.PAID_DATE,a.amount,c.firstname||' '||c.lastname as cname,a.collectedby,a.comments from erm_fine_paid a,users b,users c where a.userid=b.userid and a.collectedby=c.userid and a.id=" + id;
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                bean.setPaymentId(resultset.getLong(1));
                bean.setUserId(resultset.getInt(2));
                bean.setName(resultset.getString(3));
                bean.setDate(sdf.format(resultset.getDate(4)));
                bean.setAmount(resultset.getInt(5));
                bean.setCollectedby(resultset.getString(6));
                bean.setCollectedbyUserId(resultset.getInt(7));
                bean.setComments(resultset.getString(8));
            }
        } catch (Exception e) {
            logger.error("getPaymentId" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getPaymentId" + ex.getMessage());
            }
        }
        return bean;
    }

    public static long getlastPaymentId() {
        long paymentId = 0l;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            String query = "select max(id) from erm_fine_paid";
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                paymentId = resultset.getLong(1);
            }
        } catch (Exception e) {
            logger.error("getlastPaymentId" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getlastPaymentId" + ex.getMessage());
            }
        }
        return paymentId;
    }

    private static void addFinePaymnentHistory(ErmFinePaid payment) {
        ErmFinePaymentHistory history = new ErmFinePaymentHistory();
        try {
            Calendar cal = Calendar.getInstance();
            history.setPaymentid(payment.getId());
            history.setUserid(payment.getUserid());
            history.setAmount(payment.getAmount());
            history.setPaymentDate(payment.getPaidDate());
            history.setCollectedby(payment.getCollectedby());
            history.setComments(payment.getComments());
            history.setAddedon(cal.getTime());
            history.setStatus(payment.getStatus());
            DAOFactory.addFinePaymentHistory(history);

        } catch (Exception e) {
            logger.error("addFinePaymnentHistory" + e.getMessage());
        }
    }

    public static void updateFinePayment(ErmFinePaid payment) {
        DAOFactory.updateFinePayment(payment);
        updatePaymentHistory(payment);
    }

    private static void updatePaymentHistory(ErmFinePaid payment) {
        ErmFinePaymentHistory history = new ErmFinePaymentHistory();
        try {
            Calendar cal = Calendar.getInstance();
            history.setPaymentid(payment.getId());
            history.setUserid(payment.getUserid());
            history.setAmount(payment.getAmount());
            history.setPaymentDate(payment.getPaidDate());
            history.setCollectedby(payment.getModifiedby());
            history.setComments(payment.getComments());
            history.setAddedon(cal.getTime());
            history.setStatus(payment.getStatus());
            DAOFactory.addFinePaymentHistory(history);
        } catch (Exception e) {
            logger.error("updatePaymentHistory" + e.getMessage());
        }
    }

    public static HashMap<Integer, String> getPaymentUsers() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int fineAmount = 0;
        int paidAmount = 0;
        int balanceAmount = 0;
        HashMap<Integer, String> member = GetProjectMembers.showUsers();
        HashMap<Integer, Integer> fineAmt = new HashMap<Integer, Integer>();
        HashMap<Integer, Integer> paymentAmt = new HashMap<Integer, Integer>();
        HashMap<Integer, String> fineAmtList = new HashMap<Integer, String>();

        try {
            String status = PlanStatus.ACTIVE.getStatus();
            connection = MakeConnection.getConnection();
            String query = "select sum(amount),userid from fine_amount_users where status='" + status + "' group by userid";
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                fineAmt.put(resultset.getInt(2), resultset.getInt(1));
            }
            String querya = "select sum(amount),USERID from erm_fine_paid where status='" + status + "' group by USERID";
            logger.info(" Querya :" + querya);
            resultset = statement.executeQuery(querya);
            while (resultset.next()) {
                paymentAmt.put(resultset.getInt(2), resultset.getInt(1));
            }

            for (Map.Entry<Integer, Integer> enrty : fineAmt.entrySet()) {
                fineAmount = enrty.getValue();
                if (paymentAmt.containsKey(enrty.getKey())) {
                    paidAmount = paymentAmt.get(enrty.getKey());
                    balanceAmount = fineAmount - paidAmount;
                } else {
                    balanceAmount = fineAmount;
                }
                if (balanceAmount > 0) {
                    fineAmtList.put(enrty.getKey(), member.get(enrty.getKey()));
                }
            }

        } catch (Exception e) {
            logger.error("getPaymentUsers" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getPaymentUsers" + ex.getMessage());
            }
        }
        return fineAmtList;
    }

    public static FineAmountBean getFineAmtUser(String fineId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        FineAmountBean fab = new FineAmountBean();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        try {
            connection = MakeConnection.getConnection();
            String query = "select a.id as id,c.firstname||' '||c.lastname as name,b.reason as reason,a.fine_date as fdate,a.amount as amount from FINE_AMOUNT_USERS a,fine b,users c where a.userid=c.userid and a.reasonid=b.id and a.id=" + fineId + "";
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                fab.setFineId(resultset.getString("id"));
                fab.setName(resultset.getString("name"));
                fab.setReason(resultset.getString("reason"));
                fab.setDate(sdf.format(resultset.getDate("fdate")));
                fab.setAmount(resultset.getString("amount"));

            }
        } catch (Exception e) {
            logger.error("getFineAmtUser" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getFineAmtUser" + ex.getMessage());
            }
        }
        return fab;
    }

    public static FineReportBean fineReportForTS(int userId, String start, String end) {
        FineReportBean report = new FineReportBean();
        Connection connection = null;
        Statement statement = null, statementa = null, statementb = null;
        ResultSet resultset = null, resultseta = null, resultsetb = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        List<FineAmountBean> fineAmtList = getFineAmtForMonth(userId, start, end);
        List<FinePaymentBean> paymentList = new ArrayList();
        String status = PlanStatus.ACTIVE.getStatus();

        int prevFine = 0;
        int prevPayment = 0;
        int currFine = 0;
        int currPayment = 0;
        int prevBal = 0;
        int closeBal = 0;

        try {
//            Calendar cal = Calendar.getInstance();
//            cal.add(Calendar.MONTH, -1);
//            String prevMonthYear = "01-" + new SimpleDateFormat("MMM-yyyy").format(cal.getTime());
            connection = MakeConnection.getConnection();
            String prevFineQuery = "select sum(AMOUNT) from FINE_AMOUNT_USERS where STATUS='Active' and userid=" + userId + "  and fine_date < '" + start + "' ";
            logger.info(" prevFineQuery :" + prevFineQuery);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(prevFineQuery);
            while (resultset.next()) {
                prevFine = resultset.getInt(1);
            }

            String prevPayQuery = "select sum(AMOUNT) from ERM_FINE_PAID where STATUS='Active' and userid=" + userId + " and PAID_DATE < '" + start + "'";
            logger.info(" prevPayQuery :" + prevPayQuery);
            statementa = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultseta = statementa.executeQuery(prevPayQuery);
            while (resultseta.next()) {
                prevPayment = resultseta.getInt(1);
            }


            String currPayQuery = "select a.PAID_DATE as pdate,a.amount as amount,a.comments as comments from erm_fine_paid a,users b where a.userid=b.userid  and a.status='Active'  and a.userid=" + userId + " and PAID_DATE between '" + start + "' and '" + end + "' order by PAID_DATE desc";
            logger.info(" currPayQuery :" + currPayQuery);
            statementb = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultsetb = statementb.executeQuery(currPayQuery);
            while (resultsetb.next()) {
                FinePaymentBean payment = new FinePaymentBean();
                payment.setComments(resultsetb.getString("comments"));
                payment.setDate(sdf.format(resultsetb.getDate("pdate")));
                payment.setAmount(resultsetb.getInt("amount"));
                paymentList.add(payment);
            }

            for (FineAmountBean amount : fineAmtList) {
                currFine = currFine + Integer.parseInt(amount.getAmount());
            }
            for (FinePaymentBean amount : paymentList) {
                currPayment = currPayment + amount.getAmount();
            }
            prevBal = prevFine - prevPayment;
            closeBal = (prevBal + currFine) - currPayment;

            report.setPrevBalance(prevBal);
            report.setCurrMonFine(currFine);
            report.setCurrMonPaid(currPayment);
            report.setCloseBalance(closeBal);
            report.setFineAmtList(fineAmtList);
            report.setFinePaidList(paymentList);

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("fineReportForTS" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (resultseta != null) {
                    resultseta.close();
                }
                if (resultsetb != null) {
                    resultsetb.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (statementa != null) {
                    statementa.close();
                }
                if (statementb != null) {
                    statementb.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                logger.error("fineReportForTS" + ex.getMessage());
            }
        }
        return report;
    }

    public static HashMap<Integer, Integer> getPrevMonFine(String startDate) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<Integer, Integer> prevFineAmt = new HashMap();
        try {

            connection = MakeConnection.getConnection();
            String prevFineQuery = "select sum(AMOUNT),userid from FINE_AMOUNT_USERS where STATUS='Active' and fine_date < '" + startDate + "' group by userid";
            logger.info(" prevFineQuery :" + prevFineQuery);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(prevFineQuery);
            while (resultset.next()) {
                prevFineAmt.put(resultset.getInt(2), resultset.getInt(1));
            }

        } catch (Exception e) {
            logger.error("getPrevMonFine" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getPrevMonFine" + ex.getMessage());
            }
        }
        return prevFineAmt;

    }

    public static HashMap<Integer, Integer> getPrevMonFinePaid() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<Integer, Integer> prevFineAmtPaid = new HashMap();
        try {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.MONTH, 0);
            String curr = "01-" + new SimpleDateFormat("MMM-yyyy").format(cal.getTime());
            connection = MakeConnection.getConnection();
            String prevFineQuery = "select sum(AMOUNT),userid from ERM_FINE_PAID where STATUS='Active'  and PAID_DATE < '" + curr + "' group by userid";
            logger.info(" prevFineQuery :" + prevFineQuery);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(prevFineQuery);
            while (resultset.next()) {
                prevFineAmtPaid.put(resultset.getInt(2), resultset.getInt(1));
            }
        } catch (Exception e) {
            logger.error("getPrevMonFine" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getPrevMonFine" + ex.getMessage());
            }
        }
        return prevFineAmtPaid;

    }

    public static HashMap<Integer, String> getMonthName() {
        HashMap<Integer, String> monthSelect = new HashMap();
        monthSelect.put(0, "Jan");
        monthSelect.put(1, "Feb");
        monthSelect.put(2, "Mar");
        monthSelect.put(3, "Apr");
        monthSelect.put(4, "May");
        monthSelect.put(5, "Jun");
        monthSelect.put(6, "Jul");
        monthSelect.put(7, "Aug");
        monthSelect.put(8, "Sep");
        monthSelect.put(9, "Oct");
        monthSelect.put(10, "Nov");
        monthSelect.put(11, "Dec");
        return monthSelect;
    }

    public static List<Integer> getYears() {
        ArrayList<Integer> selectYears = new ArrayList();
        Calendar cal = new GregorianCalendar();
        int currentYear = cal.get(Calendar.YEAR);
        int startYear = 2008;

        while (startYear <= currentYear) {
            selectYears.add(startYear);
            startYear++;
        }
        return selectYears;
    }
}
