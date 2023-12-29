/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.chart;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.issue.formbean.PlannedIssueReport;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class GnattChart {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("GnattChart");
    }

    List<GnattDTO> gnattList = new ArrayList<GnattDTO>();
    Set<Integer> uniqueUsers = new LinkedHashSet<Integer>();
    Set<Integer> uniqueCustomerUsers = new LinkedHashSet<Integer>();
    Set<String> uniquePeriods = new LinkedHashSet<String>();
    Set<String> uniqueCustomerPeriods = new LinkedHashSet<String>();
    Map<String, Integer> uniquePeriodCount = new HashMap<String, Integer>();
    Map<String, Integer> uniqueCustomerPeriodCount = new HashMap<String, Integer>();
    Map<Integer, String> users = new HashMap<Integer, String>();
    List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();
    List<GnattDTO> gnattCustomerList = new ArrayList<GnattDTO>();
    LinkedHashMap<Integer, String> projectSet = new LinkedHashMap<>();
    String projectId;
    int endYear = 0, endMonth = 0;

    public void setAll(HttpServletRequest request) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HttpSession session = request.getSession();
        Integer role = (Integer) session.getAttribute("Role");
        String query, query1;
        try {
            projectId = request.getParameter("pid");
            if (projectId == null) {
                projectId = "";
            } 
            
            if(!projectId.equals("")){
                getEndDateForProject();
            }
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            query = "select CONCAT(firstname ,CONCAT(' ',substr(lastname,0,1)))as assigned,CONCAT(CONCAT('Week' ,CONCAT(' ',weeks)),CONCAT('/',years)) as periods,counts,ASSIGNEDTO from (\n"
                    + "SELECT i.ASSIGNEDTO as ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY') as years, to_char(i.DUE_DATE - 7/24,'IW') as weeks ,count(i.ISSUEID) as counts\n"
                    + "FROM issue i join  project p on i.PID=p.PID  and p.STATUS='Work in progress'\n"
                    + "left join ISSUESTATUS s on i.ISSUEID=s.ISSUEID where i.pid=" + projectId + " and s.STATUS!='Closed'\n"
                    + "group by  i.ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY'), to_char(i.DUE_DATE - 7/24,'IW')\n"
                    + "order by years, weeks,ASSIGNEDTO) countTable left join  users  on ASSIGNEDTO=userid order by years, weeks,assigned";
            resultset = statement.executeQuery(query);

            while (resultset.next()) {
                GnattDTO gnattDTO = new GnattDTO();
                gnattDTO.setUserId(resultset.getInt("ASSIGNEDTO"));
                gnattDTO.setUser(resultset.getString("assigned"));
                gnattDTO.setPeriod(resultset.getString("periods"));
                gnattDTO.setCount(resultset.getInt("counts"));
                uniquePeriods.add(resultset.getString("periods"));
                uniqueUsers.add(resultset.getInt("ASSIGNEDTO"));
                if (uniquePeriodCount.containsKey(resultset.getString("periods"))) {
                    uniquePeriodCount.put(resultset.getString("periods"), (resultset.getInt("counts") + uniquePeriodCount.get(resultset.getString("periods"))));
                } else {
                    uniquePeriodCount.put(resultset.getString("periods"), resultset.getInt("counts"));
                }
                users.put(resultset.getInt("ASSIGNEDTO"), resultset.getString("assigned"));
                gnattList.add(gnattDTO);
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
    }

    public void setAdminAll(HttpServletRequest request) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HttpSession session = request.getSession();
        String query, query1, query2;
        try {
            projectId = request.getParameter("pid");
            if (projectId == null) {
                projectId = "";
            }
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select  p.pname,p.version,p.pid  from project p where status='Work in progress' and category='SAP Project' and pmanager!=104 order by enddate,p.pname");

            while (resultset.next()) {
                projectSet.put(resultset.getInt(3), resultset.getString(1) + " v" + resultset.getString(2));
            }
            if (!projectId.equals("")) {
                getEndDateForProject();
                query = "select CONCAT(firstname ,CONCAT(' ',substr(lastname,0,1)))as assigned,CONCAT(CONCAT('Week' ,CONCAT(' ',weeks)),CONCAT('/',years)) as periods,counts,ASSIGNEDTO from (\n"
                        + "                        SELECT i.ASSIGNEDTO as ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY') as years, to_char(i.DUE_DATE - 7/24,'IW') as weeks ,count(i.ISSUEID) as counts \n"
                        + "                         FROM issue i join  project p on i.PID=p.PID  and p.STATUS='Work in progress' and category='SAP Project' and pmanager!=104\n"
                        + "                         left join ISSUESTATUS s on i.ISSUEID=s.ISSUEID where i.pid=" + projectId + " and s.STATUS!='Closed' \n"
                        + "                         group by  i.ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY'), to_char(i.DUE_DATE - 7/24,'IW') \n"
                        + "                         order by years, weeks,ASSIGNEDTO) countTable left join  users u  on ASSIGNEDTO=u.userid where u.email like '%@eminentlabs.net'  order by years, weeks,assigned";

                query1 = "select CONCAT(firstname ,CONCAT(' ',substr(lastname,0,1)))as assigned,CONCAT(CONCAT('Week' ,CONCAT(' ',weeks)),CONCAT('/',years)) as periods,counts,ASSIGNEDTO from (\n"
                        + "                        SELECT i.ASSIGNEDTO as ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY') as years, to_char(i.DUE_DATE - 7/24,'IW') as weeks ,count(i.ISSUEID) as counts \n"
                        + "                         FROM issue i join  project p on i.PID=p.PID  and p.STATUS='Work in progress' and category='SAP Project' and pmanager!=104\n"
                        + "                         left join ISSUESTATUS s on i.ISSUEID=s.ISSUEID where i.pid=" + projectId + " and s.STATUS!='Closed' \n"
                        + "                         group by  i.ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY'), to_char(i.DUE_DATE - 7/24,'IW') \n"
                        + "                         order by years, weeks,ASSIGNEDTO) countTable left join  users u  on ASSIGNEDTO=u.userid where u.email not like '%@eminentlabs.net'  order by years, weeks,assigned";
                query2 = " select distinct(CONCAT(CONCAT('Week' ,CONCAT(' ',weeks)),CONCAT('/',years))) as periods,weeks,years from (\n"
                        + "                        SELECT i.ASSIGNEDTO as ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY') as years, to_char(i.DUE_DATE - 7/24,'IW') as weeks ,count(i.ISSUEID) as counts \n"
                        + "                         FROM issue i join  project p on i.PID=p.PID  and p.STATUS='Work in progress' and category='SAP Project' and pmanager!=104\n"
                        + "                         left join ISSUESTATUS s on i.ISSUEID=s.ISSUEID where i.pid=" + projectId + " and s.STATUS!='Closed' \n"
                        + "                         group by  i.ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY'), to_char(i.DUE_DATE - 7/24,'IW') \n"
                        + "                         order by years, weeks,ASSIGNEDTO) countTable order by years, weeks";
            } else {
                query = "select CONCAT(firstname ,CONCAT(' ',substr(lastname,0,1)))as assigned,CONCAT(CONCAT('Week' ,CONCAT(' ',weeks)),CONCAT('/',years)) as periods,counts,ASSIGNEDTO from (\n"
                        + "                        SELECT i.ASSIGNEDTO as ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY') as years, to_char(i.DUE_DATE - 7/24,'IW') as weeks ,count(i.ISSUEID) as counts \n"
                        + "                         FROM issue i join  project p on i.PID=p.PID  and p.STATUS='Work in progress' and category='SAP Project' and pmanager!=104\n"
                        + "                         left join ISSUESTATUS s on i.ISSUEID=s.ISSUEID where  s.STATUS!='Closed' \n"
                        + "                         group by  i.ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY'), to_char(i.DUE_DATE - 7/24,'IW') \n"
                        + "                         order by years, weeks,ASSIGNEDTO) countTable left join  users u  on ASSIGNEDTO=u.userid where u.email like '%@eminentlabs.net'  order by years, weeks,assigned";

                query1 = "select CONCAT(firstname ,CONCAT(' ',substr(lastname,0,1)))as assigned,CONCAT(CONCAT('Week' ,CONCAT(' ',weeks)),CONCAT('/',years)) as periods,counts,ASSIGNEDTO from (\n"
                        + "                        SELECT i.ASSIGNEDTO as ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY') as years, to_char(i.DUE_DATE - 7/24,'IW') as weeks ,count(i.ISSUEID) as counts \n"
                        + "                         FROM issue i join  project p on i.PID=p.PID  and p.STATUS='Work in progress' and category='SAP Project' and pmanager!=104\n"
                        + "                         left join ISSUESTATUS s on i.ISSUEID=s.ISSUEID where  s.STATUS!='Closed' \n"
                        + "                         group by  i.ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY'), to_char(i.DUE_DATE - 7/24,'IW') \n"
                        + "                         order by years, weeks,ASSIGNEDTO) countTable left join  users u  on ASSIGNEDTO=u.userid where u.email not like '%@eminentlabs.net'  order by years, weeks,assigned";
                query2 = " select distinct(CONCAT(CONCAT('Week' ,CONCAT(' ',weeks)),CONCAT('/',years))) as periods,weeks,years from (\n"
                        + "                        SELECT i.ASSIGNEDTO as ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY') as years, to_char(i.DUE_DATE - 7/24,'IW') as weeks ,count(i.ISSUEID) as counts \n"
                        + "                         FROM issue i join  project p on i.PID=p.PID  and p.STATUS='Work in progress' and category='SAP Project' and pmanager!=104\n"
                        + "                         left join ISSUESTATUS s on i.ISSUEID=s.ISSUEID where  s.STATUS!='Closed' \n"
                        + "                         group by  i.ASSIGNEDTO,to_char(i.DUE_DATE - 7/24,'IYYY'), to_char(i.DUE_DATE - 7/24,'IW') \n"
                        + "                         order by years, weeks,ASSIGNEDTO) countTable order by years, weeks";

            }
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);

            while (resultset.next()) {
                GnattDTO gnattDTO = new GnattDTO();
                gnattDTO.setUserId(resultset.getInt("ASSIGNEDTO"));
                gnattDTO.setUser(resultset.getString("assigned"));
                gnattDTO.setPeriod(resultset.getString("periods"));
                gnattDTO.setCount(resultset.getInt("counts"));
                uniqueUsers.add(resultset.getInt("ASSIGNEDTO"));
                if (uniquePeriodCount.containsKey(resultset.getString("periods"))) {
                    uniquePeriodCount.put(resultset.getString("periods"), (resultset.getInt("counts") + uniquePeriodCount.get(resultset.getString("periods"))));
                } else {
                    uniquePeriodCount.put(resultset.getString("periods"), resultset.getInt("counts"));
                }
                users.put(resultset.getInt("ASSIGNEDTO"), resultset.getString("assigned"));
                gnattList.add(gnattDTO);
            }
            resultset = statement.executeQuery(query1);

            while (resultset.next()) {
                GnattDTO gnattDTO = new GnattDTO();
                gnattDTO.setUserId(resultset.getInt("ASSIGNEDTO"));
                gnattDTO.setUser(resultset.getString("assigned"));
                gnattDTO.setPeriod(resultset.getString("periods"));
                gnattDTO.setCount(resultset.getInt("counts"));
                uniqueCustomerUsers.add(resultset.getInt("ASSIGNEDTO"));
                if (uniqueCustomerPeriodCount.containsKey(resultset.getString("periods"))) {
                    uniqueCustomerPeriodCount.put(resultset.getString("periods"), (resultset.getInt("counts") + uniqueCustomerPeriodCount.get(resultset.getString("periods"))));
                } else {
                    uniqueCustomerPeriodCount.put(resultset.getString("periods"), resultset.getInt("counts"));
                }
                users.put(resultset.getInt("ASSIGNEDTO"), resultset.getString("assigned"));
                gnattCustomerList.add(gnattDTO);
            }
            resultset = statement.executeQuery(query2);
            while(resultset.next()){
                                uniquePeriods.add(resultset.getString("periods"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
    }

    public void getIssuesByUserWeek(HttpServletRequest request) {

        String pid;
        String weekInYear, userId;
        String week, year;
        String query;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<String> uniqueIssue = new ArrayList<String>();
        PlannedIssueReport pir = new PlannedIssueReport();
        try {

            pid = request.getParameter("pid");
            weekInYear = request.getParameter("week");
            userId = request.getParameter("userId");
            week = weekInYear.split(" ")[1].split("/")[0];
            year = weekInYear.split(" ")[1].split("/")[1];
            if (pid == null) {
                pid = "";
            }
            if (pid.equals("")) {
                query = "SELECT  distinct(i.ISSUEID) FROM issue i join  ISSUESTATUS s on i.ISSUEID=s.ISSUEID join  project p on i.PID=p.PID  and p.STATUS='Work in progress' and category='SAP Project' and pmanager!=104 where  s.STATUS!='Closed' and to_char(i.DUE_DATE - 7/24,'IW')=" + week + " and to_char(i.DUE_DATE - 7/24,'IYYY')=" + year + " and i.assignedto=" + userId + "";
            } else {
                query = "SELECT  distinct(i.ISSUEID) FROM issue i join  ISSUESTATUS s on i.ISSUEID=s.ISSUEID where i.pid=" + pid + " and s.STATUS!='Closed' and to_char(i.DUE_DATE - 7/24,'IW')=" + week + " and to_char(i.DUE_DATE - 7/24,'IYYY')=" + year + " and i.assignedto=" + userId + "";
            }

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                uniqueIssue.add(resultset.getString(1));
            }
            if (uniqueIssue.isEmpty()) {
            } else {
                issuesList = pir.getIssuesDetail(uniqueIssue);
            }
        } catch (Exception e) {
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
    }

    public void getEndDateForProject() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select to_char(enddate - 7/24,'IYYY') as years, to_char(enddate - 7/24,'IW') as weeks from project where pid=" + projectId);
            while (resultset.next()) {
                endYear = resultset.getInt(1);
                endMonth = resultset.getInt(2);
            }
        } catch (Exception e) {
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
    }

    public GnattDTO getCount(List<GnattDTO> gnattDTOs, int userId, String period) {
        GnattDTO count = new GnattDTO();
        for (GnattDTO gnattDTO : gnattDTOs) {
            if (gnattDTO.getUserId() == userId && gnattDTO.getPeriod().equalsIgnoreCase(period)) {
                count = gnattDTO;
            }
        }
        return count;
    }

    public List<GnattDTO> getGnattList() {
        return gnattList;
    }

    public void setGnattList(List<GnattDTO> gnattList) {
        this.gnattList = gnattList;
    }

    public Set<Integer> getUniqueUsers() {
        return uniqueUsers;
    }

    public void setUniqueUsers(Set<Integer> uniqueUsers) {
        this.uniqueUsers = uniqueUsers;
    }

    public Set<String> getUniquePeriods() {
        return uniquePeriods;
    }

    public void setUniquePeriods(Set<String> uniquePeriods) {
        this.uniquePeriods = uniquePeriods;
    }

    public Map<String, Integer> getUniquePeriodCount() {
        return uniquePeriodCount;
    }

    public void setUniquePeriodCount(Map<String, Integer> uniquePeriodCount) {
        this.uniquePeriodCount = uniquePeriodCount;
    }

    public Map<Integer, String> getUsers() {
        return users;
    }

    public void setUsers(Map<Integer, String> users) {
        this.users = users;
    }

    public List<IssueFormBean> getIssuesList() {
        return issuesList;
    }

    public void setIssuesList(List<IssueFormBean> issuesList) {
        this.issuesList = issuesList;
    }

    public List<GnattDTO> getGnattCustomerList() {
        return gnattCustomerList;
    }

    public void setGnattCustomerList(List<GnattDTO> gnattCustomerList) {
        this.gnattCustomerList = gnattCustomerList;
    }

    public Set<Integer> getUniqueCustomerUsers() {
        return uniqueCustomerUsers;
    }

    public void setUniqueCustomerUsers(Set<Integer> uniqueCustomerUsers) {
        this.uniqueCustomerUsers = uniqueCustomerUsers;
    }

    public Set<String> getUniqueCustomerPeriods() {
        return uniqueCustomerPeriods;
    }

    public void setUniqueCustomerPeriods(Set<String> uniqueCustomerPeriods) {
        this.uniqueCustomerPeriods = uniqueCustomerPeriods;
    }

    public LinkedHashMap<Integer, String> getProjectSet() {
        return projectSet;
    }

    public void setProjectSet(LinkedHashMap<Integer, String> projectSet) {
        this.projectSet = projectSet;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public Map<String, Integer> getUniqueCustomerPeriodCount() {
        return uniqueCustomerPeriodCount;
    }

    public void setUniqueCustomerPeriodCount(Map<String, Integer> uniqueCustomerPeriodCount) {
        this.uniqueCustomerPeriodCount = uniqueCustomerPeriodCount;
    }

    public int getEndYear() {
        return endYear;
    }

    public void setEndYear(int endYear) {
        this.endYear = endYear;
    }

    public int getEndMonth() {
        return endMonth;
    }

    public void setEndMonth(int endMonth) {
        this.endMonth = endMonth;
    }

}
