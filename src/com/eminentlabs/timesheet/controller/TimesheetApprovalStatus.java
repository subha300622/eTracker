/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.timesheet.controller;

import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.MoMUtil;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author EMINENT
 */
public class TimesheetApprovalStatus {

    static Logger logger = Logger.getLogger("TimesheetApprovalStatus");
    List<TimesheetApprovalFormbean> timeSheetFormBeans = new ArrayList<TimesheetApprovalFormbean>();

    private String startDate;
    private int month;
    private int year;
    private int userId;

    public void setAll(HttpServletRequest request) throws ParseException {
        DateFormat sdf = new SimpleDateFormat("MMMM yyyy");
        DateFormat sdfa = new SimpleDateFormat("MM yyyy");
        Calendar cal = new GregorianCalendar();
        Date date = cal.getTime();
        cal.setTime(date);
        if (request.getParameter("startDate") != null) {
            startDate = request.getParameter("startDate");
            cal.setTime(sdf.parse(startDate));
        } else {
            Calendar calc = new GregorianCalendar();
            calc.setTime(date);
            calc.add(Calendar.MONTH, -1);
            cal.setTime(calc.getTime());
            startDate = sdf.format(calc.getTime());
        }
        cal.add(Calendar.MONTH, 1);
        String converstion = sdfa.format(cal.getTime());

        timeSheetFormBeans = timeSheetAssignedTo(converstion);
        month = cal.get(Calendar.MONTH);
        year = cal.get(Calendar.YEAR);
        userId = (Integer) request.getSession().getAttribute("uid");
    }

    public List<TimesheetApprovalFormbean> timeSheetAssignedTo(String period) throws ParseException {
        Session session = null;
        List l = new ArrayList();
        DateFormat sdfa = new SimpleDateFormat("MM yyyy");
        Calendar cal = new GregorianCalendar();
        cal.setTime(sdfa.parse(period));
        cal.add(Calendar.MONTH, -1);
        Map<Integer, String> users = periodwiseUpdatedusers(sdfa.format(cal.getTime()));
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery("select b.firstname || ' ' || b.Lastname as name,APPROVALSTATUS,u.firstname || ' ' || u.Lastname as ASSIGNEDTO ,to_char(requestedon,'dd-Mon-yyyy HH:mi:ss'),timesheet.owner from timesheet,users u,users b  where u.userid=ASSIGNEDTO and b.userid=owner and to_char(requestedon,'MM YYYY')='" + period + "' ");
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                TimesheetApprovalFormbean timesheetApprovalFormbean = new TimesheetApprovalFormbean();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        timesheetApprovalFormbean.setName(row[col].toString());
                    } else if (col == 1) {
                        if (row[col] != null) {
                            timesheetApprovalFormbean.setStatus(row[col].toString());
                        } else {
                            timesheetApprovalFormbean.setStatus("Submitted");
                        }
                    } else if (col == 2) {
                        if (row[col] != null) {
                            timesheetApprovalFormbean.setAssignedTo(row[col].toString());
                        } else {
                            timesheetApprovalFormbean.setAssignedTo("");
                        }
                    } else if (col == 3) {
                        if (row[col] != null) {
                            timesheetApprovalFormbean.setRequestedOn(row[col].toString());
                        } else {
                            timesheetApprovalFormbean.setRequestedOn("");
                        }
                    } else if (col == 4) {
                        int owner = MoMUtil.parseInteger(row[col].toString(), 0);
                        timesheetApprovalFormbean.setOwner(owner);
                        users.remove(owner);
                    }
                }
                l.add(timesheetApprovalFormbean);
            }
            for (Map.Entry<Integer, String> user : users.entrySet()) {
                TimesheetApprovalFormbean timesheetApprovalFormbean = new TimesheetApprovalFormbean();
                timesheetApprovalFormbean.setName(user.getValue());
                timesheetApprovalFormbean.setAssignedTo("NA");
                timesheetApprovalFormbean.setRequestedOn("NA");
                timesheetApprovalFormbean.setStatus("Not Submitted");
                l.add(timesheetApprovalFormbean);
            }
        } catch (Exception e) {
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
        return l;

    }

    public Map<Integer, String> periodwiseUpdatedusers(String period) {
        Session session = null;
        Map<Integer, String> users = new LinkedHashMap<Integer, String>();

        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery("select Distinct(COMMENTEDBY),firstname ||' '||lastname as name from issuecomments i,users u where u.userid=i.commentedby and email like '%eminentlabs.net' and i.commentedby!=104 and to_char(COMMENT_DATE,'MM YYYY')='" + period + "' Union select Distinct(COMMENTEDBY),firstname ||' '||lastname as name from contact_comments c,users u where c.COMMENTEDBY=u.userid and  c.COMMENTEDBY!=104 and email like '%eminentlabs.net' and to_char(COMMENT_DATE,'MM YYYY')='" + period + "'");
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                int userId = 0;
                String name = "";
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        userId = (MoMUtil.parseInteger(row[col].toString(), 0));
                    } else if (col == 1) {
                        if (row[col] != null) {
                            name = row[col].toString();
                        }
                    }
                }
                users.put(userId, name);
            }

        } catch (Exception e) {
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
        return users;
    }

    public List<TimesheetApprovalFormbean> getTimeSheetFormBeans() {
        return timeSheetFormBeans;
    }

    public void setTimeSheetFormBeans(List<TimesheetApprovalFormbean> timeSheetFormBeans) {
        this.timeSheetFormBeans = timeSheetFormBeans;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

}
