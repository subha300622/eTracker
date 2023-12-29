/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.ApmTeam;
import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.dao.ModelDAO;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author E0288
 */
public class ApmTeamController {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ApmTeamController");
    }
    private long teamId;
    private String teamName;
    private String totalTeams = "";
    List<ApmTeam> teamList = new ArrayList<ApmTeam>();

    public void setAll(HttpServletRequest request) {
        teamList = findAllTeams();
    }

    public void doAction(HttpServletRequest request) {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        if (action.equalsIgnoreCase("create")) {
            addTeam(request);
        } else if (action.equalsIgnoreCase("update")) {
            update(request);
        } else if (action.equalsIgnoreCase("delete")) {
            delete(request);
        } else if (action.equalsIgnoreCase("retrieve")) {
            teamList = findAllTeams();

            for (ApmTeam apmTeam : teamList) {
                totalTeams = totalTeams + apmTeam.getTeamName() + ",";
            }
        }
    }

    public void addTeam(HttpServletRequest request) {
        String teams[] = request.getParameter("team").split(",");
        if (teams != null) {
            totalTeams="";
            for (int i = 0; i < teams.length; i++) {
                ApmTeam apmTeam = new ApmTeam();
                apmTeam.setTeamName(teams[i]);
                ModelDAO.save(DAOConstants.ENTITY_APM_TEAM,apmTeam);
                apmTeam=findByTeamName(teams[i]);
                long id=apmTeam.getTeamId();
                totalTeams=totalTeams+"<tr id='apmteamId"+id+"'><td>"+id+"</td><td id='teamName"+id+"'>"+teams[i]+"</td><td><input type='hidden' name='teamValue"+id+"' id='teamValue"+id+"' value='"+teams[i]+"'><span onclick=\"editTeam('"+id+"');\" style=\"color: blue;cursor: pointer; \">Edit</span> || <span onclick=\"deleteTeam('"+id+"');\" style=\"color: blue;cursor: pointer;\">Delete</span> || <span onclick=\"addComponents('"+id+"');\" style=\"color: blue;cursor: pointer; \">Add Components</span> || <span onclick=\"viewcomponent('"+id+"');\" style=\"color: blue;cursor: pointer;\">View Components</span>  </tr>";
            }
        }


    }

    public void update(HttpServletRequest request) {
        String team = request.getParameter("editteam");
        String editTeamId = request.getParameter("teamId");
        logger.info(team);
        if (editTeamId != null) {
            long id = Long.valueOf(editTeamId);
            ApmTeam apmTeam = new ApmTeam();
            apmTeam = findByTeamId(id);
            logger.info(apmTeam.getTeamName());
            if (team != null) {
                apmTeam.setTeamName(team);
                ModelDAO.update(DAOConstants.ENTITY_APM_TEAM, apmTeam);
            }
        }
    }

    public void delete(HttpServletRequest request) {
        String deleteTeamId = request.getParameter("teamId");
        if (deleteTeamId != null) {
            long id = Long.valueOf(deleteTeamId);
            ApmTeam apmTeam = findByTeamId(id);
            if (apmTeam != null) {
                ModelDAO.delete(DAOConstants.ENTITY_APM_TEAM, apmTeam);
            }
        }
    }

    public List<ApmTeam> findAllTeams() {
        Session session = null;
        List<ApmTeam> findAllTeams = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmTeam.findAll");

            findAllTeams = (List<ApmTeam>) query.list();
            if (findAllTeams == null) {
                findAllTeams = new ArrayList<ApmTeam>();
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
        return findAllTeams;
    }

    public ApmTeam findByTeamName(String teamName) {
        Session session = null;
        ApmTeam apmTeam = new ApmTeam();
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmTeam.findByTeamName");
            query.setParameter("teamName", teamName.toUpperCase());
            apmTeam = (ApmTeam) query.uniqueResult();

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

    public ApmTeam findByTeamId(long teamId) {
        Session session = null;
        ApmTeam apmTeam = new ApmTeam();
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

    public long getTeamId() {
        return teamId;
    }

    public void setTeamId(long teamId) {
        this.teamId = teamId;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public List<ApmTeam> getTeamList() {
        return teamList;
    }

    public void setTeamList(List<ApmTeam> teamList) {
        this.teamList = teamList;
    }

    public String getTotalTeams() {
        return totalTeams;
    }

    public void setTotalTeams(String totalTeams) {
        this.totalTeams = totalTeams;
    }
}
