<%-- 
    Document   : summary
    Created on : 27 May, 2016, 10:57:49 AM
    Author     : EMINENT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <jsp:useBean id="vmc" class="com.eminentlabs.mom.controller.ViewMomController"></jsp:useBean>

        <%vmc.updateSummaryCount(request);
            if (vmc.getMomDate().compareTo(vmc.getCurrentDate()) == 0) {
        
        %>

        <table style="width: 100%;"><tr>
                <td style="width:10%;"></td>
                <td colspan="3"><table style="width: 100%;" >

                        <tr>
                            <td style="width: 4%;">

                            </td>
                            <td style="width: 32%;">
                                <table style="width: 100%;border-collapse: collapse;" class="momp">
                                    <tr style="font-weight: bold;">
                                        <td>WRM</td>
                                        <td title="WRM with Customers">WWC</td>
                                        <td title="WRM with  Us">WWU</td>
                                        <td title="WRM Planned">WP</td>
                                        <td title="Non WRM Planned">NWP</td>
                                        <td >Closed</td>
                                        <td title="With Customer">WC</td>
                                        <td title="Not with Customer">NWC </td>
                                        <td title="Un Touched">UT</td>
                                        <td title="Adhoc">Adhoc</td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td><a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp?pid=<%=vmc.getProjectId()%>" style="cursor: pointer;color: white; "><%=vmc.getPreviousDaySummationFormbean().getWrmCount()%></a></td>
                                        <td><%=vmc.getPreviousDaySummationFormbean().getWrmWithCustomers()%></span></td>
                                        <td><%=vmc.getPreviousDaySummationFormbean().getWrmWithUs()%></td>
                                        <td><%=vmc.getPreviousDaySummationFormbean().getWrmPlanned()%></td>
                                        <td><%=vmc.getPreviousDaySummationFormbean().getNonWrmPlanned()%></td>
                                        <td><%=vmc.getPreviousDaySummationFormbean().getClosed()%></td>
                                        <td><%=vmc.getPreviousDaySummationFormbean().getWithCustomer()%></td>
                                        <td><%=vmc.getPreviousDaySummationFormbean().getNotWithCustomer()%></td>
                                        <td><span class='issuedisplay' summaryType='NWC' summaryTableType='P' style="cursor: pointer;"><%=vmc.getPreviousDaySummationFormbean().getNotUpdated()%></span></td>
                                        <td title="Adhoc"><%=vmc.getPreviousDaySummationFormbean().getAdhoc()%></td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width: 32%;">
                                <table style="width: 100%;border-collapse: collapse;" class="momc"  >
                                    <tr style="font-weight: bold;">
                                        <td >WRM</td>
                                        <td title="WRM with Customers">WWC</td>
                                        <td title="WRM with  Us">WWU</td>
                                        <td title="WRM Planned">WP</td>
                                        <td title="Non WRM Planned">NWP</td>
                                        <td >Closed</td>
                                        <td title="With Customer">WC</td>
                                        <td title="Not with Customer">NWC </td>
                                        <td title="Un Touched">UT</td>
                                        <td title="Adhoc">Adhoc</td>
                                    </tr>
                                    <tr style="text-align: center;text-decoration: underline;">
                                        <td><a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp?pid=<%=vmc.getProjectId()%>" style="cursor: pointer;color: white; "><%=vmc.getMomDaySummationFormbean().getWrmCount()%></a></td>
                                        <td title="WRM with Customers"><span heading="WRM with Customers" class='issuedisplay' summaryType='WWC' teamType="<%=vmc.getKeys()%>" summaryTableType='C' pid='<%=vmc.getProjectId()%>' style="cursor: pointer;"  ><%=vmc.getMomDaySummationFormbean().getWrmWithCustomers()%></span></td>
                                        <td title="WRM with  Us"><span heading="WRM with  Us" class='issuedisplay' summaryType='WWU' teamType="<%=vmc.getKeys()%>" summaryTableType='C' pid='<%=vmc.getProjectId()%>' style="cursor: pointer;"> <%=vmc.getMomDaySummationFormbean().getWrmWithUs()%></span></td>
                                        <td title="WRM Planned"><span heading="WRM Planned" class='issuedisplay' summaryType='WP' teamType="<%=vmc.getKeys()%>" summaryTableType='C' pid='<%=vmc.getProjectId()%>' style="cursor: pointer;"><%=vmc.getMomDaySummationFormbean().getWrmPlanned()%></span></td>
                                        <td title="Non WRM Planned"><span heading="Non WRM Planned" class='issuedisplay' summaryType='NWP' teamType="<%=vmc.getKeys()%>" summaryTableType='C' pid='<%=vmc.getProjectId()%>' style="cursor: pointer;"><%=vmc.getMomDaySummationFormbean().getNonWrmPlanned()%></span></td>
                                        <td><span heading="Closed" class='issuedisplay' summaryType='Closed' teamType="<%=vmc.getKeys()%>" summaryTableType='C' pid='<%=vmc.getProjectId()%>' style="cursor: pointer;" ><%=vmc.getMomDaySummationFormbean().getClosed()%></span></td>
                                        <td title="With Customer"><span heading="With Customer" class='issuedisplay' summaryType='WC' teamType="<%=vmc.getKeys()%>" summaryTableType='C' pid='<%=vmc.getProjectId()%>' style="cursor: pointer;"><%=vmc.getMomDaySummationFormbean().getWithCustomer()%></span></td>
                                        <td title="Not with Customer"><span heading="Not with Customer" class='issuedisplay' summaryType='NWC' teamType="<%=vmc.getKeys()%>" summaryTableType='C' pid='<%=vmc.getProjectId()%>' style="cursor: pointer;"><%=vmc.getMomDaySummationFormbean().getNotWithCustomer()%></span></td>
                                        <td title="Un Touched"><span heading="Un Touched" class='issuedisplay' summaryType='UT' teamType="<%=vmc.getKeys()%>" summaryTableType='C' pid='<%=vmc.getProjectId()%>' style="cursor: pointer;"><%=vmc.getMomDaySummationFormbean().getNotUpdated()%></span></td>
                                        <td title="Adhoc"><span heading="Adhoc" class='issuedisplay' summaryType='Adhoc' teamType="<%=vmc.getKeys()%>" summaryTableType='C' pid='<%=vmc.getProjectId()%>' style="cursor: pointer;"><%=vmc.getMomDaySummationFormbean().getAdhoc()%></span></td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width: 32%;"><table style="width: 100%;border-collapse: collapse;" class="momn"  >
                                    <tr style="font-weight: bold;background-color: ">
                                        <td >WRM</td>
                                        <td title="WRM with Customers">WWC</td>
                                        <td title="WRM with  Us">WWU</td>
                                        <td title="WRM Planned">WP</td>
                                        <td title="Non WRM Planned">NWP</td>
                                        <td >Closed</td>
                                        <td title="With Customer">WC</td>
                                        <td title="Not with Customer">NWC </td>
                                        <td title="Un Touched">UT</td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td><a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp?pid=<%=vmc.getProjectId()%>" style="cursor: pointer;color: white; "><%=vmc.getNextDaySummationFormbean().getWrmCount()%></a></td>
                                        <td><%=vmc.getNextDaySummationFormbean().getWrmWithCustomers()%></td>
                                        <td><%=vmc.getNextDaySummationFormbean().getWrmWithUs()%></td>
                                        <td><%=vmc.getNextDaySummationFormbean().getWrmPlanned()%></td>
                                        <td><%=vmc.getNextDaySummationFormbean().getNonWrmPlanned()%></td>
                                        <td><%=vmc.getNextDaySummationFormbean().getClosed()%></td>
                                        <td><%=vmc.getNextDaySummationFormbean().getWithCustomer()%></td>
                                        <td><%=vmc.getNextDaySummationFormbean().getNotWithCustomer()%></td>
                                        <td><%=vmc.getNextDaySummationFormbean().getNotUpdated()%></td>
                                    <input type='hidden' value='<%=vmc.getNextDaySummationFormbean().getAdhoc()%>'>
                                    </tr>
                                </table></td>
                        </tr></table></td>
            </tr></table>
            <%}%>
    
