<%--
    Document   : register
    Created on : Mar 23, 2012, 10:04:50 AM
    Author     : Tamilvelan
--%>
<%
String ua = request.getHeader( "User-Agent" );
boolean isFirefox = ( ua != null && ua.indexOf( "Firefox/" ) != -1 );
boolean isMSIE = ( ua != null && ua.indexOf( "MSIE" ) != -1 );
response.setHeader( "Vary", "User-Agent" );
if (!isMSIE)
{
%>
<%--<jsp:forward page="BrowserWarning.jsp"/>--%>
<%

}
%>
<%@ page language="java" contentType="text/html"  pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
<meta http-equiv="Content-Type" content="text/html">
<title>Eminentlabs&trade; - Enterprise Resource Management</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<SCRIPT  type="text/javascript">
    window.history.forward(1);
//Ajax Request
function trim(str)
{
        while (str.charAt(str.length - 1)==" ")
   	str = str.substring(0, str.length - 1);
  	while (str.charAt(0)==" ")
    	str = str.substring(1, str.length);
  	return str;
}
function createRequest(){
	var reqObj = null;
	try
	{
	   reqObj = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch (err)
	{
	   try {
			reqObj = new ActiveXObject("Microsoft.XMLHTTP");
	   }
	   catch (err2) {
		try {
			   reqObj = new XMLHttpRequest();
		}
		catch (err3) {
		  reqObj = null;
		}
	   }
	}
	return reqObj;
}


function callproduct()
{

        xmlhttp = createRequest();
        if(xmlhttp != null)
        {
            var refempid = document.getElementById("refempid").value;


            xmlhttp.open("GET","getEmployees.jsp?refempid="+refempid+"&rand="+Math.random(1,10), false);
            xmlhttp.onreadystatechange = callbackreferral;
            xmlhttp.send(null);
        }
}
function callbackreferral()
{
     if (xmlhttp.readyState == 4)
     {
	    if (xmlhttp.status == 200)
            {
                    var name = trim(xmlhttp.responseText);
                    if(name=="no"){

						alert('Please enter the correct Reference ID');
						document.theForm.refempid.value='';
						document.theForm.refempid.focus();

					}
					else{

					}

	   }
	}
}

var upload_number = 2;
function addTableInput() {
 	 var d = document.createElement('div');
	var table1=document.createElement('<table>');
        table1.setAttribute("width","90%");
        table1.setAttribute("cellspacing","1");
        table1.setAttribute("cellpadding","1");
        table1.setAttribute("border","0");


	var tbody1=document.createElement('tbody');
	var row1=document.createElement('tr');
	var cell1 =document.createElement('td');
	cell1.setAttribute("width","18%");

	var lable1=document.createTextNode("Project Name");

	var bold1=document.createElement("b");
	bold1.appendChild(lable1);
	var cell2 =document.createElement('td');




	var text=document.createElement("input")
	text.setAttribute("type","text");
	text.setAttribute("size","16");
	text.setAttribute("name","projectname"+upload_number);



	var cell3=document.createElement('td');
	cell3.setAttribute("width","10%");
	var lable2=document.createTextNode("Duration");
	var bold2=document.createElement("b");
	bold2.appendChild(lable2);

	var cell4 =document.createElement('td');
	var duration=document.createElement("input")
	duration.setAttribute("type","text");
	duration.setAttribute("size","6");
	duration.setAttribute("name","duration"+upload_number);


	var lable3=document.createTextNode("Months");


	var cell5=document.createElement('td');
	cell5.setAttribute("width","10%");
	var lable4=document.createTextNode("Team Size");
	var bold3=document.createElement("b");
	bold3.appendChild(lable4);

	var cell6 =document.createElement('td');

	var team=document.createElement("input")
	team.setAttribute("type","text");
	team.setAttribute("size","6");
	team.setAttribute("name","teamsize"+upload_number);



	cell1.appendChild(bold1);
	cell2.appendChild(text);
	cell3.appendChild(bold2);
	cell4.appendChild(duration);
        cell4.appendChild(lable3);
	cell5.appendChild(bold3);
	cell6.appendChild(team);

	row1.appendChild(cell1);
	row1.appendChild(cell2);
	row1.appendChild(cell3);
	row1.appendChild(cell4);
	row1.appendChild(cell5);
	row1.appendChild(cell6);



	var row2=document.createElement('tr');

	var r2c1=document.createElement('td');
	r2c1.setAttribute("width","18%");
		var r2l1=document.createTextNode("Client");
	var r2b1=document.createElement("b");
	r2b1.appendChild(r2l1);

	var r2c2 =document.createElement('td');

	var client=document.createElement("input")
	client.setAttribute("type","text");
	client.setAttribute("size","16");
	client.setAttribute("name","client"+upload_number);

	var r2c3=document.createElement('td');
	r2c3.setAttribute("width","10%");
	var r2l2=document.createTextNode("Environment");
	var r2b2=document.createElement("b");
	r2b2.appendChild(r2l2);

	var r2c4 =document.createElement('<td colspan=3>');

	var Environment=document.createElement("input")
	Environment.setAttribute("type","text");
	Environment.setAttribute("size","30");
	Environment.setAttribute("name","environment"+upload_number);

	r2c1.appendChild(r2b1);
	r2c2.appendChild(client);
	r2c3.appendChild(r2b2);
	r2c4.appendChild(Environment);

	row2.appendChild(r2c1);
	row2.appendChild(r2c2);
	row2.appendChild(r2c3);
	row2.appendChild(r2c4);

	var row3=document.createElement('tr');
	var r3c1=document.createElement('<td colspan=2>');
	var r3l1=document.createTextNode("PROJECT DESCRIPTION");
	var r3b1=document.createElement("b");

	r3b1.appendChild(r3l1);
	r3c1.appendChild(r3b1);

	row3.appendChild(r3c1);

	var row4=document.createElement('tr');
	var r4c1=document.createElement('<td colspan=6>');
	var textarea = document.createElement("textarea");
	textarea.setAttribute("cols", "90");
 	textarea.setAttribute("rows", "5");
 	textarea.setAttribute("wrap", "physical");
 	var idno="description"+upload_number;
 	textarea.setAttribute("name", idno);
 	textarea.setAttribute("id", idno);

	r4c1.appendChild(textarea);

	row4.appendChild(r4c1);



	var row5=document.createElement('tr');
	var r5c1=document.createElement('<td colspan=2>');
	var r5l1=document.createTextNode("ROLES & RESPONSIBILITIES");
	var r5b1=document.createElement("b");

	var r5c2=document.createElement('<td colspan=2>');
	var getvalue=document.createElement("input")
	getvalue.setAttribute("name","noofproject");
	getvalue.setAttribute("value",upload_number);
	getvalue.setAttribute("type","hidden");
	getvalue.setAttribute("size","30");
	r5c2.appendChild(getvalue);

	r5b1.appendChild(r5l1);
	r5c1.appendChild(r5b1);

	row5.appendChild(r5c1);
	row5.appendChild(r5c2);

	var row6=document.createElement('tr');
	var r6c1=document.createElement('<td colspan=5>');

	var l = document.createElement("a");

	var roles = document.createElement("textarea");
	roles.setAttribute("cols", "90");
 	roles.setAttribute("rows", "5");
 	roles.setAttribute("wrap", "physical");
 	var idno="roles"+upload_number;
 	roles.setAttribute("name", idno);
 	roles.setAttribute("id", idno);

	l.setAttribute("href", "javascript:removeFileInput('f"+upload_number+"');");
	l.appendChild(document.createTextNode("remove"));
	d.setAttribute("id", "f"+upload_number);
	r6c1.appendChild(roles);
	r6c1.appendChild(l);
	row6.appendChild(r6c1);


	tbody1.appendChild(row1);
	tbody1.appendChild(row2);
	tbody1.appendChild(row3);
	tbody1.appendChild(row4);
	tbody1.appendChild(row5);
	tbody1.appendChild(row6);

	table1.appendChild(tbody1);
	d.appendChild(table1);

	document.getElementById("moreUploads").appendChild(d);



	upload_number++;
	}

function removeFileInput(i) {
	var elm = document.getElementById(i);
	document.getElementById("moreUploads").removeChild(elm);
}

var employer_number = 2;
function addEmployerInput() {
 	var d = document.createElement('div');
	var table1=document.createElement('<table>');
        table1.setAttribute("border","0");
        table1.setAttribute("width","100%");
	var tbody1=document.createElement('tbody');
	var row1=document.createElement('tr');
	var cell1 =document.createElement('td');
        cell1.setAttribute("width","13%");


	var lable1=document.createTextNode("Prev Employer");

	var bold1=document.createElement("b");
	bold1.appendChild(lable1);
	var cell2 =document.createElement('td');



	var text=document.createElement("input")
	text.setAttribute("type","text");
	text.setAttribute("size","45");
	text.setAttribute("name","previousemployer"+employer_number);



	var cell3=document.createElement('td');
	var lable2=document.createTextNode("CTC");
	var bold2=document.createElement("b");
	bold2.appendChild(lable2);

	var cell4 =document.createElement('td');
	var duration=document.createElement("input")
	duration.setAttribute("type","text");
	duration.setAttribute("size","6");
	duration.setAttribute("name","ctc"+employer_number);


	var lable3=document.createTextNode("LPA in INR");

        var cell5=document.createElement('<td>');
	var r3l1=document.createTextNode("Joining Date");
	var r3b1=document.createElement("b");

        r3b1.appendChild(r3l1);
	cell5.appendChild(r3b1);

	var cell6=document.createElement('<td>');
	var joiningdate=document.createElement("input")

        joiningdate.setAttribute("name","joiningdate"+employer_number);
        joiningdate.setAttribute("id","joiningdate"+employer_number);

	joiningdate.setAttribute("type","text");
	joiningdate.setAttribute("size","8");

        var replace = "'"+"joiningdate"+employer_number+"'";

        var link1 = document.createElement("a");
	link1.href = "javascript:NewCal("+replace+",'ddmmyyyy')";

        var image=document.createElement("img");
        image.setAttribute("src", "images/newhelp.gif");
        image.setAttribute("border", "0");
	link1.appendChild(image);
        cell6.appendChild(joiningdate);

        cell6.appendChild(link1);




	cell1.appendChild(bold1);
	cell2.appendChild(text);
	cell3.appendChild(bold2);
	cell4.appendChild(duration)
	cell4.appendChild(lable3);


	row1.appendChild(cell1);
	row1.appendChild(cell2);
	row1.appendChild(cell3);
	row1.appendChild(cell4);
        row1.appendChild(cell5);
        row1.appendChild(cell6);



        var row2=document.createElement('tr');

	var r2c1=document.createElement('td');

        var r2l1=document.createTextNode("Designation");
	var r2b1=document.createElement("b");
	r2b1.appendChild(r2l1);

	var r2c2 =document.createElement('td');

	var client=document.createElement("input")
	client.setAttribute("type","text");
	client.setAttribute("size","45");
	client.setAttribute("name","designation"+employer_number);

	var r2c3=document.createElement('td');
	var r2l2=document.createTextNode("Role");
	var r2b2=document.createElement("b");
	r2b2.appendChild(r2l2);

	var r2c4 =document.createElement('<td>');

	var Environment=document.createElement("input")
	Environment.setAttribute("type","text");
	Environment.setAttribute("size","10");
	Environment.setAttribute("name","role"+employer_number);

        var r2c5=document.createElement('<td>');
	var r3l3=document.createTextNode("Relieving Date");
	var r3b3=document.createElement("b");

        r3b3.appendChild(r3l3);
	r2c5.appendChild(r3b3);

        var r2c6=document.createElement('<td>');
	var getvaluerelievingdate=document.createElement("input")
	getvaluerelievingdate.setAttribute("name","relievingdate"+employer_number);
        getvaluerelievingdate.setAttribute("id","relievingdate"+employer_number);

	getvaluerelievingdate.setAttribute("type","text");
	getvaluerelievingdate.setAttribute("size","8");


         var link2 = document.createElement("a");
         var fetch = "'"+"relievingdate"+employer_number+"'";

	link2.setAttribute("href", "javascript:NewCal("+fetch+",'ddmmyyyy')");

        var image1=document.createElement("img");
        image1.setAttribute("src", "images/newhelp.gif");
        image1.setAttribute("border", "0");
	link2.appendChild(image1);



        r2c6.appendChild(getvaluerelievingdate);

        r2c6.appendChild(link2);

	r2c1.appendChild(r2b1);
	r2c2.appendChild(client);
	r2c3.appendChild(r2b2);
	r2c4.appendChild(Environment);

	row2.appendChild(r2c1);
	row2.appendChild(r2c2);
	row2.appendChild(r2c3);
	row2.appendChild(r2c4);
        row2.appendChild(r2c5);
        row2.appendChild(r2c6);


        var row4=document.createElement('tr');
	var r4c1=document.createElement('<td >');
	var r4l1=document.createTextNode("Job Profile");
	var r4b1=document.createElement("b");

	r4b1.appendChild(r4l1);
	r4c1.appendChild(r4b1);



	var row4=document.createElement('tr');
	var r4c2=document.createElement('<td colspan=4>');
	var textarea = document.createElement("textarea");
	textarea.setAttribute("cols", "75");
 	textarea.setAttribute("rows", "2");
 	textarea.setAttribute("wrap", "physical");
 	var idno="jobprofile"+employer_number;
 	textarea.setAttribute("name", idno);
 	textarea.setAttribute("id", idno);

	r4c2.appendChild(textarea);


        var r4c3=document.createElement('<td>');
	var getvalue=document.createElement("input")
	getvalue.setAttribute("name","maxemp");
	getvalue.setAttribute("value",employer_number);
	getvalue.setAttribute("type","hidden");
	getvalue.setAttribute("size","30");
	r4c3.appendChild(getvalue);


        var remove = document.createElement("a");
        remove.setAttribute("href", "javascript:removeEmployerInput('f"+employer_number+"');");
	remove.appendChild(document.createTextNode("remove"));
        r4c3.appendChild(remove);


        row4.appendChild(r4c1);
	row4.appendChild(r4c2);
        row4.appendChild(r4c3);







	d.setAttribute("id", "f"+employer_number);



	tbody1.appendChild(row1);
	tbody1.appendChild(row2);

	tbody1.appendChild(row4);


	table1.appendChild(tbody1);
	d.appendChild(table1);

	document.getElementById("moreEmployer").appendChild(d);



	employer_number++;
	}

function removeEmployerInput(i) {
	var el = document.getElementById(i);
	document.getElementById("moreEmployer").removeChild(el);
}


function isNumber(str)
{
	var pattern = "0123456789"
	var i = 0;
	do
    {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                {
					pos = 1;
       				break;
      			}
    			i++;
 	}
 	while (pos==1 && i<str.length)
 	if (pos==0)
    		return false;
 	return true;
}
function isCTC(str)
{
	var pattern = "0123456789."
	var i = 0;
	do
    {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                {
					pos = 1;
       				break;
      			}
    			i++;
 	}
 	while (pos==1 && i<str.length)
 	if (pos==0)
    		return false;
 	return true;
}

	/** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

function isPositiveInteger(str)
{
	var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ."
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function isStringValid(str)
{
	var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function isAlphaNumeric(str)
{
	var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'1234567890-.@_"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function isPanValid(str)
{
	var pattern = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function isDlValid(str)
{
	var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890/"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function isEmailValid(str)
{
	var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.@_-"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function isDesignationValid(str)
{
	var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890:-"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function isValid(str)
{
	var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'1234567890-.@_(),&:"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function isEnvironmentValid(str)
{
	var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'1234567890-.,/"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function isDate(str)
{
	var pattern = "1234567890-"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function fun(theForm)
{
		if (trim(theForm.firstname.value)=='' )
		{
			alert('Please Enter the First Name');
			document.theForm.firstname.value="";
			theForm.firstname.focus();
			return false;
		}
		if (!isStringValid(trim(theForm.firstname.value)))
		{
			alert('Please enter the valid First Name ');
			document.theForm.firstname.value="";
			theForm.firstname.focus();
			return false;
		}
		if (trim(theForm.lastname.value)=='' )
		{
			alert('Please Enter the Last Name');
			document.theForm.lastname.value="";
			theForm.lastname.focus();
			return false;
		}
		if (!isStringValid(trim(theForm.lastname.value)))
		{
			alert('Please enter the valid Last Name ');
			document.theForm.lastname.value="";
			theForm.lastname.focus();
			return false;
		}
		if (!isNumber(trim(theForm.phone.value)) && trim(theForm.phone.value)!='')
		{
			alert('Please enter only Numerical Characters in the Phone ');
//			document.theForm.phone.value="";
			theForm.phone.focus();
			return false;
		}
		if (trim(theForm.mobile.value)=='')
		{
			alert('Please enter the Mobile No ');
			document.theForm.mobile.value="";
			theForm.mobile.focus();
			return false;
		}
		if (!isNumber(trim(theForm.mobile.value)))
		{
			alert('Please enter only Numerical values in the mobile ');
//			document.theForm.mobile.value="";
			theForm.mobile.focus();
			return false;
		}
                if (!((trim(theForm.mobile.value)).length == 10))
		{
			alert('Please enter the valid mobile no ');
//			document.theForm.mobile.value="";
			theForm.mobile.focus();
			return false;
		}
                if (trim(theForm.email.value)=='')
                {
   			alert('Please enter the email ');
			document.theForm.email.value="";
                        theForm.email.focus();
                        return false;
  		}
		if (!isEmailValid(trim(theForm.email.value)))
                {
   			alert('Please enter valid email id ');
	//		document.theForm.email.value="";
                        theForm.email.focus();
                        return false;
  		}

                if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(theForm.email.value)))
 		{
			alert("Invalid E-mail Address! Please re-enter.")
	//		document.theForm.email.value="";
                        theForm.email.focus();
                        return (false);
		}

		if (trim(theForm.location.value)=='')
                {
   			alert('Please enter the location ');
//			document.theForm.location.value="";
                        theForm.location.focus();
                        return false;
  		}
  		if (!isStringValid(trim(theForm.location.value)))
		{
			alert('Please enter only Alphabets in the location ');
//			document.theForm.location.value="";
			theForm.location.focus();
			return false;
		}
		if (trim(theForm.refempid.value)=='')
                {
   			alert('Please enter the Ref Emp ID ');
		//	document.theForm.refempid.value="";
                        theForm.refempid.focus();
                        return false;
  		}
		if (!isPanValid(trim(theForm.refempid.value)))
                {
   			alert('Please enter the valid Ref Emp ID ');
	//		document.theForm.refempid.value="";
                        theForm.refempid.focus();
                        return false;
  		}
                if (trim(theForm.ugcourse.value)=='')
                {
   			alert('Please Enter UG Cource ');
			document.theForm.ugcourse.value="";
                        theForm.ugcourse.focus();
                        return false;
  		}
		if (!isPositiveInteger(trim(theForm.ugcourse.value)))
                {
   			alert('Please enter the Alphabets only in the UG Course ');
			document.theForm.ugcourse.value="";
                        theForm.ugcourse.focus();
                        return false;
  		}
		if (trim(theForm.ugbranch.value)=='')
                {
   			alert('Please Enter UG Branch ');
			document.theForm.ugbranch.value="";
                        theForm.ugbranch.focus();
                        return false;
  		}
		if (!isStringValid(trim(theForm.ugbranch.value)))
                {
   			alert('Please enter the valid UG Branch ');
			document.theForm.ugbranch.value="";
                        theForm.ugbranch.focus();
                        return false;
  		}
		if (trim(theForm.uginstitute.value)=='')
                {
   			alert('Please Enter UG Institute ');
			document.theForm.uginstitute.value="";
                        theForm.uginstitute.focus();
			return false;
  		}
		if (!isStringValid(trim(theForm.uginstitute.value)))
                {
   			alert('Please enter the valid UG Institute ');
			document.theForm.uginstitute.value="";
                        theForm.uginstitute.focus();
			return false;
  		}
		if (trim(theForm.uggraduationyear.value)=='0')
                {
   			alert('Please Enter UG Graduation year ');
			document.theForm.uggraduationyear.value="";
                        theForm.uggraduationyear.focus();
                        return false;
  		}

  		 var current_date = new Date();

  		if (trim(theForm.uggraduationyear.value)>current_date.getYear())
                {
   			alert('Please enter the correct  UG Graduation year ');
			document.theForm.uggraduationyear.value="";
                        theForm.uggraduationyear.focus();
                        return false;
  		}
		if (trim(theForm.ugpercentage.value)=='')
                {
   			alert('Please enter the UG Percentage  ');
			document.theForm.ugpercentage.value="";
                        theForm.ugpercentage.focus();
                        return false;
  		}
		if (!isCTC(trim(theForm.ugpercentage.value)))
                {
   			alert('Please enter the valid UG Percentage  ');
			document.theForm.ugpercentage.value="";
                        theForm.ugpercentage.focus();
                        return false;
  		}
  		if (trim(theForm.ugpercentage.value)>100)
                {
   			alert('Please enter the correct  UG Percentage ');
			document.theForm.ugpercentage.value="";
                        theForm.ugpercentage.focus();
                        return false;
  		}
		if (trim(theForm.pgcourse.value)!='' && !isPositiveInteger(trim(theForm.pgcourse.value)) )
                {
   			alert('Please enter the valid PG course ');
			document.theForm.pgcourse.value="";
                        theForm.pgcourse.focus();
                        return false;
  		}
		if (trim(theForm.pgbranch.value)!='' && !isStringValid(trim(theForm.pgbranch.value)) )
                {
   			alert('Please enter the valid PG branch ');
			document.theForm.pgbranch.value="";
                        theForm.pgbranch.focus();
                        return false;
  		}
		if (trim(theForm.pginstitute.value)!='' && !isStringValid(trim(theForm.pginstitute.value)) )
                {
   			alert('Please enter the valid PG Institute ');
			document.theForm.pginstitute.value="";
                        theForm.pginstitute.focus();
                        return false;
  		}

  		if (trim(theForm.pggraduationyear.value) != '0' && (trim(theForm.pggraduationyear.value) < trim(theForm.uggraduationyear.value)) )
                {
   			alert('Please enter valid PG Graduation year ');
			document.theForm.pggraduationyear.value="";
                        theForm.pggraduationyear.focus();
                        return false;
  		}

		if (trim(theForm.pgpercentage.value)!='' && !isCTC(trim(theForm.pgpercentage.value)) )
                {
   			alert('Please enter the valid PG percentage');
			document.theForm.pgpercentage.value="";
                        theForm.pgpercentage.focus();
                        return false;
  		}
  		if (trim(theForm.pgpercentage.value)>100)
                {
   			alert('Please enter the correct  PG Percentage ');
			document.theForm.pgpercentage.value="";
                        theForm.pgpercentage.focus();
                        return false;
  		}
		if (trim(theForm.sapyears.value)!='' && !isNumber(trim(theForm.sapyears.value)) )
                {
   			alert('Please enter the Numerical only in the sap years');
			document.theForm.sapyears.value="";
                        theForm.sapyears.focus();
                        return false;
  		}
		if (trim(theForm.sapmonths.value)!='' && !isNumber(trim(theForm.sapmonths.value)) )
                {
   			alert('Please enter the Numerical only in the sap months ');
			document.theForm.sapmonths.value="";
                        theForm.sapmonths.focus();
                        return false;
  		}
                if (trim(theForm.sapmonths.value)!='' && trim(theForm.sapmonths.value) >11 )
                {
   			alert('SAP months should be less than 12 ');
			document.theForm.sapmonths.value="";
                        theForm.sapmonths.focus();
                        return false;
  		}


                if (trim(theForm.totalyears.value)!='' && !isNumber(trim(theForm.totalyears.value)) )
                {
   			alert('Please enter the Numerical only in the total years');
			document.theForm.totalyears.value="";
                        theForm.totalyears.focus();
                        return false;
  		}
		if (trim(theForm.totalmonths.value)!='' && !isNumber(trim(theForm.totalmonths.value)) )
                {
   			alert('Please enter the Numerical only in the total months ');
			document.theForm.totalmonths.value="";
                        theForm.totalmonths.focus();
                        return false;
  		}
		if (trim(theForm.totalmonths.value)!='' && trim(theForm.totalmonths.value) > 11 )
                {
   			alert('Total months should be less than 12 ');
			document.theForm.totalmonths.value="";
                        theForm.totalmonths.focus();
                        return false;
  		}
                if (trim(theForm.sapmonths.value) != '' || trim(theForm.sapyears.value) != ''){

                        if (trim(theForm.totalmonths.value) == '' && trim(theForm.totalyears.value) == ''){
                            alert('Please enter the Total Experience ');
                            document.theForm.totalyears.value="";
                            theForm.totalyears.focus();
                            return false;

                        }
                        var sMonth = 0, sYear = 0, tMonth = 0, tYear = 0;
                        if (trim(theForm.sapmonths.value) != ''){
                            sMonth = trim(theForm.sapmonths.value);
                        }
                        if (trim(theForm.sapyears.value) != ''){
                            sYear = trim(theForm.sapyears.value);
                        }
                        if (trim(theForm.totalmonths.value) != ''){
                            tMonth = trim(theForm.totalmonths.value);
                        }
                        if (trim(theForm.totalyears.value) != ''){
                            tYear = trim(theForm.totalyears.value);
                        }

                        var sapEx   = (sYear*12) + sMonth;
                        var totalEx = (tYear*12) + tMonth;

                        if (totalEx < sapEx){

                            alert('Please check the Total Experience ');
                            document.theForm.totalyears.value="";
                            document.theForm.totalmonths.value="";
                            theForm.totalyears.focus();
                            return false;

                        }



                }
		if ( trim(document.theForm.areaofexpertise.value) == "XX")
                {
			alert ( "Please select Area of Expertise." );
                        document.theForm.areaofexpertise.focus();
			return false;
                }

		if (trim(theForm.tools.value)!='' && !isEnvironmentValid(trim(theForm.tools.value)) )
		{
			alert('Please enter the AlphaNumerical Characters only in the tools ');
			document.theForm.tools.value="";
   			theForm.tools.focus();
   			return false;
		}

                if (trim(theForm.totalmonths.value) != '' || trim(theForm.totalyears.value) != ''){

                        var  tMonth = 0, tYear = 0;

                        if (trim(theForm.totalmonths.value) != ''){
                            tMonth = trim(theForm.totalmonths.value);
                        }
                        if (trim(theForm.totalyears.value) != ''){
                            tYear = trim(theForm.totalyears.value);
                        }


                        var totalEx = (tYear*12) + tMonth;


                        if (totalEx > 0){

                    if (trim(theForm.previousemployer1.value) =='') {
                        alert('Please enter the Current Employer ');
                        document.theForm.previousemployer1.value="";
                        theForm.previousemployer1.focus();
                        return false;
                    }
                    if (trim(theForm.ctc1.value) =='' ){
                        alert('Please enter the CTC ');
                        document.theForm.ctc1.value="";
                        theForm.ctc1.focus();
                        return false;
                    }
                    if (trim(theForm.joiningdate1.value) =='' ){
                        alert('Please enter the Joining Date ');
                        document.theForm.joiningdate1.value="";
                        theForm.joiningdate1.focus();
                        return false;
                    }
                    if (trim(theForm.designation1.value) =='' ){
                        alert('Please enter the Designation ');
                        document.theForm.designation1.value="";
                        theForm.designation1.focus();
                        return false;
                    }
                    if (trim(theForm.role1.value) ==''){
                        alert('Please enter the Role ');
                        document.theForm.role1.value="";
                        theForm.role1.focus();
                        return false;
                    }

                    if (trim(theForm.relievingdate1.value) ==''){
                        alert('Please enter the Relieving Date ');
                        document.theForm.relievingdate1.value="";
                        theForm.relievingdate1.focus();
                        return false;
                    }


                }


                }

		if (trim(theForm.previousemployer1.value)!='' && !isValid(trim(theForm.previousemployer1.value)) )
                {
                        alert('Please enter only  valid characters in the previous employer ');
                        document.theForm.previousemployer1.value="";
                        theForm.previousemployer1.focus();
                        return false;
                }
        if (trim(theForm.ctc1.value)!='' && !isCTC(trim(theForm.ctc1.value)) )
        {
   		alert('Please enter the valid CTC ');
		document.theForm.ctc1.value="";
                theForm.ctc1.focus();
                return false;
  	}
        if (trim(theForm.designation1.value)!='' && !isDesignationValid(trim(theForm.designation1.value)) )
        {
   		alert('Please enter only valid characters in the Designation ');
		document.theForm.designation1.value="";
                theForm.designation1.focus();
                return false;
  	}
        if (trim(theForm.role1.value)!='' && !isPositiveInteger(trim(theForm.role1.value)) )
        {
   		alert('Please enter only Alphabets in the Role ');
		document.theForm.role1.value="";
                theForm.role1.focus();
                return false;
  	}
        if (trim(theForm.joiningdate1.value)!='' && !isDate(trim(theForm.joiningdate1.value)) )
        {
   		alert('Please enter the valid Joining Date ');
		document.theForm.joiningdate1.value="";
                theForm.joiningdate1.focus();
                return false;
  	}
        if (trim(theForm.relievingdate1.value)!='' && !isDate(trim(theForm.relievingdate1.value)) )
        {
   		alert('Please enter the valid Relieving Date ');
		document.theForm.relievingdate1.value="";
                theForm.relievingdate1.focus();
                return false;
  	}


        if (trim(theForm.position.value)!='' && !isPositiveInteger(trim(theForm.position.value)) )
        {
   		alert('Please enter only valid characters in the position ');
		document.theForm.position.value="";
                theForm.position.focus();
                return false;
  	}
        if (trim(theForm.desiredlocation.value)=='')
        {
   		alert('Please enter the desired location ');
		document.theForm.desiredlocation.value="";
                theForm.desiredlocation.focus();
                return false;
  	}
        if (!isPositiveInteger(trim(theForm.desiredlocation.value)) )
        {
   		alert('Please enter only valid characters in the desired location ');
		document.theForm.desiredlocation.value="";
                theForm.desiredlocation.focus();
                return false;
  	}
        if (trim(theForm.noticeperiod.value)!='' && !isNumber(trim(theForm.noticeperiod.value)) )
        {
   			alert('Please enter only Numerical values in Notice Period ');
			document.theForm.noticeperiod.value="";
                        theForm.noticeperiod.focus();
                        return false;
        }
        if (trim(theForm.ectc.value) == '')
        {
   		alert('Please enter the Expected CTC ');
		document.theForm.ectc.value="";
                theForm.ectc.focus();
                return false;
  	}
        if (!isCTC(trim(theForm.ectc.value)) )
        {
   		alert('Please enter the valid Expected CTC ');
		document.theForm.ectc.value="";
                theForm.ectc.focus();
                return false;
  	}
        if (trim(theForm.referencename.value)!='' && !isPositiveInteger(trim(theForm.referencename.value)) )
        {
   		alert('Please enter only valid characters in the reference name ');
		document.theForm.referencename.value="";
                theForm.referencename.focus();
                return false;
  	}
        if (trim(theForm.referencedesignation.value)!='' && !isDesignationValid(trim(theForm.referencedesignation.value)) )
        {
   		alert('Please enter only valid characters in the reference designation ');
		document.theForm.referencedesignation.value="";
                theForm.referencedesignation.focus();
                return false;
  	}
        if (trim(theForm.organization.value)!='' && !isAlphaNumeric(trim(theForm.organization.value)) )
        {
   		alert('Please enter the AlphaNumerical only in the organization ');
		document.theForm.organization.value="";
                theForm.organization.focus();
                return false;
  	}
        if (trim(theForm.refemployeeid.value)!='' && !isAlphaNumeric(trim(theForm.refemployeeid.value)) )
        {
   		alert('Please enter the AlphaNumerical only in the refemployee id ');
		document.theForm.refemployeeid.value="";
                theForm.refemployeeid.focus();
                return false;
  	}
        if (trim(theForm.refcountrycode.value)!='' && !isNumber(trim(theForm.refcountrycode.value)) )
        {
   		alert('Please enter the Numerical only in the refcountry code');
		document.theForm.refcountrycode.value="";
                theForm.refcountrycode.focus();
                return false;
  	}
	if (trim(theForm.refstdcode.value)!='' && !isNumber(trim(theForm.refstdcode.value)) )
        {
   		alert('Please enter the Numerical only in the refstd code ');
		document.theForm.refstdcode.value="";
                theForm.refstdcode.focus();
                return false;
  	}
        if (trim(theForm.refphone.value)!='' && !isNumber(trim(theForm.refphone.value)) )
        {
   		alert('Please enter the Numerical only in the ref phone ');
		document.theForm.refphone.value="";
                theForm.refphone.focus();
                return false;
  	}
        if (trim(theForm.refmobileno.value)!='' && !isNumber(trim(theForm.refmobileno.value)))
		{
			alert('Please enter only Numerical values in the Ref mobile No ');
			document.theForm.refmobileno.value="";
			theForm.refmobileno.focus();
			return false;
		}
       if (trim(theForm.refmobileno.value)!='' && !((trim(theForm.refmobileno.value)).length == 10))
		{
			alert('Please enter the valid Ref mobile No ');
			document.theForm.refmobileno.value="";
			theForm.refmobileno.focus();
			return false;
		}
        if (trim(theForm.refmailid.value)!='' && !isEmailValid(trim(theForm.refmailid.value)) )
        {
   		alert('Please enter valid refmail id ');
		document.theForm.refmailid.value="";
                theForm.refmailid.focus();
                return false;
  	}
        if (trim(theForm.dateofbirth.value)=='')
        {
   			alert('Please select the Date of Birth ');
			document.theForm.dateofbirth.value="";
                        theForm.dateofbirth.focus();
                        return false;
  	}
  		var str   = document.theForm.dateofbirth.value;
                var first = str.indexOf("-");
                var last  = str.lastIndexOf("-");
                var year         = str.substring(last+1,last+5);
                var month        = str.substring(first+1,last);
                var date         = str.substring(0,first);
                var form_date    = new Date(year,month-1,date);
                var current_date = new Date();

		if (!isDate(trim(theForm.dateofbirth.value)))
        {
   			alert('Please enter the valid Date of Birth ');
			document.theForm.dateofbirth.value="";
                        theForm.dateofbirth.focus();
                        return false;
  	}

            if((form_date.getYear()+1900) > (current_date.getYear()-18))
        {
			window.alert("Enter the valid Date of Birth");
			theForm.dateofbirth.focus();
			return false;
	}

            if(trim(theForm.uggraduationyear.value) < (form_date.getYear()+1918))
        {
			window.alert("Please check the UG graduation year");
			theForm.uggraduationyear.focus();
			return false;
	}


                var joinYear = '';
        if(trim(theForm.joiningdate1.value) != ''){
                var str   = document.theForm.joiningdate1.value;
                var first = str.indexOf("-");
                var last  = str.lastIndexOf("-");
                joinYear  = str.substring(last+1,last+5);
                if( (trim(theForm.uggraduationyear.value) > joinYear)){

                        window.alert("Please check the joining date");
			theForm.joiningdate1.focus();
			return false;
                }
	}


                var relieveYear = '';
        if(trim(theForm.relievingdate1.value) != ''){
                var str     = document.theForm.relievingdate1.value;
                var first   = str.indexOf("-");
                var last    = str.lastIndexOf("-");
                relieveYear = str.substring(last+1,last+5);

                if(relieveYear < joinYear){

                        window.alert("Please check the relieving date");
			theForm.relievingdate1.focus();
			return false;
                }
	}

        if (trim(theForm.city.value)!='' && !isPositiveInteger(trim(theForm.city.value)) )
        {
   		alert('Please enter only valid characters in the city ');
		document.theForm.city.value="";
                theForm.city.focus();
                return false;
  	}
        if (trim(theForm.pincode.value)!='' && !isNumber(trim(theForm.pincode.value)) )
        {
   		alert('Please enter the Numerical only in the pincode ');
		document.theForm.pincode.value="";
                theForm.pincode.focus();
                return false;
  	}



        if(trim(theForm.totalyears.value) == 0){
                if(trim(theForm.pancardno.value) == '' && trim(theForm.passportno.value) == '' && trim(theForm.voteridno.value) == '' && trim(theForm.dlno.value) == ''){
                    alert('Please enter one of DL, Passport, VoterId, PAN No');
                    document.theForm.pancardno.value="";
                    theForm.pancardno.focus();
                    return false;
                }
        }
        if( trim(theForm.totalyears.value) >= 1 && trim(theForm.totalyears.value) <= 2){
                if(trim(theForm.pancardno.value) == ''){
                    alert('Please enter PAN No');
                    document.theForm.pancardno.value="";
                    theForm.pancardno.focus();
                    return false;
                }
        }

        if(trim(theForm.totalyears.value) >= 3){
                if(trim(theForm.pancardno.value) == ''){
                    alert('Please enter PAN No');
                    document.theForm.pancardno.value="";
                    theForm.pancardno.focus();
                    return false;
                }
        }
        if(trim(theForm.totalyears.value) >= 3){
                if(trim(theForm.passportno.value) == ''){
                    alert('Please enter Passport No');
                    document.theForm.passportno.value="";
                    theForm.passportno.focus();
                    return false;
                }
        }
        if (trim(theForm.pancardno.value)!='' && !isPanValid(trim(theForm.pancardno.value)) )
        {
   		alert('Please enter the valid pancard no ');
		document.theForm.pancardno.value="";
                theForm.pancardno.focus();
                return false;
  	}
        if (trim(theForm.passportno.value)!='' && !((trim(theForm.pancardno.value)).length == 10))
		{
			alert('Please enter the valid PAN no ');
			document.theForm.pancardno.value="";
			theForm.pancardno.focus();
			return false;
		}
        if (trim(theForm.passportno.value)!='' && !isPanValid(trim(theForm.passportno.value)) )
        {
   		alert('Please enter the valid passport no ');
		document.theForm.passportno.value="";
                theForm.passportno.focus();
                return false;
  	}
        if (trim(theForm.passportno.value)!='' && !(trim(theForm.passportno.value).length == 8) )
        {
   		alert('Please enter the valid passport no ');
		document.theForm.passportno.value="";
                theForm.passportno.focus();
                return false;
  	}
        if (trim(theForm.dlno.value)!='' && !isDlValid(trim(theForm.dlno.value)) )
        {
   		alert('Please enter the valid DL no ');
		document.theForm.dlno.value="";
                theForm.dlno.focus();
                return false;
  	}
        if (trim(theForm.voteridno.value)!='' && !isDlValid(trim(theForm.voteridno.value)) )
        {
   		alert('Please enter the valid voter id no ');
		document.theForm.voteridno.value="";
                theForm.voteridno.focus();
                return false;
  	}
        if (trim(theForm.projectname1.value) =='' )
        {
   		alert('Please enter project name ');
		document.theForm.projectname1.value="";
                theForm.projectname1.focus();
                return false;
  	}
        if (!isValid(trim(theForm.projectname1.value)) )
        {
   		alert('Please enter valid project name ');
		document.theForm.projectname1.value="";
                theForm.projectname1.focus();
                return false;
  	}
        if (trim(theForm.duration1.value) =='' )
        {
   		alert('Please enter the duration ');
		document.theForm.duration1.value="";
                theForm.duration1.focus();
                return false;
  	}
        if (!isNumber(trim(theForm.duration1.value)) )
        {
   		alert('Please enter only numeric value in the duration ');
		document.theForm.duration1.value="";
                theForm.duration1.focus();
                return false;
  	}
        if (trim(theForm.teamsize1.value) =='' )
        {
   		alert('Please enter the teamsize ');
		document.theForm.teamsize1.value="";
                theForm.teamsize1.focus();
                return false;
  	}
        if (!isNumber(trim(theForm.teamsize1.value)) )
        {
   		alert('Please enter only  numeric value in the teamsize ');
		document.theForm.teamsize1.value="";
                theForm.teamsize1.focus();
                return false;
  	}
        if (trim(theForm.client1.value) =='')
        {
   		alert('Please enter the client ');
		document.theForm.client1.value="";
                theForm.client1.focus();
                return false;
  	}
        if (!isValid(trim(theForm.client1.value)) )
        {
   		alert('Please enter the valid client name ');
		document.theForm.client1.value="";
                theForm.client1.focus();
                return false;
  	}
        if (trim(theForm.environment1.value) =='')
        {
   		alert('Please enter the environment ');
		document.theForm.environment1.value="";
                theForm.environment1.focus();
                return false;
  	}
        if (!isEnvironmentValid(trim(theForm.environment1.value)))
        {
   		alert('Please enter the valid environment name ');
		document.theForm.environment1.value="";
                theForm.environment1.focus();
                return false;
  	}
        if (trim(theForm.description1.value) =='')
        {
   		alert('Please enter the description ');
		document.theForm.description1.value="";
                theForm.description1.focus();
                return false;
  	}

        if (trim(theForm.roles1.value) =='')
        {
   		alert('Please enter the roles ');
		document.theForm.roles1.value="";
                theForm.roles1.focus();
                return false;
  	}



	return true;
}
function setFocus()
	{
		document.theForm.firstname.focus();
	}


	window.onload = setFocus;


</SCRIPT>
<body >
<FORM name=theForm ONSUBMIT="return fun(this)" action="<%=request.getContextPath() %>/ERM/addCandidate.jsp" method=post onReset="return setFocus()" method="post">
<div align="center">
<center>
    <table cellpadding="0" cellspacing="0" width="90%">
        <TR>
            <td align="right"><img src="../eminentech support files/Eminentlabs_logo.gif" alt="Eminentlabs Software Pvt Ltd"></td>
        </TR>
    <tr bgcolor="C3D9FF" style="height:25px;">
        <td  align="center" width="90%"><b><font size="7" color="#006699"> <strong style="font-size: 12px;">Eminentlabs&trade; New Applicant Registration Form</strong></font></b></td>
    </tr>
    </table>
    <TABLE width="90%"   bgColor=#E8EEF7 border="0">
    <tr><td width="10%"><font size="4" color="#006699"><strong>USER INFORMATION</strong></font></td></tr>
    </TABLE>
    <table width="90%"  cellspacing="1" cellpadding="4" bgColor=#E8EEF7 border="0">
        <tr>
            <td  width="13%"><strong>First Name<font size="10" COLOR="#FF0000">**</font></strong></td>
            <td><input type="text" name="firstname" id="firstname" maxlength="25" size=18></td>
            <td   width="13%"><strong>&nbsp;Last Name<font size="10" COLOR="#FF0000">**</font></strong></td>
            <td><input type="text" name="lastname" id="lastname" maxlength="25" size=18></td>
            <td  width="10%"><strong>Phone </strong></td>
            <td><input type="text" name="phone" id="phone" maxlength="13" size=10></td>
            <td  width="10%"><strong>&nbsp;Mobile<font size="10" COLOR="#FF0000">**</font></strong></td>
            <td><input type="text" name="mobile" id="mobile" maxlength="10" size=8></td>
        </tr>
     <tr>
        <td width="13%"><strong>Email<font size="10" COLOR="#FF0000">**</font></strong></td>
        <td><input type="text" name="email"  id="email" maxlength="30" size=18><span class="style13"></span></td><td></td><td></td>
        <td width="10%"><strong>Location <font size="10" COLOR="#FF0000">**</font></strong></td>
        <td><input type="text" name="location" id="location" maxlength="30" size=10></td>
        <td width="10%"><strong>&nbsp;Ref ID<font size="10" COLOR="#FF0000">**</font></strong></td>
        <td><input type="text" id="refempid" name="refempid" maxlength="5" size=8 onChange="javascript:callproduct();"><strong class="style20" ></strong></td>
    </tr>
    </table><br>

    <table width="90%"   bgColor=#E8EEF7 border="0">
        <tr><td width="10%"><font size="4" color="#006699"><strong>EDUCATIONAL QUALIFICATION</strong></font></td></tr>
    </table>
    <table width="90%"  cellspacing="1" cellpadding="1" bgColor=#E8EEF7 border="0">
        <tr>
            <td width="13%"><strong>UG Course <font size="10" COLOR="#FF0000">**</font></strong></td>
            <td width="46%"><input type="text" name="ugcourse" id="ugcourse" maxlength="20" size=25></td>
            <td width="10%"><strong>&nbsp;&nbsp;PG Course </strong></td>
            <td>&nbsp;&nbsp;<input type="text" name="pgcourse" id="pgcourse" maxlength="20" size=25></td>

            
        </tr>
        <tr>
            <td width="13%"><strong>Branch <font size="10" COLOR="#FF0000">**</font></strong></td>
            <td><input type="text" name="ugbranch" id="ugbranch" maxlength="40" size=25></td>
            <td><strong>&nbsp;&nbsp;Branch </strong></td>
            <td>&nbsp;&nbsp;<input type="text" name="pgbranch" id="pgbranch" maxlength="40" size=25></td>
        </tr>
        <tr>
            <td width="13%"><strong>Institute <font size="10" COLOR="#FF0000">**</font></strong></td>
            <td><input type="text" name="uginstitute" id="uginstitute" maxlength="40" size=25></td>
            <td><strong>&nbsp;&nbsp;Institute </strong></td>
            <td>&nbsp;&nbsp;<input type="text" name="pginstitute" id="pginstitute" maxlength="40" size=25></td>
        </tr>

        <%
        //Calculating current year
         Date date  = new Date();
         Calendar c = Calendar.getInstance();
         c.setTime(date);
         int year = c.get(c.YEAR);
        %>

        <tr>
            <td width="13%"><strong>Graduation Year <font size="10" COLOR="#FF0000">**</font></strong></td>

            <td><select name="uggraduationyear" id="uggraduationyear" size="1">
                    <option value="0" selected>Select</option>
                    <%
                    for(int i = 20;i>0;i--){
                    %>
                    <option value="<%= year %>"><%= year %></option>
                    <%
                    year = year-1;
                    }
                    %>
                </select>
            </td>

            <td><strong>&nbsp;&nbsp;Graduation Year </strong></td>
            <%
                year = year + 20;
            %>
            <td>&nbsp;&nbsp;<select name="pggraduationyear" id="pggraduationyear" size="1">
                    <option value="0" SELECTED>Select</option>
                    <%
                    for(int i = 20;i>0;i--){
                    %>
                    <option value="<%= year %>"><%= year %></option>
                    <%
                    year = year-1;
                    }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td width="13%"><strong>UG Percentage <font size="10" COLOR="#FF0000">**</font></strong></td>
            <td><input type="text" name="ugpercentage" id="ugpercentage" maxlength="5" size=6><strong class="style20">%</strong></td>

            <td><strong>&nbsp;&nbsp;PG Percentage </strong></td>
            <td>&nbsp;&nbsp;<input type="text" name="pgpercentage" id="pgpercentage" maxlength="5" size=6><strong class="style20">%</strong></td>
        </tr>
    </table><br>


    <table width="90%"   bgColor=#E8EEF7 border="0">
        <tr><td width="10%"><font size="4" color="#006699"><strong>SKILLS AND EXPERIENCE</strong></font></td></tr>
    </table>
    <table width="90%"  cellspacing="1" cellpadding="1" bgColor=#E8EEF7 border="1">
        <tr>
            <td width="13%"><strong>SAP Experience</strong></td>
            <td width="10%"><input type="text" name="sapyears" id="sapyears" maxlength="2" size=2>Yrs</td>
            <td width="30%"><input type="text" name="sapmonths" id="sapmonths" maxlength="2" size=2>Months</td>
            <td width="10%"><strong>Core Competence</strong></td>
            <td width="27%"><SELECT name="corecompetence" id="corecompetence" size="1">
                    <option value="XX" selected>--None--</option>
                    <option value="F" >Functional</option>
                    <option value="T">Technical</option>
                    <option value="TF">Techno Functional</option>
                </SELECT></td>
        </tr>
        <tr>
        <td width="13%"><strong>Total Experience </strong></td>
        <td width="10%"><input type="text" name="totalyears" maxlength="2" size=2>Yrs</td>
        <td width="30%"><input type="text" name="totalmonths" maxlength="2" size=2>Months</td>
        <td width="10%"><strong>Area of Expertise<font size="10" COLOR="#FF0000">**</font></strong></td>
        <td width="27%"><SELECT name="areaofexpertise" id="areaofexpertise" size="1">
                        <option value="XX" selected>--None--</option>
			<option value="ABAP" >ABAP</option>
                        <option value="APO">Advance Planner Optimizer</option>
			<option value="BS">BASIS</option>
                        <option value="BW">Business Warehousing</option>
						<option value="BW">Business Intelligence</option>
                        <option value="CO">Customer Relationship Management</option>
						<option value="CO">Controlling</option>
                        <option value="EP">Enterprise Portal</option>
                        <option value="XI" >Exchange Infrastructure</option>
                        <option value="FI">Finance</option>
                        <option value="FICO">Finance & Controlling</option>
                        <option value="FR">Fresher</option>
			<option value="HR">Human Resource</option>
                        <option value="MDM">Master Data Management</option>
			<option value="MM">Material Management</option>
                        <option value="NWADMIN">Netweaver Administration</option>
                        <option value="PM">Plant Maintenance</option>
                        <option value="PP">Production Planning</option>
                        <option value="PS">Project Systems</option>
			<option value="SD">Sales and Distribution</option>
			<option value="CO">Supplier Relationship Management</option>
			<option value="WD">WebDynPro</option>
                        <option value="WM">Warehouse Management</option>
			<option value="XIA">XI Administration</option>
           </SELECT></td>
    </tr>
    </table>
    <table width="90%" cellspacing="1" cellpadding="1" border="0" align=center bgcolor="#E8EEF7">
    <tr>
        <td width="13%"><strong>Programming Language </strong></td>
        <td>
        <input type="checkbox" name="proglanguages" id="proglanguages" value="ABAP">ABAP
        &nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="C">C
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="proglanguages" name="proglanguages" value="C++">C++
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="J2EE">J2EE
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="proglanguages" name="proglanguages" value="JAVA">JAVA
        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="MS.NET">MS.NET
        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="OOABAP">OOABAP
        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="WEBDYNPRO">WEBDYNPRO
        </td>
    </tr>
    </table>
    <table width="90%" cellspacing="1" cellpadding="1" border="0" align=center bgcolor="#E8EEF7">
    <tr>
        <td width="13%"><strong>ERP Packages </strong></td>
        <td>
        <input type="checkbox" name="erppackages" id="erppackages"  value="BAAN">BAAN
        &nbsp;<input type="checkbox" name="erppackages" id="erppackages"  value="I2">I2
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="erppackages" name="erppackages"  value="SAP" checked>SAP
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="erppackages" id="erppackages"  value="MS AXAPTA">MS AXAPTA
        &nbsp;<input type="checkbox" name="erppackages" id="erppackages"  value="ORACLE">ORACLE
        <input type="checkbox" name="erppackages" id="erppackages"  value="MANUGSTICS">MANUGSTICS
        </td>
    </tr>
    </table>
    <table width="90%" align=center cellspacing="1" cellpadding="1" border="0" bgcolor="#E8EEF7">
    <tr>
        <td width="13%"><strong>Operating System </strong></td>
        <td>
            <input type="checkbox" name="operatingsystem" id="operatingsystem"  value="AIX">AIX
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="operatingsystem" id="operatingsystem"  value="HP-UX">HP-UX
            &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="operatingsystem" id="operatingsystem"  value="LINUX">LINUX
            &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="operatingsystem" id="operatingsystem"  value="MACNITOSH">MACNITOSH
            &nbsp;<input type="checkbox" name="operatingsystem" id="operatingsystem"  value="UNIX">UNIX
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="operatingsystem" id="operatingsystem"  value="WINDOWS" checked>WINDOWS
        </td>
    </tr>
    </table>
    <table width="90%" align=center cellspacing="1" cellpadding="1" border="0" bgcolor="#E8EEF7">
    <tr>
        <td width="13%"><strong>Database </strong></td>
        <td>
            <input type="checkbox" name="database" id="database"  value="DB2">DB2
        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="database" id="database"  value="MAX DB">MAX DB
        &nbsp;<input type="checkbox" name="database" id="database"  value="MY SQL">MY SQL
        &nbsp;<input type="checkbox" name="database" id="database"  value="ORACLE">ORACLE
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="database" id="database"  value="SQL SERVER">SQL SERVER
        </td>
    </tr>
    </table>
    <table width="90%" align=center cellspacing="1" cellpadding="1" border="0" bgcolor="#E8EEF7">
    <tr>
        <td width="13%"><strong>Tools and Utilities </strong></td>
        <td><input type="text" name="tools" id="tools" maxlength="70" size="63" value="MS Office"> </td>
    </tr>
    </table>
	 <br>

    <table width="90%"   bgColor=#E8EEF7 border="0">
        <tr><td width="10%"><font size="4" color="#006699"><strong>PREVIOUS EXPERIENCE</strong></font></td></tr>
    </table>
    <table width="90%"   bgColor=#E8EEF7 border="0" cellspacing="1" cellpadding="0">
        <tr>
            <td width="13%"><strong>Current Employer </strong></td>
            <td><input type="text" name="previousemployer1" id="previousemployer1" maxlength="100" size=45 onblur="document.getElementById('moreEmployerLink').style.display = 'block';"></td>
            <td ><strong>CTC </strong></td>
            <td><input type="text" name="ctc1" id="ctc1" maxlength="7" size=7>LPA in INR</td>
            <td ><strong>Joining Date</strong></td>
            <td><input type="text" name="joiningdate1" id="joiningdate1" maxlength="10" size="8" /><a href="javascript:NewCal('joiningdate1','ddmmyyyy')">
		<img src="../images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></td>
        </tr>
        <tr>
            <td width="13%"><strong>Designation </strong></td>
            <td><input type="text" name="designation1" id="designation1" maxlength="50" size=45></td>
            <td ><strong>Role </strong></td>
            <td><input type="text" name="role1" id="role1" maxlength="100" size=10></td>
            <td ><strong>Relieving Date</strong></td>

            <td><input type="text" name="relievingdate1" id="relievingdate1" maxlength="10" size="8" /><a href="javascript:NewCal('relievingdate1','ddmmyyyy')">
		<img src="../images/newhelp.gif"  border="0"  width="16" height="16" alt="Pick a date"></a>
            </td>
        </tr
        <tr>
        <td width="13%"><strong>Job Profile </strong></td>
        <td colspan="5"><textarea name="jobprofile1" id="jobprofile1" wrap="physical" cols="92" rows="2" ></textarea>
        </td>
        <tr>
            <td colspan="6">
                <div id="moreEmployer"></div>
                <div id="moreEmployerLink" style="display:none;"><a href="javascript:addEmployerInput();">Add Employer</a></div>
            </td>
        </tr>


    </td>
    </tr>
    </table>
    <br>
    <table width="90%"   bgColor=#E8EEF7 border="0">
    <tr><td width="10%"><font size="4" color="#006699"><strong>DESIRED JOB</strong></font></td></tr></table>
    <table width="90%" align=center cellspacing="1" cellpadding="1" border="0" bgcolor="#E8EEF7">
        <tr>
            <td width="13%"><strong>Job Type</strong></td>
            <td><input type="radio" name="jobtype" id="jobtype" value="C">Contract&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="jobtype" id="jobtype" value="P">Permanent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	        <td width="12%"><strong>Position</strong></td>
		    <td><input type="text" name="position" id="position" maxlength="25" size="16"/></td>
			<td width="12%"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Location<font size="10" COLOR="#FF0000">**</font></strong></td>
	        <td><input type="text" name="desiredlocation" id="desiredlocation" maxlength="30" size="20"/></td>
        </tr>
        <tr>
        <td width="13%"><strong>Notice Period</strong></td>
        <td>&nbsp;&nbsp;<input type="text" name=noticeperiod id=noticeperiod maxlength="3" size="10"/>Days</td>
        <td><strong>Expected CTC<font size="10" COLOR="#FF0000">**</font></strong></td>
        <td><input type="text" name=ectc id=ectc maxlength="5" size="16"/>LPA in INR</td>
        <tr>

    </table><br>
    <table width="90%"   bgColor=#E8EEF7 border="0">
        <tr><td width="10%"><font size="4" color="#006699"><strong>REFERENCE</strong></font></td></tr>
    </table>
    <table width="90%" align=center cellspacing="1" cellpadding="1" border="0" bgcolor="#E8EEF7">
            <tr>
                <td width="13%"><strong>Reference Name</strong></td>
                <td><input type="text" name="referencename" id="referencename" maxlength="25" size="16"/></td>
                <td width="14%" align="center"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Organization</strong></td>
                <td><input type="text" name="organization"  id="organization" maxlength="100" size="16"/></td>
                <td width="18%" align="center"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Employee Id</strong></td>
                <td><input type="text" name="refemployeeid" id="refemployeeid" maxlength="5" size="16"/></td>
            </tr>

            <tr>

                <td width="13%"><strong>Designation</strong></td>
                <td><input type="text" name="referencedesignation" id="referencedesignation" maxlength="50" size="16"/></td>
                <td width="18%" align="center"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Country Code</strong></td>
                <td><input type="text" name="refcountrycode" id="refcountrycode" maxlength="5" size="16"/></td>
                <td width="14%" align="center"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;STD Code</strong></td>
                <td><input type="text" name="refstdcode" id="refstdcode" maxlength="5" size="16"/></td>
            </tr>

            <tr>
                <td width="13%"><strong>Phone #</strong></td>
                <td><input type="text" name="refphone" id="refphone" maxlength="13" size="16"/></td>
                <td width="14%" align="center"><strong>Mobile #</strong></td>
                <td><input type="text" name="refmobileno" id="refmobileno" maxlength="10" size="16"/></td>
                <td width="14%" align="center"><strong>eMail</strong></td>
                <td><input type="text" name="refmailid" id="refmailid" maxlength="30" size="16"/></td>
           </tr>
    </table>
    <br>
    <table width="90%"   bgColor=#E8EEF7 border="0">
        <tr><td width="10%"><font size="4" color="#006699"><strong>PERSONAL DETAILS</strong></font></td></tr>
    </table>
    <table width="90%" align=center cellspacing="1" cellpadding="1" border="0" bgcolor="#E8EEF7">
            <tr>
                <td width="13%"><strong>Date of Birth<font size="10" COLOR="#FF0000">**</font></strong></td>
                <td colspan="1"><input type="text" readonly name="dateofbirth" id="dateofbirth" maxlength="10" size="16" /><a href="javascript:NewCal('dateofbirth','ddmmyyyy')">
		<img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a> </td>
                <td ><strong>Gender</strong></td>
                <td><select NAME="gender" id="gender" size="1">
                        <option value="X" selected>--Select One--</option>
                        <option value="M" >Male</option>
                        <option value="F">Female</option>
                        <option value="E">Eunuch</option>
                    </select>
                </td>
                <td ><strong>Marital Status</strong></td>
                <td><select NAME="maritalstatus" id="maritalstatus" size="1">
                        <option value="X" selected>--Select One--</option>
                        <option value="S" >Single</option>
                        <option value="M">Married</option>
                </select>
                </td>

            </tr>
            <tr>

                <td width="13%"><strong>Voter ID #</strong></td>
                <td width="13%"> <input type="text" name="voteridno" maxlength="10" size="16"/></td>

                <td ><strong>DL #</strong></td>
                <td><input type="text" name="dlno" maxlength="10" size="14"/></td>
                <td ><strong>PAN Card #</strong></td>
                <td><input type="text" name="pancardno" maxlength="10" size="14"/></td>
                <td ><strong>Passport #</strong></td>
                <td><input type="text" name="passportno" maxlength="8" size="12"/></td>
            </tr>
    </table>
    <table width="90%" align=center cellspacing="1" cellpadding="1" border="0" bgcolor="#E8EEF7">
            <tr>
                <td width="12%"><strong>Mailing Address</strong></td>
                <td width="30%">&nbsp;&nbsp;<textarea name="mailingaddress" wrap="physical" cols="34" rows="2"></textarea></td>
                <td width="14%" style="margin-left: 30px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>City</b></td>
                <td width="9%"><input type="text" name="city" maxlength="20" size="14"/></td>
                <td width="14%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Pincode</b></td>
                <td width="15%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="pincode" maxlength="6" size="12"/></td>

            </tr>
    </table>

    <table width="90%"   bgColor=#E8EEF7 border="0">
    <tr><td width="10%"><font size="4" color="#006699"><strong>PROFESSIONAL SUMMARY</strong></font></td></tr>
    </table>
    <table width="90%" align=center cellspacing="1" cellpadding="1" border="0" bgcolor="#E8EEF7">
     <tr>
                <td><textarea name="summarydetails" wrap="physical" cols="90" rows="5"></textarea></td>
     </tr>
    </table><br>
    <table width="90%"   bgColor=#E8EEF7 border="0">
        <tr><td width="10%"><font size="4" color="#006699"><strong>PROJECT DETAILS: Current Project</strong></font></td></tr>
    </table>

   <table width="90%" align=center cellpadding="1" cellspacing="1" border="0" bgcolor="#E8EEF7">
    <tr>
                <td width="13%"><strong>Project Name<font size="10" COLOR="#FF0000">**</font></strong></td>
                <td><input type="text" name="projectname1" maxlength="80" size="16" onblur="document.getElementById('moreUploadsLink').style.display = 'block';" /></td>
                <td width="10%"><strong>Duration<font size="10" COLOR="#FF0000">**</font></strong></td>
                <td><input type="text" name="duration1" maxlength="10" size="6"/>Months</td>
                <td width="10%"><strong>Team Size<font size="10" COLOR="#FF0000">**</font></strong></td>
                <td><input type="text" name="teamsize1" maxlength="3" size="6"/></td>
    </tr>
    <tr>
                <td width="13%"><strong>Client<font size="10" COLOR="#FF0000">**</font></strong></td>
                <td><input type="text" name="client1" maxlength="80" size="16"/></td>
                <td width="10%"><strong>Environment<font size="10" COLOR="#FF0000">**</font></strong></td>
                <td colspan=3><input type="text" name="environment1" maxlength="80" size="30"/></td>
    </tr>

        <tr><td width="10%" colspan="2"><strong>PROJECT DESCRIPTION<font size="10" COLOR="#FF0000">**</font></strong></td></tr>

	<tr>
	<td colspan=6>
	<textarea name="description1" wrap="physical" cols="90" rows="5"></textarea>
	</td>
	</tr>
	<tr><td width="10%" colspan=2><strong>ROLES & RESPONSIBILITIES<font size="10" COLOR="#FF0000">**</font></strong></td><td colspan=2><input type="hidden" name="noofproject" value=1 size="30"/></td></tr>
	<tr>
		<td colspan=6>
		<textarea  name="roles1" cols="90" rows="5" id="roles" ></textarea>
		<div id="moreUploads"></div>
		<div id="moreUploadsLink" style="display:none;"><a href="javascript:addTableInput();">Add Project</a></div>
		</td>
</tr>
</table>


   <br>
    <TABLE width="90%"   bgColor=#E8EEF7 border="0">
    <TR>
        <TD>&nbsp;</TD>
        <TD align=right><INPUT  type=submit id="submit" value=Submit name=submit></TD>
        <TD><INPUT  type=reset id="reset" value=" Reset "></TD>
    </TR>
    </TABLE>
</center>
</div>
</FORM>
<BR>
</body>
</html>