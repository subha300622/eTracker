/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.wrm;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class WRMMailMaintainDAO {
    
    
    public static List<User> getWRMMailUserByPid(long pid){
        List<User> users =new ArrayList<>();
       Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        try{
              connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String sql = "select w.WRM_MAIL_ID,users.userid,firstname,lastname,team,email from WRM_MAIL_MAINTENANCE w,users  where  users.userid=w.userid and pid="+pid+" ";
            rs = statement.executeQuery(sql);
             while (rs.next()) {
                 User u = new User();
                u.setId(rs.getLong(1));
                u.setUserId(rs.getLong(2));
                u.setFirstName(rs.getString(3));
                u.setLastName(rs.getString(4));
                u.setTeam(rs.getString(5));
                u.setEmailId(rs.getString(6));
                users.add(u);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                
            }
        }
        return users;
    }
    
    public static List<User> getUsersByPid(long pid){
        List<User> users =new ArrayList<>();
       Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;
        try{
              connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String sql = "select users.userid,firstname,lastname,team,email from userproject up,users  where  users.userid=up.userid and roleid>0 and pid="+pid+" and up.userid not in (select userid from WRM_MAIL_MAINTENANCE where pid="+pid+") ";
            rs = statement.executeQuery(sql);
             while (rs.next()) {
                 User u = new User();
                u.setId(rs.getLong(1));
                u.setFirstName(rs.getString(2));
                u.setLastName(rs.getString(3));
                u.setTeam(rs.getString(4));
                u.setEmailId(rs.getString(5));
                users.add(u);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                
            }
        }
        return users;
    }
    public static String  deleteWrmMailId(long id){
        String res="success";
         Connection connection = null;
        Statement statement = null;
        try{
              connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String sql = "delete from WRM_MAIL_MAINTENANCE where WRM_MAIL_ID="+id+"";
            System.out.println("sql : "+sql);
         statement.executeUpdate(sql);
            
        }catch(Exception e){
            res="ERROR in deleteWrmMailId DAO";
            e.printStackTrace();
        }finally {
            try {
                
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                
            }
        }
        return res;
    }
    
}
