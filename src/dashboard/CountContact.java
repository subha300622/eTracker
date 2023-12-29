package dashboard;

import java.sql.*;
import org.apache.log4j.Logger;

import pack.eminent.encryption.MakeConnection;

public class CountContact {

    static Logger logger = Logger.getLogger("CountContact");

    public static int getContactNo(String rating) {
        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        int total = 0;

        try {
            conn = MakeConnection.getConnection();
            String query = "select count(*) as total from contact where upper(rating) = upper('" + rating + "') and roleid=2";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            if (rs.next()) {

                total = rs.getInt("total");

            } else {

                total = 0;

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }

            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
//		    System.out.println("Lead count total"+total);

        return total;

    }

}
