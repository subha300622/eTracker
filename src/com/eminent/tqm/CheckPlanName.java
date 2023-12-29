/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tqm;

import com.eminent.hibernate.HibernateUtil;
import static com.eminent.tqm.TqmUtil.logger;
import com.eminentlabs.mom.MoMUtil;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author E0288
 */
public class CheckPlanName {

    private boolean planNameExists = true;
    static Logger logger = null;

    static {
        logger = Logger.getLogger("CheckPlanName");
    }

    public List findUniqueTestPlan(String planName, String buildNo, int pid) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List l = null;
        try {
            session.beginTransaction();
            Query query = session.createQuery("from executionplan where planname=:planname and buildno=:buildno and pid=:pid");
            query.setParameter("planname", planName);
            query.setParameter("buildno", buildNo);
            query.setParameter("pid", pid);
            l = query.list();
            logger.info("findUniqueTestPlan" + l.size());
        } catch (Exception e) {
           logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return l;
    }

    public void setAll(HttpServletRequest request) {
        String planName = request.getParameter("planname");
        String buildNo = request.getParameter("buildno");
        String projectId = request.getParameter("project");
        int pId = MoMUtil.parseInteger(projectId, 0);
        List l = findUniqueTestPlan(planName, buildNo, pId);
        if (l.isEmpty()) {
            planNameExists = false;
        }

    }

    public boolean isPlanNameExists() {
        return planNameExists;
    }

    public void setPlanNameExists(boolean planNameExists) {
        this.planNameExists = planNameExists;
    }
}
