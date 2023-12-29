/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.util.GetProjectManager;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.IssueDetails;
import com.eminentlabs.mom.controller.MomMaintananceController;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class TeamClosedIssueReport {

    static Logger logger = null;

    static {
        logger = logger.getLogger("TestClosedIssueReport");
    }
    private int userId;
    private int month;
    private int year;
    String team = null, totUsers, rating = null;
    List<String> usersList;
    Map<Integer, Integer> ratingwise = new LinkedHashMap<Integer, Integer>();

    public String getQueryFormat(List<String> usersList) {
        String formatUsers = "";
        for (String user : usersList) {
            formatUsers = formatUsers + "'" + user + "',";
        }
        if (formatUsers.contains(",")) {
            formatUsers = formatUsers.substring(0, formatUsers.length() - 1);
        }
        return formatUsers;
    }
    public Map<Integer, List<IssueFormBean>> teamClosedIssues = new LinkedHashMap<Integer, List<IssueFormBean>>();
    List<Integer> pmanagers = new ArrayList<Integer>();
    HashMap<Integer, String> member = new HashMap<Integer, String>();

    public static HashMap<Integer, String> getMonths() {
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

    public static ArrayList<Integer> getYears() {
        Calendar calDuration = new GregorianCalendar();
        int current_Year = calDuration.get(Calendar.YEAR);
        ArrayList<Integer> selectYears = new ArrayList();
        int startYear = 2008;
        while (startYear <= current_Year) {
            selectYears.add(startYear);
            startYear++;
        }
        return selectYears;

    }

    public void setAll(HttpServletRequest request) {
        MomMaintananceController maintananceController = new MomMaintananceController();
        String momusers = maintananceController.allMomUsers();
        String noOfusers[] = momusers.split(",");
        member = GetProjectMembers.showUsers();
        usersList = Arrays.asList(noOfusers);
        totUsers = getQueryFormat(usersList);

        Calendar calDuration = new GregorianCalendar();
        //      calDuration.add(Calendar.MONTH, -11);
        //     int currMonth = calDuration.get(Calendar.MONTH)-1;
        //     int currYear = calDuration.get(Calendar.YEAR)+1;
        int currMonth = calDuration.get(Calendar.MONTH);
        int currYear = calDuration.get(Calendar.YEAR);
        String monthname = request.getParameter("month");
        String yearname = request.getParameter("year");
        rating = request.getParameter("rating");

        if (monthname == null) {
            month = currMonth;
        } else {
            month = Integer.parseInt(monthname);
        }
        if (yearname == null) {
            year = currYear;
        } else {
            year = Integer.parseInt(yearname);
        }
        String monthYear = getMonths().get(month) + "-" + year;
        teamClosedIssues = teamClosedIssueReport(monthYear);
        if (currMonth == month && currYear == year) {
            pmanagers = GetProjectManager.findMomProjectManagers(totUsers);
        } else {
            pmanagers = GetProjectManager.findProjectManagersFromIssueComments(monthYear);
        }
    }

    public void getTeamwise(HttpServletRequest request) {
        member = GetProjectMembers.showUsers();
        Calendar calDuration = new GregorianCalendar();
        //      calDuration.add(Calendar.MONTH, -11);
        //     int currMonth = calDuration.get(Calendar.MONTH)-1;
        //     int currYear = calDuration.get(Calendar.YEAR)+1;
        int currMonth = calDuration.get(Calendar.MONTH);
        int currYear = calDuration.get(Calendar.YEAR);
        String monthname = request.getParameter("month");
        String yearname = request.getParameter("year");
        team = request.getParameter("team");
        if (team == null) {
            team = "";
        }
        if (team.equals("")) {
            MomMaintananceController maintananceController = new MomMaintananceController();
            String momusers = maintananceController.allMomUsers();
            String noOfusers[] = momusers.split(",");
            member = GetProjectMembers.showUsers();
            usersList = Arrays.asList(noOfusers);
        } else {
            Map<String, List<Integer>> teamwise = GetProjectMembers.getEminentUsersByTeam(0);
            usersList = new ArrayList();
            for (Integer user : teamwise.get(team)) {
                usersList.add(user + "");
            }
        }
        totUsers = getQueryFormat(usersList);

        if (monthname == null) {
            month = currMonth;
        } else {
            month = Integer.parseInt(monthname);
        }
        if (yearname == null) {
            year = currYear;
        } else {
            year = Integer.parseInt(yearname);
        }
        String monthYear = getMonths().get(month) + "-" + year;
        teamClosedIssues = teamClosedIssueReport(monthYear);

    }

    public void setPeriod(HttpServletRequest request) {
        Calendar calDuration = new GregorianCalendar();
        //      calDuration.add(Calendar.MONTH, -11);
        //     int currMonth = calDuration.get(Calendar.MONTH)-1;
        //     int currYear = calDuration.get(Calendar.YEAR)+1;
        int currMonth = calDuration.get(Calendar.MONTH);
        int currYear = calDuration.get(Calendar.YEAR);
        String monthname = request.getParameter("month");
        String yearname = request.getParameter("year");

        if (monthname == null) {
            month = currMonth;
        } else {
            month = Integer.parseInt(monthname);
        }
        if (yearname == null) {
            year = currYear;
        } else {
            year = Integer.parseInt(yearname);
        }
    }

    public Map<Integer, List<IssueFormBean>> teamClosedIssueReport(String monthYear) {
        Map<Integer, List<IssueFormBean>> closedIssuesOrderByTeam = new LinkedHashMap<Integer, List<IssueFormBean>>();
        Map<Integer, List<IssueFormBean>> closedIssuesByTeam = new LinkedHashMap<Integer, List<IssueFormBean>>();
        ArrayList rejectedList = new ArrayList();
        String totalUsers = "", sql = "";
        for (String user : usersList) {
            totalUsers = totalUsers + "'" + user + "',";
        }
        if (totalUsers.contains(",")) {
            totalUsers = totalUsers.substring(0, totalUsers.length() - 1);
        }
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;
        String totalissuenos = "";

        try {
            connection = MakeConnection.getConnection();
            String reSQL = "select distinct(ISSUEID) from (select distinct(issueid),status,comment_date,LAG(status, 1, 0) OVER (ORDER BY comment_date) AS prev from issuecomments where issueid in (select distinct issueid from issuecomments where status!='Closed' and (status='Rejected' or status='Duplicate')  group by comment_date ,issueid having to_char(Max(comment_date),'DD-Mon-YYYY HH:mm:ss') =to_char(issuecomments.comment_date,'DD-Mon-YYYY HH:mm:ss') ) )where STATUS ='Closed' and PREV in('Rejected','Duplicate')";
            if (team == null) {
                if (rating != null) {
                    sql = "select distinct(i.issueid),commentedby,i.rating from issue i, issuecomments ic,issuestatus s where i.issueid=s.issueid and ic.issueid=i.issueid and i.rating = '" + rating + "' and s.status='Closed' and ic.commentedby in(" + totalUsers + ") and ic.commentedby=ic.COMMENTEDTO and to_char(i.modifiedon,'Mon-YYYY')='" + monthYear + "'  order by commentedby";
                } else {
                    sql = "select distinct(i.issueid),commentedby,i.rating from issue i, issuecomments ic,issuestatus s where i.issueid=s.issueid and ic.issueid=i.issueid and s.status='Closed' and ic.commentedby in(" + totalUsers + ") and ic.commentedby=ic.COMMENTEDTO and to_char(i.modifiedon,'Mon-YYYY')='" + monthYear + "'  order by commentedby";
                }
            } else {
                sql = "select distinct(i.issueid),commentedby,i.rating from issue i, issuecomments ic,issuestatus s where i.issueid=s.issueid and ic.issueid=i.issueid and s.status='Closed' and ic.commentedby in(" + totalUsers + ") and to_char(i.modifiedon,'Mon-YYYY')='" + monthYear + "'  order by commentedby";
            }
            ps = connection.prepareStatement(reSQL, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = ps.executeQuery();
            while (resultset.next()) {
                rejectedList.add(resultset.getString("issueid"));
            }

            ps = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = ps.executeQuery();
            while (resultset.next()) {
                if (!rejectedList.contains(resultset.getString("issueid"))) {
                    totalissuenos = totalissuenos + "'" + resultset.getString("issueid").trim() + "',";
                }
            }
            List<IssueFormBean> totalClosedIssues = new ArrayList<IssueFormBean>();
            if (totalissuenos.contains(",")) {
                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                totalClosedIssues = IssueDetails.displayIssuesDetails(totalissuenos);
            }
            resultset.beforeFirst();
            int commentedBy = 0;
            List<IssueFormBean> closedIssuesByUser = new ArrayList<IssueFormBean>();
            while (resultset.next()) {

                int commented = Integer.valueOf(resultset.getString("commentedBy"));
                String issueid = resultset.getString("issueid").trim();
               
                if (!rejectedList.contains(issueid)) {
                    
                     if (resultset.getString("rating").equalsIgnoreCase("Excellent")) {
                    if (ratingwise.containsKey(commented)) {
                        ratingwise.put(commented, (ratingwise.get(commented) + 1));
                    } else {
                        ratingwise.put(commented, 1);
                    }
                }
                    if (commentedBy == 0) {
                        for (IssueFormBean isfb : totalClosedIssues) {
                            if (isfb.getIssueId().equals(issueid)) {
                                closedIssuesByUser.add(isfb);
                            }
                        }
                        commentedBy = commented;
                        closedIssuesByTeam.put(commented, closedIssuesByUser);
                    } else if (commented != commentedBy) {
                        closedIssuesByUser = new ArrayList<IssueFormBean>();
                        for (IssueFormBean isfb : totalClosedIssues) {
                            if (isfb.getIssueId().equals(issueid)) {
                                closedIssuesByUser.add(isfb);
                            }
                        }
                        commentedBy = commented;
                        closedIssuesByTeam.put(commented, closedIssuesByUser);
                    } else {
                        for (IssueFormBean isfb : totalClosedIssues) {
                            if (isfb.getIssueId().equals(issueid)) {
                                closedIssuesByUser.add(isfb);
                            }
                        }
                        closedIssuesByTeam.put(commented, closedIssuesByUser);
                    }
                }
            }
            if (!closedIssuesByUser.isEmpty()) {
                closedIssuesByTeam.put(commentedBy, closedIssuesByUser);
            }
            HashMap<Integer, Integer> userClosedCount = new HashMap<Integer, Integer>();
            for (Map.Entry<Integer, List<IssueFormBean>> entry : closedIssuesByTeam.entrySet()) {
                userClosedCount.put(entry.getKey(), entry.getValue().size());
            }
            Map<Integer, Integer> usersClosedOrderCount = new LinkedHashMap<Integer, Integer>();
            usersClosedOrderCount = GetProjectMembers.sortHashMapByNonStringValues(userClosedCount, false);

            for (Map.Entry<Integer, Integer> entry : usersClosedOrderCount.entrySet()) {
                if (usersList.contains(entry.getKey().toString())) {
                    closedIssuesOrderByTeam.put(entry.getKey(), closedIssuesByTeam.get(entry.getKey()));
                }
            }
            if (rating == null) {
                for (String user : usersList) {
                    int usersId = Integer.parseInt(user);
                    if (closedIssuesOrderByTeam.get(usersId) == null) {
                        closedIssuesOrderByTeam.put(usersId, new ArrayList<IssueFormBean>());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }

            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                }
            }
        }
        return closedIssuesOrderByTeam;

    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public Map<Integer, List<IssueFormBean>> getTeamClosedIssues() {
        return teamClosedIssues;
    }

    public void setTeamClosedIssues(Map<Integer, List<IssueFormBean>> teamClosedIssues) {
        this.teamClosedIssues = teamClosedIssues;
    }

    public HashMap<Integer, String> getMember() {
        return member;
    }

    public void setMember(HashMap<Integer, String> member) {
        this.member = member;
    }

    public List<Integer> getPmanagers() {
        return pmanagers;
    }

    public void setPmanagers(List<Integer> pmanagers) {
        this.pmanagers = pmanagers;
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }

    public Map<Integer, Integer> getRatingwise() {
        return ratingwise;
    }

    public void setRatingwise(Map<Integer, Integer> ratingwise) {
        this.ratingwise = ratingwise;
    }

}
