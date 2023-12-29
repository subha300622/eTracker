/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.controller.Escalation;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author vanithaalliraj
 */
public class EscalationDAOImpl implements EscalationDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("EscalationDAOImpl");
    }

    @Override
    public String getEscalationCount() {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        int count = 0;
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select count(i.issueid)  from issue i left join project p on i.pid= p.pid where p.PMANAGER !=104 and i.escalation ='yes' and p.STATUS='Work in progress' and i.RATING is null";

            rsForProject = stForProject.executeQuery(query);
            if (rsForProject.next()) {
                count = rsForProject.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return "\nEscalated issue count : " + count;
    }

    @Override
    public List<String> escalationList(int projectId) {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        List<String> issues = new ArrayList<String>();
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select distinct(issueid)  from issue where escalation ='yes' and RATING is null";
            if (projectId > 0) {
                query = query + " and pid=" + projectId;
            }
            rsForProject = stForProject.executeQuery(query);
            while (rsForProject.next()) {
                issues.add(rsForProject.getString(1));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return issues;
    }

    @Override
    public List<Integer> escalationProejctList() {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        List<Integer> projects = new ArrayList<Integer>();
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rsForProject = stForProject.executeQuery("select distinct(i.pid)  from issue i left join project p on i.pid= p.pid where i.escalation ='yes' and p.PMANAGER !=104 and p.STATUS='Work in progress' and i.RATING is null");
            while (rsForProject.next()) {
                projects.add(rsForProject.getInt(1));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return projects;
    }

    @Override
    public List<Escalation> getEscalation() {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        List<Escalation> issues = new ArrayList<Escalation>();
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select i.ISSUEID,i.SUBJECT,u.FIRSTNAME||' '||SubStr(u.lastname,0,1) as assigned,pm.FIRSTNAME||' '||SubStr(pm.lastname,0,1) as pmanager,\n"
                    + "dm.FIRSTNAME||' '||SubStr(dm.lastname,0,1) as dmanager,ceil(to_number(sysdate-to_date(i.createdon))),i.pid,i.ASSIGNEDTO,\n"
                    + "ceil(to_number(sysdate-to_DATE (TO_CHAR (e.ADDEDON,'yyyy-MM-dd'),'yyyy-MM-dd'))) as escage \n"
                    + " from issue i left join project p on i.pid= p.pid left join USERS u on i.ASSIGNEDTO=u.USERID left join users pm on p.PMANAGER=pm.USERID left join users dm on p.DMANAGER=dm.USERID \n"
                    + "left join escalation_issue e on i.ISSUEID=e.ISSUEID\n"
                    + "  where  i.escalation ='yes' and i.RATING is null and p.PMANAGER !=104 and  p.STATUS='Work in progress' and i.RATING is null  order by escage desc,i.MODIFIEDON";
            rsForProject = stForProject.executeQuery(query);
            while (rsForProject.next()) {
                Escalation escalation = new Escalation();
                escalation.setIssueId(rsForProject.getString(1));
                escalation.setSubject(rsForProject.getString(2));
                escalation.setAssginedTo(rsForProject.getString(3));
                escalation.setPmanager(rsForProject.getString(4));
                escalation.setDmanager(rsForProject.getString(5));
                escalation.setDays(rsForProject.getInt(6));
                escalation.setPid(rsForProject.getLong(7));
                escalation.setAssginedToId(rsForProject.getInt(8));
                escalation.setEscDays(rsForProject.getInt(9));

                issues.add(escalation);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return issues;
    }

    @Override
    public String getEscalationStatus(String issue) {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        String count = "no";
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select escalation from issue where issueid='" + issue + "'";

            rsForProject = stForProject.executeQuery(query);
            if (rsForProject.next()) {
                count = rsForProject.getString(1);
            }
            if (count == null) {
                count = "no";
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return count;
    }

    @Override
    public List<String> AllEscalations(int projectId) {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        List<String> issues = new ArrayList<String>();
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select distinct(issueid)  from issue where escalation ='yes'";
            if (projectId > 0) {
                query = query + " and pid=" + projectId;
            }
            rsForProject = stForProject.executeQuery(query);
            while (rsForProject.next()) {
                issues.add(rsForProject.getString(1));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return issues;
    }

    @Override
    public Map<Integer, String> getEscalationAnswer(String issue) {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        Map<Integer, String> escAns = new HashMap<>();
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "SELECT * FROM ESCALATION_ISSUE WHERE issueid='" + issue + "'";

            rsForProject = stForProject.executeQuery(query);
            while (rsForProject.next()) {
                escAns.put(1, rsForProject.getString(2));
                escAns.put(2, rsForProject.getString(3));
                escAns.put(3, rsForProject.getString(4));
                escAns.put(4, rsForProject.getString(5));
                escAns.put(5, rsForProject.getString(6));
                escAns.put(6, rsForProject.getString(7));
                escAns.put(7, rsForProject.getString(8));
                escAns.put(8, rsForProject.getString(9));
                escAns.put(9, rsForProject.getString(10));
                escAns.put(10, rsForProject.getString(11));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return escAns;
    }

    @Override
    public List<Escalation> getWRMPlannedIssues() {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        List<Escalation> issues = new ArrayList<Escalation>();
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select i.issueid,i.assignedto,p.pid from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,users u,(select MAX(wrmday) as maxwrmday,pid from Apm_Wrm_Plan group by pid) apm where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and i.assignedto=u.userid and (p.STATUS='Work in progress' or p.PID in (10064,10109)) And pmanager <> 104 and i.issueid=s.issueid and to_char(ap.plannedon,'DD-Mon-YYYY')=apm.maxwrmday and ap.pid=apm.pid   and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed'\n"
                    + "and u.email like '%@eminentlabs.net'";
            rsForProject = stForProject.executeQuery(query);
            while (rsForProject.next()) {
                Escalation escalation = new Escalation();
                escalation.setIssueId(rsForProject.getString(1));
                escalation.setAssginedToId(rsForProject.getInt(2));
                escalation.setPid(rsForProject.getLong(3));
                issues.add(escalation);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return issues;
    }

    @Override
    public List<Escalation> getTodayUntouchedIssues() {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        List<Escalation> issues = new ArrayList<Escalation>();
        try {
            DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            Calendar c = new GregorianCalendar();
            Date date = c.getTime();
            String currentDate = sdf.format(date);
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select Distinct(i.issueid),  i.assignedto,p.pid from issuecomments ic,issue i ,issuestatus s,project p,modules m,users u, users us where ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid  and u.userid=i.assignedto  and i.module_id =m.moduleid and us.userid=i.createdby and s.status!='Closed' and i.issueid not in(select Distinct(i.issueid) as issueid  from issuecomments ic,issue i ,issuestatus s,  MOM_Maintanance mm  where  mm.userid=ic.commentedby and mm.team in(1,2,3) and ic.issueid=i.issueid and s.issueid=i.issueid   and i.issueid in(select Distinct(i.issueid) as issueid  from issuecomments ic,issue i ,issuestatus s,project p,users u, MOM_Maintanance mm  where mm.userid=ic.commentedby and mm.team in(1,2,3) and to_date(ic.comment_date,'DD-MM-YY')=to_date('" + currentDate + "','DD-MM-YY')   and  ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid and u.userid=i.assignedTo  And pmanager <> 104 and  s.status!='Closed' )) and i.issueid in(select issue from (select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task t, MOM_Maintanance mm  where mm.userid=t.userid and mm.team in(1,2,3) and type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '20-Oct-2020'),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and to_char(p.plannedon,'dd-Mon-yyyy') = '" + currentDate + "' ) and u.email like '%@eminentlabs.net'";
            rsForProject = stForProject.executeQuery(query);
            while (rsForProject.next()) {
                Escalation escalation = new Escalation();
                escalation.setIssueId(rsForProject.getString(1));
                escalation.setAssginedToId(rsForProject.getInt(2));
                escalation.setPid(rsForProject.getLong(3));
                issues.add(escalation);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return issues;
    }
    @Override
    public List<Escalation> getESPLEscalation() {
        Connection connection = null;
        Statement stForProject = null;
        ResultSet rsForProject = null;
        List<Escalation> issues = new ArrayList<Escalation>();
        try {
            connection = MakeConnection.getConnection();
            stForProject = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        String query = "select i.ISSUEID,i.SUBJECT,u.FIRSTNAME||' '||SubStr(u.lastname,0,1) as assigned,pm.FIRSTNAME||' '||SubStr(pm.lastname,0,1) as pmanager,\n"
                + "dm.FIRSTNAME||' '||SubStr(dm.lastname,0,1) as dmanager,ceil(to_number(sysdate-to_date(i.createdon))),i.pid,i.ASSIGNEDTO,\n"
                + "ceil(to_number(sysdate-to_DATE (TO_CHAR (e.ADDEDON,'yyyy-MM-dd'),'yyyy-MM-dd'))) as escage \n"
                + " from issue i left join project p on i.pid= p.pid left join USERS u on i.ASSIGNEDTO=u.USERID left join users pm on p.PMANAGER=pm.USERID left join users dm on p.DMANAGER=dm.USERID \n"
                + "left join escalation_issue e on i.ISSUEID=e.ISSUEID\n"
                + "  where  i.escalation ='yes' and i.RATING is null and p.STATUS='Work in progress' and u.email like '%@eminentlabs.net' order by escage desc,i.MODIFIEDON";
            rsForProject = stForProject.executeQuery(query);
            while (rsForProject.next()) {
                Escalation escalation = new Escalation();
                escalation.setIssueId(rsForProject.getString(1));
                escalation.setSubject(rsForProject.getString(2));
                escalation.setAssginedTo(rsForProject.getString(3));
                escalation.setPmanager(rsForProject.getString(4));
                escalation.setDmanager(rsForProject.getString(5));
                escalation.setDays(rsForProject.getInt(6));
                escalation.setPid(rsForProject.getLong(7));
                escalation.setAssginedToId(rsForProject.getInt(8));
                escalation.setEscDays(rsForProject.getInt(9));

                issues.add(escalation);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsForProject != null) {
                    rsForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }

            try {
                if (stForProject != null) {
                    stForProject.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error("Exception:" + e);
            }
        }
        return issues;
    }

}
