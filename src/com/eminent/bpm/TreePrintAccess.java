/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.bpm;

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
public class TreePrintAccess {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("TreePrintAccess");
    }
    private Integer type;
    private long pId;
    private String message;
    private Map<Integer, String> treeAccessType = new LinkedHashMap<Integer, String>();
    private Map<Long, String> treeProjectsList = new LinkedHashMap<Long, String>();
    List<BpmPrintaccess> l = new ArrayList<BpmPrintaccess>();

    public void setAll(HttpServletRequest request) {
        HttpSession session = request.getSession();
        int roleId = (Integer) session.getAttribute("Role");
        if (roleId != 1) {
            message = "You are not authorized to access this page";
        } else {
            l = findAll();
            String projectIds[] = request.getParameterValues("pid");
            String types[] = request.getParameterValues("type");
            BpmPrintaccess bpa = new BpmPrintaccess();
            if (projectIds != null) {

                for (int i = 0; i < projectIds.length; i++) {

                    pId = Long.valueOf(projectIds[i]);
                    type = Integer.valueOf(types[i]);
                    boolean flag = false;
                    if (l != null && !l.isEmpty()) {
                        for (BpmPrintaccess bpaccess : l) {
                            if (pId == bpaccess.getPid()) {
                                flag = true;
                            }
                        }
                    }
                    if (flag == true) {
                        for (BpmPrintaccess bpaccess : l) {
                            if (pId == bpaccess.getPid()) {
                                if (type != bpaccess.getType()) {
                                    bpaccess.setType(type);
                                    DAOFactory.updateBPA(bpaccess);
                                }
                            }
                        }

                    } else {
                        bpa.setPid(pId);
                        bpa.setType(type);
                        DAOFactory.createBPA(bpa);
                    }
                }
            }
            treeProjectList();
            accessTypeList();
        }

    }

    public void accessTypeList() {
        treeAccessType.put(0, "Internal");
        treeAccessType.put(1, "Both");
        treeAccessType.put(2, "External");
    }

    public void treeProjectList() {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select b.CLIENT_ID,CONCAT(CONCAT(p.pname,' v'),p.version) as pfullname from BPM_COMPANY b, Project p where b.CLIENT_ID=p.pid");
            while (resultset.next()) {
                treeProjectsList.put(resultset.getLong(1), resultset.getString(2));
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

    }

    public Map<Long, String> treeProject(int userId) {
        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        Map<Long, String> treeProjects = new LinkedHashMap<Long, String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select b.CLIENT_ID,CONCAT(CONCAT(p.pname,' v'),p.version) as pfullname from BPM_COMPANY b, Project p,USERPROJECT U where b.CLIENT_ID=p.pid and  USERID = " + userId + " AND P.PID = U.PID AND STATUS != 'Finished'");
            while (resultset.next()) {
                treeProjects.put(resultset.getLong(1), resultset.getString(2));
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
        return treeProjects;
    }

    public List<BpmPrintaccess> findAll() {
        Session session = null;
        List<BpmPrintaccess> l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("BpmPrintaccess.findAll");
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

    public BpmPrintaccess findByPid(String pid) {
        Session session = null;
        BpmPrintaccess bpAccess = null;
        try {
            long projectid = Long.valueOf(pid);
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("BpmPrintaccess.findByPid");
            query.setParameter("pid", projectid);
            bpAccess = (BpmPrintaccess) query.uniqueResult();
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
        return bpAccess;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Long getpId() {
        return pId;
    }

    public void setpId(Long pId) {
        this.pId = pId;
    }

    public Map<Integer, String> getTreeAccessType() {
        return treeAccessType;
    }

    public void setTreeAccessType(Map<Integer, String> treeAccessType) {
        this.treeAccessType = treeAccessType;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<Long, String> getTreeProjectsList() {
        return treeProjectsList;
    }

    public void setTreeProjectsList(Map<Long, String> treeProjectsList) {
        this.treeProjectsList = treeProjectsList;
    }

    public List<BpmPrintaccess> getL() {
        return l;
    }

    public void setL(List<BpmPrintaccess> l) {
        this.l = l;
    }
}
