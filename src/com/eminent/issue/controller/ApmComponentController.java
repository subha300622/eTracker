/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.hibernate.HibernateUtil;
import com.eminent.issue.ApmComponent;
import com.eminent.issue.ApmComponentIssues;
import com.eminent.issue.ApmTeam;
import com.eminent.issue.dao.ApmComponentDAO;
import com.eminent.issue.dao.ApmComponentDAOImpl;
import com.eminentlabs.dao.HibernateFactory;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;

public class ApmComponentController extends HttpServlet {

    static Logger logger = null;
    
    public void setAll(HttpServletRequest request) {
        componentList = getComponentList();
    }
    static {
        logger = Logger.getLogger("ApmComponentController");
    }
    String totalComponent = "";
    String totalComponents = "";
    boolean isDeleteDone=false;
    List<ApmComponent> componentList = new ArrayList<ApmComponent>();
    ApmComponentDAO componentDAO = new ApmComponentDAOImpl();
    ApmComponentIssueController aic=new ApmComponentIssueController();

    public void doAction(HttpServletRequest request) throws ServletException, IOException {

        String action = request.getParameter("action");
              if (action == null) {
            action = "";
        }
        if (action.equalsIgnoreCase("create")) {
            String componentTeamId = request.getParameter("componentTeamId");
            String values[] = request.getParameter("component").split(",");
            for (int i = 0; i < values.length; i++) {
                ApmComponent apmComponent = new ApmComponent();
                apmComponent.setTeamId(new ApmTeam(Long.valueOf(componentTeamId)));
                apmComponent.setComponentName(values[i]);
                componentDAO.addComponent(apmComponent);

            }
        } else if (action.equalsIgnoreCase("update")) {
            ApmComponent apmComponent = new ApmComponent();
            String compId = request.getParameter("componentId");
            String teamId = request.getParameter("componentTeamId");
            String compName = request.getParameter("editcomponent");
            apmComponent.setComponentName(compName);
            apmComponent.setComponentId(BigDecimal.valueOf(Long.valueOf(compId)));
             apmComponent.setTeamId(new ApmTeam(Long.valueOf(teamId)));
            componentDAO.update(apmComponent);
        } else if (action.equalsIgnoreCase("delete")) {
              ApmComponent apmComponent = new ApmComponent();
            String compId = request.getParameter("componentId");
            List<ApmComponentIssues> findByComponentId = aic.findByComponentId(BigDecimal.valueOf(Long.valueOf(compId)));
            if(findByComponentId.isEmpty()){
            apmComponent.setComponentId(BigDecimal.valueOf(Long.valueOf(compId)));
            componentDAO.delete(apmComponent);
             isDeleteDone=true;
            }else{
              isDeleteDone=false;
            }

        } else if (action.equalsIgnoreCase("retrieve")) {
            String teamId = request.getParameter("componentTeamId");
            componentList = componentDAO.findAllComponents(BigDecimal.valueOf(Long.valueOf(teamId)));
            int i=0;
           for (ApmComponent component : componentList) {
            totalComponent = totalComponent + component.getComponentName() + ",";
            BigDecimal id = component.getComponentId();
            String components = component.getComponentName();
              i++;
            if(i%2 ==0){
            totalComponent = totalComponent + "<tr style=\"height:21px;\" bgcolor=\"#E8EEF7\" id='apmcomponentId" + id + "'><td>" + id + "</td><td id='componentName" + id + "'>" + components + "</td><td><input type='hidden' name='componentValue" + id + "' id='componentValue" + id + "' value='" + components + "'> <span onclick=\"editComponent('" + id + "');\" style=\"color: blue;cursor: pointer; \">Edit</span> || <span onclick=\"deleteComponent('" + id + "');\" style=\"color: blue;cursor: pointer;\">Delete</span> </tr>";
            }else{
               totalComponent = totalComponent + "<tr style=\"height:21px;\" id='apmcomponentId" + id + "'><td>" + id + "</td><td id='componentName" + id + "'>" + components + "</td><td><input type='hidden' name='componentValue" + id + "' id='componentValue" + id + "' value='" + components + "'> <span onclick=\"editComponent('" + id + "');\" style=\"color: blue;cursor: pointer; \">Edit</span> || <span onclick=\"deleteComponent('" + id + "');\" style=\"color: blue;cursor: pointer;\">Delete</span> </tr>";  
            }
        }  
        }else if (action.equalsIgnoreCase("retrieveAll")) {
                    componentList=componentDAO.findAllComponentNames();
                  for (ApmComponent component : componentList) {
                totalComponents = totalComponents + component.getComponentName() + ",";
           }
        }
    }

    public boolean isIsDeleteDone() {
        return isDeleteDone;
    }
    
    public static HashMap getComponents() throws HibernateException {
        Session session = HibernateUtil.getSessionFactory().openSession();
        HashMap<BigDecimal, String> component = new HashMap();

        try {
            List<ApmComponent> componentset = session.createQuery("from ApmComponent").list();

            for (ApmComponent o : componentset) {

                BigDecimal compId = o.getComponentId();
                String name = o.getComponentName();
                component.put(compId, name);

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
        return component;
    }

    public ApmComponent findByComponentId(long componentId) {
        Session session = null;
        ApmComponent apmComponent = new ApmComponent();
        try {

            session = HibernateFactory.getCurrentSession();
            apmComponent = (ApmComponent) session.get(ApmComponent.class, componentId);

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
        return apmComponent;
    }

    public String getTotalComponent() {
        return totalComponent;
    }

    public void setTotalComponent(String totalComponent) {
        this.totalComponent = totalComponent;
    }
    
     public String getTotalComponents() {
        return totalComponents;
    }

    public void setTotalComponents(String totalComponents) {
        this.totalComponents = totalComponents;
    }
    public List<ApmComponent> getComponentList() {
        return componentList;
     }

    public void setComponentList(List<ApmComponent> componentList) {
        this.componentList = componentList;
    }

}
