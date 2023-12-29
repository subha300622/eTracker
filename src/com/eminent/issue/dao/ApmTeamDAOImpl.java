/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.dao;

import com.eminent.issue.ApmTeam;
import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

public class ApmTeamDAOImpl implements ApmTeamDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ApmTeamDAOImpl");
    }

    @Override
    public void addTeam(ApmTeam apmTeam) {
        apmTeam.setTeamId(apmTeam.getTeamId());
        apmTeam.setTeamName(apmTeam.getTeamName());
        ModelDAO.save(DAOConstants.ENTITY_APM_TEAM, apmTeam);
    }

    @Override
    public List<ApmTeam> findAllTeams(ApmTeam apmTeam) {
        List<ApmTeam> findAllApmTeam = null;
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmTeam.findAll");

            findAllApmTeam = (List<ApmTeam>) query.list();
            if (findAllApmTeam == null) {
                findAllApmTeam = new ArrayList<ApmTeam>();
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
        return findAllApmTeam;
    }

    @Override
    public void update(ApmTeam apmTeam) {
        ModelDAO.update(DAOConstants.ENTITY_APM_TEAM, apmTeam);

    }

    @Override
    public void delete(ApmTeam apmTeam) {
        ApmTeam apmTeam1 = findByTeamId(Long.valueOf(apmTeam.getTeamId()));
        if (apmTeam1 != null) {
            ModelDAO.delete(DAOConstants.ENTITY_APM_TEAM, apmTeam);
        }
    }

    @Override
    public ApmTeam findByTeamId(long teamId) {
        ApmTeam apmTeam = new ApmTeam();
        Session session = null;
        try {

            session = HibernateFactory.getCurrentSession();
            apmTeam = (ApmTeam) session.get(ApmTeam.class, teamId);

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
        return apmTeam;
    }
}
