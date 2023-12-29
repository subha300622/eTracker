/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack;

import com.eminent.util.UserUtils;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


public class MyServlerContextListener implements ServletContextListener {

    public MyServlerContextListener() {
    }
    Map<String, String> sessionUsers = new HashMap();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        ServletContext sc = sce.getServletContext();
        if(sc.getAttribute("sessionIdsSet")!=null){
        sessionUsers =SessionCounter.getActiveUsersList() ;

        
        if (!sessionUsers.isEmpty()) {
            for (Map.Entry<String, String> entry : sessionUsers.entrySet()) {
                UserUtils.abNormalLogOut(entry.getValue());

            }
        }
    }
    }
}
