/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import com.eminent.issue.TeamClosedIssueReport;
import com.eminent.leaveUtil.LeaveUtil;
import com.eminent.util.GetProjectMembers;
import com.google.gson.Gson;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author EMINENT
 */
public class MoMAttendance {

    private String name;
    private BigDecimal userId;
    private String status;
    private int count;
    private String period;
    private String time;
    List<String> datesList;
    private int month;
    private int year;
    private String momComments;
    private int branch;
    List<MoMAttendance> userAttendies = new ArrayList<MoMAttendance>();
    String[][] leaveDetail = null;

    public void setAll(HttpServletRequest request) throws ParseException {
        int roleId = (Integer) request.getSession().getAttribute("Role");
        SimpleDateFormat sdfs = new SimpleDateFormat("yyyy-MM-dd");
        Date current = new Date();
        Calendar calDuration = Calendar.getInstance();

        String start = request.getParameter("start");
        String monthname = request.getParameter("month");
        String yearname = request.getParameter("year");
        String user = request.getParameter("userId");
        if (start != null) {
            current = sdfs.parse(start);
        } else if (monthname == null && yearname == null) {
            month = calDuration.get(Calendar.MONTH);
            year = calDuration.get(Calendar.YEAR);
        } else {

            month = Integer.parseInt(monthname);
            year = Integer.parseInt(yearname);
            current = sdfs.parse(year + "-" + (month + 1) + "-" + "01");
        }
        int assignedto = (Integer) request.getSession().getAttribute("userid_curr");
        if (user != null) {
            assignedto = MoMUtil.parseInteger(user, 0);
            roleId = 0;
        }
        calDuration.setTime(current);
        calDuration.add(Calendar.DATE, 8);
        month = calDuration.get(Calendar.MONTH);
        year = calDuration.get(Calendar.YEAR);
        if (assignedto == 1189) {
            roleId = 1;
        }
//        if (roleId == 1) {
//            userAttendies = MoMUtil.userAttendance(month + 1, year, roleId, assignedto);
//        } else {
//            userAttendies = MoMUtil.userAttendanceList(month + 1, year, roleId, assignedto);
//        }
        branch = GetProjectMembers.getBranchId(assignedto);
        userAttendies = MoMUtil.userAttendanceList(month + 1, year, roleId, assignedto);
        leaveDetail = LeaveUtil.getLeave(assignedto);
    }

    public void attendanceSummary(HttpServletRequest request) throws ParseException {
        int roleId = (Integer) request.getSession().getAttribute("Role");
        SimpleDateFormat sdfs = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfa = new SimpleDateFormat("MMM yyyy");
        Date current = new Date();
        Calendar calDuration = Calendar.getInstance();

        String start = request.getParameter("start");
        String user = request.getParameter("userId");
        if (start != null) {
            Date startDate = sdfa.parse(start);
            calDuration.setTime(startDate);
        }
        month = calDuration.get(Calendar.MONTH);
        year = calDuration.get(Calendar.YEAR);

        current = sdfs.parse(year + "-" + (month + 1) + "-" + "01");

        int assignedto = (Integer) request.getSession().getAttribute("userid_curr");
        if (user != null) {
            int id = MoMUtil.parseInteger(user, 0);
            if (id > 0) {
                assignedto = id;
            }
        }
        calDuration.setTime(current);
        calDuration.add(Calendar.DATE, 8);
        month = calDuration.get(Calendar.MONTH);
        year = calDuration.get(Calendar.YEAR);
        branch = GetProjectMembers.getBranchId(assignedto);

        userAttendies = MoMUtil.userAttendance(month + 1, year, roleId, assignedto);
    }

    public String getJsonRes(int year, int month, List<MoMAttendance> attendances) throws ParseException {
        String ajaxResponse = "";
        List<JsonOb> list = new ArrayList<JsonOb>();
        SimpleDateFormat sdfs = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cale = Calendar.getInstance();
        cale.set(year, month, 1);
        int maxday = cale.getActualMaximum(Calendar.DATE);

        for (int i = 1; i <= maxday; i++) {
            String datea = year + "-" + (month + 1) + "-" + i;

            datea = sdfs.format(sdfs.parse(datea));
            String displayMor = "", displayEve = "";
            String date = i + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
            if (i < 10) {
                date = "0" + i + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
            }

            for (MoMAttendance uds : attendances) {
                if (uds.getDatesList().contains(date + ", Morning")) {
                    displayMor = uds.getStatus();
                }
                if (uds.getDatesList().contains(date + ", Evening")) {
                    displayEve = uds.getStatus();
                }

            }
            if (displayMor.contains("Unintimated")) {
                displayMor = "<span class=\"title-redtheme\">" + displayMor + "</span>";
            } else if (displayMor.contains("Approved Leave")) {
                displayMor = "<span class=\"title-bluetheme\">" + displayMor + "</span>";
            } else if (displayMor.contains("Intimated")) {
                displayMor = "<span class=\"title-orangetheme\">" + displayMor + "</span>";
            } else if (displayMor.contains("Permission")) {
                displayMor = "<span class=\"title-yellowtheme\">" + displayMor + "</span>";
            }
            if (displayEve.contains("Unintimated")) {
                displayEve = "<span class=\"title-redtheme\">" + displayEve + "</span>";
            } else if (displayEve.contains("Approved Leave")) {
                displayEve = "<span class=\"title-bluetheme\">" + displayEve + "</span>";
            } else if (displayEve.contains("Intimated")) {
                displayEve = "<span class=\"title-orangetheme\">" + displayEve + "</span>";
            } else if (displayEve.contains("Permission")) {
                displayEve = "<span class=\"title-yellowtheme\">" + displayEve + "</span>";
            }
            String len = displayMor + displayEve;
            if (len.length() > 0) {
                JsonOb jsonOb = new JsonOb();
                if (displayMor.length() > 0) {
                    if (displayEve.length() > 0) {
                        jsonOb.setTitle(displayMor + " <br/> " + displayEve);
                    } else {
                        jsonOb.setTitle(displayMor);
                    }
                } else {
                    jsonOb.setTitle(displayMor + displayEve);
                }
                jsonOb.setStart(datea);
                list.add(jsonOb);
                displayMor = "";
                displayEve = "";
            } else {
                List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(sdfs.parse(datea));
                if (holidaysList.size() > 0) {
                    for (Holidays h : holidaysList) {
                        displayMor = h.getHolidayName();
                    }
                }
                if (displayMor.length() > 0) {
                    JsonOb jsonOb = new JsonOb();
                    jsonOb.setTitle("<span class='title-greentheme'>" + displayMor + "</span>");
                    jsonOb.setStart(datea);
                    list.add(jsonOb);
                    displayMor = "";
                }
            }
        }
        JsonFull jf = new JsonFull();
        jf.setList(list);
        jf.setUnintimated(2);
        ajaxResponse = new Gson().toJson(list);

        return ajaxResponse;

    }

    public String getnewJsonRes(int year, int month, List<MoMAttendance> attendances, int branchId, String[][] leaves) throws ParseException {
        String ajaxResponse = "";
        List<JsonOb> list = new ArrayList<JsonOb>();
        SimpleDateFormat sdfs = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        Map leaveStatus = LeaveUtil.leaveStatus();
        Calendar cale = Calendar.getInstance();
        cale.set(year, month, 1);
        Date fromDate = null, toDate = null;
        int maxday = cale.getActualMaximum(Calendar.DATE);
        for (int i = 1; i <= maxday; i++) {
            String datea = year + "-" + (month + 1) + "-" + i;

            datea = sdfs.format(sdfs.parse(datea));
            String displayMor = "", displayEve = "";
            String date = i + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
            if (i < 10) {
                date = "0" + i + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
            }
            for (MoMAttendance uds : attendances) {
                if (uds.getTime().equalsIgnoreCase(date + ", Morning")) {
                    displayMor = uds.getStatus();
                    if (uds.getMomComments() == null || uds.getMomComments().equalsIgnoreCase("")) {
                    } else {
                        displayMor = displayMor + "<span style='color:#2196F3'>(" + uds.getMomComments() + ")</span>";
                    }
                }
                if (uds.getTime().equalsIgnoreCase(date + ", Evening")) {
                    displayEve = uds.getStatus();
                    if (uds.getMomComments() == null || uds.getMomComments().equalsIgnoreCase("")) {
                    } else {
                        displayEve = displayEve + " <span style='color:#2196F3'>(" + uds.getMomComments() + ")</span>";
                    }
                }
                //System.out.println("date : "+uds.getTime()+"ID -->"+uds.getUserId()+"Morn :"+displayMor+" Eve : "+displayEve);
            }
            if (displayMor.contains("Unintimated")) {
                displayMor = "<span class=\"title-redtheme\">" + displayMor + "</span>";
            } else if (displayMor.contains("Leave")) {
                displayMor = "<span class=\"title-bluetheme\">" + displayMor + "</span>";
            } else if (displayMor.contains("Intimated")) {
                displayMor = "<span class=\"title-orangetheme\">" + displayMor + "</span>";
            } else if (displayMor.contains("Permission") || displayMor.contains("On Duty")) {
                displayMor = "<span class=\"title-yellowtheme\">" + displayMor + "</span>";
            }
            if (displayEve.contains("Unintimated")) {
                displayEve = "<span class=\"title-redtheme\">" + displayEve + "</span>";
            } else if (displayEve.contains("Leave")) {
                displayEve = "<span class=\"title-bluetheme\">" + displayEve + "</span>";
            } else if (displayEve.contains("Intimated")) {
                displayEve = "<span class=\"title-orangetheme\">" + displayEve + "</span>";
            } else if (displayMor.contains("Permission") || displayMor.contains("On Duty")) {
                displayEve = "<span class=\"title-yellowtheme\">" + displayEve + "</span>";
            }
            String len = displayMor + displayEve;
            if (len.length() > 0) {
                JsonOb jsonOb = new JsonOb();
                if (displayMor.length() > 0) {
                    if (displayEve.length() > 0) {
                        jsonOb.setTitle(displayMor + " <br/> " + displayEve);
                    } else {
                        jsonOb.setTitle(displayMor);
                    }
                } else {
                    jsonOb.setTitle(displayMor + displayEve);
                }
                jsonOb.setStart(datea);
                list.add(jsonOb);
                displayMor = "";
                displayEve = "";
            } else {
                List<Holidays> holidaysList = HolidaysUtil.findByHolidayDateByBranch(sdfs.parse(datea), branchId);
                if (holidaysList.size() > 0) {
                    for (Holidays h : holidaysList) {
                        displayMor = h.getHolidayName();
                    }
                }
                if (displayMor.length() > 0) {
                    JsonOb jsonOb = new JsonOb();
                    jsonOb.setTitle("<span class='title-greentheme'>" + displayMor + "</span>");
                    jsonOb.setStart(datea);
                    list.add(jsonOb);
                    displayMor = "";
                } else {
                    for (int j = 0; j < leaves.length; j++) {
                        fromDate = sdf.parse(leaves[j][1]);
                        toDate = sdf.parse(leaves[j][2]);
                        if (fromDate.compareTo(sdfs.parse(datea)) == 0 && toDate.compareTo(sdfs.parse(datea)) == 0 && Integer.parseInt(leaves[j][9]) >= 0) {
                            JsonOb jsonOb = new JsonOb();
                            if (leaves[j][12].equalsIgnoreCase("Full Day")) {
                                jsonOb.setTitle("<span class='title-bluetheme'>" + leaveStatus.get(Integer.parseInt(leaves[j][9])) + "<br/>" + leaveStatus.get(Integer.parseInt(leaves[j][9])) + "</span>");
                            } else if (leaves[j][12].equalsIgnoreCase("First Half")) {
                                jsonOb.setTitle("<span class='title-bluetheme'>" + leaveStatus.get(Integer.parseInt(leaves[j][9])) + "<br/></span>");
                            } else if (leaves[j][12].equalsIgnoreCase("Second Half")) {
                                jsonOb.setTitle("<span class='title-bluetheme'><br/><br/>" + leaveStatus.get(Integer.parseInt(leaves[j][9])) + "</span>");
                            }

                            jsonOb.setStart(datea);
                            list.add(jsonOb);
                            displayMor = "";
                            displayEve = "";
                        }
                    }
                }
            }
        }
//        for(JsonOb j:list){
//            System.out.println("Title : "+j.getTitle() +" Start :"+j.getStart());
//        }
        JsonFull jf = new JsonFull();
        jf.setList(list);
        jf.setUnintimated(2);
        ajaxResponse = new Gson().toJson(list);
        return ajaxResponse;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getUserId() {
        return userId;
    }

    public void setUserId(BigDecimal userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public List<String> getDatesList() {
        return datesList;
    }

    public void setDatesList(List<String> datesList) {
        this.datesList = datesList;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
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

    public List<MoMAttendance> getUserAttendies() {
        return userAttendies;
    }

    public void setUserAttendies(List<MoMAttendance> userAttendies) {
        this.userAttendies = userAttendies;
    }

    public void setYear(int year) {
        this.year = year;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 71 * hash + Objects.hashCode(this.userId);
        hash = 71 * hash + Objects.hashCode(this.status);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final MoMAttendance other = (MoMAttendance) obj;
        if (!Objects.equals(this.userId, other.userId)) {
            return false;
        }
        if (!Objects.equals(this.status, other.status)) {
            return false;
        }
        return true;
    }

    public String getMomComments() {
        return momComments;
    }

    public void setMomComments(String momComments) {
        this.momComments = momComments;
    }

    public int getBranch() {
        return branch;
    }

    public void setBranch(int branch) {
        this.branch = branch;
    }

    public String[][] getLeaveDetail() {
        return leaveDetail;
    }

    public void setLeaveDetail(String[][] leaveDetail) {
        this.leaveDetail = leaveDetail;
    }

}
