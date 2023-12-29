/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.leaveUtil;

import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import com.eminent.util.GetProjectMembers;
import com.eminentlabs.dao.HibernateFactory;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author EMINENT
 */
public class LeaveRequestController {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("LeaveRequestController");
    }
    List<Leave> leaveRequests = new ArrayList();
    private String startDate;
    private String endDate;

    public List<Leave> getLeaveRequest(String start, String end) {
        List<Leave> leaveRequesta = new ArrayList();
        //   DateFormat sdf = new SimpleDateFormat("dd-MM-YYYY HH:mm:ss");
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        /*edit by mukesh*/
        Set<String> holidayDatesList = new HashSet<>();
        SimpleDateFormat sdfa = new SimpleDateFormat("dd-MMM-yy");
        int branch = 0;
        Session session = null;
        try {
            Map<Integer, Set<String>> holidaysMap = new HashMap<>();
            List<Holidays> holidaysList = HolidaysUtil.findCalendarYearHolidays(sdfa.parse(start), sdfa.parse(end));

            if (!holidaysList.isEmpty()) {
                for (Holidays holday : holidaysList) {
                    Set<String> holidays = holidaysMap.get(holday.getBranchId());
                    if(holidays==null){
                       holidays = new HashSet<>();
                       holidaysMap.put(holday.getBranchId(), holidays);
                    }
                    holidays.add(sdfa.format(holday.getHolidayDate()));
                }
            }
            /*edit by mukesh*/
            session = HibernateFactory.getCurrentSession();

            Query query = session.createSQLQuery("select l.leaveId,l.fromdate,l.todate,l.type,l.description,to_char(l.createdon,'DD-MM-YYYY HH24:MI:SS'),to_char(l.modifiedon,'DD-MM-YYYY HH24:MI:SS'),l.requestedby,l.assignedto,l.approval,l.comments,l.approver,l.duration from Leave l where (to_date(l.fromdate,'DD-MM-YY') <=to_date('" + end + "','DD-MM-YY') and to_date(l.todate,'DD-MM-YY') >=to_date('" + start + "','DD-MM-YY')) order by l.fromdate desc");
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                 Leave l = new Leave();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        l.setLeaveid(new BigInteger(row[col].toString()));
                    } else if (col == 1) {
                        l.setFromdate((java.util.Date) row[col]);
                    } else if (col == 2) {
                        l.setTodate((java.util.Date) row[col]);
                    } else if (col == 3) {
                        l.setType((String) row[col]);
                    } else if (col == 4) {
                        l.setDescription((String) row[col]);
                    } else if (col == 5) {
                        l.setCreatedon(sdf.parse((String) row[col]));
                    } else if (col == 6) {
                        l.setModifiedon(sdf.parse((String) row[col]));
                    } else if (col == 7) {
                        l.setRequestedby(new BigDecimal(row[col].toString()));
                    } else if (col == 8) {
                        l.setAssignedto(new BigDecimal(row[col].toString()));
                    } else if (col == 9) {
                        l.setApproval(new BigInteger(row[col].toString()));
                    } else if (col == 10) {
                        l.setComments((String) (row[col]));
                    } else if (col == 11) {
                        if (row[col] != null) {
                            l.setApprover(new BigDecimal(row[col].toString()));
                        }
                    } else if (col == 12) {
                        l.setDuration((String) (row[col]));
                    }

                }
                /*edit by mukesh*/
                holidayDatesList = holidaysMap.get(GetProjectMembers.getBranchId(l.getRequestedby().intValue()));
                l.setNoOfLeaveDays(new LeaveBlancePeriodDAO().getLeaveDays(holidayDatesList, sdfa.format(l.getFromdate()), sdfa.format(l.getTodate()), l.getDuration()));
                /*edit by mukesh*/
                leaveRequesta.add(l);
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
        return leaveRequesta;
    }

    public HashMap<Integer, String> getLeaveStatus() {
        HashMap<Integer, String> hm = new HashMap<Integer, String>();
        hm.put(0, "Yet to Approve");
        hm.put(1, "Approved");
        hm.put(-1, "Rejected");
        hm.put(-2, "Cancelled");
        return hm;
    }

    public void setAll(HttpServletRequest request) {
        DateFormat sdf = new SimpleDateFormat("dd-MMM-YYYY");
        String from = sdf.format(new Date());
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        Date start = c.getTime();
        c.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
        Date end = c.getTime();
        startDate = sdf.format(start);
        endDate = sdf.format(end);
        if (request.getParameter("fromDate") != null) {
            startDate = request.getParameter("fromDate");
        }
        if (request.getParameter("toDate") != null) {
            endDate = request.getParameter("toDate");
            logger.info("---->" + endDate);
        }
        leaveRequests = getLeaveRequest(startDate, endDate);
    }

    /* edit by mukesh for Eporting excelSheet*/
    public void excelAll(String fromDate, String toDate) {
        DateFormat sdf = new SimpleDateFormat("dd-MMM-YYYY");
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        Date start = c.getTime();
        c.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
        Date end = c.getTime();
        startDate = sdf.format(start);
        endDate = sdf.format(end);
        if (fromDate != null) {
            startDate = fromDate;
        }
        if (toDate != null) {
            endDate = toDate;

        }
        leaveRequests = getLeaveRequest(startDate, endDate);
    }

    public static void main(String[] args) {
        LeaveRequestController ob = new LeaveRequestController();

    }

    public List<Leave> getLeaveRequests() {
        return leaveRequests;
    }

    public void setLeaveRequests(List<Leave> leaveRequests) {
        this.leaveRequests = leaveRequests;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

}
