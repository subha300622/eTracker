<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%
String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
</head>
<body>
<!-- Java Package Import Declarations -->
<%@ page import="java.sql.*,java.util.ArrayList,pack.eminent.encryption.*,com.eminent.util.UpdateUserProject,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers"%>
<!-- Notifying JSP to use AdminBean Class in the Package Named com.pack -->
<jsp:useBean id="getConnect" class="com.pack.AdminBean">
	<jsp:setProperty name="getConnect" property="*" />
</jsp:useBean>
<%Logger logger = Logger.getLogger("newproject");
		Connection  connection = null;
                PreparedStatement ps = null;
		PreparedStatement ps1=null,phaseDate = null;
                Statement seqStatement  =   null;
                ResultSet seqResultSet  =   null;
		try  
		{
			//connection = getConnect.ConnectToDatabase();
			String category = request.getParameter("category").trim();
			String dname = request.getParameter("pname").trim();
			connection=MakeConnection.getConnection();
			String version = request.getParameter("versionInfo").trim();
			String platform = request.getParameter("platform").trim();
                        
			String platforms = request.getParameter("platforms");
                        if(platform.equalsIgnoreCase("Others")) {
                           platforms = platforms.trim(); 
                        }
			String manager = request.getParameter("projectManager").trim();
                        String dmanager = request.getParameter("deliveryManager").trim();
                        String amanager = request.getParameter("accountManager").trim();
                        String sponsorer = request.getParameter("executiveSponsorer").trim();
                        String stakeholder = request.getParameter("projectStakeholder").trim();
                        String coordinator = request.getParameter("projectCoordinator").trim();

                      
                        int spon     =   Integer.parseInt(sponsorer);
                        int stkh     =   Integer.parseInt(stakeholder);
                        int coor     =   Integer.parseInt(coordinator);
                        int amng     =   Integer.parseInt(amanager);
                        int dmng     =   Integer.parseInt(dmanager);

                        ArrayList al    =   new ArrayList<Integer>();

                        if(!al.contains(spon)){
                            al.add(spon);
                        }
                        if(!al.contains(stkh)){
                            al.add(stkh);
                        }
                        if(!al.contains(coor)){
                            al.add(coor);
                        }
                        if(!al.contains(amng)){
                            al.add(amng);
                        }
                        if(!al.contains(dmng)){
                            al.add(dmng);
                        }

                                              
			String customer = request.getParameter("customer").trim();
                        String startdate = request.getParameter("startdate").trim();
                        String enddate = request.getParameter("enddate").trim();
                        String totalhours=request.getParameter("totalhours").trim();
                        String phase = request.getParameter("phase").trim();
			String platforms1="";
			if (platform.equals("Others"))
				platforms1=platforms;
			else
				platforms1=platform;
                        
                    if(connection != null)  {
					
                    //If the Project is not in DB Get Input Values from Previous page
					
                    int projectid=getConnect.CreateNewProject(connection,dname);

                    GetProjectMembers.EmailAlerts(al,projectid);
//                    UpdateUserProject.UpdateUsers(((Integer)projectid).toString(), manager);
                    
//                  String projectids=projectid+"";
                    session.setAttribute("projectid",new Integer(projectid));
                    String[] selected = request.getParameterValues("teamFinal");
                        if (selected!=null)
                        {
                            int[] selectedmembers=new int[selected.length];
                            for(int i=0;i<selected.length;i++)
                            {
                            try
                            {
				selectedmembers[i]=Integer.parseInt(selected[i]);
                                ps=connection.prepareStatement("insert into userproject(pid,userid) values(?,?)");
                                ps.setInt(1,projectid);
                                ps.setInt(2,selectedmembers[i]);
                                ps.executeUpdate();
								
							}catch(Exception e)
                            {
								logger.error(e.getMessage());    
                            }
							}
						}
						if (category.equals("SAP Project"))
						{
							try
							{
								String projecttype ="";
								projecttype =request.getParameter("projecttype");
								ps1=connection.prepareStatement("insert into project_type(pid,type) values(?,?)");
								ps1.setInt(1,projectid);
								ps1.setString(2,projecttype);
								ps1.executeUpdate();
                                                                seqStatement = connection.createStatement();
                                                                
                                                                int nextValue = 0;
                                                                
                                                                if(projecttype.equalsIgnoreCase("Implementation")||projecttype=="Implementation"){
                                                                    String firststartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("impstartdate1"));
                                                                    String firstenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("impenddate1"));
                                                                    String firstPhase        =   request.getParameter("firstPhase");
                                                                    String firstTotalhours        =   request.getParameter("imptotalhours1");
                                                                    String secondstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("impstartdate2"));
                                                                    String secondenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("impenddate2"));
                                                                    String secondPhase        =   request.getParameter("secondPhase");
                                                                    String secondTotalhours        =   request.getParameter("imptotalhours2");
                                                                    String thirdstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("impstartdate3"));
                                                                    String thirdenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("impenddate3"));
                                                                    String thirdPhase        =   request.getParameter("thirdPhase");
                                                                    String thirdTotalhours        =   request.getParameter("imptotalhours3");
                                                                    String fourthstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("impstartdate4"));
                                                                    String fourthenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("impenddate4"));
                                                                    String fourthPhase        =   request.getParameter("fourthPhase");
                                                                    String fourthTotalhours        =   request.getParameter("imptotalhours4");
                                                                    String fifthstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("impstartdate5"));
                                                                    String fifthenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("impenddate5"));
                                                                    String fifthPhase        =   request.getParameter("fifthPhase");
                                                                    String fifthTotalhours        =   request.getParameter("imptotalhours5");
                                                                    phaseDate   =   connection.prepareStatement("insert into apm_phasedate(dateid,pid,phase,plannedstartdate,plannedenddate,totalhours) values(?,?,?,?,?,?)");

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,firstPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(firststartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(firstenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(firstTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,secondPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(secondstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(secondenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(secondTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,thirdPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(thirdstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(thirdenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(thirdTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,fourthPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(fourthstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(fourthenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(fourthTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,fifthPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(fifthstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(fifthenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(fifthTotalhours));
                                                                    phaseDate.addBatch();

                                                                   phaseDate.executeBatch();
                                                                   GetProjects.updateStartPhasedate(projectid, firstPhase);
                                                                }
                                                                if(projecttype.equalsIgnoreCase("Upgradation")||projecttype=="Upgradation"){
                                                                    String firststartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("upgstartdate1"));
                                                                    String firstenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("upgenddate1"));
                                                                    String firstPhase        =   request.getParameter("upgfirstPhase");
                                                                    String firstTotalhours        =   request.getParameter("upgtotalhours1");
                                                                    String secondstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("upgstartdate2"));
                                                                    String secondenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("upgenddate2"));
                                                                    String secondPhase        =   request.getParameter("upgsecondPhase");
                                                                    String secondTotalhours        =   request.getParameter("upgtotalhours2");
                                                                    String thirdstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("upgstartdate3"));
                                                                    String thirdenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("upgenddate3"));
                                                                    String thirdPhase        =   request.getParameter("upgthirdPhase");
                                                                    String thirdTotalhours        =   request.getParameter("upgtotalhours3");
                                                                    String fourthstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("upgstartdate4"));
                                                                    String fourthenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("upgenddate4"));
                                                                    String fourthPhase        =   request.getParameter("upgfourtPhase");
                                                                    String fourthTotalhours        =   request.getParameter("upgtotalhours4");
                                                                    String fifthstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("upgstartdate5"));
                                                                    String fifthenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("upgenddate5"));
                                                                    String fifthPhase        =   request.getParameter("upgfifthPhase");
                                                                    String fifthTotalhours        =   request.getParameter("upgtotalhours5");
                                                                    phaseDate   =   connection.prepareStatement("insert into apm_phasedate(dateid,pid,phase,startdate,enddate,totalhours) values(?,?,?,?,?,?)");

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,firstPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(firststartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(firstenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(firstTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,secondPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(secondstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(secondenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(secondTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,thirdPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(thirdstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(thirdenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(thirdTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,fourthPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(fourthstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(fourthenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(fourthTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,fifthPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(fifthstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(fifthenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(fifthTotalhours));
                                                                    phaseDate.addBatch();

                                                                   phaseDate.executeBatch();
                                                                   GetProjects.updateStartPhasedate(projectid, firstPhase);
                                                                }
                                                                if(projecttype.equalsIgnoreCase("Support")||projecttype=="Support"){
                                                                    String firststartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("supstartdate1"));
                                                                    String firstenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("supenddate1"));
                                                                    String firstPhase        =   request.getParameter("supfirstPhase");
                                                                    String firstTotalhours        =   request.getParameter("suptotalhours1");
                                                                    String secondstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("supstartdate2"));
                                                                    String secondenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("supenddate2"));
                                                                    String secondPhase        =   request.getParameter("supsecondPhase");
                                                                    String secondTotalhours        =   request.getParameter("suptotalhours2");
                                                                    String thirdstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("supstartdate3"));
                                                                    String thirdenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("supenddate3"));
                                                                    String thirdPhase        =   request.getParameter("supthirdPhase");
                                                                    String thirdTotalhours        =   request.getParameter("suptotalhours3");
                                                                    String fourthstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("supstartdate4"));
                                                                    String fourthenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("supenddate4"));
                                                                    String fourthPhase        =   request.getParameter("supfourtPhase");
                                                                    String fourthTotalhours        =   request.getParameter("suptotalhours4");
                                                                    String fifthstartdate    =   com.pack.ChangeFormat.getDateFormat(request.getParameter("supstartdate5"));
                                                                    String fifthenddate      =   com.pack.ChangeFormat.getDateFormat(request.getParameter("supenddate5"));
                                                                    String fifthPhase        =   request.getParameter("supfifthPhase");
                                                                    String fifthTotalhours        =   request.getParameter("suptotalhours5");
                                                                    phaseDate   =   connection.prepareStatement("insert into apm_phasedate(dateid,pid,phase,startdate,enddate,totalhours) values(?,?,?,?,?,?)");

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,firstPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(firststartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(firstenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(firstTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,secondPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(secondstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(secondenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(secondTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,thirdPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(thirdstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(thirdenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(thirdTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,fourthPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(fourthstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(fourthenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(fourthTotalhours));
                                                                    phaseDate.addBatch();

                                                                    seqResultSet = seqStatement.executeQuery("select PHASEDATE_SEQ.nextval as nextvalue from dual");
                                                                    seqResultSet.next();
                                                                    nextValue = seqResultSet.getInt("nextvalue");

                                                                    phaseDate.setInt(1,nextValue);
                                                                    phaseDate.setInt(2,projectid);
                                                                    phaseDate.setString(3,fifthPhase);
                                                                    phaseDate.setDate(4,java.sql.Date.valueOf(fifthstartdate));
                                                                    phaseDate.setDate(5,java.sql.Date.valueOf(fifthenddate));
                                                                    phaseDate.setInt(6, Integer.parseInt(fifthTotalhours));
                                                                    phaseDate.addBatch();

                                                                   phaseDate.executeBatch();
                                                                   GetProjects.updateStartPhasedate(projectid, firstPhase);
                                                                }
							}catch(Exception e)
							{
								logger.error(e.getMessage());
							}
                                                        finally{
                                                            if(seqResultSet!=null){
                                                                seqResultSet.close();
                                                            }
                                                            if(seqStatement!=null){
                                                                seqStatement.close();
                                                            }
                                                        }

						}
	%>
<!-- The User Input Values to create a Project are passed to the CreateNewProjectBean Using Jsp Property tag -->
<jsp:getProperty name="getConnect" property="pname" />
<jsp:getProperty name="getConnect" property="versionInfo" />
<jsp:getProperty name="getConnect" property="platform" />
<jsp:getProperty name="getConnect" property="platforms" />
<jsp:getProperty name="getConnect" property="projectManager" />
<jsp:getProperty name="getConnect" property="customer" />
<jsp:getProperty name="getConnect" property="startdate" />
<jsp:getProperty name="getConnect" property="enddate" />
<jsp:getProperty name="getConnect" property="totalhours" />
<jsp:getProperty name="getConnect" property="phase" />
<jsp:forward page="/admin/project/addmodules.jsp" />
<%               	
				}
			
		}
		//Handles Any Exception That Arises During Execution	
		catch(Exception ex)  {
			logger.error(ex.getMessage());
	    }finally
				{
					if (connection!=null)
					{
						connection.close();
					}
				}
	%>

</body>
</html>