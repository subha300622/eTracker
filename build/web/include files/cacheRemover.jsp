<%-- 
    Document   : cacheRemover
    Created on : Mar 23, 2009, 11:16:34 AM
    Author     : Balaguru Ramasamy
--%>

<%

    //Remove browser cache to ensure the users are getting issue list from DB and not from cache
    response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
 	response.setHeader("Pragma","no-cache");

%>
