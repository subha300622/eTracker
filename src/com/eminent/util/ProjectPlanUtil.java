/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

import com.eminent.issue.PlanStatus;
import com.eminent.issue.ProjectPlannedIssue;
import com.eminentlabs.dao.DAOFactory;
import com.eminentlabs.dao.HibernateFactory;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author E0288
 */
public class ProjectPlanUtil {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ProjectPlanUtil");
    }

    public static void createProjectPlanIssue(ProjectPlannedIssue projectPlannedIssue) {

        DAOFactory.saveProjectPlannedIssue(projectPlannedIssue);

    }

    public static void updateProjectPlanIssue(ProjectPlannedIssue projectPlannedIssue) {

        DAOFactory.updateProjectPlannedIssue(projectPlannedIssue);

    }

    public static long uniqueProjectPlan(long pid, String issueId, Date plannedOn) {

        Session session = null;
        long id = 0l;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ProjectPlannedIssue.findUniqueProjectPlan");
            query.setParameter("pId", pid);
            query.setParameter("issueId", issueId);
            query.setParameter("plannedOn", plannedOn);
            ProjectPlannedIssue projectPlannedIssue = (ProjectPlannedIssue) query.uniqueResult();
            if (projectPlannedIssue != null) {
                id = projectPlannedIssue.getId();
            }
            logger.info("projectPlannedIssue.getId()" + id);
        } catch (Exception e) {
            logger.error("uniqueProjectPlan" + e.getMessage());
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
        return id;
    }

    public static List findByDayAndProjectId(Date plannedOn, long pid) {
        Session session = null;
        List<ProjectPlannedIssue> dayWisePlan = new ArrayList<ProjectPlannedIssue>();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ProjectPlannedIssue.findByPlannedOnAndProjectId");
            query.setParameter("pId", pid);
            query.setParameter("plannedOn", plannedOn);
            dayWisePlan = (List<ProjectPlannedIssue>) query.list();

            logger.info("dayWisePlan.size()" + dayWisePlan.size());
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
        return dayWisePlan;
    }

    public static List<String> findByPlannedOn(Date plannedOn) {

        List<String> plannedOnList = new ArrayList<String>();
        Session session = null;
        long id = 0l;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ProjectPlannedIssue.findByPlannedOn");
            query.setParameter("plannedOn", plannedOn);
            query.setParameter("status", PlanStatus.ACTIVE.getStatus());
            plannedOnList = (List<String>) query.list();

            logger.info("plannedOnList.size()" + plannedOnList.size());
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
        return plannedOnList;
    }

    public static List<String> findIssuesByDayAndProjectId(Date plannedOn, long pid) {
        Session session = null;
        List<String> dayWisePlan = new ArrayList<String>();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ProjectPlannedIssue.findByIssuesPlannedOnAndProjectId");
            query.setParameter("pId", pid);
            query.setParameter("plannedOn", plannedOn);
            query.setParameter("status", PlanStatus.ACTIVE.getStatus());
            dayWisePlan = (List<String>) query.list();

            logger.info("dayWisePlan.size()" + dayWisePlan.size());
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
        return dayWisePlan;
    }

    public static List<ProjectPlannedIssue>  findByDay(Date plannedOn) {
        Session session = null;
        List<ProjectPlannedIssue> dayWisePlan = new ArrayList<ProjectPlannedIssue>();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ProjectPlannedIssue.findAllByPlannedOn");
            query.setParameter("plannedOn", plannedOn);
            query.setParameter("status", PlanStatus.ACTIVE.getStatus());
            dayWisePlan = (List<ProjectPlannedIssue>) query.list();
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
        return dayWisePlan;
    }

}
