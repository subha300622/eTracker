<%-- 
    Document   : listMonthlyCTC
    Created on : 27 May, 2010, 9:18:15 AM
    Author     : ADAL
--%>

<%@page  import="com.pack.*,com.eminent.tqm.TqmCtcm,com.eminent.tqm.TqmUtil, com.eminent.tqm.TqmIssuetestcases, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%


        session.setAttribute("forwardpage","/admin/tqm/listPTC.jsp");



	//Configuring log4j properties
	
	Logger logger = Logger.getLogger("List CTC");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		//response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
	}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/header.jsp"%>
<%!
		String start,end;
		int i,year,month;

		private static HashMap<Integer,String> monthSelect = new HashMap<Integer,String>();

	    static{

	    monthSelect.put(0,"Jan");
	    monthSelect.put(1,"Feb");
	    monthSelect.put(2,"Mar");
	    monthSelect.put(3,"Apr");
	    monthSelect.put(4,"May");
	    monthSelect.put(5,"Jun");
	    monthSelect.put(6,"Jul");
	    monthSelect.put(7,"Aug");
	    monthSelect.put(8,"Sep");
	    monthSelect.put(9,"Oct");
	    monthSelect.put(10,"Nov");
	    monthSelect.put(11,"Dec");

	}
	%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
         <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
<script>
    function monthSelection(){

        var date=1;
        var startMonth=1;
        var startYear =2010;

        var startRange = new Date(startYear,startMonth,date);

        var month   =   document.getElementById("month").value;
        var year    =   document.getElementById("year").value;
        var selectedValue= new Date(year,month,date);
        var current_date = new Date();
        if(selectedValue>=startRange &&selectedValue<=current_date ){
            document.getElementById('button').value = 'Processing';
            document.getElementById('button').disabled = true;
            location = 'listMonthlyCTC.jsp?month='+month+'&year='+year;
        }else{
            alert("You can view your CTC from Feb 2010 to Current Month");
        }
    }


</script>
    </head>
    <body>
        
 <%
            try{
                //calculating start and end date of this month
		Calendar cal = new GregorianCalendar();
                int currentYear  = cal.get(Calendar.YEAR);
                int currentMonth = cal.get(Calendar.MONTH);
                int currentDay   = cal.get(Calendar.DAY_OF_MONTH);

                String selectYear = request.getParameter("year");
                String selectMonth = request.getParameter("month");
        //        logger.info("Selected Year"+selectYear);
        //        logger.info("Selected Month"+selectMonth);
                 year=0;
                 month=0;
                int maxday=30;
                if(selectYear==null || selectYear.equals("")){
                         year = currentYear;
                         month = cal.get(Calendar.MONTH);
                         maxday=cal.get(Calendar.DAY_OF_MONTH);
                }else{
                    year =Integer.parseInt(selectYear);
                    month=Integer.parseInt(selectMonth);

                     Calendar cale=Calendar.getInstance();
                     cale.set(year, month, 1);
                     maxday = cale.getActualMaximum(Calendar.DATE);
                }
         //       logger.info("Year"+year);
         //       logger.info("Month"+monthSelect.get(month));

         //       logger.info("MAX DAY of MOnth"+maxday);
                start="1"+"-"+monthSelect.get(month)+"-"+year;
                end=maxday+"-"+monthSelect.get(month)+"-"+year;

                String selectedStartDate = "01-"+(month+1)+"-"+year+" 00:00:00";
                String selectedEndDate = maxday+"-"+(month+1)+"-"+year+" 23:59:59";


                List l =TqmUtil.listMonthlyCTC(start, end);
                int noOfRecords =   l.size();
                %>
 <table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#C3D9FF">
		<td align="left"><b> Common Test Cases</b>

                <select name="month" id="month">
                         <%

                            for(int k=0;k<monthSelect.size();k++){
                                    if(k==month){
                                     %>
                                     <option value='<%=k%>' selected><%=monthSelect.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=k%>'><%=monthSelect.get(k)%></option>
                                     <%
                                    }

                                }
%>

                    </select>

                    <%
                        ArrayList<Integer> selectYears=new ArrayList<Integer>();
                        int startYear = 2010;

                        while(startYear<=currentYear){
                            selectYears.add(startYear);
                            startYear++;
                        }
                    %>

                    <select name='year' id='year' >
                        <%
                        for(int k=0,selected=2010;k<selectYears.size();k++,selected++){
                                    if(selected==year){
                                     %>
                                     <option value='<%=selectYears.get(k)%>' selected><%=selectYears.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=selectYears.get(k)%>'><%=selectYears.get(k)%></option>
                                     <%
                                    }

                                }

                       %>
                    </select>
                    <input type="button" id="button" value="Submit" onclick="monthSelection()"></td>
                </td>

	</tr>

        </table>
     
                <br>
<table width="100%">

	<tr height="10">
		<td align="left" width="80%">This list shows <b> <%=noOfRecords %></b> Common Test  created in the month of <b><%=monthSelect.get(month)%> <%=year%></b>.</td>
     <!--           <td align="right"><a href="createPTC.jsp">Create Test Case</a></td> -->
	</tr>
</table>
<br>
<table width="100%">

    <tr bgcolor="#C3D9FF" width="100%">
        <td width="8%"><b>TestCaseId</b></td>

        <td width="20%"><b>Functionality</b></td>
        <td width="22%"><b>Description</b></td>
        <td width="20%"><b>Expected Result</b></td>

    </tr>
    <%
    int k=1;
     for (Iterator i = l.iterator(); i.hasNext();k++ ) {
            TqmCtcm t =(TqmCtcm)i.next();
            String ctcid     =   t.getCtcid();
            String func      =   t.getFunctionality();
            String desc      =   t.getDescription();
            String reslt     =   t.getExpectedresult();


%>
   <%
                if(( k % 2 ) != 0)
                {
%>
	<tr bgcolor="white" height="22">
		<%
                }
                else
                {
%>

	<tr bgcolor="#E8EEF7" height="22">
		<%
                }
%>
<td><a href="viewCTC.jsp?ctcID=<%=ctcid%>"><%=ctcid%></a></td>

        <td title="<%=StringUtil.encodeHtmlTag(func)%>"><%=StringUtil.encodeHtmlTag(func)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(desc)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(reslt)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>

    </tr>



               <%
                }
                }
            catch(Exception e){
                logger.error(e.getMessage());
                }
%>
    </table>
    </body>
</html>

