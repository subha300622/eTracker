/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.controller;

import com.eminentlabs.mom.MoMUtil;
import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.issue.formbean.LastAssginForm;
import static com.eminent.issue.formbean.PlannedIssueReport.severityColor;
import com.eminent.util.GetAge;
import com.eminent.util.IssueDetails;
import dashboard.CheckDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class SummaryIssuesController {

    static Logger logger = Logger.getLogger("SummaryIssuesController");
    List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();
    private String summaryType;
    private String summaryTableType;
    private String teamType;
    private int projectId;

    public void setAll(HttpServletRequest request) {
        summaryTableType = request.getParameter("summaryTableType");
        teamType = request.getParameter("teamType");
        DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        String currentDate = sdf.format(date);
        Date nextWorkDay = MoMUtil.nextDay(date);
        Date previousDay = MoMUtil.previousDay(date);
        String pid = request.getParameter("pid");
        if (pid != null) {
            if ("".equals(pid)) {
                pid = null;
            } else {
                projectId = MoMUtil.parseInteger(pid, 0);
            }
        }

        boolean flag = true;
        if (summaryTableType.equalsIgnoreCase("N")) {

            while (flag == true) {
                List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(nextWorkDay);
                if (!holidaysList.isEmpty()) {
                    nextWorkDay = MoMUtil.nextDay(nextWorkDay);
                } else {
                    flag = false;
                }
            }
            currentDate = sdf.format(nextWorkDay);
        } else if (summaryTableType.equalsIgnoreCase("P")) {
            flag = true;
            while (flag == true) {
                List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(previousDay);
                if (!holidaysList.isEmpty()) {
                    previousDay = MoMUtil.previousDay(previousDay);
                } else {
                    flag = false;
                }
            }
            currentDate = sdf.format(previousDay);
        }
        summaryType = request.getParameter("summaryType");
        String query = "";
        String additional = "";
        if (projectId != 0) {
            additional = "and i.pid=" + projectId;
        }
        if (summaryType.equalsIgnoreCase("WWC")) {

            query = "select i.issueid,  CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, subject, description, priority, severity, us.firstname || ' ' ||substr(us.lastname,0,1) as createdby , createdon, u.firstname || ' ' || substr(u.lastname,0,1) as assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age from issue i,issuestatus s,WRMPERIOD w,project p,modules m,Apm_Wrm_Plan ap,users u,users us where i.PID=w.pid " + additional + " and p.STATUS='Work in progress' And pmanager <> 104  and ap.pid=i.pid and i.module_id=m.moduleid and ap.pid=p.pid  and i.issueid=s.issueid and u.userid=assignedto and us.userid=i.createdby and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan where wrmday <= to_date('" + currentDate + "','DD-Mon-YY') group by pid) and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed' and u.email not like '%eminentlabs.net'";
        } else if (summaryType.equalsIgnoreCase("WWU")) {
            query = "select i.issueid,  CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, subject, description, priority, severity, us.firstname || ' ' ||substr(us.lastname,0,1) as createdby , createdon, u.firstname || ' ' || substr(u.lastname,0,1) as assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age from issue i,issuestatus s,WRMPERIOD w,project p,modules m,Apm_Wrm_Plan ap,users u,users us where i.PID=w.pid " + additional + " and p.STATUS='Work in progress' And pmanager <> 104 and ap.pid=i.pid and i.module_id=m.moduleid and ap.pid=p.pid  and i.issueid=s.issueid and u.userid=assignedto and us.userid=i.createdby and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan where wrmday <= to_date('" + currentDate + "','DD-Mon-YY') group by pid) and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed' and u.email like '%eminentlabs.net'";
        } else if (summaryType.equalsIgnoreCase("WP")) {
            query = "select distinct(i.issueid),  CONCAT(pname ,CONCAT(' v',version)) as project, i.type, s.status, subject, description, priority, severity, us.firstname || ' ' ||substr(us.lastname,0,1) as createdby , createdon, u.firstname || ' ' || substr(u.lastname,0,1) as assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age from issue i, project p,modules m,users u,users us ,issuestatus s, (select issue from (select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task t, MOM_Maintanance mm where mm.userid=t.userid and mm.team in(" + teamType + ") and type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + currentDate + "'),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active'  and to_char(p.plannedon,'dd-Mon-yyyy') = '" + currentDate + "' "
                    + " intersect select AP.issueid as issue from Apm_Wrm_Plan ap,project p,issuestatus s where ap.pid=p.pid and p.status='Work in progress' and pmanager<>104 and  (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan where wrmday <= to_date('" + currentDate + "','DD-Mon-YY') group by pid) and  ap.status='Active' and s.status!='Closed' and ap.issueid=s.issueid ) wp where  i.module_id=m.moduleid and  u.userid=assignedto " + additional + " and us.userid=i.createdby and wp.issue=i.issueid and s.issueid=i.issueid and i.pid=p.pid";
        } else if (summaryType.equalsIgnoreCase("NWP")) {
            query = "select distinct(i.issueid),  CONCAT(pname ,CONCAT(' v',version)) as project, i.type, s.status, subject, description, priority, severity, us.firstname || ' ' ||substr(us.lastname,0,1) as createdby , createdon, u.firstname || ' ' || substr(u.lastname,0,1) as assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age from issue i, project p,modules m,users u,users us ,issuestatus s, (select issue from (select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task t, MOM_Maintanance mm  where mm.userid=t.userid and mm.team in(" + teamType + ") and type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + currentDate + "'),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and to_char(p.plannedon,'dd-Mon-yyyy') = '" + currentDate + "' "
                    + " MINUS select AP.issueid as issue from Apm_Wrm_Plan ap,project p,issuestatus s where ap.pid=p.pid and p.status='Work in progress' and pmanager<>104 and  (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan where wrmday <= to_date('" + currentDate + "','DD-Mon-YY') group by pid) and  ap.status='Active' and s.status!='Closed' and ap.issueid=s.issueid ) wp where  i.module_id=m.moduleid and  u.userid=assignedto " + additional + " and us.userid=i.createdby and wp.issue=i.issueid and s.issueid=i.issueid and i.pid=p.pid";
        } else if (summaryType.equalsIgnoreCase("Closed")) {
            query = "select Distinct(i.issueid) as issueid ,  CONCAT(pname ,CONCAT(' v',version)) as project, i.type, s.status, subject, description, priority, severity, us.firstname || ' ' ||substr(us.lastname,0,1) as createdby , createdon, u.firstname || ' ' || substr(u.lastname,0,1) as assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age from issue i ,issuestatus s,project p,modules m,users u ,users us  where i.modifiedon=to_date('" + currentDate + "','DD-Mon-YYYY')   and  s.issueid=i.issueid " + additional + " and  i.pid=p.pid and p.STATUS='Work in progress' And pmanager <> 104 and s.status='Closed'and i.module_id=m.moduleid and  u.userid=assignedto and us.userid=i.createdby  and i.issueid in(select issue from (select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task t, MOM_Maintanance mm where type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + currentDate + "'),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and to_char(p.plannedon,'dd-Mon-yyyy') = '" + currentDate + "' )";

        } else if (summaryType.equalsIgnoreCase("WC")) {
            query = "select Distinct(i.issueid) as issueid ,  CONCAT(pname ,CONCAT(' v',version)) as project, i.type, s.status, subject, description, i.priority, i.severity, us.firstname || ' ' ||substr(us.lastname,0,1) as createdby , createdon, u.firstname || ' ' || substr(u.lastname,0,1) as assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age  from issuecomments ic,issue i ,issuestatus s,project p,modules m,users u, users us,  MOM_Maintanance mm  where  mm.userid=ic.commentedby and mm.team in(" + teamType + ")  and   ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid " + additional + " and u.userid=i.assignedto  and i.module_id =m.moduleid and us.userid=i.createdby   and i.issueid in(select Distinct(i.issueid) as issueid  from issuecomments ic,issue i ,issuestatus s,project p,users u  where to_date(ic.comment_date,'DD-MM-YY')=to_date('" + currentDate + "','DD-MM-YY')   and  ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid and u.userid=i.assignedTo  and p.STATUS='Work in progress' And pmanager <> 104 and u.email not like '%eminentlabs.net' and s.status!='Closed'  and i.issueid in(select issue from (select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task t, MOM_Maintanance mm where mm.userid=t.userid and mm.team in(" + teamType + ") and type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + currentDate + "'),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and to_char(p.plannedon,'dd-Mon-yyyy') = '" + currentDate + "'))";

        } else if (summaryType.equalsIgnoreCase("NWC")) {
            query = "select Distinct(i.issueid) as issueid ,  CONCAT(pname ,CONCAT(' v',version)) as project, i.type, s.status, subject, description, i.priority, i.severity, us.firstname || ' ' ||substr(us.lastname,0,1) as createdby , createdon, u.firstname || ' ' || substr(u.lastname,0,1) as assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age  from issuecomments ic,issue i ,issuestatus s,project p,modules m,users u, users us,  MOM_Maintanance mm  where  mm.userid=ic.commentedby and mm.team in(" + teamType + ")  and ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid " + additional + " and u.userid=i.assignedto  and i.module_id =m.moduleid and us.userid=i.createdby   and i.issueid in(select Distinct(i.issueid) as issueid  from issuecomments ic,issue i ,issuestatus s,project p,users u,  MOM_Maintanance mm  where  mm.userid=ic.commentedby and mm.team in(" + teamType + ")  and to_date(ic.comment_date,'DD-MM-YY')=to_date('" + currentDate + "','DD-MM-YY')   and  ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid and u.userid=i.assignedTo  and p.STATUS='Work in progress' And pmanager <> 104 and u.email  like '%eminentlabs.net' and s.status!='Closed'  and i.issueid in(select issue from (select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task t, MOM_Maintanance mm  where mm.userid=t.userid and mm.team in(" + teamType + ") and type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + currentDate + "'),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and to_char(p.plannedon,'dd-Mon-yyyy') = '" + currentDate + "'))";

        } else if (summaryType.equalsIgnoreCase("UT")) {
            query = "select Distinct(i.issueid),  CONCAT(pname ,CONCAT(' v',version)) as project, i.type, s.status, subject, description, i.priority, i.severity, us.firstname || ' ' ||substr(us.lastname,0,1) as createdby , createdon, u.firstname || ' ' || substr(u.lastname,0,1) as assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age from issuecomments ic,issue i ,issuestatus s,project p,modules m,users u, users us where ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid " + additional + " and u.userid=i.assignedto  and i.module_id =m.moduleid and us.userid=i.createdby and s.status!='Closed' and i.issueid not in(select Distinct(i.issueid) as issueid  from issuecomments ic,issue i ,issuestatus s,  MOM_Maintanance mm  where  mm.userid=ic.commentedby and mm.team in(" + teamType + ") and ic.issueid=i.issueid and s.issueid=i.issueid   and i.issueid in(select Distinct(i.issueid) as issueid  from issuecomments ic,issue i ,issuestatus s,project p,users u, MOM_Maintanance mm  where mm.userid=ic.commentedby and mm.team in(" + teamType + ") and to_date(ic.comment_date,'DD-MM-YY')=to_date('" + currentDate + "','DD-MM-YY')   and  ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid and u.userid=i.assignedTo  And pmanager <> 104 and  s.status!='Closed' )) and i.issueid in(select issue from (select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task t, MOM_Maintanance mm  where mm.userid=t.userid and mm.team in(" + teamType + ") and type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + currentDate + "'),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and to_char(p.plannedon,'dd-Mon-yyyy') = '" + currentDate + "' )  and u.email like '%@eminentlabs.net'";

        } else if (summaryType.equalsIgnoreCase("Adhoc")) {
            query = "select Distinct(i.issueid),  CONCAT(pname ,CONCAT(' v',version)) as project, i.type, s.status, subject, description, i.priority, i.severity, us.firstname || ' ' ||substr(us.lastname,0,1) as createdby , createdon, u.firstname || ' ' || substr(u.lastname,0,1) as assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age from issuecomments ic,issue i ,issuestatus s,project p,modules m,users u, users us,users usr, MOM_Maintanance mmt  where ic.issueid=i.issueid and s.issueid=i.issueid and i.pid=p.pid " + additional + "  and p.STATUS='Work in progress' And pmanager <> 104 and u.userid=i.assignedto  and i.module_id =m.moduleid and us.userid=i.createdby and usr.userid=ic.commentedby and usr.userid=mmt.userid and mmt.team in(" + teamType + ")  and usr.email like '%eminentlabs.net'   and to_date(ic.comment_date,'DD-MM-YY')=to_date('" + currentDate + "','DD-MM-YY')  and ic.status <> 'Unconfirmed' and i.issueid not in(select issue from (select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task t, MOM_Maintanance mm  where mm.userid=t.userid and mm.team in(" + teamType + ") and type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = '" + currentDate + "'),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and to_char(p.plannedon,'dd-Mon-yyyy') = '" + currentDate + "' )";
        } else {
            summaryType = "WRM";
        }
        executeme(query);

    }

    public void executeme(String query) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = ps.executeQuery();
            String totalissuenos = "";
            int i = 1;
            List<String> noassignedTo = new ArrayList<String>();
            while (resultset.next()) {
                totalissuenos = totalissuenos + "'" + resultset.getString("issueid").trim() + "',";
                noassignedTo.add(resultset.getString("assignedto"));
                i++;
            }
            Set<String> uniqueSet = new HashSet<String>(noassignedTo);
            Map<String, Integer> map = new HashMap<String, Integer>();

            for (String temp : noassignedTo) {
                Integer count = map.get(temp);
                map.put(temp, (count == null) ? 1 : count + 1);
            }
            Map<String, Integer> treeMapa = new TreeMap<String, Integer>(map);
            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
            List<LastAssginForm> lastAssign = new ArrayList<LastAssginForm>();
            if (totalissuenos.contains(",")) {
                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                lastAssign = IssueDetails.lastAssign();
            }
            resultset.beforeFirst();
            i = 1;
            for (Map.Entry<String, Integer> entry : entriesSortedByValues(treeMapa)) {

                while (resultset.next()) {
                    if (entry.getKey().equals(resultset.getString("assignedto"))) {
                        IssueFormBean isfb = new IssueFormBean();

                        isfb.setSeverity(severityColor(resultset.getString("severity")));
                        isfb.setIssueId(resultset.getString("issueid"));
                        isfb.setType(resultset.getString("type"));
                        String p = "NA";
                        String pri = resultset.getString("priority");
                        if (pri != null) {
                            p = pri.substring(0, 2);
                        }
                        isfb.setPriority(p);

                        isfb.setpName(resultset.getString("project"));
                        if (isfb.getpName().length() >= 15) {
                            isfb.setRedPName(isfb.getpName().substring(0, 14) + "..");
                        } else {
                            isfb.setRedPName(resultset.getString("project"));
                        }
                        isfb.setmName(resultset.getString("module"));
                        if (isfb.getmName().length() >= 10) {
                            isfb.setRedMName(isfb.getmName().substring(0, 9) + "..");
                        } else {
                            isfb.setRedMName(resultset.getString("module"));
                        }
                        String sub = resultset.getString("subject");
                        if (sub.length() > 42) {
                            sub = sub.substring(0, 42) + "...";
                        }
                        isfb.setSubject(sub);
                        isfb.setDescription(resultset.getString("description"));
                        String status = resultset.getString("status");
                        isfb.setStatus(status);
                        String dueDateFormat = resultset.getDate("due_date").toString();
                        String dueDate = "NA";
                        if (dueDateFormat != null) {
                            dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                        }
                        String dateString1 = sdf.format(dateConversion.parse(resultset.getDate("modifiedon").toString()));
                        String create = sdf.format(dateConversion.parse(resultset.getDate("createdon").toString()));

                        isfb.setDueDate(dueDate);
                        if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {
                            isfb.setDueDateColor("red");
                        } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                            isfb.setDueDateColor("red");
                        } else {
                            isfb.setDueDateColor("#000000");
                        }
                        isfb.setModifiedOn(dateString1);
                        isfb.setCreatedOn(create);
                        if (resultset.getString("createdby") != null) {
                            isfb.setCreatedBy(resultset.getString("createdby"));
                        }
                        if (resultset.getString("assignedto") != null) {
                            isfb.setAssignto(resultset.getString("assignedto"));
                        }
                        int filesCount = 0;
                        if (fileCountList.containsKey(resultset.getString("issueid"))) {
                            filesCount = fileCountList.get(resultset.getString("issueid"));
                        }
                        if (filesCount > 0) {
                            isfb.setRefer("View Files(" + filesCount + ")");
                        } else {
                            isfb.setRefer("No Files");
                        }
                        int lastAsigneeAge = 1;
                        if (lastAsigneeAgeList.containsKey(resultset.getString("issueid"))) {
                            lastAsigneeAge = lastAsigneeAgeList.get(resultset.getString("issueid"));
                        }
                        if (lastAsigneeAge == 1) {
                            lastAsigneeAge = resultset.getInt("age");
                        }

                        if (lastAsigneeAge == 0) {
                            lastAsigneeAge = lastAsigneeAge + 1;
                        }
                        isfb.setAge(resultset.getInt("age"));
                        isfb.setLastAssigneeAge(lastAsigneeAge);

                        for (LastAssginForm lastAssignForm : lastAssign) {
                            if (resultset.getString("issueid").equals(lastAssignForm.getIssueId())) {
                                isfb.setLastAssigneeName(lastAssignForm.getLastAssigneeName());
                                isfb.setLastModifiedOn(lastAssignForm.getLastModifiedOn());
                            }
                        }
                        issuesList.add(isfb);
                        i++;
                    }
                }
                resultset.beforeFirst();
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

    }

    public List<IssueFormBean> getIssuesList() {
        return issuesList;
    }

    public void setIssuesList(List<IssueFormBean> issuesList) {
        this.issuesList = issuesList;
    }

    public String getSummaryType() {
        return summaryType;
    }

    public void setSummaryType(String summaryType) {
        this.summaryType = summaryType;
    }

    public String getSummaryTableType() {
        return summaryTableType;
    }

    public void setSummaryTableType(String summaryTableType) {
        this.summaryTableType = summaryTableType;
    }

    static <K, V extends Comparable<? super V>>
            List<Map.Entry<K, V>> entriesSortedByValues(Map<K, V> map) {

        List<Map.Entry<K, V>> sortedEntries = new ArrayList<Entry<K, V>>(map.entrySet());

        Collections.sort(sortedEntries,
                new Comparator<Entry<K, V>>() {
                    @Override
                    public int compare(Entry<K, V> e1, Entry<K, V> e2) {
                        return e2.getValue().compareTo(e1.getValue());
                    }
                }
        );

        return sortedEntries;
    }
}
