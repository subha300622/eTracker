<%-- 
    Document   : requestedAttendance
    Created on : 22 May, 2015, 2:54:06 PM
    Author     : EMINENT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href='<%=request.getContextPath()%>/css/fullcalendar.css?test=4' rel='stylesheet' />
        <link href='<%=request.getContextPath()%>/css/fullcalendar.print.css' rel='stylesheet' media='print' />

    </head>
    <body>
        <div id='usercalendar'></div>
        <input type="hidden" name="user" id="reqUserId" value="<%=request.getParameter("userId")%>" />
    </body>
    <script src='<%=request.getContextPath()%>/javaScript/moment.min.js'></script>

    <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
    <script src='<%=request.getContextPath()%>/javaScript//fullcalendar.min.js'></script>
    <script type="text/javascript">
        $('#usercalendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
            },
            editable: false,
            eventLimit: true, // allow "more" link when too many events
            events: '<%=request.getContextPath()%>/UserProfile/userAttJson.jsp?month=<%=request.getParameter("month")%>&year=<%=request.getParameter("year")%>&userId=' + $('#reqUserId').val() + '&rand=' + Math.random(1, 10),
            eventMouseover: function(calEvent, jsEvent) {
                var tooltip = '<div class="tooltipevent" style="width:100px;height:90px;background:#FFF;position:absolute;z-index:10001;padding:10px;border :1px solid #CCC;border-radius:10px;">' + calEvent.title + '</div>';
                $("body").append(tooltip);
                $(this).mouseover(function(e) {
                    $(this).css('z-index', 10000);
                    $('.tooltipevent').fadeIn('500');
                    $('.tooltipevent').fadeTo('10', 1.9);
                }).mousemove(function(e) {
                    $('.tooltipevent').css('top', e.pageY + 10);
                    $('.tooltipevent').css('left', e.pageX + 20);
                });
            },
            eventMouseout: function(calEvent, jsEvent) {
                $(this).css('z-index', 8);
                $('.tooltipevent').remove();
            },
            eventRender: function(event, element) {
                element.find('span.fc-title').html(element.find('span.fc-title').text());
            },
        });
            $('#usercalendar').fullCalendar('gotoDate', new Date(<%=request.getParameter("year")%>,<%=request.getParameter("month")%>, 1));
        $.noConflict();
    </script>
</html>
