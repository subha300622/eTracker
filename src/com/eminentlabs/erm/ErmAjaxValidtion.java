/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminentlabs.dao.HibernateFactory;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

/**
 *
 * @author admin
 */
public class ErmAjaxValidtion {
   static Logger logger = null;

    static {
        logger = Logger.getLogger("ErmAjaxValidtion");
    }
    public static String alreadyexitsErmEmail(HttpServletRequest request) {
      
        String email = request.getParameter("email");
        if(email==null||email.isEmpty()){
            email="";
        }
        Session session = null;
       
        String alEmail = "true";
        try {
            session = HibernateFactory.getCurrentSession();
            String sql = "select EMAIL from ERM_APPLICANT  where EMAIL='"+ email+"'";
            System.out.println(sql);
            SQLQuery query = session.createSQLQuery(sql);
            alEmail=(String)query.uniqueResult();
                    
            if (alEmail == null || alEmail.isEmpty()) {
                alEmail="flase";
            } else {
                alEmail ="true";
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
        return alEmail;
    }
}
