/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

import com.eminent.issue.Modules;
import com.eminentlabs.dao.HibernateFactory;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author EMINENT
 */
public class ModuleUtil {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ModuleUtil");
    }
   

    public List<Modules> findModulesByPid(BigDecimal pid) {
        Session session = null;
        List<Modules> l = new ArrayList<Modules>();
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery("select Moduleid,module from Modules  where PID= '"+pid+"'");
            Iterator iterator = query.list().iterator();
            
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                Modules module = new Modules();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        module.setModuleid((BigDecimal)row[col]);
                    } else if (col == 1) {
                        module.setModule((String)row[col]);
                    }
                }
                l.add(module);
            }
            logger.info("No of Tasks" + l.size() + "for pid :" + pid);
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
}
