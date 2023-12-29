package com.eminent.resource;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import pack.eminent.encryption.MakeConnection;

import org.apache.log4j.Logger;

public class ResourceRequestBean {
	static Logger logger = Logger.getLogger("ResourceRequestBean");
	
	Statement st;
	ResultSet rs;
	Connection connection;
	PreparedStatement ps;
	
	public ResultSet getRequest(Connection connection) throws SQLException{
		ps = connection.prepareStatement("select * from resourcerequest where status!='Closed'",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
		
		rs = ps.executeQuery();
		return rs;
		
	}
	public ResultSet getResourceRequest(Connection connection,int userid) throws Exception{
		if(userid!=104){
                    ps = connection.prepareStatement("SELECT * from  resourcerequest where assignedto=? and status!='Closed'",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                    ps.setInt(1,userid);
                }else{
                    ps = connection.prepareStatement("SELECT * from  resourcerequest where status!='Closed'",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                }
		
		
		rs = ps.executeQuery();
		
		return rs;
	}
        public ResultSet getMyResourceRequest(Connection connection,int userid) throws Exception{
		
                    ps = connection.prepareStatement("SELECT * from  resourcerequest where createdby=? and status!='Closed'",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                    ps.setInt(1,userid);
               


		rs = ps.executeQuery();

		return rs;
	}
	public ResultSet editRequest(Connection connection,String requestid) throws SQLException{
		ps = connection.prepareStatement("select * from resourcerequest where requestid='"+requestid+"'",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
		
		rs = ps.executeQuery();
		return rs;
		
	}
	public String getROHCount(String skillset,String requestid,String exp_years) throws Exception{
		int count=0;
        Connection rohConnection    =   null;
        ResultSet rohResultSet      =   null;
        PreparedStatement   rohPS   =   null;
		try{
		rohConnection=MakeConnection.getSAPConnection();
		//ps = connection.prepareStatement("SELECT count(*) from yapn  where (sel_status is null or sel_status != 'S') and (area = '"+ skill +"' or lang = '"+ skill +"') and (reqid is null or reqid = '"+ reqId +"') and apid not in(select distinct apid from yrr_history where reqid='"+ reqId +"') ");
		rohPS = rohConnection.prepareStatement("SELECT count(*) from yapn  where osta != 'OI' and spey >= '"+ exp_years+"' and (sel_status is null or sel_status != 'S') and (area = '"+ skillset +"' or lang = '"+ skillset +"') and (reqid is null or reqid = '"+ requestid +"') and apid not in(select distinct apid from yrr_history where reqid='"+ requestid +"') ");
		
		rohResultSet = rohPS.executeQuery();
		if(rohResultSet!=null){
			rohResultSet.next();
			count=rohResultSet.getInt(1);
		}
		}catch(Exception e){
			logger.error(e.getMessage());
			return "NA";
		}
        finally{

            try{
                if(rohResultSet!=null){
                    rohResultSet.close();
                }
            }catch(SQLException sqle){
                logger.error(sqle.getMessage());
            }
                try{
                    if(rohPS!=null){
                        rohPS.close();
                    }
                }
                catch(SQLException e){
                    logger.error(e.getMessage());
                }
            try{
                if(rohConnection!=null){
                    rohConnection.close();
                }
            }catch(SQLException ex){
                logger.error(ex.getMessage());
            }

        }
		return ((Integer)count).toString();
		
	}
        public int getAttachedFileCount(String requestid) throws Exception{
		int count=0;
        Connection rohConnection    =   null;
        ResultSet rohResultSet      =   null;
        PreparedStatement   rohPS   =   null;
		try{
		rohConnection=MakeConnection.getConnection();
		//ps = connection.prepareStatement("SELECT count(*) from yapn  where (sel_status is null or sel_status != 'S') and (area = '"+ skill +"' or lang = '"+ skill +"') and (reqid is null or reqid = '"+ reqId +"') and apid not in(select distinct apid from yrr_history where reqid='"+ reqId +"') ");
		rohPS = rohConnection.prepareStatement("select count(*) from fileattach where issueid='"+requestid+"'");

		rohResultSet = rohPS.executeQuery();
		if(rohResultSet!=null){
			rohResultSet.next();
			count=rohResultSet.getInt(1);
		}
		}catch(Exception e){
			logger.error(e.getMessage());
			return 0;
		}
        finally{

            try{
                if(rohResultSet!=null){
                    rohResultSet.close();
                }
            }catch(SQLException sqle){
                logger.error(sqle.getMessage());
            }
                try{
                    if(rohPS!=null){
                        rohPS.close();
                    }
                }
                catch(SQLException e){
                    logger.error(e.getMessage());
                }
            try{
                if(rohConnection!=null){
                    rohConnection.close();
                }
            }catch(SQLException ex){
                logger.error(ex.getMessage());
            }

        }
		return count;

	}
	public String getProjectDetails() throws Exception{
		String pid=null;
		String mid=null;
		String pmanager=null;
        Connection projectDetailsConnection =   null;
        ResultSet pdResultSet      =   null;
        PreparedStatement   pdPS   =   null;
		try{
		projectDetailsConnection=MakeConnection.getConnection();
        if(projectDetailsConnection!=null){
		pdPS = projectDetailsConnection.prepareStatement("select p.pid,m.moduleid,p.pmanager from project p,modules m where p.pid=m.pid and pname='ERM' and version='1.0'");
		
		
		pdResultSet = pdPS.executeQuery();
		
		if(pdResultSet.next()){
			pid			=	pdResultSet.getString(1);
			mid			=	pdResultSet.getString(2);
			pmanager	=	pdResultSet.getString(3);
            pid=pid+":"+mid+":"+pmanager;
		}
        else{
            pid = "NA";
        }
		
		} else{
            pid = "NA";
        }
        }catch(Exception e){
			logger.error(e.getMessage());
		
		}
        finally{

            try{
                if(pdResultSet!=null){
                    pdResultSet.close();
                }
            }catch(SQLException sqle){
                logger.error(sqle.getMessage());
            }
                try{
                    if(pdPS!=null){
                        pdPS.close();
                    }
                }
                catch(SQLException e){
                    logger.error(e.getMessage());
                }
            try{
                if(projectDetailsConnection!=null){
                    projectDetailsConnection.close();
                }
            }catch(SQLException ex){
                logger.error(ex.getMessage());
            }

        }
		return pid;
		
	}
	public int getResourceRequestNo(Connection connection,int userid) throws Exception{
		int count=0;
		try{
		ps = connection.prepareStatement("SELECT count(*) as total from  resourcerequest where assignedto=? AND STATUS!='Closed'",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ps.setInt(1,userid);
		
		rs = ps.executeQuery();
		if(rs.next()){
			count=count+rs.getInt(1);
		}
                }catch(Exception ex){
                    logger.error(ex.getMessage());
                }
                finally{
                    if(rs!=null){
                        rs.close();
                    }
                    if(ps!=null){
                        ps.close();
                    }
                }
		return count;
	}
        public int getResourceRequestNumber(int userid) throws Exception{
		int count=0;
                Connection dbconnection=null;
		try{
                    dbconnection=MakeConnection.getConnection();
		ps = dbconnection.prepareStatement("SELECT count(*) as total from  resourcerequest where assignedto=? AND STATUS!='Closed'",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ps.setInt(1,userid);
		
		rs = ps.executeQuery();
		if(rs.next()){
			count=count+rs.getInt(1);
		}
                }catch(Exception ex){
                    logger.error(ex.getMessage());
                }
                finally{
                    if(rs!=null){
                        rs.close();
                    }
                    if(ps!=null){
                        ps.close();
                    }
                    if(dbconnection!=null){
                        dbconnection.close();
                    }
                }
		return count;
	}
	public int checkProject() throws Exception{
		int count=0;
        Connection checkProjectConnection = null;
        ResultSet checkProjectResultSet      =   null;
        PreparedStatement   checkProjectPS   =   null;
		try{
		checkProjectConnection=MakeConnection.getConnection();

        if(checkProjectConnection!=null){
		checkProjectPS = checkProjectConnection.prepareStatement("SELECT count(*) from project where pname='ERM' and version='1.0' ");

            checkProjectResultSet = checkProjectPS.executeQuery();
		if(checkProjectResultSet.next()){
				count=checkProjectResultSet.getInt(1);
            }
        }
		}catch(Exception e){
			logger.error(e.getMessage());
			
		}
        finally{
                 try{
                if(checkProjectResultSet!=null){
                    checkProjectResultSet.close();
                }
            }catch(SQLException sqle){
                logger.error(sqle.getMessage());
            }
                try{
                    if(checkProjectPS!=null){
                        checkProjectPS.close();
                    }
                }
                catch(SQLException e){
                    logger.error(e.getMessage());
                }
             try{
                     if(checkProjectConnection!=null&& !checkProjectConnection.isClosed()){
                               checkProjectConnection.close();
                     }
                }
                catch(SQLException s){
                     logger.error(s.getMessage());
                }
                }
		return count;
	}
	

}
