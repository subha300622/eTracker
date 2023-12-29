<%-- 
    Document   : printTreeMap
    Created on : Mar 13, 2014, 11:11:41 AM
    Author     : E0288
--%>



<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="com.eminent.tqm.TqmTestcaseexecutionresult"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminent.tqm.TqmTestcaseresult"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.log4j.*,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers" %>
<%@page import="com.eminentlabs.userBPM.ViewBPM" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.LinkedHashMap" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator,dashboard.CheckCategory,dashboard.TestCases" %>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        
        <meta content="IE=EmulateIE8" http-equiv="X-UA-Compatible" >
        <title>eTracker&#0153; - Eminentlabs&#0153; CRM, BPM, APM, TQM, ERM and EPTS Solution</title>
       <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/bp.js?v=1.0" type="text/javascript"></script>
        
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>

       <style type="text/css">
           ul{list-style: none outside none;padding: 0;	margin: 0;margin-top: 4px;background-color: white;}
           ul li{padding: 3px 0px 3px 16px;margin: 0;}
           a{text-decoration: none;color: black;}
 
       </style>
       <script type="text/javascript">
    function callPrint(){       
    document.getElementById("print").style.display='none';
           window.print();
    }
       </script>
    </head>
    <%
                 String mail=(String)session.getAttribute("theName");
                 String url =   null;
                 if(mail!=null){
                    url=mail.substring(mail.indexOf("@")+1,mail.length());
                 }        
                String pid = request.getParameter("pid");
                Integer current_userId = (Integer) session.getAttribute("userid_curr");
       String userId= current_userId.toString();
        boolean projectAccess=false;
        int roleId  =   (Integer)session.getAttribute("Role");
        if(roleId!=1){
               projectAccess= GetProjectMembers.isAssigned(userId, pid);
        }else{
            projectAccess=true;
        }
        if(projectAccess== true){
                String project  =   GetProjects.getProjectName(pid);

%>
    <body>
        
        <table align="center" width="100%" cellpadding="0" cellspacing="0">
                        <tr style="height: 20px;">

                            <td width="145" align="left"><a
                                    href="https://www.eminentlabs.net" target="_new"><img border="0" height="28"
                                                                                     alt="Eminentlabs Software Pvt. Ltd."
                                                                                     src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
                            <td align="right">
                                <img alt="Eminentlabs Software Pvt Ltd" height="25" src="<%= request.getContextPath()%>/eminentech support files/Eminentlabs_logo.gif">
                            </td>
                        </tr>
                    </table>
                            <br/>
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr >
		<td border="1" align="left" width="80%">
                    <font size="4" COLOR="#0000FF"><b>View <%=GetProjects.getProject(Integer.parseInt(pid))%> Test Map Tree</b></font>
                </td><td id="print"><input type="button" name="print" value="Print"
                                                   onclick="javascript:callPrint()" /><input type="button"
                                                   name="Close" value="Close" onclick="javascript:window.close();" /></td>
	</tr>
</table>

        
        
                <div >
                    <input type="hidden" value="<%=pid%>" id="pid"/>
                    <input type="hidden" value="<%=project%>" id="pname"/>
                    <ul id="mainTree">
                <%
    String wholedata="";
    ArrayList<String> viewClient =  ViewBPM.getClient(Integer.parseInt(pid));
    HashMap modules              =  GetProjects.getModules(pid);
    int companyCount             =  ViewBPM.getCompanyCount(Integer.parseInt(pid));
    for( String clientName : viewClient) {
%>
<li id="client">
    <div class="treeclass treeExpand" onclick="javascript:viewCompany(<%=pid%>);"></div>
    <a href="#" onclick="javascript:viewCompany(<%=pid%>);"><b>Client: </b><%=clientName%> (<span id="ccount"><%=companyCount%></span>)</a>
    <span style='display:none;' onclick="javascript:editCompany(<%=pid%>);"><img style="position: relative;"src="<%=request.getContextPath()%>/images/edit.png"/></span>
    <%
        
        HashMap ncompanyMap =   ViewBPM.getCompany(Integer.parseInt(pid));
    LinkedHashMap ncompany=GetProjectMembers.sortHashMapByKeys(ncompanyMap,true);
    
    if(ncompany.size()>0){
        Collection set=ncompany.keySet();
        Iterator ite = set.iterator();
        int bpCount=0;
        int cmCount=0;
        while (ite.hasNext()) {
            
            String compName  =   "";
            String bpName  =   "";
            String mpName  =   "";
            String spName  =   "";
            String scName  =   "";
            String vtName  =   "";
            int key=(Integer)ite.next();
            bpCount  =   ViewBPM.getBPCount(key);
            String nameofcomp=(String)ncompany.get(key);
            if(cmCount==0){
                wholedata=wholedata="<ul class='tree'>";
            }
            if(bpCount==0){
                wholedata=wholedata+"<li id='c"+key+"' class='expandable'> <div class='treeclass' onclick='javascript:viewBP("+key+")'></div><a href='#'  onclick='javascript:viewBP("+key+");return false;' style='margin-left:0px;'><b>Company:</b><input type='hidden' id='cvalue"+key+"' value='"+nameofcomp+"'> <span id='cspan"+key+"'>"+nameofcomp +"</span> (<span id='bpcount"+key+"'>"+bpCount+"</span>) </a><span  onclick='javascript:editc("+key+");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span  id='deletec"+key+"' onclick='javascript:deleteCompany("+key+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span></li>";
                compName    =   compName+"<ul class='tree'><li id='c"+key+"' class='expandable'> <div class='treeclass' onclick='javascript:viewBP("+key+")'></div><a href='#'  onclick='javascript:viewBP("+key+");return false;' style='margin-left:0px;'><b>Company:</b><input type='hidden' id='cvalue"+key+"' value='"+nameofcomp+"'> <span id='cspan"+key+"'>"+nameofcomp +"</span> (<span id='bpcount"+key+"'>"+bpCount+"</span>) </a><span  onclick='javascript:editc("+key+");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span  id='deletec"+key+"' onclick='javascript:deleteCompany("+key+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span></li>";
            }else{
                wholedata=wholedata+"<li id='c"+key+"' class='expandable'> <div class='treeclass treeExpand' onclick='javascript:viewBP("+key+")'></div><a href='#'  onclick='javascript:viewBP("+key+");return false;' style='margin-left:0px;'><b>Company:</b><input type='hidden' id='cvalue"+key+"' value='"+nameofcomp+"'> <span id='cspan"+key+"'>"+nameofcomp +"</span> (<span id='bpcount"+key+"'>"+bpCount+"</span>) </a><span  onclick='javascript:editc("+key+");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span>";
                compName    =   compName+"<ul class='tree'><li id='c"+key+"' class='expandable'> <div class='treeclass' onclick='javascript:viewBP("+key+")'></div><a href='#'  onclick='javascript:viewBP("+key+");return false;' style='margin-left:0px;'><b>Company:</b><input type='hidden' id='cvalue"+key+"' value='"+nameofcomp+"'> <span id='cspan"+key+"'>"+nameofcomp +"</span> (<span id='bpcount"+key+"'>"+bpCount+"</span>) </a><span  onclick='javascript:editc("+key+");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span></li>";
            
   HashMap bProcess =   ViewBPM.getBP(key);
    LinkedHashMap businessProcess=GetProjectMembers.sortHashMapByKeys(bProcess,true);
    if(businessProcess.size()>0){
        Collection bpset=businessProcess.keySet();
        Iterator bpite = bpset.iterator();
        int mpCount =   0;
        int buCount=0;
        while (bpite.hasNext()) {
            int bpkey=(Integer)bpite.next();
            String nameofbp=(String)businessProcess.get(bpkey);
            mpCount         =   ViewBPM.getMPCount(bpkey);
            if(buCount==0){
                wholedata=wholedata+"<ul >";
            }
            if (mpCount == 0) {
                wholedata=wholedata+"<li id='bp" + bpkey + "' class='expandable'> <div class='treeclass' onclick='javascript:viewMP(" + bpkey + ")'></div><a href='#'  onclick='javascript:viewMP(" + bpkey + ");return false;' ><b>Business Process:</b><input type='hidden' id='bpvalue" + bpkey + "' value='" + nameofbp + "'> <span id='bpspan" + bpkey + "' >" + nameofbp + "</span> (<span id='mpcount"+bpkey+"'>" + mpCount + "</span>) </a><span  onclick='javascript:editbp(" + bpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span  id='deletebp"+bpkey+"' onclick='javascript:deleteBP("+bpkey+","+key+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";    
                bpName = bpName + "<ul ><li id='bp" + bpkey + "' class='expandable'> <div class='treeclass' onclick='javascript:viewMP(" + bpkey + ")'></div><a href='#'  onclick='javascript:viewMP(" + bpkey + ");return false;' ><b>Business Process:</b><input type='hidden' id='bpvalue" + bpkey + "' value='" + nameofbp + "'> <span id='bpspan" + bpkey + "' >" + nameofbp + "</span> (<span id='mpcount"+bpkey+"'>" + mpCount + "</span>) </a><span  onclick='javascript:editbp(" + bpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span  id='deletebp"+bpkey+"' onclick='javascript:deleteBP("+bpkey+","+key+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";
                } else {
                wholedata=wholedata  + "<li id='bp" + bpkey + "' class='expandable'> <div class='treeclass treeExpand' onclick='javascript:viewMP(" + bpkey + ")'></div><a href='#'  onclick='javascript:viewMP(" + bpkey + ");return false;' ><b>Business Process:</b><input type='hidden' id='bpvalue" + bpkey + "' value='" + nameofbp + "'> <span id='bpspan" + bpkey + "'>" + nameofbp + "</span> (<span id='mpcount"+bpkey+"'>" + mpCount + "</span>) </a><span  onclick='javascript:editbp(" + bpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>"; 
                bpName = bpName + "<ul ><li id='bp" + bpkey + "' class='expandable'> <div class='treeclass' onclick='javascript:viewMP(" + bpkey + ")'></div><a href='#'  onclick='javascript:viewMP(" + bpkey + ");return false;' ><b>Business Process:</b><input type='hidden' id='bpvalue" + bpkey + "' value='" + nameofbp + "'> <span id='bpspan" + bpkey + "'>" + nameofbp + "</span> (<span id='mpcount"+bpkey+"'>" + mpCount + "</span>) </a><span  onclick='javascript:editbp(" + bpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span></li>";
                HashMap mProcess =   ViewBPM.getMP(bpkey);
            LinkedHashMap mainProcess=GetProjectMembers.sortHashMapByKeys(mProcess,true);
    
    if(mainProcess.size()>0){
        Collection mpset=mainProcess.keySet();
        Iterator mpite = mpset.iterator();
        int spCount  =  0;
        int maCount=0;
        while (mpite.hasNext()) {
            int mpkey=(Integer)mpite.next();
            String nameofmp=(String)mainProcess.get(mpkey);
            spCount   =   ViewBPM.getSPCount(mpkey);
            if(maCount==0){
                wholedata=wholedata+"<ul>";
            }
            if (spCount == 0) {
                wholedata=wholedata   + "<li id='mp" + mpkey + "' class='expandable'><div class='treeclass'  onclick='javascript:viewSP(" + mpkey + ")'></div><a href='#'  onclick='javascript:viewSP(" + mpkey + ");return false;'  ><b>Main Process:</b> <input type='hidden' id='mpvalue" + mpkey + "' value='" + nameofmp + "'><span id='mpspan" + mpkey + "'>" + nameofmp + "</span> (<span id='spcount"+mpkey+"'>" + spCount + "</span>) </a><span  onclick='javascript:editmp(" + mpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletemp"+mpkey+"' onclick='javascript:deleteMP("+mpkey+","+bpkey+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";   
                mpName = mpName + "<ul><li id='mp" + mpkey + "' class='expandable'><div class='treeclass'  onclick='javascript:viewSP(" + mpkey + ")'></div><a href='#'  onclick='javascript:viewSP(" + mpkey + ");return false;'  ><b>Main Process:</b> <input type='hidden' id='mpvalue" + mpkey + "' value='" + nameofmp + "'><span id='mpspan" + mpkey + "'>" + nameofmp + "</span> (<span id='spcount"+mpkey+"'>" + spCount + "</span>) </a><span  onclick='javascript:editmp(" + mpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletemp"+mpkey+"' onclick='javascript:deleteMP("+mpkey+","+bpkey+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";
                } else {
                 wholedata=wholedata   + "<li id='mp" + mpkey + "' class='expandable'><div class='treeclass treeExpand'  onclick='javascript:viewSP(" + mpkey + ")'></div><a href='#'  onclick='javascript:viewSP(" + mpkey + ");return false;'  ><b>Main Process:</b> <input type='hidden' id='mpvalue" + mpkey + "' value='" + nameofmp + "'><span id='mpspan" + mpkey + "'>" + nameofmp + "</span> (<span id='spcount"+mpkey+"'>" + spCount + "</span>) </a><span  onclick='javascript:editmp(" + mpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>"; 
                mpName = mpName + "<ul><li id='mp" + mpkey + "' class='expandable'><div class='treeclass'  onclick='javascript:viewSP(" + mpkey + ")'></div><a href='#'  onclick='javascript:viewSP(" + mpkey + ");return false;'  ><b>Main Process:</b> <input type='hidden' id='mpvalue" + mpkey + "' value='" + nameofmp + "'><span id='mpspan" + mpkey + "'>" + nameofmp + "</span> (<span id='spcount"+mpkey+"'>" + spCount + "</span>) </a><span  onclick='javascript:editmp(" + mpkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span></li>";
            HashMap sProcess =   ViewBPM.getSP(mpkey);
    LinkedHashMap subProcess=GetProjectMembers.sortHashMapByKeys(sProcess,true);
    
    if(subProcess.size()>0){
        Collection spset=subProcess.keySet();
        Iterator spite = spset.iterator();
        int scCount  =  0;
        int suCount=0;
        while (spite.hasNext()) {
            int spkey=(Integer)spite.next();
            String nameofsp=(String)subProcess.get(spkey);
            scCount   =   ViewBPM.getSCCount(spkey);
            if(suCount==0){
                wholedata=wholedata+"<ul >";
            }
            if (scCount == 0) {
                wholedata=wholedata+ " <li id='sp" + spkey + "' class='expandable'><div class='treeclass' onclick='javascript:viewSC(" + spkey + ")'></div><a href='#'  onclick='javascript:viewSC(" + spkey + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + spkey + "' value='" + nameofsp + "'> <span id='spspan" + spkey + "'>" + nameofsp + "</span>  (<span id='sccount" + spkey + "'>" + scCount + "</span>) </a><span  onclick='javascript:editsp(" + spkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletesp"+spkey+"' onclick='javascript:deleteSP(" + spkey + "," + mpkey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";   
                spName = spName + "<ul><li id='sp" + spkey + "' class='expandable'><div class='treeclass' onclick='javascript:viewSC(" + spkey + ")'></div><a href='#'  onclick='javascript:viewSC(" + spkey + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + spkey + "' value='" + nameofsp + "'> <span id='spspan" + spkey + "'>" + nameofsp + "</span>  (<span id='sccount" + spkey + "'>" + scCount + "</span>) </a><span  onclick='javascript:editsp(" + spkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletesp"+spkey+"' onclick='javascript:deleteSP(" + spkey + "," + mpkey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";
                } else {
                   if(url.equals("eminentlabs.net")){
                     wholedata=wholedata+ "<li id='sp" + spkey + "' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewSC(" + spkey + ")'></div><a href='#'  onclick='javascript:viewSC(" + spkey + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + spkey + "' value='" + nameofsp + "'> <span id='spspan" + spkey + "'>" + nameofsp + "</span>  (<span id='sccount" + spkey + "'>" + scCount + "</span>) </a><span  onclick='javascript:editsp(" + spkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span title='Download Sub Process'>  <a href='/eTracker/UserBPM/downloadTree.jsp?spId="+spkey+"' target='_blank'><img style='border:none;position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/down.png'/></a></span>";
                       spName = spName + "<li id='sp" + spkey + "' class='expandable'><div class='treeclass' onclick='javascript:viewSC(" + spkey + ")'></div><a href='#'  onclick='javascript:viewSC(" + spkey + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + spkey + "' value='" + nameofsp + "'> <span id='spspan" + spkey + "'>" + nameofsp + "</span>  (<span id='sccount" + spkey + "'>" + scCount + "</span>) </a><span  onclick='javascript:editsp(" + spkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span title='Download Sub Process'>  <a href='/eTracker/UserBPM/downloadTree.jsp?spId="+spkey+"' target='_blank'><img style='border:none;position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/down.png'/></a></span></li>";
                   }else{
                     wholedata=wholedata+ "<li id='sp" + spkey + "' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewSC(" + spkey + ")'></div><a href='#'  onclick='javascript:viewSC(" + spkey + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + spkey + "' value='" + nameofsp + "'> <span id='spspan" + spkey + "'>" + nameofsp + "</span>  (<span id='sccount" + spkey + "'>" + scCount + "</span>) </a><span  onclick='javascript:editsp(" + spkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";
                       spName = spName + "<li id='sp" + spkey + "' class='expandable'><div class='treeclass' onclick='javascript:viewSC(" + spkey + ")'></div><a href='#'  onclick='javascript:viewSC(" + spkey + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + spkey + "' value='" + nameofsp + "'> <span id='spspan" + spkey + "'>" + nameofsp + "</span>  (<span id='sccount" + spkey + "'>" + scCount + "</span>) </a><span  onclick='javascript:editsp(" + spkey + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span></li>";

                   }
                   HashMap scenarioMap =   ViewBPM.getSC(spkey);
    LinkedHashMap scenario=GetProjectMembers.sortHashMapByKeys(scenarioMap,true);
    
    if(scenario.size()>0){
        Collection scset=scenario.keySet();
        Iterator scite = scset.iterator();
        int vtCount  = 0;
        int sceCount=0;
        while (scite.hasNext()) {
            int sckey=(Integer)scite.next();
            String nameofsc=(String)scenario.get(sckey);
            vtCount   =   ViewBPM.getVTCount(sckey);
            if(sceCount==0){
                wholedata=wholedata+"<ul >";
            }
             if (vtCount == 0) {
                   
                 wholedata=wholedata+ "<li id='sc"+sckey+"' class='expandable'><div class='treeclass' onclick='javascript:viewVT("+sckey+")'></div><a href='#'  onclick='javascript:viewVT("+sckey+");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue"+sckey+"' value='"+nameofsc+"'> <span id='scspan"+sckey+"'>"+nameofsc +"</span>  (<span id='vtcount" + sckey + "'>"+vtCount+"</span>) </a><span  onclick='javascript:editsc("+sckey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletesc"+sckey+"' onclick='javascript:deleteSC(" + sckey + "," + spkey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";
                 scName = scName + "<li id='sc"+sckey+"' class='expandable'><div class='treeclass' onclick='javascript:viewVT("+sckey+")'></div><a href='#'  onclick='javascript:viewVT("+sckey+");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue"+sckey+"' value='"+nameofsc+"'> <span id='scspan"+sckey+"'>"+nameofsc +"</span>  (<span id='vtcount" + sckey + "'>"+vtCount+"</span>) </a><span  onclick='javascript:editsc("+sckey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletesc"+sckey+"' onclick='javascript:deleteSC(" + sckey + "," + spkey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";
                } else {
                    
                 if(url.equals("eminentlabs.net")){
                     wholedata=wholedata+ "<li id='sc"+sckey+"' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewVT("+sckey+")'></div><a href='#'  onclick='javascript:viewVT("+sckey+");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue"+sckey+"' value='"+nameofsc+"'> <span id='scspan"+sckey+"'>"+nameofsc +"</span>  (<span id='vtcount" + sckey + "'>"+vtCount+"</span>) </a><span  onclick='javascript:editsc("+sckey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";
                     scName = scName + "<li id='sc"+sckey+"' class='expandable'><div class='treeclass' onclick='javascript:viewVT("+sckey+")'></div><a href='#'  onclick='javascript:viewVT("+sckey+");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue"+sckey+"' value='"+nameofsc+"'> <span id='scspan"+sckey+"'>"+nameofsc +"</span>  (<span id='vtcount" + sckey + "'>"+vtCount+"</span>) </a><span  onclick='javascript:editsc("+sckey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span></li>";
                   }else{
                     wholedata=wholedata+ "<li id='sc"+sckey+"' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewVT("+sckey+")'></div><a href='#'  onclick='javascript:viewVT("+sckey+");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue"+sckey+"' value='"+nameofsc+"'> <span id='scspan"+sckey+"'>"+nameofsc +"</span>  (<span id='vtcount" + sckey + "'>"+vtCount+"</span>) </a><span  onclick='javascript:editsc("+sckey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";
                     scName = scName + "<li id='sc"+sckey+"' class='expandable'><div class='treeclass' onclick='javascript:viewVT("+sckey+")'></div><a href='#'  onclick='javascript:viewVT("+sckey+");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue"+sckey+"' value='"+nameofsc+"'> <span id='scspan"+sckey+"'>"+nameofsc +"</span>  (<span id='vtcount" + sckey + "'>"+vtCount+"</span>) </a><span  onclick='javascript:editsc("+sckey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span></li>";

                   }
                HashMap variantMap =   ViewBPM.getVT(sckey);
    LinkedHashMap variant=GetProjectMembers.sortHashMapByKeys(variantMap,true);
    
    if(variant.size()>0){
        Collection vtset=variant.keySet();
        Iterator vtite = vtset.iterator();
        int tcCount  = 0;
        int vaCount=0;
        while (vtite.hasNext()) {
            int vtkey=(Integer)vtite.next();
            String nameofvt=(String)variant.get(vtkey);
            tcCount   =   ViewBPM.getTCCount(vtkey);
            if(vaCount==0){
                wholedata=wholedata+"<ul >";
            }
            if (tcCount == 0) {
                wholedata=wholedata+"<li id='vt"+vtkey+"' class='expandable'><div class='treeclass' onclick='javascript:viewTC("+vtkey+")'></div><a href='#'  onclick='javascript:viewTC("+vtkey+");return false;' style='margin-left:3px;'><b>Variant:</b><input type='hidden' id='vtvalue"+vtkey+"' value='"+nameofvt+"'> <span id='vtspan"+vtkey+"'>"+nameofvt +"</span>  (<span id='tccount"+vtkey+"'>"+tcCount+"</span>) </a><span  onclick='javascript:editvt("+vtkey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletevt"+vtkey+"' onclick='javascript:deleteVT(" + vtkey + "," + sckey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";    
                vtName    =   vtName+"<li id='vt"+vtkey+"' class='expandable'><div class='treeclass' onclick='javascript:viewTC("+vtkey+")'></div><a href='#'  onclick='javascript:viewTC("+vtkey+");return false;' style='margin-left:3px;'><b>Variant:</b><input type='hidden' id='vtvalue"+vtkey+"' value='"+nameofvt+"'> <span id='vtspan"+vtkey+"'>"+nameofvt +"</span>  (<span id='tccount"+vtkey+"'>"+tcCount+"</span>) </a><span  onclick='javascript:editvt("+vtkey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletevt"+vtkey+"' onclick='javascript:deleteVT(" + vtkey + "," + sckey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";
                } else {
                 wholedata=wholedata+"<li id='vt"+vtkey+"' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewTC("+vtkey+")'></div><a href='#'  onclick='javascript:viewTC("+vtkey+");return false;' style='margin-left:3px;'><b>Variant:</b><input type='hidden' id='vtvalue"+vtkey+"' value='"+nameofvt+"'> <span id='vtspan"+vtkey+"'>"+nameofvt +"</span>  (<span id='tccount"+vtkey+"'>"+tcCount+"</span>) </a><span  onclick='javascript:editvt("+vtkey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";    
                vtName    =   vtName+"<li id='vt"+vtkey+"' class='expandable'><div class='treeclass' onclick='javascript:viewTC("+vtkey+")'></div><a href='#'  onclick='javascript:viewTC("+vtkey+");return false;' style='margin-left:3px;'><b>Variant:</b><input type='hidden' id='vtvalue"+vtkey+"' value='"+nameofvt+"'> <span id='vtspan"+vtkey+"'>"+nameofvt +"</span>  (<span id='tccount"+vtkey+"'>"+tcCount+"</span>) </a><span  onclick='javascript:editvt("+vtkey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span></li>";
            HashMap tcase =   ViewBPM.getTC(vtkey);
    LinkedHashMap testcase=GetProjectMembers.sortHashMapByKeys(tcase,true);
    String tcName  =   "";
    if(testcase.size()>0){
        Collection tcset=testcase.keySet();
        Iterator tcite = tcset.iterator();
        int tsCount  = 0;
        int tcaCount=0;
        while (tcite.hasNext()) {
            int tckey=(Integer)tcite.next();
            String nameoftc=(String)testcase.get(tckey);
            tsCount   =   ViewBPM.getTSCount(tckey);
            if(tcaCount==0){
                wholedata=wholedata+"<ul >";
            }
            if (tsCount == 0) {
                    wholedata=wholedata+"<li id='tc"+tckey+"' class='expandable'><div class='treeclass' onclick='javascript:viewTS("+tckey+")'></div><a href='#'  onclick='javascript:viewTS("+tckey+");return false;' style='margin-left:3px;'><b>Business Case:</b><input type='hidden' id='tcvalue"+tckey+"' value='"+nameoftc+"'> <span id='tcspan"+tckey+"'>"+nameoftc +"</span>  (<span id='tscount"+tckey+"'>"+tsCount+"</span>) </a><span  onclick='javascript:edittc("+tckey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletetc"+tckey+"' onclick='javascript:deleteTC(" + tckey + "," + vtkey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";
                    tcName    =   tcName+"<li id='tc"+tckey+"' class='expandable'><div class='treeclass' onclick='javascript:viewTS("+tckey+")'></div><a href='#'  onclick='javascript:viewTS("+tckey+");return false;' style='margin-left:3px;'><b>Business Case:</b><input type='hidden' id='tcvalue"+tckey+"' value='"+nameoftc+"'> <span id='tcspan"+tckey+"'>"+nameoftc +"</span>  (<span id='tscount"+tckey+"'>"+tsCount+"</span>) </a><span  onclick='javascript:edittc("+tckey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletetc"+tckey+"' onclick='javascript:deleteTC(" + tckey + "," + vtkey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></li>";
                } else {
                    wholedata=wholedata+"<li id='tc"+tckey+"' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewTS("+tckey+")'></div><a href='#'  onclick='javascript:viewTS("+tckey+");return false;' style='margin-left:3px;'><b>Business Case:</b><input type='hidden' id='tcvalue"+tckey+"' value='"+nameoftc+"'> <span id='tcspan"+tckey+"'>"+nameoftc +"</span>  (<span id='tscount"+tckey+"'>"+tsCount+"</span>) </a><span  onclick='javascript:edittc("+tckey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>";
                    tcName    =   tcName+"<li id='tc"+tckey+"' class='expandable'><div class='treeclass' onclick='javascript:viewTS("+tckey+")'></div><a href='#'  onclick='javascript:viewTS("+tckey+");return false;' style='margin-left:3px;'><b>Business Case:</b><input type='hidden' id='tcvalue"+tckey+"' value='"+nameoftc+"'> <span id='tcspan"+tckey+"'>"+nameoftc +"</span>  (<span id='tscount"+tckey+"'>"+tsCount+"</span>) </a><span  onclick='javascript:edittc("+tckey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span></li>";
            HashMap tstep =   ViewBPM.getTS(tckey);
    LinkedHashMap teststep=GetProjectMembers.sortHashMapByKeys(tstep,true);
    String tsName  =   "";
    if(teststep.size()>0){
        Collection tsset=teststep.keySet();
        Iterator tsite = tsset.iterator();
        int tscCount  = 0;
        int tstCount=0;
        while (tsite.hasNext()) {
            int tskey=(Integer)tsite.next();
            String nameofts=(String)teststep.get(tskey);
            tscCount   =   ViewBPM.getTestScriptCount(tskey);
            if(tstCount==0){
                wholedata=wholedata+"<ul >";
            }
            if (tscCount == 0) {
                wholedata=wholedata+"<li id='ts"+tskey+"' class='expandable'><div class='treeclass' onclick='javascript:viewTSC("+tskey+")'></div><a href='#'  onclick='javascript:viewTSC("+tskey+");return false;' style='margin-left:3px;'><b>Business Step:</b><input type='hidden' id='tsvalue"+tskey+"' value='"+nameofts+"'> <span id='tsspan"+tskey+"'>"+nameofts +"</span> (<span id='tsrcount"+tskey+"'>"+tscCount+"</span>) </a><span  onclick='javascript:editts("+tskey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletets"+tskey+"' onclick='javascript:deleteTS(" + tskey + "," + tckey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span><span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/create.jpeg'/ title='Create Issue' onclick='tStepCtreateIssue("+tskey+")'></span></li>";    
                tsName    =   tsName+"<ul ><li id='ts"+tskey+"' class='expandable'><div class='treeclass' onclick='javascript:viewTSC("+tskey+")'></div><a href='#'  onclick='javascript:viewTSC("+tskey+");return false;' style='margin-left:3px;'><b>Business Step:</b><input type='hidden' id='tsvalue"+tskey+"' value='"+nameofts+"'> <span id='tsspan"+tskey+"'>"+nameofts +"</span> (<span id='tsrcount"+tskey+"'>"+tscCount+"</span>) </a><span  onclick='javascript:editts("+tskey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletets"+tskey+"' onclick='javascript:deleteTS(" + tskey + "," + tckey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span><span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/create.jpeg'/ title='Create Issue' onclick='tStepCtreateIssue("+tskey+")'></span></li>";
                } else {
                wholedata=wholedata+"<li id='ts"+tskey+"' class='expandable'><div class='treeclass treeExpand' onclick='javascript:viewTSC("+tskey+")'></div><a href='#'  onclick='javascript:viewTSC("+tskey+");return false;' style='margin-left:3px;'><b>Business Step:</b><input type='hidden' id='tsvalue"+tskey+"' value='"+nameofts+"'> <span id='tsspan"+tskey+"'>"+nameofts +"</span> (<span id='tsrcount"+tskey+"'>"+tscCount+"</span>) </a><span  onclick='javascript:editts("+tskey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/create.jpeg'/ title='Create Issue' onclick='tStepCtreateIssue("+tskey+")'></span>";
                tsName    =   tsName+"<li id='ts"+tskey+"' class='expandable'><div class='treeclass' onclick='javascript:viewTSC("+tskey+")'></div><a href='#'  onclick='javascript:viewTSC("+tskey+");return false;' style='margin-left:3px;'><b>Business Step:</b><input type='hidden' id='tsvalue"+tskey+"' value='"+nameofts+"'> <span id='tsspan"+tskey+"'>"+nameofts +"</span> (<span id='tsrcount"+tskey+"'>"+tscCount+"</span>) </a><span  onclick='javascript:editts("+tskey+");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/create.jpeg'/ title='Create Issue' onclick='tStepCtreateIssue("+tskey+")'></span></li>";
    LinkedHashMap testscript=ViewBPM.getTestScript(tskey);
    String tscName  =   "",color="white";
    int i=0;
    if(testscript.size()>0){
        Collection tscset=testscript.keySet();
        Iterator tscite = tscset.iterator();
        String testScript   =   null;
        String expRslt      =   null;
        String createdBy    =   null;
        String ptcId        =   null;
        String tscId        =   null;
        String uniqueId     =   null;
        while (tscite.hasNext()) {
            if(( i % 2 ) != 0)
            {
                color="#E8EEF7";
            }
            else
            {

                color    ="white";

            }
            String tsckey=(String)tscite.next();
            String nameoftsc=(String)testscript.get(tsckey);
            testScript  =   nameoftsc.substring(0, nameoftsc.indexOf("###")) ;
            expRslt     =   nameoftsc.substring(nameoftsc.indexOf("###")+3,nameoftsc.lastIndexOf("###"));
            createdBy   =   nameoftsc.substring(nameoftsc.lastIndexOf("###")+3,nameoftsc.indexOf("***")-2);
            ptcId       =   nameoftsc.substring(nameoftsc.indexOf("***")+3,nameoftsc.lastIndexOf("***"));
            tscId       =   nameoftsc.substring(nameoftsc.lastIndexOf("***")+3);
            String testcaseId="'"+tsckey+"'";
            uniqueId    =   tsckey+tskey;
            tscName    =   tscName+"<tr id='"+tscId+"' style='background-color:"+color+";'><td><div id="+uniqueId+" onclick=javascript:showComments('"+tsckey+"','"+tskey+"'); style='margin-left:2px;width:30px;bgcolor:red;' class='treeclass'></div>"+testScript+" </td><td>"+expRslt +" </td><td>"+createdBy +"</td><td>"+ptcId+"<span id='deletetsc"+tscId+"' onclick='javascript:deleteTSC(" + tscId + "," + tskey + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span></td></tr><tr ><td colspan=4 > <div id='ptc"+uniqueId+"'></div></td></tr>";
            i++;    
            
        }    
                    wholedata=wholedata+"<ul><li class='lasttestscript'><table id='"+tskey+"' style='border:solid 1px #696969'><tr style='background-color: #C3D9FF;'><td><b>Test Script</b></td><td><b>Expected Result</b></td><td><b>Created By</b></td><td><b>Status</b></td></tr>"+tscName+"</table></li></ul>";

            }    
            }
        tstCount++;
        if(tstCount==teststep.size()){
            wholedata=wholedata+"</ul>";
        }
        }
           
                }
                }
            tcaCount++;
        if(tcaCount==testcase.size()){
            wholedata=wholedata+"</ul>";
        }
        }
        }
    }
    vaCount++;
    if(vaCount==variant.size()){
        wholedata=wholedata+"</ul>";
    }
    
    }}} 
    sceCount++;
    if(sceCount==scenario.size()){
        wholedata=wholedata+"</ul>";
    }
    
    
    }}}
    suCount++;
    if(suCount==subProcess.size()){
        wholedata=wholedata+"</ul>";
    }
    
    }} }
    maCount++;
    if(maCount==mainProcess.size()){
        wholedata=wholedata+"</ul>";
    }
    
    }}}
    buCount++;
    if(buCount==businessProcess.size()){
        wholedata=wholedata+"</ul>";
    }
    
    }}}
        
        cmCount++;
        if(cmCount==ncompany.size()){
            wholedata=wholedata+"</ul>";
        }
       
        
        }}}
     %>
<%=wholedata%>
<%wholedata="";
    
    %>
</li>
                    </ul>
                </div>
<br>
                    <br>
                    <TABLE bgColor="#C3D9FF" border=0 width="100%">
                        <tbody>
                            <TR>
                                <TD align=center noWrap vAlign=top width="50%" height="150%">
                                    <font face="Verdana" size="4" color="#666666">
                                        KPI Tracker&#153;, ERPDS&#153;, EWE&#153;, eTracker&#153;, eOutsource&#153;, Rightshore&#153; are registered trademarks of Eminentlabs&#153; Software Private Limited
                                    </font>
                                </TD>

                            </TR>
                        </TBODY>
                    </TABLE>
    </body>
    <%}else{%>
<br/><div style="text-align: center;color: red;">You are not authorized to access it</div>
        <%}%>
</html>

