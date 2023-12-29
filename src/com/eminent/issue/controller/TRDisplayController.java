/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.ApmTrFormat;
import com.eminent.issue.TrDetails;
import com.eminent.issue.dao.ApmTrFormatDAO;
import com.eminent.issue.dao.ApmTrFormatDAOImpl;
import com.eminentlabs.dao.DAOFactory;
import com.eminentlabs.dao.HibernateFactory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

public class TRDisplayController {

    static org.apache.log4j.Logger logger = null;

    static {
        logger = org.apache.log4j.Logger.getLogger(TRDisplayController.class.getName());
    }
    private String message;
    List<TrDetails> trList = new ArrayList<>();
    List<ApmTrFormat> trFormats = new ArrayList<ApmTrFormat>();
    Map<Long, String> trFormatsByProject = new HashMap<Long, String>();
    Map<Long, String> sapProjects = new HashMap<Long, String>();
    String totalTrFormats = "";
    String totalTrFormat = "";
    ApmTrFormatDAO apmTrFormatDAO = new ApmTrFormatDAOImpl();

    public void setAll(HttpServletRequest request) {

        trList = trDisplay();
        trFormats = findAll();
        sapProjects = getProjects();
        if (request.getMethod().equalsIgnoreCase("post")) {

            String projectIds[] = request.getParameterValues("pid");
            String trProjectFormats[] = request.getParameterValues("trProjectFormat");
            HttpSession session = request.getSession();
            int roleId = (Integer) session.getAttribute("Role");
            if (roleId != 1) {
                message = "You are not authorized to access this page";
            }
        }
    }

    public List<TrDetails> trDisplay() {
        Session session = null;
        List<TrDetails> l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("TrDetails.findAll");
            l = (List<TrDetails>) query.list();
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

    public Map<Long, String> getProjects() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        long id = 0l;
        String name = null;
        Map<Long, String> member = new HashMap<Long, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("SELECT P.PID,CONCAT(CONCAT(p.pname,' v'),p.version) as pfullname  FROM PROJECT P where Category='SAP Project' and status ='Work in progress' and pmanager <> 104 order by upper(pname) asc,version asc");
            while (resultset.next()) {
                id = resultset.getLong(1);
                name = resultset.getString(2);
                member.put(id, name);
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
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return member;

    }

    public List<ApmTrFormat> findAll() {
        Session session = null;
        List<ApmTrFormat> l = null;
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmTrFormat.findAll");
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

    public void doAction(HttpServletRequest request) throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        if (action.equalsIgnoreCase("create")) {

            String TrformatpId = request.getParameter("TrformatpId").replaceAll("\\s", "");
            String values[] = request.getParameter("trFormat").split(",");
            for (int i = 0; i < values.length; i++) {

                ApmTrFormat apmTrFormat = new ApmTrFormat();
                apmTrFormat.setPid(Long.valueOf(TrformatpId));
                apmTrFormat.setTrFormat(values[i].split("-")[0].trim());
                apmTrFormat.setTrType(Integer.parseInt(values[i].split("-")[1]));
                apmTrFormatDAO.addTrFormat(apmTrFormat);

            }

        } else if (action.equalsIgnoreCase("delete")) {
            ApmTrFormat apmTrFormat = new ApmTrFormat();
            String id = request.getParameter("TrformatpId");
            apmTrFormat.setId(Long.valueOf(id));
            apmTrFormatDAO.delete(apmTrFormat);

        } else if (action.equalsIgnoreCase("retrieve")) {
            String TrformatpId = request.getParameter("TrformatpId").replaceAll("\\s", "");
            trFormats = apmTrFormatDAO.findAllTrFormatsByPid((Long.valueOf(TrformatpId)));
            for (ApmTrFormat apmTrFormat : trFormats) {
                totalTrFormats = totalTrFormats + apmTrFormat.getTrFormat() + "-" + apmTrFormat.getTrType() + ",";
            }
        } else if (action.equalsIgnoreCase("retrieveone")) {
            String TrformatpId = request.getParameter("TrformatpId").replaceAll("\\s", "");

            trFormats = apmTrFormatDAO.findAllTrFormatsByPid((Long.valueOf(TrformatpId)));
            int i = 0;
            for (ApmTrFormat format : trFormats) {
                totalTrFormat = totalTrFormat + format.getTrFormat() + "-" + format.getTrType() + ",";

                long id = format.getId();
                long pid = format.getPid();
                String formats = format.getTrFormat();
                i++;
                if (i % 2 == 0) {
                    totalTrFormat = totalTrFormat + "<tr style=\"height:21px;\" bgcolor=\"#E8EEF7\" id='apmTrformatId1" + id + "'><td  id='apmTrformatId" + id + "'><img  src=\'/eTracker/images/edit.png' onclick=\"editcrid('" + id + "','" + pid + "');\" style=\"cursor: pointer;\" ></img>" + id + "</td><td id='trFormats" + id + "' >" + formats + "</td><td id='trTypes" + id + "' >" + getTrTypes().get(format.getTrType()) + "</td><td><img onclick=javascript:DeleteTrFormat('" + id + "','" + pid + "'); src=\"/eTracker/images/remove.gif\"/></td> </tr>";

                } else {
                    totalTrFormat = totalTrFormat + "<tr style=\"height:21px;\" id='apmTrformatId1" + id + "'><td  id='apmTrformatId" + id + "'><img  src=\'/eTracker/images/edit.png' onclick=\"editcrid('" + id + "','" + pid + "');\" style=\"cursor: pointer;\" ></img>" + id + "</td><td id='trFormats" + id + "' >" + formats + "</td><td id='trTypes" + id + "' >" + getTrTypes().get(format.getTrType()) + "</td><td> <img onclick=javascript:DeleteTrFormat('" + id + "','" + pid + "'); src=\"/eTracker/images/remove.gif\"/></td></td> </tr>";
                }
            }
        } //      else if (action.equalsIgnoreCase("retrieveAll")) {
        //            String pid = request.getParameter("pid");
        //              String values[] = request.getParameterValues("totalcrIds");
        //              trFormats = apmTrFormatDAO.findAllTrFormatsByPid(Long.valueOf(pid));
        //            for (ApmTrFormat format : trFormats) {
        //                totalTrFormat = totalTrFormat + format.getTrFormat() + ",";
        //
        //            }
        //           
        //            if (totalTrFormat.length() > 2) {
        //                totalTrFormat = totalTrFormat.substring(0, totalTrFormat.length() - 1);
        //            }
        //       }
        else if (action.equalsIgnoreCase("Update")) {
            String id = request.getParameter("TrformatpId");
            String pid = request.getParameter("pid");
            String TrFormatvalue = request.getParameter("edittrFormat");
            ApmTrFormat apmTrFormat = new ApmTrFormat();
            apmTrFormat.setId(Long.valueOf(id));
            apmTrFormat.setTrFormat(TrFormatvalue);
            apmTrFormat.setTrFormat(TrFormatvalue.split("-")[0].trim());
            apmTrFormat.setTrType(Integer.parseInt(TrFormatvalue.split("-")[1]));
            apmTrFormat.setPid(Long.valueOf(pid));
            apmTrFormatDAO.update(apmTrFormat);

        }
    }

    public String findByPid(long pid) {

        Session session = null;
        String listvalues = "";
        try {

            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("ApmTrFormat.findByPid");
            query.setLong("pid", pid);
            trFormats = query.list();
            for (ApmTrFormat apmTrFormats : trFormats) {
                String val = apmTrFormats.getTrFormat() + "-" + getTrTypes().get(apmTrFormats.getTrType());
                if (listvalues.length() == 0) {
                    listvalues = val;
                } else {
                    listvalues = listvalues + "," + val;
                }
            }

        } catch (HibernateException e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (HibernateException e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return listvalues;
    }

    public Map<Integer, String> getTrTypes() {
        Map<Integer, String> trTypes = new HashMap<>();
        trTypes.put(0, "Numeric");
        trTypes.put(1, "Alphanumeric");
        return trTypes;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<TrDetails> getTrList() {
        return trList;
    }

    public void setTrList(List<TrDetails> trList) {
        this.trList = trList;
    }

    public List<ApmTrFormat> getTrFormats() {
        return trFormats;
    }

    public void setTrFormats(List<ApmTrFormat> trFormats) {
        this.trFormats = trFormats;
    }

    public Map<Long, String> getSapProjects() {
        return sapProjects;
    }

    public void setSapProjects(Map<Long, String> sapProjects) {
        this.sapProjects = sapProjects;
    }

    public String getTotalTrFormats() {
        return totalTrFormats;
    }

    public String getTotalTrFormat() {
        return totalTrFormat;
    }

    public void setTotalTrFormat(String totalTrFormat) {
        this.totalTrFormat = totalTrFormat;
    }

    public void setTotalTrFormats(String totalTrFormats) {
        this.totalTrFormats = totalTrFormats;
    }

}
