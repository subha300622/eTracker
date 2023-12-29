/*
 * SessionCounter.java
 *
 * Created on March 20, 2007, 8:49 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.pack;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.apache.log4j.Logger;
import java.util.HashMap;
import com.eminent.util.UserUtils;
/**
 *
 * @author Balaguru Ramasamy
 */
public class SessionCounter implements HttpSessionListener {

    
    static Logger logger  =   Logger.getLogger("Session Counter");
    /** Creates a new instance of SessionCounter */
    public SessionCounter() {
    }
    
    
    private static int sessionCount  = 0;
    private static HashMap<String,String> users  =   new HashMap();
    
    public void sessionCreated(HttpSessionEvent event){
   
        sessionCount++;
        logger.info("New Session created"+event.getSession().getId());
        
    }

    public void sessionDestroyed(HttpSessionEvent e){
        
        
        if(sessionCount > 0){
            
        
            sessionCount--;
            logger.info("Session Destroyed"+e.getSession().getId());
            String sessionId    =e.getSession().getId();
            if(sessionId!=null){            
                String userId = users.get(sessionId);
                if(userId!=null){
                    UserUtils.updateLogin(Integer.parseInt(userId));
                }
            }
            if(users.containsKey(sessionId)){
                users.remove(sessionId);
               
            }
             UserUtils.updateLogout(sessionId);
        }
        
}
      
    public static int getActiveUsers(){
        
        return users.size();
        
    }
    public static void setActiveUsers(String sessionId,String userName){

        users.put(sessionId,userName);

    }
    public static HashMap getActiveUsersList(){

        return users;

    }
    
    
}
