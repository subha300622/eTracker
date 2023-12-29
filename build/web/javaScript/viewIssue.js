/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function trim(str)  {
  		while (str.charAt(str.length - 1)==" ")
                    str = str.substring(0, str.length - 1);
  		while (str.charAt(0)==" ")
                    str = str.substring(1, str.length);
  		return str;
	}
    function createRequest(){
		var reqObj = null;
		try {
		   reqObj = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (err) {
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
     function assignedusers(){
       xmlhttp = createRequest();

        if(xmlhttp!=null){
            var issueid=document.getElementById("issueId").value;
            var status=document.getElementById("issuestatus").value;
            xmlhttp.open("GET","${pageContext.servletContext.contextPath}/MyIssues/assignedToDetails.jsp?issueid="+issueid+"&status="+status+"&rand="+Math.random(1,10), false);

            xmlhttp.onreadystatechange = callassignedto;
            xmlhttp.send(null);
        }
    }
    function callassignedto()
    {
         var results="";
         if (xmlhttp.readyState == 4)
         {
	    if (xmlhttp.status == 200)
            {
                    var results="";
                    var result = xmlhttp.responseText.split(";");
        //            alert("Result:"+result);
                    var results = result[1].split(",");
           //         alert("Result:"+results);
                   	objLinkList 	= eval("document.getElementById('assignedto')");
                    objLinkList.length=0;
                    var assigned=results[results.length-1];

	                for(i=0;i<results.length-1;i++)
       	             {

                         var k  =results[i];


                       var id   =   k.substring(0,k.indexOf('-'));
                       var name   =   k.substring(k.indexOf('-')+1,k.length);

           	            objLinkList.length++;
                        objLinkList[i].text =name;
                   	    objLinkList[i].value = id;
                        if(assigned==id){
                            objLinkList[i].selected = true;
                        }

                   	}
                     var results="";
                     var result="";
            }
	}
    }



        function isModuleExist() {
        xmlhttp = createRequest();
        if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
            xmlhttp = new XMLHttpRequest();
        }
        if(xmlhttp != null) {

            var version = theForm.fix_version.value;
            xmlhttp.open("GET","moduleCheck.jsp?version="+version+"&rand="+Math.random(1,10), true);
            xmlhttp.onreadystatechange = userAlert;
            xmlhttp.send(null);
        }
	}


	function userAlert() {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {

                var module = xmlhttp.responseText.split(",");
                var flag = module[1];

                if(flag == 'no'){

                    alert("This module is not present in the selected version. Please contact your Project Manager");
                    document.theForm.fix_version.value = module[2];
                    theForm.fix_version.focus();
                }

          	}
    	}
	}

    function isDuedateCorrect() {
        xmlhttp = createRequest();
        if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
            xmlhttp = new XMLHttpRequest();
        }
        if(xmlhttp != null) {

            var dueDate = theForm.date.value;
            xmlhttp.open("GET","dueDateCheck.jsp?dueDate="+dueDate+"&rand="+Math.random(1,10), true);
            xmlhttp.onreadystatechange = dueDateAlert;
            xmlhttp.send(null);
        }
	}


	function dueDateAlert() {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {

                var due = xmlhttp.responseText.split(",");
                var flag = due[1];

                if(flag != 'correct'){

                    alert("Due Date should be less than Project End Date ("+flag+").Please contact your Project Manager");

                    theForm.date.value = "";


                }

          	}
    	}
	}


function calcCharLeft(theForm)
{
	var mytext = theForm.description.value;
	var availChars = 450;
	if (mytext.length > availChars) {
		theForm.description.value = mytext.substring(0,availChars);
		theForm.description.focus();
		return false;
  	}
  	return true;
}
function textCounter(field,cntfield,maxlimit) {
	if (field.value.length > maxlimit)
	{
		field.value = field.value.substring(0, maxlimit);
		alert('Description size is exceeding 2000 characters');
	}
	else
	cntfield.value = maxlimit - field.value.length;
	}
function printpost(post)
{
	pp = window.open('profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
	pp.focus();
}

function fun(theForm)
{
	var fromPage=document.getElementById("issuestatus").value;
        alert(fromPage);
	var status="Unconfirmed";

	if(status==fromPage)
  	{
	   	alert('Change the status before update');
	    theForm.issuestatus.focus();
	    return false;
    }


        if(theForm.date.value == '')
  	{
	    alert('Please enter the Due Date');
	    theForm.date.focus();
	    return false;
        }

	if(theForm.comments.value.length<=0)
  	{
	    alert('Enter your comments');
	    theForm.comments.focus();
	    return false;
    }

	if(theForm.comments.value.length>2000)
  	{
	    alert('Comments Should not exceed 2000 Characters');
	    theForm.comments.focus();
	    return false;
    }

    if(document.getElementById('issuestatus').value == 'Closed') {
            var check = document.getElementById('feedback').value;
                  if(check == 'Select') {
                        alert('Your feedback is valuable for us');
                        document.getElementById('feedback').focus();
                        return false;
                   }

            }

            if(document.getElementById('issuestatus').value == 'Closed' && document.getElementById('feedback').value == 'Need Improvement') {

                  if(document.getElementById('feedbackString').value == '') {
                        alert('Your feedback is valuable for us');
                        document.getElementById('feedbackString').focus();
                        return false;
                   }

            }
            alert(fromPage);
            if(fromPage=="QA-Build Test Cases"){
                alert('Inside Test Case Validation');
                var func=document.getElementsByName("functionality");
                var desc=document.getElementsByName("description");
                var rslt=document.getElementsByName("expectedresult");
                alert(func.length);
                for(var i=0;i<func.length;i++){

                    if(trim(func[i].value)==''){
                        alert('Please enter the Functionality');
                        func[i].focus();
                        return false;
                    }
                    var functext=func[i].value;

                    if((functext.length)>1000){
                        alert('Functionality length should be less than 1000');
                        func[i].focus();
                        return false;
                    }
                     if(trim(desc[i].value)==''){
                        alert('Please enter the Description');
                        desc[i].focus();
                        return false;
                    }
                    var desctext=desc[i].value;

                    if((desctext.length)>1000){
                        alert('Description length should be less than 1000');
                        desc[i].focus();
                        return false;
                    }
                    if(trim(rslt[i].value)==''){
                        alert('Please enter the Expected Result');
                        rslt[i].focus();
                        return false;
                    }
                    var rslttext=rslt[i].value;

                    if((rslttext.length)>1000){
                        alert('Expected Result length should be less than 1000');
                        rslt[i].focus();
                        return false;
                    }

                }
            }


	   monitorSubmit();

}
function addRow() {
                        var table = document.getElementById('testcases');
                 	var rowCount = table.rows.length;
			var row1 = table.insertRow(rowCount-1);
                        if(rowCount==7){
                            table.deleteRow(7);
                        }
                        var idno=rowCount-1;
                        rowCount=rowCount-1;
			row1.id="id"+idno;
                        var cell1 =document.createElement('td');
                        cell1.id="cellid"+idno;

                        var lable1=document.createTextNode(idno);


                        cell1.appendChild(lable1);

			var cell2 = document.createElement('td');
                        cell2.align="center";
			var appre = document.createElement("textarea");
			appre.name="functionality";
                        appre.id="functionality";
                        appre.cols="25";
                        appre.rows="3";

			cell2.appendChild(appre);

                        var cell3 = document.createElement('td');
                        cell3.align="center";
			var desc = document.createElement("textarea");
			desc.name="description";
                        desc.id="description";
                        desc.cols="25";
                        desc.rows="3";
			cell3.appendChild(desc);

			var cell4 = document.createElement('td');
                        cell4.align="left";
			var result = document.createElement("textarea");
			result.name="expectedresult";
                        result.id="expectedresult";
                        result.cols="25";
                        result.rows="3";

                        var sub = document.createElement("img");
                        sub.src="bullet.jpg";

                        sub.id="remove";
                        sub.alt="Remove";
                        sub.onclick=new Function("javascript:removeRow('id"+rowCount+"');");


			cell4.appendChild(result);
                        cell4.appendChild(sub);

                        row1.appendChild(cell1);
                        row1.appendChild(cell2);
                        row1.appendChild(cell3);
                        row1.appendChild(cell4);

		}
                function removeRow(rowCount) {
                    var tables = document.getElementById("testcases");
			var rows = tables.rows.length;

                          var row=rows-1;
                            if(document.getElementById('add')==null){
                                row=rows;
                            }


			try {
                            var removed='false';
                            for(var i=0;i<row;i++){

                                if(tables.rows[i].id==rowCount)
                                {
                                tables.deleteRow(i);
                                i--;
                                removed=true;
                                }
                                if(removed==true){

                                        if(i<row-2){
                                        tables.rows[i+1].cells[0].innerHTML=i+1;
                                        }

                                }


                            }

			}catch(e) {
		//		alert(e);
			}

		}


