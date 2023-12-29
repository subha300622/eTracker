package com.eminent.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Logger;

//import org.apache.log4j.Level;
//import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

public class GetName {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("GetName");
    }
    String name;

    public String getUserName(String UserId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select firstname,lastname from users where userid=" + UserId);
            while (resultset.next()) {
                name = resultset.getString(1) + " " + resultset.getString(2);

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

    public static String getEmail(String UserId) {
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

    public static String getUserFirstName(String UserId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String firstName = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select firstname from users where userid=" + UserId);
            while (resultset.next()) {
                firstName = resultset.getString(1);

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

        return firstName;
    }

    public static String getFirstName(String email) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String firstName = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select firstname from users where email='" + email + "'");
            while (resultset.next()) {
                firstName = resultset.getString(1);

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

        return firstName;
    }
}
