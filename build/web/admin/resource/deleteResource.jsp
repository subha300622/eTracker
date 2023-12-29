
<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="asset" class="com.eminent.Assets.AssetsController"/>
<%String machinename="";
    asset.doAction(request);
    if (asset.getMachinename() != "") {
        machinename=asset.getMachinename();
        out.print(asset.getMachinename());
}
%>

 <jsp:forward page="/admin/resource/viewResources.jsp">
                <jsp:param name="newresource" value="deleted" />
                <jsp:param name="machinename" value="<%= machinename%>" />
            </jsp:forward>
