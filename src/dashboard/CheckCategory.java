package dashboard;

import java.sql.*;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

public class CheckCategory {

    static Logger logger = Logger.getLogger("CheckCategory");

    public static String getCategory(String projectVersion) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String category = null;

        int index = projectVersion.lastIndexOf(":");

        String project = projectVersion.substring(0, index);
        String version = projectVersion.substring((index + 1));

        try {
            conn = MakeConnection.getConnection();
            String query = "select pid, category from project where pname = ? and version = ?";
            pstmt = conn.prepareStatement(query);

            pstmt.setString(1, project);
            pstmt.setString(2, version);

            rs = pstmt.executeQuery();

            if (rs.next()) {

                category = rs.getString("category");

            } else {

                category = "Nil";
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

        return category;
    }

    public static String getProjectCategory(String pId) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String category = null;

        try {
            conn = MakeConnection.getConnection();
            String query = "select pid, category from project where pid = ?";
            pstmt = conn.prepareStatement(query);

            pstmt.setString(1, pId);
            rs = pstmt.executeQuery();

            if (rs.next()) {

                category = rs.getString("category");

            } else {

                category = "Nil";
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

        return category;
    }

    public static String getProjectType(String projectVersion) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String projectType = null;

        int index = projectVersion.lastIndexOf(":");

        String project = projectVersion.substring(0, index);
        String version = projectVersion.substring((index + 1));

        try {
            conn = MakeConnection.getConnection();
            String query = "select type from project_type where pid = (select pid from project where pname = ? and version = ?)";
            pstmt = conn.prepareStatement(query);

            pstmt.setString(1, project);
            pstmt.setString(2, version);

            rs = pstmt.executeQuery();

            if (rs.next()) {

                projectType = rs.getString("type");

            } else {

                projectType = "Nil";
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

        return projectType;
    }
}
