/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.leaveUtil;

import com.eminentlabs.mom.MoMAttendance;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.mom.controller.MomMaintananceController;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author admin
 */
public class LeaveBalancePeriod {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("LeaveBalancePeriod");
    }
    String momAttandance[][] = null;
    String startMonth = "";
    String endMonth = "";
    LeaveBalanceReportBean leaveBalanceReportBean;
    List<LeaveBalanceReportBean> listLeaveBalanceReportBeans = new ArrayList<LeaveBalanceReportBean>();
    LeaveBlancePeriodDAO leaveBlancePeriodDAO = new LeaveBlancePeriodDAO();

    public void getAll(HttpServletRequest request) throws SQLException, ParseException {

        startMonth = request.getParameter("fromDate");
        endMonth = request.getParameter("toDate");
        DateFormat sdf = new SimpleDateFormat("MMMM yyyy");
        try {
            String startdate = "";
            String endDate = "";
            int month = 0;
            int year = 0;
            Calendar cal = Calendar.getInstance();

            if (startMonth == null && endMonth == null) {
                cal.add((Calendar.MONTH), -1);
                startMonth = sdf.format(cal.getTime());
                endMonth = sdf.format(cal.getTime());
            }
            SimpleDateFormat sdff = new SimpleDateFormat("dd-MMM-yyyy");
            Date statrtdt = sdf.parse(startMonth);
            Date endDt = sdf.parse(endMonth);
            cal.setTime(statrtdt);

            cal.set(Calendar.DAY_OF_MONTH, 1);
            startdate = sdff.format(cal.getTime());
            month = cal.get(Calendar.MONTH);
            year = cal.get(Calendar.YEAR);

            cal.setTime(endDt);
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DATE));
            endDate = sdff.format(cal.getTime());

            Map<Integer, String> momteam = new MomMaintananceController().momTypeMaintanance();
            Map<Integer, String> team = leaveBlancePeriodDAO.userTeam();

            Map<Integer, LinkedHashMap<String, Float>> leaveDeatalisMontha = LeaveBlancePeriodDAO.leaveCountByPeriod(startdate, endDate);
            Map<Integer, LinkedHashMap<String, Float>> leaveBlance = LeaveBlancePeriodDAO.leaveBalnceAllUser(year, month);

            Set<String> attStatu = MoMUtil.attendancsStatus();

            Map<BigDecimal, String> users = new LinkedHashMap<BigDecimal, String>();
            List<MoMAttendance> moMAttendancesList = leaveBlancePeriodDAO.userAttendanceByMomths(startdate, endDate);
            String startDate = "01-Apr-" + year;
            String enddate = "31-Mar-" + (year + 1);
            if (month < 3) {
                startDate = "01-Apr-" + (year - 1);
                enddate = "31-Mar-" + (year);
            }
            List<MoMAttendance> moMAttendancePL = new ArrayList<MoMAttendance>();
            if (new Date().getTime() >= sdff.parse("01-Apr-2016").getTime()) {
                moMAttendancePL = leaveBlancePeriodDAO.userAttendanceByMomths(startDate, enddate);
            }

            for (MoMAttendance uds : moMAttendancesList) {
                if (!users.containsKey(uds.getUserId())) {
                    users.put(uds.getUserId(), uds.getName());

                }

            }

            for (Map.Entry<BigDecimal, String> entry : users.entrySet()) {
                leaveBalanceReportBean = new LeaveBalanceReportBean();
                float presnt = 0.0f;
                float other = 0.0f;
                float unintimated = 0.0f;
                float pLleavepresent = 0.0f;
                String empTTeam = "";

                for (String status : attStatu) {
                    int count = 0;
                    if (new Date().getTime() >= sdff.parse("01-Apr-2016").getTime()) {
                        for (MoMAttendance uds : moMAttendancePL) {
                            if (uds.getUserId().equals(entry.getKey())) {
                                if (status.equalsIgnoreCase(uds.getStatus())) {
                                    count = uds.getCount();
                                }

                            }
                        }
                    }
                    if (status.equalsIgnoreCase("Present") || status.contains("Permission") || status.contains("Client") || status.contains("Intimated")) {
                        pLleavepresent = pLleavepresent + count / 2;

                    }
                }
                for (String status : attStatu) {
                    int count = 0;
                    for (MoMAttendance uds : moMAttendancesList) {
                        if (uds.getUserId().equals(entry.getKey())) {
                            if (status.equalsIgnoreCase(uds.getStatus())) {
                                count = uds.getCount();
                            }
                            empTTeam = uds.getPeriod();
                        }
                    }

                    if (status.contains("Present") || status.contains("Permission") || status.contains("Client") || status.contains("Intimated")) {
                        presnt = presnt + ((float) count) / 2;
                    }
                    if (status.contains("Medical")) {
                        other = ((float) count) / 2;
                    } else if (status.contains("Unintimated")) {
                        unintimated = ((float) count) / 2;
                    }
                }
                String sl = "0.0";
                String cl = "0.0";
                String pl = "0.0";
                String absent = "0.0";
                for (Map.Entry<Integer, LinkedHashMap<String, Float>> map : leaveDeatalisMontha.entrySet()) {
                    if (entry.getKey().intValue() == map.getKey()) {
                        for (Map.Entry<String, Float> entry1 : map.getValue().entrySet()) {
                            if (entry1.getKey().contains("Sick")) {
                                sl = String.valueOf(entry1.getValue());
                            }
                            if (entry1.getKey().contains("Privil")) {
                                pl = String.valueOf(entry1.getValue());
                            }
                            if (entry1.getKey().contains("Casual")) {
                                cl = String.valueOf(entry1.getValue());
                            }
                            if (entry1.getKey().contains("Absent")) {
                                absent = String.valueOf(entry1.getValue());
                            }
                        }
                    }
                }
                String blancesl = "8.0";
                String blancecl = "8.0";
                String blanceabsent = "0.0";
                float aviliedsl = 0.0f;
                float aviliedcl = 0.0f;
                float aviliedpl = 0.0f;
                float aviliedabsent = 0.0f;
                int maxPLleave = (int) pLleavepresent / 20;
                if (maxPLleave > 8) {
                    maxPLleave = 8;
                }
                float maxPLeave = (float) maxPLleave;
                float total = 0.0f;
                String blancepl = String.valueOf(maxPLeave);
                for (Map.Entry<Integer, LinkedHashMap<String, Float>> blance : leaveBlance.entrySet()) {
                    if (entry.getKey().intValue() == blance.getKey()) {
                        for (Map.Entry<String, Float> entry1 : blance.getValue().entrySet()) {
                            if (entry1.getKey().contains("Sick")) {
                                total = total + entry1.getValue();
                                aviliedsl = entry1.getValue();
                                blancesl = String.valueOf(8.0 - entry1.getValue());
                            }
                            if (entry1.getKey().contains("Privil")) {
                                total = total + entry1.getValue();
                                aviliedpl = entry1.getValue();
                                blancepl = String.valueOf(maxPLeave - entry1.getValue());
                            }
                            if (entry1.getKey().contains("Casual")) {
                                total = total + entry1.getValue();
                                aviliedcl = entry1.getValue();
                                blancecl = String.valueOf(8.0 - entry1.getValue());
                            }
                            if (entry1.getKey().contains("Absent")) {
                                total = total + entry1.getValue();
                                aviliedabsent = entry1.getValue();
                                blanceabsent = String.valueOf(0.0);
                            }
                        }
                    }
                }

                String empno = "";
                String userteam = "";

                for (Map.Entry<Integer, String> uteam : team.entrySet()) {

                    if (uteam.getKey() == entry.getKey().intValue()) {
                        String str[] = uteam.getValue().split("-");
                        empno = str[0];
                        for (Map.Entry<Integer, String> mteam : momteam.entrySet()) {
                            if (mteam.getKey() == Integer.parseInt(str[1])) {
                                userteam = "-" + mteam.getValue();

                            }
                        }
                    }
                }

                if (empno.equalsIgnoreCase("null") || "".equals(empno)) {
                    empno = "";
                }
                if (new Date().getTime() < sdff.parse("01-Apr-2016").getTime()) {
                    maxPLeave = 8.0f;
                    blancepl = String.valueOf(8.0 - aviliedpl);
                }
                leaveBalanceReportBean.setUserId(String.valueOf(entry.getKey()));
                leaveBalanceReportBean.setEmpNo(empno);
                leaveBalanceReportBean.setEmpName(entry.getValue());
                leaveBalanceReportBean.setEmpDivision(userteam);
                leaveBalanceReportBean.setTeam(empTTeam);

                leaveBalanceReportBean.setPeriodPresent(String.valueOf(presnt));
                leaveBalanceReportBean.setPeriodOther(String.valueOf(other));
                leaveBalanceReportBean.setPeriodUnInitmeted(unintimated);
                leaveBalanceReportBean.setPeriodSickLeave(sl);
                leaveBalanceReportBean.setPeriodCasualLeave(cl);
                leaveBalanceReportBean.setPeriodPrivilegeLeave(pl);
                leaveBalanceReportBean.setPeriodAbsent(absent);

                leaveBalanceReportBean.setAvailableSickLeave("8.0");
                leaveBalanceReportBean.setAvailableCasualLeave("8.0");
                leaveBalanceReportBean.setAvailablePrivilegeLeave(String.valueOf(maxPLeave));
                leaveBalanceReportBean.setAvailableAbsent("0.0");

                leaveBalanceReportBean.setAvailedSickLeave(aviliedsl);
                leaveBalanceReportBean.setAvailedCasualLeave(aviliedcl);
                leaveBalanceReportBean.setAvailedPrivilegeLeave(aviliedpl);
                leaveBalanceReportBean.setAvailedAbsent(aviliedabsent);

                leaveBalanceReportBean.setBalanceSickLeave(blancesl);
                leaveBalanceReportBean.setBalanceCasualLeave(blancecl);
                leaveBalanceReportBean.setBalancePrivilegeLeave(blancepl);
                leaveBalanceReportBean.setBalanceAbsent(blanceabsent);

                leaveBalanceReportBean.setTotalLeaveTaken(String.valueOf(total));

                listLeaveBalanceReportBeans.add(leaveBalanceReportBean);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getAll()" + e.getMessage());
        }

    }

    public void exportExcel(String fmonth, String tomonth) {

        startMonth = fmonth;
        endMonth = tomonth;
        DateFormat sdf = new SimpleDateFormat("MMMM yyyy");
        try {
            String startdate = "";
            String endDate = "";
            int month = 0;
            int year = 0;
            Calendar cal = Calendar.getInstance();

            if (startMonth == null && endMonth == null) {
                cal.add((Calendar.MONTH), -1);
                startMonth = sdf.format(cal.getTime());
                endMonth = sdf.format(cal.getTime());
            }
            SimpleDateFormat sdff = new SimpleDateFormat("dd-MMM-yyyy");
            Date statrtdt = sdf.parse(startMonth);
            Date endDt = sdf.parse(endMonth);
            cal.setTime(statrtdt);

            cal.set(Calendar.DAY_OF_MONTH, 1);
            startdate = sdff.format(cal.getTime());
            month = cal.get(Calendar.MONTH);
            year = cal.get(Calendar.YEAR);

            cal.setTime(endDt);
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DATE));
            endDate = sdff.format(cal.getTime());

            Map<Integer, String> momteam = new MomMaintananceController().momTypeMaintanance();
            Map<Integer, String> team = leaveBlancePeriodDAO.userTeam();

            Map<Integer, LinkedHashMap<String, Float>> leaveDeatalisMontha = LeaveBlancePeriodDAO.leaveCountByPeriod(startdate, endDate);
            Map<Integer, LinkedHashMap<String, Float>> leaveBlance = LeaveBlancePeriodDAO.leaveBalnceAllUser(year, month);

            Set<String> attStatu = MoMUtil.attendancsStatus();

            Map<BigDecimal, String> users = new LinkedHashMap<BigDecimal, String>();
            List<MoMAttendance> moMAttendancesList = leaveBlancePeriodDAO.userAttendanceByMomths(startdate, endDate);
            String startDate = "01-Apr-" + year;
            String enddate = "31-Mar-" + (year + 1);
            if (month < 3) {
                startDate = "01-Apr-" + (year - 1);
                enddate = "31-Mar-" + (year);
            }
            List<MoMAttendance> moMAttendancePL = new ArrayList<MoMAttendance>();
            if (new Date().getTime() >= sdff.parse("01-Apr-2016").getTime()) {
                moMAttendancePL = leaveBlancePeriodDAO.userAttendanceByMomths(startDate, enddate);
            }

            for (MoMAttendance uds : moMAttendancesList) {
                if (!users.containsKey(uds.getUserId())) {
                    users.put(uds.getUserId(), uds.getName());

                }

            }

            for (Map.Entry<BigDecimal, String> entry : users.entrySet()) {
                leaveBalanceReportBean = new LeaveBalanceReportBean();
                float presnt = 0.0f;
                float other = 0.0f;
                float unintimated = 0.0f;
                float pLleavepresent = 0.0f;
                String empTTeam = "";

                for (String status : attStatu) {
                    int count = 0;
                    for (MoMAttendance uds : moMAttendancePL) {
                        if (uds.getUserId().equals(entry.getKey())) {
                            if (status.equalsIgnoreCase(uds.getStatus())) {
                                count = uds.getCount();
                            }
                        }
                    }
                    if (status.equalsIgnoreCase("Present") || status.contains("Permission") || status.contains("Client") || status.contains("Intimated")) {
                        pLleavepresent = pLleavepresent + count / 2;

                    }
                }
                for (String status : attStatu) {
                    int count = 0;
                    for (MoMAttendance uds : moMAttendancesList) {
                        if (uds.getUserId().equals(entry.getKey())) {
                            if (status.equalsIgnoreCase(uds.getStatus())) {
                                count = uds.getCount();
                            }
                            empTTeam = uds.getPeriod();
                        }
                    }
                    if (status.contains("Medical")) {
                        other = ((float) count) / 2;

                    } else if (status.contains("Present") || status.contains("Client") || status.contains("Permission") || status.contains("Intimated")) {
                        presnt = presnt + ((float) count) / 2;
                    } else if (status.contains("Unintimated")) {
                        unintimated = ((float) count) / 2;
                    }
                }

                String sl = "0.0";
                String cl = "0.0";
                String pl = "0.0";
                String absent = "0.0";
                for (Map.Entry<Integer, LinkedHashMap<String, Float>> map : leaveDeatalisMontha.entrySet()) {
                    if (entry.getKey().intValue() == map.getKey()) {
                        for (Map.Entry<String, Float> entry1 : map.getValue().entrySet()) {
                            if (entry1.getKey().contains("Sick")) {
                                sl = String.valueOf(entry1.getValue());
                            }
                            if (entry1.getKey().contains("Privil")) {
                                pl = String.valueOf(entry1.getValue());
                            }
                            if (entry1.getKey().contains("Casual")) {
                                cl = String.valueOf(entry1.getValue());
                            }
                            if (entry1.getKey().contains("Absent")) {
                                absent = String.valueOf(entry1.getValue());
                            }
                        }
                    }
                }
                String blancesl = "8.0";
                String blancecl = "8.0";
                String blanceabsent = "0.0";
                float aviliedsl = 0.0f;
                float aviliedcl = 0.0f;
                float aviliedpl = 0.0f;
                float aviliedabsent = 0.0f;
                int maxPLleave = (int) pLleavepresent / 20;
                if (maxPLleave > 8) {
                    maxPLleave = 8;
                }
                float maxPLeave = (float) maxPLleave;
                float total = 0.0f;
                String blancepl = String.valueOf(maxPLeave);
                for (Map.Entry<Integer, LinkedHashMap<String, Float>> blance : leaveBlance.entrySet()) {
                    if (entry.getKey().intValue() == blance.getKey()) {
                        for (Map.Entry<String, Float> entry1 : blance.getValue().entrySet()) {
                            if (entry1.getKey().contains("Sick")) {
                                total = total + entry1.getValue();
                                aviliedsl = entry1.getValue();
                                blancesl = String.valueOf(8.0 - entry1.getValue());
                            }
                            if (entry1.getKey().contains("Privil")) {
                                total = total + entry1.getValue();
                                aviliedpl = entry1.getValue();

                                blancepl = String.valueOf(maxPLeave - entry1.getValue());
                            }
                            if (entry1.getKey().contains("Casual")) {
                                total = total + entry1.getValue();
                                aviliedcl = entry1.getValue();
                                blancecl = String.valueOf(8.0 - entry1.getValue());
                            }
                            if (entry1.getKey().contains("Absent")) {
                                total = total + entry1.getValue();
                                aviliedabsent = entry1.getValue();
                                blanceabsent = String.valueOf(0.0);
                            }
                        }
                    }
                }

                String empno = "";
                String userteam = "";

                for (Map.Entry<Integer, String> uteam : team.entrySet()) {

                    if (uteam.getKey() == entry.getKey().intValue()) {
                        String str[] = uteam.getValue().split("-");
                        empno = str[0];
                        for (Map.Entry<Integer, String> mteam : momteam.entrySet()) {
                            if (mteam.getKey() == Integer.parseInt(str[1])) {
                                userteam = "-" + mteam.getValue();

                            }
                        }
                    }
                }
                if (empno.equalsIgnoreCase("null") || "".equals(empno)) {
                    empno = "";
                }
                if (new Date().getTime() < sdff.parse("01-Apr-2016").getTime()) {
                    maxPLeave = 8.0f;
                    blancepl = String.valueOf(8.0 - aviliedpl);
                }
                leaveBalanceReportBean.setUserId(String.valueOf(entry.getKey()));
                leaveBalanceReportBean.setEmpNo(empno);
                leaveBalanceReportBean.setEmpName(entry.getValue());
                leaveBalanceReportBean.setEmpDivision(userteam);
                leaveBalanceReportBean.setTeam(empTTeam);

                leaveBalanceReportBean.setPeriodPresent(String.valueOf(presnt));
                leaveBalanceReportBean.setPeriodOther(String.valueOf(other));
                leaveBalanceReportBean.setPeriodUnInitmeted(unintimated);
                leaveBalanceReportBean.setPeriodSickLeave(sl);
                leaveBalanceReportBean.setPeriodCasualLeave(cl);
                leaveBalanceReportBean.setPeriodPrivilegeLeave(pl);
                leaveBalanceReportBean.setPeriodAbsent(absent);

                leaveBalanceReportBean.setAvailableSickLeave("8.0");
                leaveBalanceReportBean.setAvailableCasualLeave("8.0");
                leaveBalanceReportBean.setAvailablePrivilegeLeave(String.valueOf(maxPLeave));
                leaveBalanceReportBean.setAvailableAbsent("0.0");

                leaveBalanceReportBean.setAvailedSickLeave(aviliedsl);
                leaveBalanceReportBean.setAvailedCasualLeave(aviliedcl);
                leaveBalanceReportBean.setAvailedPrivilegeLeave(aviliedpl);
                leaveBalanceReportBean.setAvailedAbsent(aviliedabsent);

                leaveBalanceReportBean.setBalanceSickLeave(blancesl);
                leaveBalanceReportBean.setBalanceCasualLeave(blancecl);
                leaveBalanceReportBean.setBalancePrivilegeLeave(blancepl);
                leaveBalanceReportBean.setBalanceAbsent(blanceabsent);

                leaveBalanceReportBean.setTotalLeaveTaken(String.valueOf(total));

                listLeaveBalanceReportBeans.add(leaveBalanceReportBean);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    public String getStartMonth() {
        return startMonth;
    }

    public String getEndMonth() {
        return endMonth;
    }

    public List<LeaveBalanceReportBean> getListLeaveBalanceReportBeans() {
        return listLeaveBalanceReportBeans;
    }

    public void setListLeaveBalanceReportBeans(List<LeaveBalanceReportBean> listLeaveBalanceReportBeans) {
        this.listLeaveBalanceReportBeans = listLeaveBalanceReportBeans;
    }

}
