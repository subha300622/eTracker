<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String spId   =   request.getParameter("spId");

    HashMap scenarioMap =   ViewBPM.getSC(Integer.parseInt(spId));
    LinkedHashMap scenario=GetProjectMembers.sortHashMapByKeys(scenarioMap,true);
    String scName  =   ";";
    scName=scName+"--Select One--"+"*"+"--Select One--"+",";
    if(scenario.size()>0){
        Collection set=scenario.keySet();
        Iterator ite = set.iterator();
        while (ite.hasNext()) {
            int key=(Integer)ite.next();
            String nameofsc=(String)scenario.get(key);

           scName  =   scName+key+"*"+nameofsc+",";

        }
        

    }
    out.print(scName);
%>
