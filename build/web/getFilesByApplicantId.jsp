<%-- 
    Document   : validateReplaceSerialNo
    Created on : 16 Mar, 2015, 10:55:13 AM
    Author     : Muthu
--%>

<%@page import="com.eminent.issue.formbean.FileAttachBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
<jsp:useBean id="re" class="com.eminentlabs.erm.ERMAttachFileController"></jsp:useBean>
<%

    String applicantId = request.getParameter("applicantId");
    List<FileAttachBean> fileList = re.getFilesByApplicantId(applicantId);
%>

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <STYLE>
        div#IssuePopupFiles {
            overflow-y: scroll;
            height: 356px;
        }
    </style>
</head>
<body>
    <table style=" " class="fileAttachTable" >
        <thead style="height: 26px;font-weight: bold;color:#000;background-color: #C3D9FE;">
        <th>Attached On</th>
        <th class="filter-select filter-match" data-placeholder="All">Owner</th>
        <th>File Name</th>

    </thead>
    <%int i = 0;
        for (FileAttachBean attch : fileList) {
            if (i % 2 == 0) {%>
    <tr class="zebralinealter" style="height: 21px;">    
        <%} else {%>
    <tr class="zebraline" style="height: 21px;background-color: #E8EEF7;">
        <%}
                i++;%>
        <td class="background"><%=attch.getDate()%></td>
        <td class="background"><%=attch.getOwner()%></td>
        <td class="background"><a href="<%=request.getContextPath()%>/Etracker_AttachedFiles/ERMAttachFile/<%=attch.getFileName()%>" target="_blank"><%=attch.getFileName()%></a></td>
    </tr>
    <%}%>
</table>

</body>
<script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=4">
<script type="text/javascript">

    $(document).ready(function ()
    {



        // call the tablesorter plugin
        $(".fileAttachTable").tablesorter({
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

            }

        });
    });
</script>



</html>