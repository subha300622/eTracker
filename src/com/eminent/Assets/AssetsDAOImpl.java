/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.Assets;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;

import pack.eminent.encryption.MakeConnection;

public class AssetsDAOImpl implements AssetsDAO {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("AssetDAO");
    }

    @Override
    public void delete(String assetId, String machinename) {

        Connection connection = null;
        PreparedStatement pst = null;

        try {
            connection = MakeConnection.getConnection();
            if (connection != null) {

                pst = connection.prepareStatement("Delete from resources where UNIQUE_ASSET_NO='" + assetId + "' and machinename='" + machinename + "'");

                pst.executeUpdate();
                connection.commit();
                logger.info("Successfully deleted!!!");

            }
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }
    }

    @Override
    public List<String> findAllMACaddresses(String IpAddress, String text, String machinename) {
        List<String> MACaddress = new ArrayList<String>();
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = "";

        try {
            connection = MakeConnection.getConnection();
            if (connection != null) {
                if (text.equalsIgnoreCase("newResource")) {
                    sql = "SELECT ipaddress  from resources";
                } else {

                    sql = "SELECT ipaddress  from resources where  machinename!='" + machinename + "'";
                }
                st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                rs = st.executeQuery(sql);
                rs.last();
                int rowcount = rs.getRow();
                logger.debug("Total No of records:" + rowcount);
                rs.beforeFirst();
                while (rs.next()) {
                    String dbaddress = rs.getString("ipaddress");
                    MACaddress.add(dbaddress);
                }

            }
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }
        return MACaddress;

    }

    @Override
    public int getAssetCount() {
        int count = 0;
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();

            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select count (*) from resources");
             if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }

        return count;

    }

}
