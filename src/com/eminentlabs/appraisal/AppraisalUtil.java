/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.appraisal;
import com.eminentlabs.dao.HibernateFactory;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ResourceBundle;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Query;
import com.eminentlabs.dao.DAOFactory;
import com.eminentlabs.dao.ModelDAO;
import java.util.List;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.HashMap;
import java.text.SimpleDateFormat;
/**
 *
 * @author Tamilvelan
 */
public class AppraisalUtil {
    static Logger logger=Logger.getLogger("Appraisal Util");
    private static ResourceBundle rb = null;
    static {
		rb = ResourceBundle.getBundle("Resources");
	}
    public static HashMap getIntiater(){
        HashMap initiater   =   new HashMap<Integer,String>();
        initiater.put((Integer)212, "Gopal T");
        initiater.put((Integer)112, "Tamilvelan T");
        initiater.put((Integer)200, "Thuyavan A");
        initiater.put((Integer)103, "Vanaja N");
        initiater.put((Integer)481, "Saravanan P");
        return initiater;
    }
    public static HashMap getAccounts(){
        HashMap accountant   =   new HashMap<Integer,String>();
        String acountId     = rb.getString("accId");
        String accountName  = rb.getString("accName");
        accountant.put((Integer)Integer.parseInt(acountId), accountName);
        return accountant;
    }
    public static HashMap getUserDetails(int userId){
        Connection connection   =   null;
        Statement statement     =   null;
        ResultSet resultset     =   null;
        HashMap userDetails   =   new HashMap<Integer,String>();
        try{
            connection      =   MakeConnection.getConnection();
            statement       =   connection.createStatement();
            resultset       =   statement.executeQuery("select designation,emp_id from users where userid="+userId);
            while(resultset.next()){
                logger.info("Designation"+resultset.getString(1));
                logger.info("Emp Id"+resultset.getString(2));
                userDetails.put("designation",resultset.getString(1));
                userDetails.put("employeeId",resultset.getString(2));
            }

        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try{
                if(resultset!=null)
                    resultset.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(statement!=null)
                    statement.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(connection!=null)
                    connection.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
        }
        return userDetails;
   }
   public static boolean checkEligibility(int userId){
        Connection connection   =   null;
        Statement statement     =   null;
        ResultSet resultset     =   null;
        boolean flag            =   false;
        try{
            connection      =   MakeConnection.getConnection();
            statement       =   connection.createStatement();
            resultset       =   statement.executeQuery("SELECT TIMESHEETID,APPRAISAL_ELIGIBILITY  FROM (SELECT A.*, ROWNUM RWNM FROM(SELECT * FROM TIMESHEET WHERE OWNER="+userId+" ORDER BY ROWNUM DESC) A WHERE ROWNUM = 1)");
            while(resultset.next()){
                String eligibility =   resultset.getString(2);
                if(eligibility!=null){
                    char app    =   eligibility.charAt(0);
                    if(app=='Y'){
                        flag    =   true;
                    }
                }
            }

        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
           try{
                if(resultset!=null)
                    resultset.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(statement!=null)
                    statement.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(connection!=null)
                    connection.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
        }
        return flag;
   }
   public static void calculateEligibility(int userId){
        Connection connection   =   null;
        Statement statement     =   null;
        ResultSet resultset     =   null;
        boolean flag            =   false;
        try{
            connection      =   MakeConnection.getConnection();
            statement       =   connection.createStatement();
            resultset       =   statement.executeQuery("SELECT TIMESHEETID,APPRAISAL_ELIGIBILITY  FROM (SELECT A.*, ROWNUM RWNM FROM(SELECT * FROM TIMESHEET WHERE OWNER="+userId+" ORDER BY ROWNUM DESC) A WHERE ROWNUM = 1)");
            while(resultset.next()){
                String eligibility =   resultset.getString(2);
                if(eligibility!=null){
                    char app    =   eligibility.charAt(0);
                    if(app=='Y'){
                        flag    =   true;
                    }
                }
            }

        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
                        try{
                if(resultset!=null)
                    resultset.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(statement!=null)
                    statement.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(connection!=null)
                    connection.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
        }
   }
   public static void createAppraisal(String empId,int userId,int firstAppraiser,int secondAppraiser,int thirdAppraiser,int as,int initiatedBy,String period,String appComments){

       try{
            Timestamp date=new Timestamp(new java.util.Date().getTime());

            ErmAppraisal app    =   new ErmAppraisal();
            ErmAppraisalComment comments    =   new ErmAppraisalComment();

            app.setEmpId(empId);
            app.setAppraisalUser(userId);
            app.setFirstAppraiser(firstAppraiser);
            app.setSecondAppraiser(secondAppraiser);
            app.setThirdAppraiser(thirdAppraiser);
            app.setInitiatedBy(initiatedBy);
            app.setAssignedto(firstAppraiser);
            app.setCreatedon(date);
            app.setUpdatedon(date);
            app.setErmAppraisalStatus((ErmAppraisalStatus)ModelDAO.load(ErmAppraisalStatus.class, 1));
            app.setPeriod(period);
            app.setApprovalStatus("P");
            app.setSystemAppraisalPercentage(getIndividualPerformance(userId, period));
            int appId   =   ModelDAO.createErmAppraisal(app);

            comments.setCommentedBy(initiatedBy);
            comments.setCommentedOn(date);
            comments.setCommentedTo(firstAppraiser);
            comments.setComments(appComments);
            comments.setStatus(1);
            comments.setErmAppraisal((ErmAppraisal)ModelDAO.load(ErmAppraisal.class, appId));
            DAOFactory.createErmAppraisalComment(comments);

        }catch(Exception e){
            logger.error(e.getMessage());
        }
   }
       public static int createUserAppraisal(String empId,int userId,String period,String appComments,String accomplishments,String ongoing,String nextcycle){
      int appId =   0;
       try{
            Timestamp date=new Timestamp(new java.util.Date().getTime());

            ErmAppraisal app    =   new ErmAppraisal();
            ErmAppraisalComment comments    =   new ErmAppraisalComment();

            int firstAppraiser     = Integer.parseInt(rb.getString("firstAppraiser"));

            app.setEmpId(empId);
            app.setAppraisalUser(userId);
            app.setFirstAppraiser(firstAppraiser);
            app.setSecondAppraiser(firstAppraiser);
            app.setThirdAppraiser(firstAppraiser);
            app.setInitiatedBy(userId);
            app.setAssignedto(firstAppraiser);
            app.setCreatedon(date);
            app.setUpdatedon(date);
            app.setErmAppraisalStatus((ErmAppraisalStatus)ModelDAO.load(ErmAppraisalStatus.class, 1));
            app.setPeriod(period);
            app.setApprovalStatus("P");
            app.setSystemAppraisalPercentage(getIndividualPerformance(userId, period));
            appId   =   ModelDAO.createErmAppraisal(app);

            if(appComments==null){
                appComments =   "Creating appraisal request";
            }

            comments.setCommentedBy(userId);
            comments.setCommentedOn(date);
            comments.setCommentedTo(firstAppraiser);
            comments.setComments(appComments);
            comments.setStatus(1);
            comments.setErmAppraisal((ErmAppraisal)ModelDAO.load(ErmAppraisal.class, appId));
            DAOFactory.createErmAppraisalComment(comments);

        }catch(Exception e){
            logger.error(e.getMessage());
        }
      return appId;
   }
   public static boolean previousAppraisal(int userId){
        Connection connection   =   null;
        Statement statement     =   null;
        ResultSet resultset     =   null;
        boolean flag            =   false;
        try{
            connection      =   MakeConnection.getConnection();
            statement       =   connection.createStatement();
            resultset       =   statement.executeQuery("SELECT TIMESHEETID,APPRAISAL_ELIGIBILITY  FROM (SELECT A.*, ROWNUM RWNM FROM(SELECT * FROM TIMESHEET WHERE OWNER="+userId+" ORDER BY ROWNUM DESC) A WHERE ROWNUM = 1)");
            while(resultset.next()){
                String eligibility =   resultset.getString(2);
                if(eligibility!=null){
                    char app    =   eligibility.charAt(0);
                    if(app=='Y'){
                        flag    =   true;
                    }
                }
            }

        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
           try{
                if(resultset!=null)
                    resultset.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(statement!=null)
                    statement.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(connection!=null)
                    connection.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
        }
        return flag;
   }
   	public static int getNoOfAppraisalRequest(int userId){

	Connection connection   =   null;
        Statement statement     =   null;
        ResultSet resultset     =   null;
        int noOfApprovals       =   0;
        
        try{
            connection      =   MakeConnection.getConnection();
            statement       =   connection.createStatement();
            resultset       =   statement.executeQuery("select count(*) from Erm_Appraisal where STATUS_ID!=9 and assignedto="+userId);
            while(resultset.next()){
                noOfApprovals =   resultset.getInt(1);
            }

        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
           try{
                if(resultset!=null)
                    resultset.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(statement!=null)
                    statement.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(connection!=null)
                    connection.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
        }


        return noOfApprovals;

    }
    public static int getNoOfppraisalRequestRaised(int userId){

	Connection connection   =   null;
        Statement statement     =   null;
        ResultSet resultset     =   null;
        int noOfApprovals       =   0;

        try{
            connection      =   MakeConnection.getConnection();
            statement       =   connection.createStatement();
            resultset       =   statement.executeQuery("select count(*) from Erm_Appraisal where STATUS_ID!=9 and APPRAISAL_USER="+userId);
            while(resultset.next()){
                noOfApprovals =   resultset.getInt(1);
            }

        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
           try{
                if(resultset!=null)
                    resultset.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(statement!=null)
                    statement.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(connection!=null)
                    connection.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
        }


        return noOfApprovals;

    }
    public static int getMyAppraisalId(int userId){
            Session session	=	null;
            List l	=	null;
            int appId   =   0;
		try{

                    String[] monthName = {"Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov","Dec"};

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("from ErmAppraisal where ermAppraisalStatus!=9 and appraisalUser="+userId+" order by createdon desc");
                    l  =   query.list();
                    if(l.size()>0){
                        ErmAppraisal app = (ErmAppraisal)l.get(0);
                        appId       =   app.getAppraisalId();

                    }
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return appId;

        }
    public static String getAppraisalStatus(int statusId){

	Connection connection   =   null;
        Statement statement     =   null;
        ResultSet resultset     =   null;
        String statusName       =   "";

        try{
            connection      =   MakeConnection.getConnection();
            statement       =   connection.createStatement();
            resultset       =   statement.executeQuery("select STATUS from Erm_Appraisal_status where STATUS_ID="+statusId);
            while(resultset.next()){
                statusName =   resultset.getString(1);
            }

        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
           try{
                if(resultset!=null)
                    resultset.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(statement!=null)
                    statement.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(connection!=null)
                    connection.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
        }


        return statusName;

    }
        public static List viewAppraisalrequest(int userId){
		Session session	=	null;
                List l	=	null;
	 
		try{
 
                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("from ErmAppraisal where ermAppraisalStatus!=9 and assignedto="+userId);
                    l  =   query.list();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return l;
	}
        public static List viewAppraisalrequestForAdmin(int userId){
		Session session	=	null;
                List l	=	null;

		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("from ErmAppraisal");
                    l  =   query.list();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return l;
	}
        public static List viewMyAppraisalrequest(int userId){
		Session session	=	null;
                List l	=	null;

		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("from ErmAppraisal where ermAppraisalStatus!=9 and appraisalUser="+userId);
                    l  =   query.list();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return l;
	}
            public static HashMap getStatus(int statusId){
		Session session	=	null;
                List l	=	null;
                HashMap statusList = new HashMap<Integer, String>();

		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createSQLQuery("select status_sub_id,status from ERM_APPRAISAL_STATUS_FLOW f , ERM_APPRAISAL_STATUS s where status_master_id="+statusId+" and status_id=status_sub_id");
                    l  =   query.list();
                    int i=0;
                    int status_id    =   0;
                    String status    = "";

                    for (Iterator reqIterator = l.iterator(); reqIterator.hasNext();i++ ) {
                        Object stat[] =   (Object[])reqIterator.next();
                        status_id     =    ((BigDecimal)stat[0]).intValue();
                        status        =    (String)stat[1];
                        statusList.put(status_id, status);
                    }
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return statusList;
	}

        public static List viewAppraisalComments(int appId){
		Session session	=	null;
                List l	=	null;
		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("from ErmAppraisalComment where ermAppraisal="+appId+" order by commentedOn");
                    l  =   query.list();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
                        if(session!=null){
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
                    }
		}
                return l;
	}
        public static void getAppStartMonth(int userId){
         Session session	=	null;
                List l	=	null;
                String period   =   "";
		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("from ErmAppraisal where appraisalUser="+userId+" order by createdon desc");
                    l  =   query.list();
                    if(l.size()>0){
                        ErmAppraisal iss = (ErmAppraisal)l.get(0);
                        String status =   iss.getApprovalStatus();
                        if(status.equalsIgnoreCase("Y")){

                        }else if(status.equalsIgnoreCase("N")){

                        }else if(status.equalsIgnoreCase("P")){
                            
                        }
                    }
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
                        if(session!=null){
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
                    }
		}
        }
        public static void createAccomplishedIssues(String[] issueId,String type,int appId){
            int i   =   0;
            ErmAppraisalAchievement achievement =   null;

            try{
                
            while(i<issueId.length){
                try{
                achievement     =   new ErmAppraisalAchievement();
              
                achievement.setIssueId(issueId[i]);
                achievement.setType(type);
                achievement.setAppraisalId(appId);

               
                 DAOFactory.createErmAchievement(achievement);
                }catch(Exception e){
                    logger.error(e.getMessage());
                }
                i++;


        }
            }catch(Exception e){
                logger.error(e.getMessage());
            }
            
        }
        public static List getAccomplishment(int appId){
            Session session	=	null;
                List l	=	null;

		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("from ErmAppraisalAchievement where type='A' and appraisalId="+appId);
                    l  =   query.list();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return l;
        }
        public static int getAccomplishmentCount(int appId){
            Session session	=	null;
                int l	=	0;

		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("select count(*) from ErmAppraisalAchievement where type='A' and appraisalId="+appId);
                    l  =   ( (Long) query.iterate().next() ).intValue();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return l;
        }
        public static List getPlan(int appId){
            Session session	=	null;
                List l	=	null;

		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("from ErmAppraisalAchievement where type='P' and appraisalId="+appId);
                    l  =   query.list();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return l;
        }
        public static int getPlanCount(int appId){
            Session session	=	null;
                int l	=	0;

		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("select count(*) from ErmAppraisalAchievement where type='P' and appraisalId="+appId);
                    l  =   ( (Long) query.iterate().next() ).intValue();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return l;
        }
        public static List getActivities(int appId){
            Session session	=	null;
                List l	=	null;

		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("from ErmAppraisalAchievement where type='O' and achievementId="+appId);
                    l  =   query.list();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return l;
        }
        public static int getActivityCount(int appId){
            Session session	=	null;
                int l	=	0;

		try{

                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("select count(*) from ErmAppraisalAchievement where type='O' and appraisalId="+appId);
                    l  =   ( (Long) query.iterate().next() ).intValue();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return l;
        }
        public static boolean appraisalEligibility(int userId){
            Connection connection   =   null;
            Statement statement     =   null;
            ResultSet resultset     =   null;
            int count               =   0;
            boolean flag            = false;

        try{
                String[] monthName = {"Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov","Dec"};
                Calendar cal    =   new GregorianCalendar();
                String startperiod  =   getLastAppraisalPeriod(userId);
                logger.info("Start Period"+startperiod);
                int year = cal.get(Calendar.YEAR);
                int month = cal.get(Calendar.MONTH);
                int maxday=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
                String enDay    = "";
                if(maxday<10){
                    enDay  =   "0"+maxday;
                }else{
                    enDay=maxday+"";
                }

                String enMon    = "";
                if(month<10){
                    enMon  =   "0"+month;
                }else{
                    enMon=month+"";
                }

                String endPeriod    =   enDay+"-"+enMon+"-"+year;
                logger.info("End Period"+endPeriod);
                SimpleDateFormat sdfInput =   new SimpleDateFormat (  "dd-MM-yyyy"  ) ;
                SimpleDateFormat sdfOutput =  new SimpleDateFormat  (  "dd-MMM-yy"  ) ;

                

                connection      =   MakeConnection.getConnection();
                statement       =   connection.createStatement();
                String sql      =   "select count(*) from timesheet where owner="+userId+" and approvalpercentage >=80 and to_date(to_char(requestedon,'DD-Mon-YY'),'DD-Mon-YY') between '"+sdfOutput.format(sdfInput.parse(startperiod))+"' and '"+sdfOutput.format(sdfInput.parse(endPeriod))+"' order by approvalpercentage desc";
                logger.info("Eligiblity Query:::"+sql);
                resultset       =   statement.executeQuery(sql);
                while(resultset.next()){
                    count   =   resultset.getInt(1);
                }
                if(count>=6){
                    flag    =   true;
                }

        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
           try{
                if(resultset!=null)
                    resultset.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(statement!=null)
                    statement.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
          
            try{
                if(connection!=null)
                    connection.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
        }
            return flag;
        }
        public static String getLastAppraisalPeriod(int userId){
            Session session	=	null;
            List l	=	null;
            String periodDate = "01-01-2008";
		try{
                    
                    String[] monthName = {"Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov","Dec"};
        
                    session = HibernateFactory.getCurrentSession();
                    Query query =   session.createQuery("from ErmAppraisal where approvalStatus='Y' and appraisalUser="+userId+" order by updatedon desc");
                    l  =   query.list();
                    if(l.size()>0){
                        ErmAppraisal app = (ErmAppraisal)l.get(0);
                        String period   =   app.getPeriod();
                        String start   =   period.substring(0, period.indexOf('*'));
                        String end     =   period.substring(period.indexOf('*')+1,period.length() );
                        String startMonth  =   start.substring(0, start.indexOf('-'));
                        String endMonth  =   end.substring(0, end.indexOf('-'));

                        String startYear  =   start.substring(start.indexOf('-')+1, start.length());
                        String endYear  =   end.substring(end.indexOf('-')+1, end.length());

                        int stMonth     =   (Integer.parseInt(startMonth));
                        if(stMonth<10){
                            startMonth  =   "0"+stMonth;
                        }

                        int enMonth     =   (Integer.parseInt(endMonth));
                        if(enMonth<10){
                            endMonth  =   "0"+enMonth;
                        }

                        Calendar cal = new GregorianCalendar();
                        cal.set(Calendar.YEAR,Integer.parseInt(endYear) );
                        cal.set(Calendar.MONDAY,(enMonth+1));


                        periodDate      =   startMonth+"-"+enMonth+"-"+endYear;

                    }
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		finally{
			if(session.isOpen()){
				try{
				session.close();
				}catch(Exception e){
					logger.error(e.getMessage());

				}
			}
		}
                return periodDate;
            
        }
        public static int getIndividualPerformance(int userId, String period){
            Connection connection   =   null;
            Statement statement     =   null;
            ResultSet resultset     =   null;
            Statement statementC     =   null;
            ResultSet resultsetC     =   null;
            int indPerformance       =   0,comPerformance=0;

        try{
            String start   =   period.substring(0, period.indexOf('*'));
            String end     =   period.substring(period.indexOf('*')+1,period.length() );
            String startMonth  =   start.substring(0, start.indexOf('-'));
            String endMonth  =   end.substring(0, end.indexOf('-'));

            String startYear  =   start.substring(start.indexOf('-')+1, start.length());
            String endYear  =   end.substring(end.indexOf('-')+1, end.length());

           int stMonth     =   (Integer.parseInt(startMonth));
            if(stMonth<10){
                startMonth  =   "0"+stMonth;
            }

            int enMonth     =   (Integer.parseInt(endMonth));
            if(enMonth<10){
                endMonth  =   "0"+enMonth;
            }

            Calendar cal = new GregorianCalendar();
            cal.set(Calendar.YEAR,Integer.parseInt(endYear) );
            cal.set(Calendar.MONDAY,enMonth);
            int maxday=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
            String startDate    =   "01-"+(stMonth+1)+"-"+startYear;
            String endDate      =   maxday+"-"+(enMonth+1)+"-"+endYear;
            SimpleDateFormat sdfInput =   new SimpleDateFormat (  "dd-MM-yyyy"  ) ;
            SimpleDateFormat sdfOutput =  new SimpleDateFormat  (  "dd-MMM-yy"  ) ;
                        
            connection      =   MakeConnection.getConnection();
            statement       =   connection.createStatement();
            statementC       =   connection.createStatement();
            resultset       =   statement.executeQuery("select avg(APPROVALPERCENTAGE)/2 as individual_performance from timesheet where to_date(to_char(requestedon ,'DD-Mon-YY'),'DD-Mon-YY') between '"+sdfOutput.format(sdfInput.parse(startDate))+"' and '"+sdfOutput.format(sdfInput.parse(endDate))+"' and owner="+userId+" and ACCOMPLISHMENTS is not null order by requestedon");
            while(resultset.next()){
                indPerformance =   resultset.getInt(1);
            }

            resultsetC       =   statementC.executeQuery("select avg(PERCENTAGE)/2 from COMPANY_PERFORMANCE where year between "+Integer.parseInt(startYear)+" and "+Integer.parseInt(endYear));
            while(resultsetC.next()){
                comPerformance =   resultsetC.getInt(1);
            }
            logger.info("Individual performance"+indPerformance);
            logger.info("Company performance"+comPerformance);
        }catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
           try{
                if(resultset!=null)
                    resultset.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(statement!=null)
                    statement.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
           try{
                if(resultsetC!=null)
                    resultsetC.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(statementC!=null)
                    statementC.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
            try{
                if(connection!=null)
                    connection.close();
            }catch(SQLException e){
                logger.error(e.getMessage());
            }
        }
        return (indPerformance+comPerformance);
        }
       

}
