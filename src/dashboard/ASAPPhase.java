package dashboard;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import org.apache.log4j.Logger;

import pack.eminent.encryption.MakeConnection;

public class ASAPPhase {

    static Logger logger = Logger.getLogger("ASAPPhase");

    public static ArrayList<String> getPhases(String type) {
        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        ArrayList<String> allPhase = new ArrayList<String>();

        String project = "PROJECT_" + type.toUpperCase();
//	    System.out.println("type" + project);

        try {
            conn = MakeConnection.getConnection();

            stmt = conn.createStatement();

            rs = stmt.executeQuery("select distinct phase,phaseindex from " + project + " order by phaseindex");

            if (rs.next()) {
                do {
                    allPhase.add(rs.getString("phase"));
                } while (rs.next());

            } else {
//	               System.out.println("There are no phases for this type.Do verify the type");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return allPhase;
    }

}
