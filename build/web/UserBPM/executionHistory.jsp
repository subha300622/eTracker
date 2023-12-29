<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.eminent.tqm.IssueTestCaseUtil,com.eminent.tqm.TqmTestcaseresult,com.eminent.tqm.TqmTestcaseexecutionresult,java.math.BigDecimal,com.eminent.tqm.TestCasePlan,java.sql.Timestamp,java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmTestcaseresult, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%@page import="com.pack.StringUtil" %>


<%Logger logger = Logger.getLogger("executionHistory");
                        String ptcID    =   request.getParameter("ptcId");

                        List total     =   TestCasePlan.getResults(ptcID);

                        int noOfPlan    =   total.size();
                          int k=1;
                        try{

                            %>
                            
                            <table style="width:100%;border: 1px solid gray;">

                                <tr style="width:100%;">
                                    <th width="8%">Executed By</th>
                                    <th width="10%">Executed On</th>
                                    <th width="50%">Execution Comments</th>
                                    <th width="10%">Status</th>

                                </tr>
                            <%
                           if(noOfPlan>0){
                            TqmTestcaseresult issue =   null;
                            HashMap statusMap   =   TestCasePlan.getTescaseStatus();


                            Iterator iter = total.iterator();
                            while(iter.hasNext()){
                                List result       =  null;
                                Object[] obj      = (Object[]) iter.next();
                                int tceId         =  ((BigDecimal)obj[0]).intValue();
                                int tepId         =  ((BigDecimal)obj[1]).intValue();
                                String planName   =  ((String)obj[2]);

                                result    =   TestCasePlan.getExecutionResult(ptcID, ((Integer)tceId).toString());
                                int size       =    result.size();

                            %>



                            <tr style="width:100%;" bgcolor="#C3D9FF">
                                    <td width="10%"><b>Test Plan Name</b></td>
                                    <td width="90%" colspan="3"><b><%=planName%></b></td>


                                </tr>
                                                    <%
                              k=1;
                             TqmTestcaseexecutionresult t = null;
     for (Iterator i = result.iterator(); i.hasNext();k++ ) {
            t =(TqmTestcaseexecutionresult)i.next();
            String comments     =   t.getComments();
            String status       =   (String)statusMap.get(t.getStatusid());
            Date stamp     =   t.getCommentedon();
            String commentedby  =   GetProjectManager.getUserName(t.getCommentedby());
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
            String commentedOn  =   sdf.format(stamp);

%>
   <%
                String color    =   "white";
                if(( k % 2 ) != 0)
                {
                    color    =   "white";
                }
                else
                {
                    color    =   "#E8EEF7";
                }
%>
        <tr bgcolor="<%=color%>" style="height:22px;">
        <td><%=commentedby%></td>
        <td><%=commentedOn%></td>
        <td><%=comments%></td>
        <td><%=status%></td>

        </tr>
    <tr>
		<td colspan="4" align="center">-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
    </tr>
<%
}
 }
 }
if(noOfPlan<1){
    %>
    <tr><td colspan="4">No Comments available for this Test Case</td></tr>
    <%
    }


                        }catch(Exception e){
                            logger.error(e.getMessage());
                        }
%>
           </table>



