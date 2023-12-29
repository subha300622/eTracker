/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.timesheet.controller;

import com.eminentlabs.dao.HibernateFactory;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author EMINENT
 */
public class HardShipAndSuggestionController {

    static Logger logger = Logger.getLogger("HardShipAndSuggestionController");
    List<TimeSheetFormBean> timeSheetFormBeans = new ArrayList<TimeSheetFormBean>();

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

        timeSheetFormBeans = getHssSg(converstion);
        month = cal.get(Calendar.MONTH);
        year = cal.get(Calendar.YEAR);
        userId = (Integer) request.getSession().getAttribute("uid");
    }

    public List<TimeSheetFormBean> getHssSg(String period) {
        Session session = null;
        List l = new ArrayList();
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery("select firstname || ' ' || Lastname,HARDSHIP,SUGGESTION from timesheet,users  where userid=owner and to_char(requestedon,'MM YYYY')='" + period + "'");
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                TimeSheetFormBean timeSheetFormBean = new TimeSheetFormBean();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        timeSheetFormBean.setName(row[col].toString());
                    } else if (col == 1) {
                        if (row[col] != null) {
                            timeSheetFormBean.setHardship(row[col].toString());
                        } else {
                            timeSheetFormBean.setHardship("");
                        }
                    } else if (col == 2) {
                        if (row[col] != null) {
                            timeSheetFormBean.setSuggestion(row[col].toString());
                        } else {
                            timeSheetFormBean.setSuggestion("");
                        }
                    }
                }
                l.add(timeSheetFormBean);
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

    public List<TimeSheetFormBean> getTimeSheetFormBeans() {
        return timeSheetFormBeans;
    }

    public void setTimeSheetFormBeans(List<TimeSheetFormBean> timeSheetFormBeans) {
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
