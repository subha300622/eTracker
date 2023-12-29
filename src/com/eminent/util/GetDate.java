package com.eminent.util;

import pack.eminent.encryption.MakeConnection;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.Calendar;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import org.apache.log4j.*;

/**
 *
 * @author Tamilvelan
 */
public class GetDate {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("Get Date");

    }

    public static Date getDate() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Date date = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select to_date(to_char(sysdate,'DD-Mon-YY'),'DD-Mon-YY') as today from dual");
            while (resultset.next()) {
                date = resultset.getDate(1);
            }
            logger.info("Sys Date" + date);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details" + ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details" + ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                    logger.info("Connection closed");
                    if (connection.isClosed()) {
                        logger.info("Closed");
                    } else {
                        logger.info("Not Closed");
                    }
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details" + ex.getMessage());
            }
        }

        return date;
    }

    public static String getYesterdayDate() {
        String date = null;

        Calendar cal = Calendar.getInstance();
        DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");
        cal.add(Calendar.DATE, -1);

        date = dateFormat.format(cal.getTime());
        return date;

    }

    public static String getStringDate() {
        String date = null;

        Calendar cal = Calendar.getInstance();
        DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");
        date = dateFormat.format(cal.getTime());
        return date;
    }

}
