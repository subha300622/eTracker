<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String mpId   =   request.getParameter("mpId");

    HashMap sProcess =   ViewBPM.getSP(Integer.parseInt(mpId));
    LinkedHashMap subProcess=GetProjectMembers.sortHashMapByKeys(sProcess,true);
    String spName  =   ";";
    spName=spName+"--Select One--"+"*"+"--Select One--"+",";
    if(subProcess.size()>0){
        Collection set=subProcess.keySet();
        Iterator ite = set.iterator();

        while (ite.hasNext()) {
            int key=(Integer)ite.next();
            String nameofsp=(String)subProcess.get(key);
            spName  =   spName+key+"*"+nameofsp+",";

        }
 

    }
    out.print(spName);
%>
