package com.eminent.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Tamilvelan
 */
public class UserUtils {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("UserUtils");

    }

    public static void updateLogin(int userId) {
        Connection connection = null;
        PreparedStatement st = null;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {
            connection = MakeConnection.getConnection();
            st = connection.prepareStatement("update users set lastloggedon=(select loggedon from (select * from login_history where userid=? order by loggedon desc) where rownum<2) where userid=?");
            st.setInt(1, userId);
            st.setInt(2, userId);
            st.executeUpdate();

        } catch (Exception e) {
            logger.error("Error whileupdating last login"+e.getMessage());
        } finally {
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment"+ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection"+ex.getMessage());
            }
        }
    }

    public static void updateLoginHistory(int userId, String browserDetails, String sessionId, String ipAddress, String resolution, String timezone) {
        Connection connection = null;
        PreparedStatement st = null;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {
            String systemLoginName = System.getProperty("user.name");
            logger.info("systemLoginName" + systemLoginName);
            connection = MakeConnection.getConnection();
            st = connection.prepareStatement("insert into login_history(userid,loggedon,browser,sessionid,address,resolution,timezone,login_name) values(?,?,?,?,?,?,?,?)");
            st.setInt(1, userId);
            st.setTimestamp(2, date);
            st.setString(3, browserDetails);
            st.setString(4, sessionId);
            st.setString(5, ipAddress);
            st.setString(6, resolution);
            st.setString(7, timezone);
            st.setString(8, systemLoginName);
            st.execute();
        } catch (Exception e) {
            logger.error("Error whileupdating last login"+e.getMessage());
        } finally {
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment"+ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection"+ ex.getMessage());
            }
        }
    }

    public static void updateLogout(String sessionId) {
        Connection connection = null;
        PreparedStatement st = null;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        try {
            connection = MakeConnection.getConnection();
            st = connection.prepareStatement("update login_history set loggedout =? where sessionid =?");
            st.setTimestamp(1, date);
            st.setString(2, sessionId);
            st.executeUpdate();

        } catch (Exception e) {
            logger.error("Error whileupdating last login"+ e.getMessage());
        } finally {
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment"+ ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection"+ex.getMessage());
            }
        }

    }

    public static String[][] userActivity() {
        Calendar c = new GregorianCalendar();
        int month = c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);
        int day = 0;
        String dayofWeek = "";
        c.add(Calendar.DAY_OF_MONTH, -30);
        String loginHistory[][] = new String[30][2];
        for (int i = 0; i < 30; i++) {
            c.add(Calendar.DAY_OF_MONTH, 1);
            Date date = c.getTime();
            day = c.get(Calendar.DAY_OF_WEEK);
            switch (day) {
                case 1:
                    dayofWeek = "Sunday,";
                    break;
                case 2:
                    dayofWeek = "Monday,";
                    break;
                case 3:
                    dayofWeek = "Tuesday,";
                    break;
                case 4:
                    dayofWeek = "Wednesday,";
                    break;
                case 5:
                    dayofWeek = "Thrusday,";
                    break;
                case 6:
                    dayofWeek = "Friday,";
                    break;
                case 7:
                    dayofWeek = "Saturday,";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            String dateFor = sdf.format(date);
            loginHistory[i][0] = dayofWeek + " " + dateFor;
            loginHistory[i][1] = ((Integer) getLoggedInUsers(dateFor)).toString();
        }
        return loginHistory;
    }

    public static int getLoggedInUsers(String date) {
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        int totalUsers = 0;

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select distinct userid from login_history where to_char(loggedon,'dd-Mon-yyyy')='" + date + "'");
            rs.last();

            totalUsers = rs.getRow();

        } catch (Exception e) {
            logger.error("Error whileupdating last login"+e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing resultset"+ ex.getMessage());
            }
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment"+ ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection"+ex.getMessage());
            }
        }
        return totalUsers;
    }

    public static List getLoggedInUsersDetails(String date) {
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;

        List userList = new ArrayList();

        try {
            logger.info("getting user value" + date);
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select distinct h.userid,firstname ||' '||lastname,company from login_history h,users u where to_char(h.loggedon,'dd-Mon-yyyy')='" + date + "'  and h.userid=u.userid order by company");
            logger.info("getting user value");
            while (rs.next()) {
                logger.info("getting user value");
                userList.add(getLoginHistory(date, rs.getInt(1)));
            }

        } catch (Exception e) {
            logger.error("Error while getLoggedInUsersDetails"+ e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                    logger.info("Closing result set ");
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment"+ex.getMessage());

            }
            try {

                if (st != null) {
                    st.close();
                    logger.info("Closing statement ");
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment"+ ex.getMessage());

            }
            try {
                if (connection != null) {
                    connection.close();
                    logger.info("Closing Connection");
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection"+ex.getMessage());

            }
        }
        return userList;
    }

    public static Object getLoginHistory(String date, int userId) {
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;

        LoginDetails det = new LoginDetails();

        try {
            logger.info("Passed User Id" + userId);
            logger.info("Passed date" + date);
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select h.userid,firstname ||' '||lastname as name,company,to_char(h.loggedon,'dd-Mon-yyyy hh24:mi:ss') as Logon_Time,to_char(h.LOGGEDOUT,'dd-Mon-yyyy hh24:mi:ss') as Logout_Time,browser,address from login_history h,users u where to_char(h.loggedon,'dd-Mon-yyyy')='" + date + "' and  h.userid=" + userId + " and u.userid=h.userid order by Logon_Time desc");
            if (rs.next()) {

                det.setUserId(rs.getInt(1));
                det.setUserName(rs.getString(2));
                det.setCompany(rs.getString(3));
                det.setLoginTime(rs.getString(4));
                det.setLogoutTime(rs.getString(5));
                det.setBrowser(rs.getString(6));
                det.setIpAddress(rs.getString(7));

                logger.info("DB User Id" + rs.getInt(1));
                logger.info("DB Name" + rs.getString(2));
                logger.info("DB Company" + rs.getString(3));
                logger.info("DB User Id" + rs.getString(4));

            }

        } catch (Exception e) {
            logger.error("Error while retriving getLoginHistory"+ e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                    logger.info("Closing result set DB User Id");
                }
            } catch (Exception ex) {
                logger.error("Error while closing resultset in getLoginHistory"+ ex.getMessage());
            }
            try {

                if (st != null) {
                    st.close();
                    logger.info("Closing statement DB User Id");
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment in getLoginHistory"+ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                    logger.info("Closing Connection DB User Id");
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection"+ex.getMessage());
            }
        }
        return det;
    }

    public static Object getLoginHistory(int userId, String sessionId) {
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;

        LoginDetails det = new LoginDetails();

        try {
            logger.info("Passed User Id" + userId);
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select h.userid,firstname ||' '||lastname as name,company,to_char(h.loggedon,'dd-Mon-yyyy hh24:mi:ss') as Logon_Time,to_char(h.LOGGEDOUT,'dd-Mon-yyyy hh24:mi:ss') as Logout_Time,browser,address from login_history h,users u where to_char(h.loggedon,'dd-Mon-yyyy')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY') FROM DUAL) and  h.userid=" + userId + " and u.userid=h.userid and h.sessionid='" + sessionId + "' order by Logon_Time desc");
            if (rs.next()) {

                det.setUserId(rs.getInt(1));
                det.setUserName(rs.getString(2));
                det.setCompany(rs.getString(3));
                det.setLoginTime(rs.getString(4));
                det.setLogoutTime(rs.getString(5));
                det.setBrowser(rs.getString(6));
                det.setIpAddress(rs.getString(7));

                logger.info("DB User Id" + rs.getInt(1));
                logger.info("DB Name" + rs.getString(2));
                logger.info("DB Company" + rs.getString(3));
                logger.info("DB User Id" + rs.getString(4));

            }

        } catch (Exception e) {
            logger.error("Error while retriving getLoginHistory"+ e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                    logger.info("Closing result set DB User Id");
                }
            } catch (Exception ex) {
                logger.error("Error while closing resultset in getLoginHistory"+ ex.getMessage());
            }
            try {

                if (st != null) {
                    st.close();
                    logger.info("Closing statement DB User Id");
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment in getLoginHistory"+ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                    logger.info("Closing Connection DB User Id");
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection"+ex.getMessage());
            }
        }
        return det;
    }

    public static void abNormalLogOut(String userId) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            logger.info("userId" + userId);
            conn = MakeConnection.getConnection();
            String query = "Update LoginDetails set logoutTime=sysdate and userid = ?";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

        } catch (Exception e) {
           logger.error(e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
    }

    public static List getUserLoginHistory(int userId) {
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        List userList = new ArrayList();

        try {
            logger.info("Passed User Id" + userId);
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select userid,to_char(loggedon,'dd-Mon-yyyy hh24:mi:ss') as Logon_Time,to_char(LOGGEDOUT,'dd-Mon-yyyy hh24:mi:ss') as Logout_Time,browser,address from (select * from login_history where userid=" + userId + " order by loggedon desc) where rownum <= 11");
            while (rs.next()) {
                LoginDetails det = new LoginDetails();
                det.setUserId(rs.getInt(1));
                det.setLoginTime(rs.getString(2));
                det.setLogoutTime(rs.getString(3));
                det.setBrowser(rs.getString(4));
                det.setIpAddress(rs.getString(5));
                userList.add(det);
                logger.info("Login Time" + rs.getString(2));

            }

        } catch (Exception e) {
            logger.error("Error while retriving getUserLoginHistory"+e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                    logger.info("Closing result set DB User Id");
                }
            } catch (Exception ex) {
                logger.error("Error while closing resultset in getLoginHistory"+ ex.getMessage());
            }
            try {

                if (st != null) {
                    st.close();
                    logger.info("Closing statement DB User Id");
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment in getLoginHistory"+ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                    logger.info("Closing Connection DB User Id");
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection"+ex.getMessage());
            }
        }
        logger.info("Total login" + userList.size());
        return userList;
    }

    public static String getBrowser(String browser) {

        try {
            if (browser != null) {
                if (browser.contains("rv:11.0")) {
                    browser = "IE 11";
                } else if (browser.contains("MSIE 10.0")) {
                    browser = "IE 10";
                } else if (browser.contains("MSIE 9.0")) {
                    browser = "IE 9";
                } else if (browser.contains("MSIE 8.0")) {
                    browser = "IE 8";
                } else if (browser.contains("MSIE 7.0")) {
                    browser = "IE 7";
                } else if (browser.contains("MSIE 6.0")) {
                    browser = "IE 6";
                } else if (browser.contains("Firefox")) {
                    browser = (browser.substring(browser.indexOf("F"))).replace("/", " v");
                } else if (browser.contains("Chrome")) {
                    browser = browser.substring(browser.indexOf("Chrome/") + 7, browser.indexOf(" Safari"));
                    browser = "Chrome v" + browser;
                } else if (browser.contains("Safari") && browser.contains("Version")) {
                    browser = browser.substring(browser.indexOf("Version/") + 8, browser.indexOf(" Safari"));
                    browser = "Safari v" + browser;
                }
            } else {
                browser = "NA";
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return browser;
    }

    public static boolean getEmp(String empId) {
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        boolean flag = false;

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select * from users where emp_id='" + empId + "'");
            while (rs.next()) {
                flag = true;
            }

        } catch (Exception e) {
            logger.error("Error whileupdating last login"+ e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment"+ ex.getMessage());
            }
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment"+ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection"+ ex.getMessage());
            }
        }
        return flag;
    }

    public static boolean getRegistrationDate(int userId, String duration) {
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        boolean flag = true;
        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query="select userid from users where userid='" + userId + "' and to_date(to_char(registeredon,'DD-MM-YYYY'), 'DD-MM-YYYY') > to_date('01-"+duration+"', 'DD-MM-YYYY') and registeredon  is not null";
            logger.info(query);
            rs = st.executeQuery(query);
            while (rs.next()) {
                flag = false;
            }

        } catch (Exception e) {
            logger.error("Error whileupdating getRegistrationDate"+ e.getMessage());
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment"+ex.getMessage());
            }
            try {

                if (st != null) {
                    st.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing statment"+ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while closing connection"+ ex.getMessage());
            }
        }
        return flag;
    }
}
