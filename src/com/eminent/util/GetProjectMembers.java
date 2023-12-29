package com.eminent.util;

import com.eminent.timesheet.Users;
import com.eminentlabs.mom.MoMUtil;
import java.sql.Connection;
//import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;
import java.util.ArrayList;
import org.apache.log4j.*;
import pack.eminent.encryption.MakeConnection;

public class GetProjectMembers {
    
    static Logger logger = Logger.getLogger("Get Project Members");
    
    public static HashMap<String, String> getMembers(String projectName, String version, String orginator, String assignee) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        ArrayList<String> al = new ArrayList();
        ArrayList<String> userid = new ArrayList();
        ArrayList<String> username = new ArrayList();
        HashMap<String, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select up.userid,firstname||' '||lastname as name from userproject up, project p,users u  where up.pid=p.pid and pname='" + projectName + "'and version='" + version + "' and u.userid=up.userid and u.roleid>0 order by UPPER(NAME) ASC");
            
            GetName user = new GetName();
            
            while (resultset.next()) {
                id = resultset.getString(1);
                userid.add(id);
                
                name = resultset.getString(2);
                username.add(name);
                member.put(id, name);
                //                                  logger.info("Project Users id--"+id+"Name-"+name);
            }
            
            if (GetProjectMembers.isUserActive(orginator)) {
                if (member.get(orginator) == null) {
                    id = orginator;
                    name = user.getUserName(id);
                    member.put(id, name);
                }
            }
            if (GetProjectMembers.isUserActive(assignee)) {
                if (member.get(assignee) == null) {
                    
                    id = assignee;
                    name = user.getUserName(id);
                    member.put(id, name);
                }
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
        
        al.addAll(userid);
        al.addAll(username);
        
        return member;
        
    }
    
    public static HashMap<String, String> getTeamMembers(String projectId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        HashMap<String, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select up.userid,firstname||' '||lastname from userproject up, project p,users u  where up.pid=p.pid and p.pid='" + projectId + "' and u.userid=up.userid and u.roleid>0");
            
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2);
                member.put(id, name);
                //                                  logger.info("Project Users id--"+id+"Name-"+name);
            }
            
        } catch (Exception e) {
            logger.info("getTeamMembers" + e.getMessage());
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
    
    public static HashMap<String, String> getMembersWithTeam(String projectId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        HashMap<String, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select up.userid,firstname, team from userproject up, project p,users u  where up.pid=p.pid and p.pid='" + projectId + "' and u.userid=up.userid and u.roleid>0");
            
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2) + "(" + resultset.getString(3) + ")";
                member.put(id, name);
                //                                  logger.info("Project Users id--"+id+"Name-"+name);
            }
            
        } catch (Exception e) {
            logger.info("getTeamMembers" + e.getMessage());
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
    
    public static HashMap<String, String> getTestMembers(String pId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        ArrayList<String> al = new ArrayList();
        ArrayList<String> userid = new ArrayList();
        ArrayList<String> username = new ArrayList();
        HashMap<String, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");
            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select up.userid,firstname||' '||lastname as name from userproject up, project p,users u  where up.pid=p.pid and p.pid='" + pId + "' and u.userid=up.userid and u.roleid>0 order by UPPER(NAME) ASC");
            
            GetName user = new GetName();
            
            while (resultset.next()) {
                id = resultset.getString(1);
                userid.add(id);
                
                name = resultset.getString(2);
                username.add(name);
                member.put(id, name);
                //                                  logger.info("Project Users id--"+id+"Name-"+name);
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
        
        al.addAll(userid);
        al.addAll(username);
        
        return member;
        
    }
    
    public static String getMembers(String pid) {
        String members = "";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select up.userid as userid,firstname||' '||lastname as name from userproject up, project p,users u  where up.pid='" + pid + "' and up.pid=p.pid and u.userid=up.userid and u.roleid>0 order by UPPER(NAME) ASC");
            while (resultset.next()) {
                members = members + resultset.getString("userid") + "-" + resultset.getString("name") + ",";
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
        
        return members;
    }
    
    public static HashMap<String, String> getBDMembers(String projectName, String version) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        ArrayList<String> al = new ArrayList();
        ArrayList<String> userid = new ArrayList();
        ArrayList<String> username = new ArrayList();
        HashMap<String, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userproject.userid from userproject,project where userproject.pid=project.pid and project.pname='" + projectName + "'and version='" + version + "'");
            
            GetName user = new GetName();
            
            while (resultset.next()) {
                id = resultset.getString(1);
                userid.add(id);
                
                name = user.getUserName(id);
                username.add(name);
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
        
        al.addAll(userid);
        al.addAll(username);
        
        return member;
        
    }
    
    public static boolean isBDMembers(int userId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        boolean flag = false;
        ResourceBundle rb = ResourceBundle.getBundle("Resources");
        String crmProject = rb.getString("crm_project");
        String crmVersion = rb.getString("crm_version");
        
        try {
            connection = MakeConnection.getConnection();
            
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userproject.userid from userproject,project where userproject.pid=project.pid and project.pname='" + crmProject + "' and project.VERSION='" + crmVersion + "' and userid=" + userId);
            
            while (resultset.next()) {
                
                flag = true;
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
        
        return flag;
        
    }
    
    public static LinkedHashMap<Integer, String> getAllMembers() {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id = 0;
        String name = null;
        
        LinkedHashMap<Integer, String> member = new LinkedHashMap();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userid,firstname||' '||lastname as name from users where roleid>0 order by UPPER(NAME) ASC");
            
            while (resultset.next()) {
                id = resultset.getInt(1);
                
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
    
    public static HashMap<Integer, String> getProjectManagers(String pId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        HashMap<Integer, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pmanager,dmanager,amanager,sponsorer,stakeholder,coordinator from project where pid='" + pId + "'");
            GetName user = new GetName();
            
            while (resultset.next()) {
                
                int pmanager = resultset.getInt(1);
                int dmanager = resultset.getInt(2);
                int amanager = resultset.getInt(3);
                int sponsorer = resultset.getInt(4);
                int stakeholder = resultset.getInt(5);
                int coordinator = resultset.getInt(6);
                
                member.put(pmanager, user.getUserName(((Integer) pmanager).toString()));
                
                if (!member.containsKey(dmanager) && dmanager != 0) {
                    member.put(dmanager, user.getUserName(((Integer) dmanager).toString()));
                }
                if (!member.containsKey(amanager) && amanager != 0) {
                    member.put(amanager, user.getUserName(((Integer) amanager).toString()));
                }
                if (!member.containsKey(sponsorer) && dmanager != 0) {
                    member.put(sponsorer, user.getUserName(((Integer) sponsorer).toString()));
                }
                if (!member.containsKey(stakeholder) && amanager != 0) {
                    member.put(stakeholder, user.getUserName(((Integer) stakeholder).toString()));
                }
                if (!member.containsKey(coordinator) && coordinator != 0) {
                    member.put(coordinator, user.getUserName(((Integer) coordinator).toString()));
                }
                
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
    
    public static HashMap<Integer, String> getPMAndDM(String pId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        HashMap<Integer, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select pmanager,dmanager,amanager  from project where pid='" + pId + "'");
            GetName user = new GetName();
            int admin = getAdminID();
            while (resultset.next()) {
                
                int pmanager = resultset.getInt(1);
                int dmanager = resultset.getInt(2);
                String mail = GetName.getEmail(String.valueOf(pmanager));
                String dmmail = GetName.getEmail(String.valueOf(dmanager));
                String url = mail.substring(mail.indexOf("@") + 1, mail.length());
                String dmurl = dmmail.substring(dmmail.indexOf("@") + 1, dmmail.length());
                if (url.equals("eminentlabs.net")) {
                    member.put(pmanager, user.getUserName(((Integer) pmanager).toString()));
                }
                
                if (!member.containsKey(dmanager) && dmanager != 0) {
                    if (dmurl.equals("eminentlabs.net")) {
                        member.put(dmanager, user.getUserName(((Integer) dmanager).toString()));
                    }
                }
                if (!member.containsKey(admin) && admin != 0) {
                    
                    member.put(admin, user.getUserName(((Integer) admin).toString()));
                    
                }
                
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
    
    public static String getProjectManager(Long pId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        String email = null;
        
        try {
            connection = MakeConnection.getConnection();
            //		Class.forName("oracle.jdbc.driver.OracleDriver");

            //		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select email from project ,users  where pmanager=userid and pid=" + pId + " and email like '%eminentlabs.net' and userid!=112 and userid!=104");
            while (resultset.next()) {
                
                email = resultset.getString(1);
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
        
        return email;
        
    }
    
    public static HashMap<Integer, String> showUsers() {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id = 0;
        String name = null;
        
        HashMap<Integer, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            //removed eminent and active users filter
            resultset = statement.executeQuery("select userid,firstname||' '||lastname as name from users ");
            while (resultset.next()) {
                id = resultset.getInt(1);
                
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
    
    public static List<Users> showUsersList() {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        List<Users> userList = new ArrayList();
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userid,firstname,email,team from users");
            
            while (resultset.next()) {
                Users user = new Users();
                user.setUserid(resultset.getInt(1));
                user.setFirstname(resultset.getString(2));
                user.setEmail(resultset.getString(3));
                user.setTeam(resultset.getString(4));
                userList.add(user);
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
        
        return userList;
        
    }
    
    public static HashMap<Integer, String> showUsersSName() {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id = 0;
        String name = null;
        
        HashMap<Integer, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userid,firstname||' '||SubStr(lastname,0,1) as name from users");
            
            while (resultset.next()) {
                id = resultset.getInt(1);
                
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
    
    public static String getUserName(String UserId) {
        String name = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            
            resultset = statement.executeQuery("select firstname||' '||lastname as name from users where userid='" + UserId + "'");
            while (resultset.next()) {
                name = resultset.getString("name");
                
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
        
        return name;
    }

    /*edit by mukesh*/
    public static String[] getDisableUserDetail(String UserId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String disableusr[] = new String[4];
        try {
            
            int userid = Integer.parseInt(UserId);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            
            resultset = statement.executeQuery("select firstname as name,lastname,Email,Company from users where userid='" + userid + "'");
            
            while (resultset.next()) {
                disableusr[0] = resultset.getString("name");
                disableusr[1] = resultset.getString("lastname");
                disableusr[2] = resultset.getString("Email");
                disableusr[3] = resultset.getString("Company");
                
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
        
        return disableusr;
    }

    /*edit by mukesh*/
    public static String getUserNameByEid(String EmpId) {
        String name = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            
            resultset = statement.executeQuery("select firstname||' '||lastname as name from users where EMP_ID='" + EmpId + "'");
            while (resultset.next()) {
                name = resultset.getString("name");
                
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
        
        return name;
    }
    
    public static String getMail(String UserId) {
        String email = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select email from users where userid=" + UserId);
            while (resultset.next()) {
                email = resultset.getString(1);
                
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
        
        return email;
    }
    
    public static HashMap<String, String> getAdminDetail() {
        String userid = null;
        String email = null;
        String mobile = null;
        String operator = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<String, String> admin = new HashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userid,email,mobile,mobileoperator from users where roleid=1");
            while (resultset.next()) {
                userid = resultset.getString(1);
                email = resultset.getString(2);
                mobile = resultset.getString(3);
                operator = resultset.getString(4);
                
            }
            admin.put("userid", userid);
            admin.put("email", email);
            admin.put("mobile", mobile);
            admin.put("operator", operator);
            
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
        
        return admin;
    }
    
    public static int getAdminID() {
        int userid = 104;
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userid,email,mobile,mobileoperator from users where roleid=1 order by userid");
            while (resultset.next()) {
                userid = resultset.getInt(1);
                
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
        
        return userid;
    }
    
    public static HashMap<String, String> getUserDetail(int userid) {
        String name = null;
        String email = null;
        String mobile = null;
        String operator = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<String, String> user = new HashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select firstname,lastname,email,mobile,mobileoperator from users where userid=" + userid);
            while (resultset.next()) {
                name = resultset.getString("firstname") + " " + resultset.getString("lastname");
                email = resultset.getString("email");
                mobile = resultset.getString("mobile");
                operator = resultset.getString("mobileoperator");
                
            }
            user.put("username", name);
            user.put("email", email);
            user.put("mobile", mobile);
            user.put("operator", operator);
            
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
        
        return user;
    }
    
    public static boolean isUserActive(String userid) {
        boolean flag = false;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int roleid;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select roleid from users where userid='" + userid + "'");
            while (resultset.next()) {
                
                roleid = resultset.getInt(1);
                if (roleid > 0) {
                    flag = true;
                }
                
            }
            
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        
        return flag;
    }
// Sorting the HashMap for User Name sorting

    public static LinkedHashMap sortHashMapByValues(HashMap passedMap, boolean ascending) {
        
        List mapKeys = new ArrayList(passedMap.keySet());
        List mapValues = new ArrayList(passedMap.values());
        Collections.sort(mapValues, String.CASE_INSENSITIVE_ORDER);
        Collections.sort(mapKeys);
        
        if (!ascending) {
            Collections.reverse(mapValues);
        }
        
        LinkedHashMap someMap = new LinkedHashMap();
        Iterator valueIt = mapValues.iterator();
        while (valueIt.hasNext()) {
            Object val = valueIt.next();
            Iterator keyIt = mapKeys.iterator();
            while (keyIt.hasNext()) {
                Object key = keyIt.next();
                if (passedMap.get(key).toString().equalsIgnoreCase(val.toString())) {
                    passedMap.remove(key);
                    mapKeys.remove(key);
                    someMap.put(key, val);
                    break;
                }
            }
        }
        return someMap;
    }
    
    public static LinkedHashMap sortHashMapByNonStringValues(HashMap passedMap, boolean ascending) {
        
        List mapKeys = new ArrayList(passedMap.keySet());
        List mapValues = new ArrayList(passedMap.values());
        Collections.sort(mapValues);
        Collections.sort(mapKeys);
        
        if (!ascending) {
            Collections.reverse(mapValues);
        }
        
        LinkedHashMap someMap = new LinkedHashMap();
        Iterator valueIt = mapValues.iterator();
        while (valueIt.hasNext()) {
            Object val = valueIt.next();
            Iterator keyIt = mapKeys.iterator();
            while (keyIt.hasNext()) {
                Object key = keyIt.next();
                if (passedMap.get(key).toString().equalsIgnoreCase(val.toString())) {
                    passedMap.remove(key);
                    mapKeys.remove(key);
                    someMap.put(key, val);
                    break;
                }
            }
        }
        return someMap;
    }
    
    public static LinkedHashMap sortHashMapByKeys(HashMap passedMap, boolean ascending) {
        
        List mapKeys = new ArrayList(passedMap.keySet());
        List mapValues = new ArrayList(passedMap.values());
        
        Collections.sort(mapKeys);
        logger.info(mapKeys);
        if (!ascending) {
            Collections.reverse(mapKeys);
        }
        
        LinkedHashMap someMap = new LinkedHashMap();
        Iterator keyIt = mapKeys.iterator();
        while (keyIt.hasNext()) {
            Object key = keyIt.next();
            someMap.put(key, passedMap.get(key).toString());
            
        }
        return someMap;
    }
    
    public static String getEminentMembers() {
        String members = "";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userid,firstname||' '||lastname as name from users  where email like '%@eminentlabs.net' and roleid>0 order by UPPER(NAME) ASC");
            while (resultset.next()) {
                members = members + resultset.getString("userid") + "-" + resultset.getString("name") + ",";
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        
        return members;
    }
    
    public static Map getAllEminentMembers() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Integer, String> member = new LinkedHashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userid,firstname||' '||lastname as name from users  where email like '%@eminentlabs.net' order by UPPER(NAME) ASC");
            while (resultset.next()) {
                int id = resultset.getInt(1);
                String name = resultset.getString(2);
                member.put(id, name);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        
        return member;
    }
    
    public static int getID() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int slNo = 0;
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select EMAILALERT_SEQ.nextval as nextvalue from dual");
            resultset.next();
            slNo = resultset.getInt("nextvalue");
            
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return slNo;
    }
    
    public static ArrayList getMailAlerts(int pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        ArrayList<Integer> al = new ArrayList();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select manager from apm_projectalerts where project='" + pid + "'");
            while (resultset.next()) {
                al.add(resultset.getInt(1));
            }
            
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return al;
    }
    
    public static boolean isAssigned(String userid, String pid) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        boolean isAssigned = false;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            logger.info("select * from userproject where userid='" + userid + "' and pid='" + pid + "'");
            resultset = statement.executeQuery("select * from userproject where userid='" + userid + "' and pid='" + pid + "'");
            while (resultset.next()) {
                isAssigned = true;
            }
            
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return isAssigned;
    }
    
    public static void EmailAlerts(ArrayList managers, int projectid) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultset = null;
        String alert = "Yes";
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.prepareStatement("insert into apm_projectalerts(slno,project,manager,alert) values(?,?,?,?)");
            for (int i = 0; i < managers.size(); i++) {
                statement.setInt(1, getID());
                statement.setInt(2, projectid);
                statement.setInt(3, (Integer) managers.get(i));
                statement.setString(4, alert);
                statement.addBatch();
            }
            statement.executeBatch();
            
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        
    }
    
    public static void UpdateEmailAlerts(ArrayList<Integer> managers, int projectid) {
        Connection connection = null;
        PreparedStatement addStatement = null, removeStatement = null;
        ResultSet resultset = null;
        String alert = "Yes";
        ArrayList<Integer> addAlerts = new ArrayList();
        try {
            ArrayList<Integer> existingAlerts = getMailAlerts(projectid);
            
            for (int s : managers) {
                if (existingAlerts.contains(s)) {
                    existingAlerts.remove(((Integer) s));
                    
                } else {
                    addAlerts.add(s);
                }
            }
            
            connection = MakeConnection.getConnection();
            addStatement = connection.prepareStatement("insert into apm_projectalerts(slno,project,manager,alert) values(?,?,?,?)");
            for (int i = 0; i < addAlerts.size(); i++) {
                addStatement.setInt(1, getID());
                addStatement.setInt(2, projectid);
                addStatement.setInt(3, (Integer) addAlerts.get(i));
                addStatement.setString(4, alert);
                addStatement.addBatch();
            }
            addStatement.executeBatch();
            
            removeStatement = connection.prepareStatement("delete from apm_projectalerts where project=? and manager=?");
            for (int i = 0; i < existingAlerts.size(); i++) {
                
                removeStatement.setInt(1, projectid);
                removeStatement.setInt(2, (Integer) existingAlerts.get(i));
                
                removeStatement.addBatch();
            }
            removeStatement.executeBatch();
            
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (addStatement != null) {
                    addStatement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (removeStatement != null) {
                    removeStatement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        
    }
    
    public static HashMap getCustomeUsers(int pid) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<Integer, String> member = new HashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select Distinct(u.userId),firstname||' '||lastname as name from userproject up,users u where up.pid ='" + pid + "' and u.userid=up.userid and u.email not like '%eminentlabs.net'");
            while (resultset.next()) {
                int id = resultset.getInt(1);
                String name = resultset.getString(2);
                member.put(id, name);
            }
            
        } catch (Exception e) {
            logger.info("getPIdsByCustomer" + e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            
            if (connection != null) {
                connection.close();
            }
        }
        
        return member;
    }
    
    public static Map<String, String> getAgreedIssues(int pid) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<String, String> issues = new HashMap<>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select issue_id,ISSUE_TYPE from agreed_issues where project_id=" + pid + " and status=0");
            while (resultset.next()) {
                if (issues.containsKey(resultset.getString(1))) {
                    issues.put(resultset.getString(1), issues.get(resultset.getString(1)) + "&&" + resultset.getString(2));
                    
                } else {
                    issues.put(resultset.getString(1), resultset.getString(2));
                }
            }
            
        } catch (Exception e) {
            logger.info("getAgreedIssues" + e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            
            if (connection != null) {
                connection.close();
            }
        }
        
        return issues;
    }
    
    public static int getAgreedIssuesByType(int pid, String type) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int issues = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select count(issue_id) from agreed_issues where project_id=" + pid + " and  ISSUE_TYPE='" + type + "' and status=0");
            while (resultset.next()) {
                issues = resultset.getInt(1);
            }
            
        } catch (Exception e) {
            logger.info("getAgreedIssues" + e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            
            if (connection != null) {
                connection.close();
            }
        }
        
        return issues;
    }
        public static int updateIssueCategory(int pid, String type,String newType) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int issues = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            issues= statement.executeUpdate("update  agreed_issues set  ISSUE_TYPE='" + newType + "' where project_id=" + pid + " and  ISSUE_TYPE='" + type + "'");
           
            
        } catch (Exception e) {
            logger.info("getAgreedIssues" + e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            
            if (connection != null) {
                connection.close();
            }
        }
        
        return issues;
    }

    
    public static LinkedHashMap getEminentUsers() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        LinkedHashMap<Integer, String> member = new LinkedHashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userid,firstname||' '||lastname as name from users  where email like '%@eminentlabs.net' and roleid>0 order by Upper(firstname) ASC");
            while (resultset.next()) {
                int id = resultset.getInt(1);
                String name = resultset.getString(2);
                member.put(id, name);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        
        return member;
    }
    
    public static HashMap getEminentUsersShortName() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<Integer, String> member = new HashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select userid,firstname||' '||substr(lastname,0,1) as name from users  where email like '%@eminentlabs.net' and roleid>0 order by UPPER(NAME) ASC");
            while (resultset.next()) {
                int id = resultset.getInt(1);
                String name = resultset.getString(2);
                member.put(id, name);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        
        return member;
    }
    
    public static Map getEminentUsersOrder() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Integer, String> member = new LinkedHashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select u.userid,firstname||' '||lastname as name from users u  where email like '%@eminentlabs.net' and roleid>0 order by UPPER(NAME) ASC");
            while (resultset.next()) {
                int id = resultset.getInt(1);
                String name = resultset.getString(2);
                member.put(id, name);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        
        return member;
    }
    
    public static HashMap<Integer, String> getTeamMembersByProject(int projectId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int id = 0;
        String name = null;
        HashMap<Integer, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select up.userid,firstname||' '||lastname from userproject up, project p,users u  where up.pid=p.pid and p.pid=" + projectId + " and u.userid=up.userid and u.roleid>0");
            
            while (resultset.next()) {
                id = resultset.getInt(1);
                name = resultset.getString(2);
                member.put(id, name);
                //                                  logger.info("Project Users id--"+id+"Name-"+name);
            }
            
        } catch (Exception e) {
            logger.info("getTeamMembers" + e.getMessage());
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
    
    public static Map<String, List<Integer>> getEminentUsersByTeam(int branch) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<String, List<Integer>> member = new LinkedHashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            if (branch > 0) {
                resultset = statement.executeQuery("select userid,team  from users  where email like '%@eminentlabs.net' and roleid>0 and branch_id=" + branch + " group by team,userid order by UPPER(team) ASC");
            } else {
                resultset = statement.executeQuery("select userid,team  from users  where email like '%@eminentlabs.net' and roleid>0 group by team,userid order by UPPER(team) ASC");
            }
            String pteam = null;
            List<Integer> teamUsers = new ArrayList();
            while (resultset.next()) {
                
                int id = resultset.getInt(1);
                String team = resultset.getString(2);
                if (pteam == null) {
                    pteam = team;
                    teamUsers.add(id);
                } else if (pteam.equalsIgnoreCase(team)) {
                    
                    teamUsers.add(id);
                } else {
                    member.put(pteam, teamUsers);
                    teamUsers = new ArrayList();
                    pteam = team;
                    teamUsers.add(id);
                }
                
            }
            member.put(pteam, teamUsers);
            logger.info(member);
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
                
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        
        return member;
    }
    
    public static HashMap<Integer, Integer> getAllMyAssignIssueCount() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int count = 0;
        int userId = 0;
        HashMap<Integer, Integer> member = new HashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select * from ALLVIEW");
            while (resultset.next()) {
                count = resultset.getInt(1);
                userId = MoMUtil.parseInteger(resultset.getString(2), 0);
                member.put(userId, count);
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
    
    public static boolean checkIssueAssigned(int userId, long pid) {
        boolean flag = true;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int count = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            logger.info("select count(i.issueid) from issue i,issuestatus s where i.issueid=s.issueid and s.status!='Closed' and i.pid=" + pid + " and i.assignedto=" + userId);
            resultset = statement.executeQuery("select count(i.issueid) from issue i,issuestatus s where i.issueid=s.issueid and s.status!='Closed' and i.pid=" + pid + " and i.assignedto=" + userId);
            if (resultset.next()) {
                count = resultset.getInt(1);
            }
            if (count == 0) {
                flag = false;
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
        return flag;
    }
    
    public static int getBranchId(int userId) {
        int branch = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select branch_id from users where userid=" + userId);
            if (resultset.next()) {
                branch = resultset.getInt(1);
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
        return branch;
    }
    
    public static Map<Integer, Set<Integer>> getUsersByBranch() {
        Map<Integer, Set<Integer>> branches = new LinkedHashMap<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select branch_id,userid from users where email like '%@eminentlabs.net' and roleid>0");
            while (resultset.next()) {
                Set<Integer> branch = branches.get(resultset.getInt(1));
                if (branch == null) {
                    branch = new LinkedHashSet<>();
                    branches.put(resultset.getInt(1), branch);
                }
                branch.add(resultset.getInt(2));
                
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
        return branches;
    }
    
    public static HashMap<String, String> getAllTeamMembers(String projectId) {
        
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String id = null;
        String name = null;
        HashMap<String, String> member = new HashMap();
        
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select up.userid,firstname||' '||lastname from userproject up, project p,users u  where up.pid=p.pid and p.pid='" + projectId + "' and u.userid=up.userid");
            
            while (resultset.next()) {
                id = resultset.getString(1);
                name = resultset.getString(2);
                member.put(id, name);
                //                                  logger.info("Project Users id--"+id+"Name-"+name);
            }
            
        } catch (Exception e) {
            logger.info("getTeamMembers" + e.getMessage());
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
    
      public static String getMailForAcvtiveUser(String UserId) {
        String email = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select email from users where roleid > 0 and  userid=" + UserId);
            while (resultset.next()) {
                email = resultset.getString(1);
                
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
        
        return email;
    }
    
}
