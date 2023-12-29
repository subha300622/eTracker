package com.eminent.examples;
import java.net.InetAddress;
import java.io.IOException;
import java.util.Date;
import java.util.Calendar;
import java.text.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import org.apache.log4j.*;
import pack.eminent.encryption.MakeConnection;
import com.eminent.util.SendMail;
import java.util.GregorianCalendar;

public class Test 
{
    static{
        Logger logger   =   Logger.getLogger("Test");
    }
	public static long ping(InetAddress addy)
	{ 
		long time = System.currentTimeMillis();
		try { 
			addy.isReachable(2000); 
		} catch (IOException ex) {
			ex.printStackTrace();
			return -1; 
		}
		return System.currentTimeMillis() - time; 
	}
    public static String[][] getProjectStatus(){
        Connection connection = null;
        ResultSet projectStatusRS = null;
        PreparedStatement projectStatusPS = null;
        String moduleDetails[][]   =   null;



        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

            connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost8:1521:XE", "eminenttracker", "eminentlabs");
            projectStatusPS = connection.prepareStatement("select moduleid,module from modules m,project p where p.pid=m.pid and p.pname='ContiSupport'",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            projectStatusRS = projectStatusPS.executeQuery();
            projectStatusRS.last();
            int noOfMembers=projectStatusRS.getRow();
            moduleDetails  = new String[noOfMembers][3];
            projectStatusRS.beforeFirst();
            int i=0;

            while (projectStatusRS.next()) {
                moduleDetails[i][0]   =   projectStatusRS.getString("Module");
                String issueDetails  =   Test.getModuleDetails(projectStatusRS.getString("moduleid"));

                int openIssue       =   Integer.parseInt(issueDetails.substring(issueDetails.indexOf("_")+1,issueDetails.length()));
                int closedIssue     =   Integer.parseInt(issueDetails.substring(0,issueDetails.indexOf("_")));
                int total           =   openIssue+closedIssue;

                moduleDetails[i][1]   =   (((Integer)openIssue).toString()).replaceAll("_","");
                moduleDetails[i][2]   =   (((Integer)closedIssue).toString()).replaceAll("_", "");


                i++;
            }

        } catch (Exception s) {
            s.printStackTrace();
        }
                finally {
            try {
                if (projectStatusRS != null) {
                    projectStatusRS.close();
                }
                if (projectStatusPS != null) {
                    projectStatusPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                System.out.println("Error while getting Project Members"+ ex);
            }

        return moduleDetails;
    }
    }
    public static String getModuleDetails(String moduleid){
        Connection connection = null;
        ResultSet moduleClosedIssuesRS = null,moduleOpenIssuesRS = null;
        PreparedStatement moduleClosedIssuesPS = null,moduleOpenIssuesPS = null;
        String issueNoDetails   =   null;

        int mod=Integer.parseInt(moduleid);

          Calendar cal = Calendar.getInstance();
        DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");

       String end = dateFormat.format(cal.getTime());
       
        cal.add(Calendar.DATE, -6);
      
        String start =   dateFormat.format(cal.getTime());

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

            connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
            moduleClosedIssuesPS = connection.prepareStatement("select count(*) as count from issue i,issuestatus s where module_id="+mod+" and i.issueid=s.issueid and status='Closed'",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            moduleClosedIssuesRS = moduleClosedIssuesPS.executeQuery();
            moduleClosedIssuesRS.next();
            int noOfClosedIssues=moduleClosedIssuesRS.getInt("count");

            String sql="select i.issueid as issueid, pname as project, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status  from project p, issue i, issuestatus s where i.issueid = s.issueid and i.pid = p.pid and p.pid=10072 and modifiedon between "+start+" and "+end+" order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            System.out.println(sql);

            moduleOpenIssuesPS = connection.prepareStatement("select count(*) as count  from project p, issue i, issuestatus s where i.issueid = s.issueid and i.pid = p.pid and p.pid=10072 and modifiedon between '"+start+"' and '"+end+"' order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            moduleOpenIssuesRS = moduleOpenIssuesPS.executeQuery();
            moduleOpenIssuesRS.next();
            int noOfOpenIssues=moduleOpenIssuesRS.getInt("count");

           issueNoDetails   =   noOfClosedIssues+"_"+noOfOpenIssues;
           System.out.println("Module id"+mod);
           System.out.println("Closed Issues"+noOfClosedIssues);
           System.out.println("Open Issues"+noOfOpenIssues);
           System.out.println("Issue No Details"+issueNoDetails);

//new line


        } catch (Exception s) {
            s.printStackTrace();
        }
                finally {
            try {
                if (moduleClosedIssuesRS != null) {
                    moduleClosedIssuesRS.close();
                }
                if (moduleClosedIssuesPS != null) {
                    moduleClosedIssuesPS.close();
                }
                if (moduleOpenIssuesRS != null) {
                    moduleOpenIssuesRS.close();
                }
                if (moduleOpenIssuesPS != null) {
                    moduleOpenIssuesPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                System.out.println("Error while getting Project Members"+ ex);
            }

        return issueNoDetails;
    }
    }
	public static void main(String[] args) throws Exception {
//            int[][] ia = new int[1][2];
//            System.out.println(ia.length);
//            System.out.println(ia[0].length);
//            int index=0,endIndex=30;
//            String descTitle =   "System should not pick any blank email ID's. Fix the bug and  Kindly update the status of the issue.";
//            String desc1 = null,desc_substr=null,nextline="\n";
//            int desclen = descTitle.length();
//            System.out.println("Length of the String::"+desclen);
//            
//            int noOfSplit   =   desclen/30;
//            if(desclen%30>0)
//                noOfSplit++;
//
//            System.out.println("No of split"+noOfSplit);
//            int splitStartLength    =   0, splitEndLength   =   40;
////             while((desclen/30)>=1)
////             {
////
////                 System.out.println("Length calculation-->"+descTitle.substring(splitStartLength, splitEndLength));
////                 desclen=desclen-30;
////                 splitStartLength   =   splitEndLength;
////             }
////            
//            if(desclen>=30)
//            {
//
//                   while((desclen/30)>=1)
//                   {
//                         
//                         
//                         desc_substr=descTitle.substring(index,endIndex);
//                         desc1=desc1.concat(desc_substr);
//                         desclen=desclen-30;
//                         desc1=desc1.concat(nextline);
//                         index  =   endIndex;
//                        for(int inde = desc_substr.indexOf(" ");inde >= 0;inde = desc_substr.indexOf(" ", inde + 1))
//                        {
//                            System.out.println(inde);
//                        }
// //                        System.out.println("Start Description"+desc1);
//                   }
//                   index=index+30;
//                   desc1=desc1.concat(nextline);
//                   desc1=desc1.concat(descTitle.substring(index));
////                   System.out.println("Final Description"+desc1);
//            }
//            else
//            {
//                    desc1=descTitle.substring(index);
//            }
//            System.out.println("Final Description"+desc1);
           /*
           String a ="tamil";
           String b="velan";
           System.out.println(a+b);
           String c=a+"\n"+b;
            System.out.println(c);
            String date     =   "19-2-2010";
            System.out.println("Parse"+com.pack.ChangeFormat.getDateFormat(date));
            System.out.println("Parse"+com.pack.ChangeFormat.changeDateFormat(date));

            String dtVelan ="12-Jul-10";
            System.out.println("Month"+dtVelan.substring(dtVelan.indexOf("-")+1, dtVelan.lastIndexOf("-")));
            System.out.println("Year"+dtVelan.substring(dtVelan.lastIndexOf("-")+1,dtVelan.length()));
           
                                
         DateFormat df    = new  SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat sdf    = new  SimpleDateFormat("dd-MMM-yy");
        Date d=new Date();
        String s    =   "2009-02-09";
        Date da     =df.parse(date);
        Date k      =java.sql.Date.valueOf(date);
        System.out.println("SQL Date"+da);
        System.out.println("Parse"+sdf.format(da));

        System.out.println("Util Date"+d);
        SimpleDateFormat sdf    = new  SimpleDateFormat("dd-MMM-yy");
        String dat  =sdf.format(da);
        System.out.println("Date with time stamp-->"+dat);
/*

         Calendar cal = Calendar.getInstance();
        DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy hh:mm");

        System.out.println("Current date"+dateFormat.format(cal.getTime()));

        cal.add(Calendar.DATE, -7);

        String date =   dateFormat.format(cal.getTime());

         System.out.println("Last Week date"+date);

         String moduleDetails[][]   =   null;
            String memberDetails[][]   =   null;

            String modDet   =   getModuleDetails("10596");

             // Getting All the Active Projects
//            moduleDetails=Test.getProjectStatus();


        String r ="70-17";
        String issueDetails ="70-17";
        String openIssue       =   issueDetails.substring(issueDetails.indexOf("-")+1,issueDetails.length());
        String closedIssue     =   issueDetails.substring(0,issueDetails.indexOf("-"));
        System.out.println(openIssue);
        System.out.println(closedIssue);
        

        r=r.replaceAll("\\s","");
        //System.out.println(r.toLowerCase());
		InetAddress addy=null;
		try{
			addy = InetAddress.getByName("192.168.1.250");
		}catch(Exception e){
			e.printStackTrace();
		}
		for (int i = 0; i < 4; i++) {
			System.out.println(ping(addy));
			Thread.sleep(1000); 
		}
//		java.net.InetAddress localHost = java.net.InetAddress.getLocalHost();
/*		for (int i=0; i<4; i++) {
			long start = System.currentTimeMillis(); 
			boolean areYouThere = localHost.isReachable(1000); 
			long end = System.currentTimeMillis();
			long result = end - start;
			System.out.println("areYouThere = " + (areYouThere == true) + " " + result);
			}

		
		java.net.InetAddress localHost = java.net.InetAddress.getByName("192.168.1.36");
		boolean areYouThere = localHost.isReachable(10000); 
		System.out.println("System Available"+areYouThere);
		String name="virtual consulting Pvt Ltd";
		System.out.println("Length"+name.length());
	
          Connection connection = null;
        ResultSet projectStatusRS = null;
        PreparedStatement projectStatusPS = null;
        
		 try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

           connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");
            projectStatusPS = connection.prepareStatement("select to_date(to_char(sysdate,'DD-Mon-YY'),'DD-Mon-YY') as today from dual",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            projectStatusRS = projectStatusPS.executeQuery();
           while(projectStatusRS.next()){
                Date date    =   projectStatusRS.getDate(1);
                System.out.println("Sys Date"+date);
            }

        String tim  =   "10072"+":"+"eTracker v2.9.5"+":"+"Yes";
        System.out.println(tim.substring(0, tim.indexOf(":")));
        System.out.println(tim.substring(tim.indexOf(":")+1,tim.lastIndexOf(":")+10));
        System.out.println(tim.substring(tim.lastIndexOf(":")+1,tim.length()));

          
        } catch (Exception s) {
         
           System.out.println("Exception    "+ s.toString());
              SendMail.InformExceptions(s.toString());
            String k    =   s.toString();
            
        }
                finally {
            try {
                if (projectStatusRS != null) {
                    projectStatusRS.close();
                }
                if (projectStatusPS != null) {
                    projectStatusPS.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                System.out.println("Error while getting Project Members"+ ex);
             

            }

	}
        */
            
            String period = "3-2008*2-2012";
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


                        String periodm     =   startMonth+"-"+enMonth+"-"+endYear;
                        System.out.println("Period Start Date"+periodm);
                         String newMonth      =   periodm.substring(periodm.indexOf("-")+1, periodm.lastIndexOf("-"));
                         String stYear      =   periodm.substring(periodm.lastIndexOf("-")+1, periodm.length());
                          System.out.println(" Start Month"+newMonth);
                           System.out.println("Start Year"+stYear);
//                           new line
}
}