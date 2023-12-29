/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import pack.eminent.encryption.MakeConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import org.apache.log4j.Logger;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author Tamilvelan
 */
public class ContactUtil {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ContactUtil");

    }

    public static int getContactCount(String userId) {

        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        int count = 0;

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement();
            rs = st.executeQuery("SELECT count(*) as count from CONTACT where contact_owner='" + userId + "' order by firstname ASC ");
            if (rs.next()) {
                count = rs.getInt("count");

            }

        } catch (Exception e) {
            logger.error("Error while finding the count", e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag", ex);
            }
        }

        return count;

    }

    public static HashMap getCRMIssues(int user) throws SQLException {
        int count = 0;
        logger.debug("Query()");
        String assignedto = String.valueOf(user);
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null;
        PreparedStatement ps = null, ps1 = null, ps2 = null, ps3 = null;
        int contact = 0, lead = 0, opportunity = 0, account = 0;
        HashMap<String, Integer> hm = new HashMap();
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("SELECT count(*) as total from  contact where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, assignedto);

            rs = ps.executeQuery();
            if (rs.next()) {
                contact = rs.getInt(1);
            }
            ps1 = connection.prepareStatement("SELECT count(*) as total from  lead where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps1.setString(1, assignedto);

            rs1 = ps1.executeQuery();
            if (rs1.next()) {
                lead = rs1.getInt(1);
            }
            ps2 = connection.prepareStatement("SELECT count(*) as total from  opportunity where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps2.setString(1, assignedto);

            rs2 = ps2.executeQuery();
            if (rs2.next()) {
                opportunity = rs2.getInt(1);
            }
            ps3 = connection.prepareStatement("SELECT count(*) as total from  account where roleid=2 and assignedto=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps3.setString(1, assignedto);

            rs3 = ps3.executeQuery();
            if (rs3.next()) {
                account = rs3.getInt(1);
            }
            hm.put("contact", contact);
            hm.put("lead", lead);
            hm.put("opportunity", opportunity);
            hm.put("account", account);
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (rs1 != null) {
                rs1.close();
            }
            if (rs2 != null) {
                rs2.close();
            }
            if (rs3 != null) {
                rs3.close();
            }

            if (ps != null) {
                ps.close();
            }

            if (ps1 != null) {
                ps1.close();
            }
            if (ps2 != null) {
                ps2.close();
            }
            if (ps3 != null) {
                ps3.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return hm;
    }

    public static Map<Integer, CRMSummaryCount> getCRMSummary() throws SQLException {

        // logger.debug("Query()");
        Connection connection = null;
        ResultSet rs = null, rs1 = null, rs2 = null;
        PreparedStatement ps = null, ps1 = null, ps2 = null;
        Map<Integer, CRMSummaryCount> summaryCount = new LinkedHashMap<>();

        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("SELECT l.assignedto,l.contact_type, count(*) as total from  contact l where l.roleid=2 and l.assignedto in (select userproject.userid from userproject,project where userproject.pid=project.pid and project.pname='CRM'and project.version='1.0')  group by l.assignedto,l.contact_type order by l.assignedto desc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = ps.executeQuery();

            while (rs.next()) {

                if (summaryCount.containsKey(rs.getInt(1))) {
                    CRMSummaryCount count = summaryCount.get(rs.getInt(1));

                    if (rs.getString(2).equalsIgnoreCase("normal")) {
                        count.setContactCount(rs.getInt(3));
                    } else if (rs.getString(2).equalsIgnoreCase("Influencer")) {
                        count.setInfContactCount(rs.getInt(3));
                    } else if (rs.getString(2).equalsIgnoreCase("Decision Maker")) {
                        count.setDecsionContactCount(rs.getInt(3));
                    }
                } else {
                    CRMSummaryCount count = new CRMSummaryCount();
                    if (rs.getString(2).equalsIgnoreCase("normal")) {
                        count.setContactCount(rs.getInt(3));
                    } else if (rs.getString(2).equalsIgnoreCase("Influencer")) {
                        count.setInfContactCount(rs.getInt(3));
                    } else if (rs.getString(2).equalsIgnoreCase("Decision Maker")) {
                        count.setDecsionContactCount(rs.getInt(3));
                    }

                    summaryCount.put(rs.getInt(1), count);
                }
            }

            ps1 = connection.prepareStatement("SELECT  l.assignedto,l.lead_type, count(*) as total from  lead l  where l.roleid=2  and l.assignedto in (select userproject.userid from userproject,project where userproject.pid=project.pid and project.pname='CRM'and project.version='1.0') group by l.assignedto,l.lead_type order by l.assignedto desc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs1 = ps1.executeQuery();
            while (rs1.next()) {
                if (summaryCount.containsKey(rs1.getInt(1))) {
                    CRMSummaryCount count = summaryCount.get(rs1.getInt(1));
                    if (rs1.getString(2).equalsIgnoreCase("normal")) {
                        count.setLeadCount(rs1.getInt(3));
                    } else if (rs1.getString(2).equalsIgnoreCase("Influencer")) {
                        count.setInfLeadCount(rs1.getInt(3));
                    } else if (rs1.getString(2).equalsIgnoreCase("Decision Maker")) {
                        count.setDecsionLeadCount(rs1.getInt(3));
                    }
                } else {
                    CRMSummaryCount count = new CRMSummaryCount();
                    if (rs1.getString(2).equalsIgnoreCase("normal")) {
                        count.setLeadCount(rs1.getInt(3));
                    } else if (rs1.getString(2).equalsIgnoreCase("Influencer")) {
                        count.setInfLeadCount(rs1.getInt(3));
                    } else if (rs1.getString(2).equalsIgnoreCase("Decision Maker")) {
                        count.setDecsionLeadCount(rs1.getInt(3));
                    }
                    summaryCount.put(rs1.getInt(1), count);
                }
            }
            ps2 = connection.prepareStatement("SELECT  l.assignedto, count(*) as total from  opportunity l  where l.roleid=2 and  l.assignedto in (select userproject.userid from userproject,project where userproject.pid=project.pid and project.pname='CRM'and project.version='1.0') group by l.assignedto order by l.assignedto desc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs2 = ps2.executeQuery();
            while (rs2.next()) {
                if (summaryCount.containsKey(rs2.getInt(1))) {
                    CRMSummaryCount count = summaryCount.get(rs2.getInt(1));
                    count.setOppCount(rs2.getInt(2));
                } else {
                    CRMSummaryCount count = new CRMSummaryCount();
                    count.setOppCount(rs2.getInt(2));
                    summaryCount.put(rs2.getInt(1), count);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (rs1 != null) {
                rs1.close();
            }
            if (rs2 != null) {
                rs2.close();
            }

            if (ps != null) {
                ps.close();
            }

            if (ps1 != null) {
                ps1.close();
            }
            if (ps2 != null) {
                ps2.close();
            }

            if (connection != null) {
                connection.close();
            }
        }
        return summaryCount;
    }

    public static String[][] getMeetings() throws SQLException {

        // logger.debug("Query()");
        Connection connection = null;
        ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null;
        PreparedStatement ps = null, ps1 = null, ps2 = null;
        HashMap<String, String> hm = new HashMap();
        String meeting[][] = null;

        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("select to_char(meeting_date,'DD-Mon-YYYY') as Meeting,meeting_time as time,company,assignedto,firstname||' '||lastname as name,contact_type  from contact where roleid=2 and meeting_time is not null order by meeting,time desc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            rs = ps.executeQuery();
            while (rs.next()) {
                hm.put(rs.getString(3) + " @ " + rs.getString(5), rs.getString(1) + "_" + rs.getString(2) + "*" + rs.getString(4) + "&&" + rs.getString(6));
//                System.out.println("Contact Count"+contactCount);
//                System.out.println("Contact "+contact);
            }
            ps1 = connection.prepareStatement("select to_char(meeting_date,'DD-Mon-YYYY') as Meeting,meeting_time as time,company,assignedto,firstname||' '||lastname as name,lead_type from lead where roleid=2 and meeting_time is not null order by meeting,time desc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs1 = ps1.executeQuery();

            while (rs1.next()) {
                hm.put(rs1.getString(3) + " @ " + rs1.getString(5), rs1.getString(1) + "_" + rs1.getString(2) + "*" + rs1.getString(4) + "&&" + rs1.getString(6));
            }

            ps2 = connection.prepareStatement("select to_char(meeting_date,'DD-Mon-YYYY') as Meeting,meeting_time as time,opportunityname,assignedto from opportunity where roleid=2 and meeting_time is not null order by meeting,time desc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs2 = ps2.executeQuery();
            while (rs2.next()) {
                hm.put(rs2.getString(3), rs2.getString(1) + "_" + rs2.getString(2) + "*" + rs2.getString(4) + "&&Normal");
            }

            int size = hm.size();
            meeting = new String[size][4];
            String metDate = null, company = null, time = null, dat = null, assigned = null, type = "Normal", companya = "";
            Iterator it = hm.entrySet().iterator();
            int i = 0;
            while (it.hasNext()) {
                Map.Entry pair = (Map.Entry) it.next();
                company = (String) pair.getKey();
                metDate = (String) pair.getValue();
                dat = metDate.substring(0, metDate.indexOf("_"));
                time = metDate.substring(metDate.indexOf("_") + 1, metDate.indexOf("*"));
                assigned = metDate.substring(metDate.indexOf("*") + 1, metDate.indexOf("&&"));
                type = metDate.substring(metDate.indexOf("&&") + 2, metDate.length());
                if (company.contains("@")) {
                    companya = company.substring(0, company.indexOf("@"));
                } else {
                    companya = company;
                }
                logger.info("Date" + dat);
                logger.info("TIME::::" + time);
                logger.info("Assigned::::" + assigned);
                it.remove(); // avoids a ConcurrentModificationException

                //color Sreeja=Green, Prakash=blue,Deepak=brown,Gopal=Black
                if (assigned.equals("2887")) {
                    company = "<a href='/eTracker/MyCRM/crmCompany.jsp?company=" + companya + "&state=&industry=' color='brown' style='cursor: pointer;color: brown;' target='_blank'>" + company + "</a>";
                } else if (assigned.equals("2508")) {
                    company = "<a href='/eTracker/MyCRM/crmCompany.jsp?company=" + companya + "&state=&industry=' color='blue' style='cursor: pointer;color: blue;' target='_blank'>" + company + "</a>";
                } else if (assigned.equals("212")) {
                    company = "<a href='/eTracker/MyCRM/crmCompany.jsp?company=" + companya + "&state=&industry=' color='green' style='cursor: pointer;color: green;' target='_blank'>" + company + "</a>";
                } else {
                    company = "<a href='/eTracker/MyCRM/crmCompany.jsp?company=" + companya + "&state=&industry=' color='black' style='cursor: pointer;color: black;' target='_blank'>" + company + "</a>";
                }
                if (type.equalsIgnoreCase("Influencer")) {
                    company = company + "<img src='/eTracker/images/star.png' alt='Influencer' title='Influencer' style='cursor: pointer;height: 11px;'/>";
                } else if (type.equalsIgnoreCase("Decision Maker")) {
                    company = company + "<img src='/eTracker/images/hammer.png' alt='Decision Maker' title='Decision Maker' style='cursor: pointer;height: 11px;'/>";
                }
                meeting[i][0] = dat;
                if (time.equals("First Half")) {
                    meeting[i][1] = company;
                    meeting[i][2] = "";
                } else {
                    meeting[i][1] = "";
                    meeting[i][2] = company;
                }
                if (assigned.equals("2887")) {
                    meeting[i][3] = "North";
                } else {
                    meeting[i][3] = "South";
                }
                i++;
            }

        } catch (Exception e) {
            e.printStackTrace();
//            logger.error(e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (rs1 != null) {
                rs1.close();
            }
            if (rs2 != null) {
                rs2.close();
            }

            if (ps != null) {
                ps.close();
            }

            if (ps1 != null) {
                ps1.close();
            }
            if (ps2 != null) {
                ps2.close();
            }

            if (connection != null) {
                connection.close();
            }
        }

        return meeting;
    }

    public static String[][] getMeetingSummary() {
        String meeting[][] = null;
        try {
            Calendar aCalendar = Calendar.getInstance();
            Calendar bCalendar = Calendar.getInstance();
            // add -1 month to current month
            aCalendar.add(Calendar.MONTH, -1);
            // set DATE to 1, so first date of previous month
            aCalendar.set(Calendar.DATE, 1);

            Date firstDateOfPreviousMonth = aCalendar.getTime();

            bCalendar.add(Calendar.MONTH, 1);

            // set actual maximum date of previous month
            bCalendar.set(Calendar.DATE, bCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            //read it
            Date lastDateOfNextMonth = bCalendar.getTime();
//                            System.out.println("Start Date"+firstDateOfPreviousMonth);
//                            System.out.println("End Date"+lastDateOfNextMonth);

            long diff = lastDateOfNextMonth.getTime() - firstDateOfPreviousMonth.getTime();
            float days = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
//                            System.out.println("Days between dates"+days);
            meeting = new String[(int) days][6];
            int i = 0;
            String fixed[][] = getMeetings();
            String meetingDate = "";
            String first = "", second = "", third = "", fourth = "", reg = "", temp;
            DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
            while (!lastDateOfNextMonth.equals(firstDateOfPreviousMonth)) {
                first = "";
                second = "";
                third = "";
                fourth = "";
                temp = "";
                for (int k = 0; k < fixed.length; k++) {
                    meetingDate = fixed[k][0];
                    reg = fixed[k][3];
                    logger.info("Region::" + reg);
                    if (meetingDate != null) {
                        if (df.parse(meetingDate).equals(df.parse(df.format(lastDateOfNextMonth)))) {
                            if (reg.equals("South")) {
                                temp = "";
                                temp = fixed[k][1];
                                if (temp != null) {
                                    first = first + "</br>" + fixed[k][1];
                                }
                                temp = "";
                                temp = fixed[k][2];
                                if (temp != null) {
                                    second = second + "</br>" + fixed[k][2];
                                }
                            } else {
                                temp = "";
                                temp = fixed[k][1];
                                if (temp != null) {
                                    third = third + "</br>" + fixed[k][1];
                                }
                                temp = "";
                                temp = fixed[k][2];
                                if (temp != null) {
                                    fourth = fourth + "</br>" + fixed[k][2];
                                }
                            }
                        } else {
                            logger.info("Not Equal" + meetingDate + " Calculated Date" + df.format(lastDateOfNextMonth));
                        }
                    }
                }

                // Do Work Here
//            System.out.println("Date of the month"+lastDateOfNextMonth);
                meeting[i][0] = new SimpleDateFormat("dd-MMM-yyyy").format(lastDateOfNextMonth);
                meeting[i][1] = new SimpleDateFormat("EEE").format(lastDateOfNextMonth);
                meeting[i][2] = first;
                meeting[i][3] = second;
                meeting[i][4] = third;
                meeting[i][5] = fourth;

                bCalendar.add(Calendar.DATE, -1);
                lastDateOfNextMonth = bCalendar.getTime();
//                                System.out.println("Next Date"+new SimpleDateFormat("dd-MMM-yyyy").format(firstDateOfPreviousMonth));
//                                System.out.println(new SimpleDateFormat("EEE").format(firstDateOfPreviousMonth));
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return meeting;
    }
}
