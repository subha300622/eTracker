/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.ApmWrmDay;
import com.eminentlabs.dao.DAOFactory;
import com.eminentlabs.dao.HibernateFactory;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class MaintainWRMDay {
static Logger logger = null;

    static {
        logger = Logger.getLogger("MaintainWRMDay");
    }
    private String message;
    List<ApmWrmDay> projectWrmDays = new ArrayList<ApmWrmDay>();

    public void setAll(HttpServletRequest request) {
        projectWrmDays = findAll();
        String projectIds[] = request.getParameterValues("pid");
        String wrmDays[] = request.getParameterValues("wrmDay");

        HttpSession session = request.getSession();
        int roleId = (Integer) session.getAttribute("Role");
        if (roleId != 1) {
            message = "You are not authorized to access this page";
        } else {
            if (projectIds != null) {

                for (int i = 0; i < projectIds.length; i++) {

                    long pId = Long.valueOf(projectIds[i]);
                    int wrmDay = Integer.valueOf(wrmDays[i]);
                    boolean flag = false;
                    if (projectWrmDays != null && !projectWrmDays.isEmpty()) {
                        for (ApmWrmDay apmWrmDay : projectWrmDays) {
                            if (pId == apmWrmDay.getPid()) {
                                flag = true;
                            }
                        }
                    }
                    if (flag == true) {
                        for (ApmWrmDay apmWrmDay : projectWrmDays) {
                            if (pId == apmWrmDay.getPid()) {
                                if (wrmDay != apmWrmDay.getWrmDay()) {
                                    apmWrmDay.setWrmDay(wrmDay);
                                    DAOFactory.updateAWD(apmWrmDay);
                                }
                            }
                        }

                    } else {
                        ApmWrmDay awd = new ApmWrmDay(pId, wrmDay);

                        DAOFactory.createWRMDay(awd);
                    }
                }
            }
        }


    }

    public Map<Long, String> projectList() {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        Map<Long, String> projectsList = new LinkedHashMap<Long, String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pid,CONCAT(CONCAT(p.pname,' v'),p.version) as pfullname from  Project p where (status='Work in progress') order by upper(pfullname) asc");
            while (resultset.next()) {
                projectsList.put(resultset.getLong(1), resultset.getString(2));
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

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return projectsList;
    }

    public Map<Integer, String> days() {
        Map<Integer, String> projectsList = new LinkedHashMap<Integer, String>();
        projectsList.put(0, "--Select One--");
        projectsList.put(1, "Sunday");
        projectsList.put(2, "Monday");
        projectsList.put(3, "Tuesday");
        projectsList.put(4, "Wednesday");
        projectsList.put(5, "Thursday");
        projectsList.put(6, "Friday");
        projectsList.put(7, "Saturday");
        return projectsList;
    }

    public List<ApmWrmDay> findAll() {
        Session session = null;
        List<ApmWrmDay> l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmWrmDay.findAll");
            l = query.list();
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

    public int findDayByPid(long pid) {
        Session session = null;
        int day = 0;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmWrmDay.findByPid");
            query.setParameter("pid", pid);
            Object ob = (Object) query.uniqueResult();
            if (ob != null) {
                day = (Integer) ob;
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
        return day;
    }

    public int getWRMDAY(long pid) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        int day = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select wrm_day from project where pid = " + pid);
            while (resultset.next()) {
                day = resultset.getInt("wrm_day");
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

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return day;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<ApmWrmDay> getProjectWrmDays() {
        return projectWrmDays;
    }

    public void setProjectWrmDays(List<ApmWrmDay> projectWrmDays) {
        this.projectWrmDays = projectWrmDays;
    }
}
