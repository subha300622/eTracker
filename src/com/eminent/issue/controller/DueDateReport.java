/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.formbean.DueDateTodayAndExceFormBean;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class DueDateReport {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("DueDateReport");
    }
    List<DueDateTodayAndExceFormBean> finalized = new ArrayList<>();
    /*
     *  
     * To get issues count based on Due date before today open issues 
     * project which is work in progress exactly like mom
     * 
     * 
     */
    public List<DueDateTodayAndExceFormBean> dueDateExceededCount() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<DueDateTodayAndExceFormBean> ddtaefbs = new ArrayList<>();
        String sql = "select count(i.issueid) as count, p.pid, concat(Firstname,concat(' ',substr(lastname,0,1))) as name,concat(pname,concat(' v', version)) as prname from issue i,issuestatus s,project p,users u where  i.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and i.issueid=s.issueid  and u.userid=p.pmanager and to_date(to_char(due_date,'DD-Mon-YYYY'),'DD-Mon-YYYY') < to_date(to_char(sysdate,'DD-Mon-yyyy'),'DD-Mon-YYYY') and s.status!='Closed' group by p.pid,Firstname,lastname,pname,version order by count";
        int i = 0;
        logger.info("Project SQL" + sql);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery(sql);

            while (resultset.next()) {
                DueDateTodayAndExceFormBean ddtaefb = new DueDateTodayAndExceFormBean();
                ddtaefb.setPid(resultset.getLong("pid"));
                ddtaefb.setExcCount(resultset.getInt("count"));
                ddtaefb.setPmanager(resultset.getString("name"));
                ddtaefb.setPname(resultset.getString("prname"));
                ddtaefbs.add(ddtaefb);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
        return ddtaefbs;
    }

    /*
     *  
     * To get issues count based on Due date today open issues 
     * project which is work in progress exactly like mom
     * 
     * 
     */
    public List<DueDateTodayAndExceFormBean> dueDateExceededOnToday(List<DueDateTodayAndExceFormBean> ddtaefbs) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String sql = "select count(i.issueid) as count, p.pid, concat(Firstname,concat(' ',substr(lastname,0,1))) as name, concat(pname,concat(' v', version)) as prname from issue i,issuestatus s,project p,users u where  i.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and i.issueid=s.issueid  and u.userid=p.pmanager and to_char(due_date,'dd-Mon-YYYY') =to_char(sysdate,'DD-Mon-yyyy') and s.status!='Closed' group by p.pid,Firstname,lastname,pname,version";
        List<DueDateTodayAndExceFormBean> ddtaefbsa = new ArrayList<>();
        List<Long> pidsa = new ArrayList<>();
        List<Long> pids = new ArrayList<>();
        int i = 0;
        logger.info("Project SQL" + sql);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery(sql);

            while (resultset.next()) {
                DueDateTodayAndExceFormBean ddtaefb = new DueDateTodayAndExceFormBean();
                boolean flag = true;
                for (DueDateTodayAndExceFormBean ddtaefbA : ddtaefbs) {

                    if (resultset.getLong("pid") == ddtaefbA.getPid()) {
                        ddtaefbA.setTodCont(resultset.getInt("count"));
                        ddtaefbsa.add(ddtaefbA);
                        pids.add(resultset.getLong("pid"));
                        flag = false;
                    }
                }
                if (flag == true) {
                    ddtaefb.setPid(resultset.getLong("pid"));
                    ddtaefb.setTodCont(resultset.getInt("count"));
                    ddtaefb.setPmanager(resultset.getString("name"));
                    ddtaefb.setPname(resultset.getString("prname"));
                    ddtaefbsa.add(ddtaefb);
                }
            }

            for (DueDateTodayAndExceFormBean ddtaefbA : ddtaefbsa) {
                pidsa.add(ddtaefbA.getPid());
            }
            for (DueDateTodayAndExceFormBean ddtaefbA : ddtaefbs) {
                if (!pidsa.contains(ddtaefbA.getPid())) {
                    ddtaefbsa.add(ddtaefbA);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
        return ddtaefbsa;
    }

    public static Map<Integer, Integer> dueDateExceededCountAmount() {
        Map<Integer, Integer> dueDateExceedIssueAmount = new HashMap<Integer, Integer>();

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        String sql = "select count(i.issueid) as count,u.userid from issue i,issuestatus s,project p,users u where  i.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and i.issueid=s.issueid  and u.userid=p.pmanager and to_date(to_char(due_date,'DD-Mon-YYYY'),'DD-Mon-YYYY') < to_date(to_char(sysdate,'DD-Mon-yyyy'),'DD-Mon-YYYY') and s.status!='Closed' group by p.pid,u.userid";
        int  userid = 0, count = 0;
        logger.info("Project SQL" + sql);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                userid = resultset.getInt("userid");
                count = resultset.getInt("count");
                if (dueDateExceedIssueAmount.containsKey(userid)) {
                    int value = dueDateExceedIssueAmount.get(userid);
                    dueDateExceedIssueAmount.put(userid, value + count * 100);
                } else {
                    dueDateExceedIssueAmount.put(userid, count * 100);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
        return dueDateExceedIssueAmount;
    }

    /*
     *  
     *
     *Call this method in jsp
     * 
     * 
     */
    public List<DueDateTodayAndExceFormBean> setAll() {
        List<DueDateTodayAndExceFormBean> ddtaefbs = dueDateExceededCount();
        finalized = dueDateExceededOnToday(ddtaefbs);

        return finalized;
    }

    public List<DueDateTodayAndExceFormBean> getFinalized() {
        return finalized;
    }

    public void setFinalized(List<DueDateTodayAndExceFormBean> finalized) {
        this.finalized = finalized;
    }
}
