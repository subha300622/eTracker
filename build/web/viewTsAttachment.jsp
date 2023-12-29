<%-- 
    Document   : viewTsAttachment
    Created on : 28 Sep, 2015, 4:51:26 PM
    Author     : EMINENT
--%>

<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminent.issue.ApmTsAttachment"%>
<%@page import="com.eminent.util.GetProjects"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="java.util.List"%>
<%@page import="com.eminent.issue.ApmModuleAttachment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="amac" class="com.eminent.issue.controller.ApmTestStepAttachmentController"></jsp:useBean>
    <html>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">


    </head>
<%
     String tsId = request.getParameter("tsId");
      long tscId = MoMUtil.parseLong(tsId, 0l);
    List<ApmTsAttachment> list = amac.viewDocuments(tscId);
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
  %>
<body>
    <table style="width: 100%;" class="tablesorter" id="documentTable">
        <thead style="height: 26px;font-weight: bold;color:#000;background-color: #C3D9FE;">
        <th>Attached On</th>
        <th class="filter-select filter-match" data-placeholder="All">Owner</th>
        <th>File Name</th>
    </thead>
    <%int i = 0;
        for (ApmTsAttachment apmModuleAttachment : list) {
            if (i % 2 == 0) {%>
    <tr class="zebralinealter" style="height: 21px;">    
        <%} else {%>
    <tr class="zebraline" style="height: 21px;background-color: #E8EEF7;">
        <%}
            i++;%>
        <td class="background"><%=sdf.format(apmModuleAttachment.getAttacheddate())%></td>
        <td class="background"><%=GetProjectManager.getUserName(apmModuleAttachment.getOwner())%></td>
        <td class="background"><a href="Etracker_AttachedFiles/<%=apmModuleAttachment.getFilename()%>" target="_blank"><%=apmModuleAttachment.getFilename()%></a></td>
    </tr>
    <%}%>
</table>
</body>
<script type="text/javascript">
    $(document).ready(function ()
    {



        // call the tablesorter plugin
        $(".tablesorter").tablesorter({
            theme: 'blue',
            // hidden filter input/selects will resize the columns, so try to minimize the change
            widthFixed: true,
            // initialize zebra striping and filter widgets
            widgets: ["zebra", "filter"],

            widgetOptions: {
                // extra css class applied to the table row containing the filters & the inputs within that row
                filter_cssFilter: 'tablesorter-filter',
                // If there are child rows in the table (rows with class name from "cssChildRow" option)
                // and this option is true and a match is found anywhere in the child row, then it will make that row
                // visible; default is false
                filter_childRows: false,
                // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                filter_hideFilters: false,
                // Set this option to false to make the searches case sensitive
                filter_ignoreCase: true,
                // jQuery selector string of an element used to reset the filters
                filter_reset: '.reset',
                // Use the $.tablesorter.storage utility to save the most recent filters
                filter_saveFilters: false,
                // Delay in milliseconds before the filter widget starts searching; This option prevents searching for
                // every character while typing and should make searching large tables faster.
                filter_searchDelay: 300,
                // Set this option to true to use the filter to find text from the start of the column
                // So typing in "a" will find "albert" but not "frank", both have a's; default is false
                filter_startsWith: false,
                // if false, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                // Add select box to 4th column (zero-based index)
                // each option has an associated function that returns a boolean
                // function variables:
                // e = exact text from cell
                // n = normalized value returned by the column parser
                // f = search filter input value
                // i = column index
                filter_functions: {
                },
                filter_formatter: {
                    8: function ($cell, indx) {
                        return $.tablesorter.filterFormatter.select2($cell, indx, {
                            match: false // exact match only
                        });
                    }
                }
            }

        });
    });
</script>


</html>