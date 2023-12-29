/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dashboard;

import java.sql.*;
import java.util.*;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class MOMMaxIssues {

    static Logger logger = Logger.getLogger("MOMMaxIssues");

    public static HashMap<String, Integer> getIssueCountForMOM(int pid) {

        TreeSet<Integer> ts = new TreeSet<Integer>();
        HashMap<String, Integer> hm = new HashMap<String, Integer>();

        //   int issueMaxCount   = 0;
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;

        ArrayList<Integer> al = new ArrayList<Integer>();

        try {
            conn = MakeConnection.getConnection();
            String query = "select count(*) as total, s.status from issue i, issuestatus s, project p where i.pid=? and i.pid = p.pid and i.issueid = s.issueid  and s.status <> ? and i.assignedto <> p.pmanager and i.assignedto in(Select up.userid from UserProject up, users u where up.userId=u.userId and up.pid = p.pid and u.email like ?)group by s.status order by total";
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setInt(1, pid);
            pstmt.setString(2, "Closed");
            pstmt.setString(3, "%eminentlabs.net%");

            rs = pstmt.executeQuery();

            String status = null;
            int totalRows = 0;

            if (rs.next()) {

                rs.last();
                totalRows = rs.getRow();

                rs.beforeFirst();
                boolean flag = false;
                boolean flagQB = false;
                boolean flagQT = false;
                boolean flagAB = false;

                int rowForFC = 0;
                int rowForQABTC = 0;
                int rowForQATCE = 0;
                int rowForAbap = 0;
                int issueCountForInp = 0;
                int issueCountForTest = 0;
                int issueCountForAbap = 0;
                int issueCountForFC = 0;

                for (int row = 1; row <= totalRows; row++) {

                    rs.next();

                    status = rs.getString("status");
                    if (status != null) {

                        if (status.equalsIgnoreCase("QA-BTC") || status.equalsIgnoreCase("Investigation") || status.equalsIgnoreCase("Confirmed")) {
                            flagQB = true;
                            rowForQABTC = row;
                            issueCountForInp = issueCountForInp + rs.getInt("total");
                            hm.put("qa-btc", issueCountForInp);
                        } else if (status.equalsIgnoreCase("QA-TCE") || status.equalsIgnoreCase("Verified") || status.equalsIgnoreCase("Transport to TS") || status.equalsIgnoreCase("Transport to PS") || status.equalsIgnoreCase("Performance QA") || status.equalsIgnoreCase("Performance Testing")) {
                            flagQT = true;
                            rowForQATCE = row;
                            issueCountForTest = issueCountForTest + rs.getInt("total");
                            hm.put("qa-tce", issueCountForTest);
                        } else if (status.equalsIgnoreCase("Development") || status.equalsIgnoreCase("Detail Design") || status.equalsIgnoreCase("Workbench Request") || status.equalsIgnoreCase("Replicating in DS") || status.equalsIgnoreCase("ReadytoBuild") || status.equalsIgnoreCase("Code Review")) {
                            flagAB = true;
                            rowForAbap = row;
                            issueCountForAbap = issueCountForAbap + rs.getInt("total");
                            hm.put("withabap", issueCountForAbap);
                        } else if (status.equalsIgnoreCase("Documentation") || status.equalsIgnoreCase("Duplicate") || status.equalsIgnoreCase("Rejected") || status.equalsIgnoreCase("Training") || status.equalsIgnoreCase("User Error") || status.equalsIgnoreCase("Evaluation") || status.equalsIgnoreCase("Review") || status.equalsIgnoreCase("Customizing Request")) {
                            flag = true;
                            rowForFC = row;
                            issueCountForFC = issueCountForFC + rs.getInt("total");
                            hm.put("withfc", issueCountForFC);
                        }
                    }

                }

                if (flagQB == false) {

                    hm.put("qa-btc", 0);

                }
                if (flagQT == false) {

                    hm.put("qa-tce", 0);

                }
                if (flagAB == false) {

                    hm.put("withabap", 0);

                }
                if (flag == false) {

                    hm.put("withfc", 0);

                }

                rs.beforeFirst();
                for (int row = 1; row <= totalRows; row++) {

                    rs.next();

                    al.add(rs.getInt("total"));

                }

                int altogether = 0;
                for (int x : al) {

                    ts.add(x);
                    altogether = altogether + x;

                }
                hm.put("altogether", altogether);

                int maximum = 0;

                for (int x : ts) {

                    maximum = x;

                }

                hm.put("maximum", maximum);

            } else {
                hm.put("qa-btc", 0);
                hm.put("qa-tce", 0);
                hm.put("withabap", 0);
                hm.put("withfc", 0);
                hm.put("altogether", 0);

            }

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

        return hm;
    }
}
