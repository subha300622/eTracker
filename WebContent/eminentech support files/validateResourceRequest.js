function trim(str)  
{
        while (str.charAt(str.length - 1)==" ") 
   	str = str.substring(0, str.length - 1); 
  	while (str.charAt(0)==" ") 
    	str = str.substring(1, str.length); 
  	return str; 
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

	if (document.getElementById('position').value == '--Select One--') 
    {
        alert("Please choose a Position");
        document.getElementById('position').focus();
        return false;
    }
	if (document.getElementById('project').value == '--Select One--') 
    {
        alert("Please choose a Project");
        document.getElementById('project').focus();
        return false;
    }
	if (document.getElementById('team').value == '--Select One--') 
    {
        alert("Please choose a Team");
        document.getElementById('team').focus();
        return false;
    }
	if (document.getElementById('totalyears').value == '--None--') 
    {
        alert("Please choose a Experience");
        document.getElementById('totalyears').focus();
        return false;
    }
	if (document.getElementById('skill').value == '--None--') 
    {
        alert("Please choose a Skill Set");
        document.getElementById('skill').focus();
        return false;
    }
	if (trim(document.theForm.duedate.value)== "")
    {
        alert ("Please Enter the Due Date ");
        document.theForm.duedate.focus();
        return false;
    }
    if (!isDate(trim(theForm.duedate.value)))  
    {
        alert('Please enter the valid Due Date'); 
	document.theForm.duedate.value="";
        theForm.duedate.focus(); 
        return false; 
    }
    var str   = document.theForm.duedate.value;
    var first = str.indexOf("-");
    var last  = str.lastIndexOf("-");
    var year         = str.substring(last+1,last+5);
    var month        = str.substring(first+1,last);
    var date         = str.substring(0,first);
    var form_date    = new Date(year,month-1,date);
    var current_date = new Date();
    
    var current_year  = current_date.getYear();
    var current_month = current_date.getMonth();
    var current_date  = current_date.getDate();
    var today = new Date(current_year,current_month,current_date);
                
    if(form_date < today){
        alert('Due Date cannot be less than Today'); 
	document.theForm.duedate.value="";
        theForm.duedate.focus(); 
        return false; 
    }
    if(theForm.p1.value==''){
   	 alert("Please enter the first primary responsibility");
   	 theForm.p1.focus(); 
        return false; 
    }
    if(theForm.p1.value.length<120){
      	 alert("The First primary responsibility should be more than 120 characters");
      	 theForm.p1.focus(); 
           return false; 
      }
       if(theForm.p1.value.length>200){
         	 alert("The First primary responsibility should be less than 200 characters");
         	 theForm.p1.focus(); 
              return false; 
         }
    
       if(theForm.s1.value.length>200){
       	alert("The First Secondary responsibility should be less than 200 characters");
      	 	theForm.s1.focus(); 
           return false; 
       }
       if(theForm.p2.value==''){
    	   	 alert("Please enter the Second primary responsibility");
    	   	 theForm.p2.focus(); 
    	        return false; 
    	 }
       if(theForm.p2.value.length<120){
        	 alert("The Second primary responsibility should be more than 120 characters");
        	 theForm.p2.focus(); 
             return false; 
        }
         if(theForm.p2.value.length>200){
           	 alert("The Second primary responsibility should be less than 200 characters");
           	 theForm.p2.focus(); 
                return false; 
        }
         if(theForm.s2.value.length>200){
            	alert("The First Secondary responsibility should be less than 200 characters");
           	 	theForm.s2.focus(); 
                return false; 
        }
         if(theForm.p3.value==''){
    	   	 alert("Please enter the Third primary responsibility");
    	   	 theForm.p3.focus(); 
    	        return false; 
    	 }
         if(theForm.p3.value.length<120){
        	 alert("The Third primary responsibility should be more than 120 characters");
        	 theForm.p3.focus(); 
             return false; 
        }
         if(theForm.p3.value.length>200){
           	 alert("The Third primary responsibility should be less than 200 characters");
           	 theForm.p3.focus(); 
                return false; 
        }
         if(theForm.s3.value.length>200){
         	alert("The Third Secondary responsibility should be less than 200 characters");
        	 	theForm.s3.focus(); 
             return false; 
         }
         if(theForm.p4.value==''){
    	   	 alert("Please enter the Fourth primary responsibility");
    	   	 theForm.p4.focus(); 
    	        return false; 
    	 }
         if(theForm.p4.value.length<120){
        	 alert("The Fourth primary responsibility should be more than 120 characters");
        	 theForm.p4.focus(); 
             return false; 
        }
         if(theForm.p4.value.length>200){
           	 alert("The Fourth primary responsibility should be less than 200 characters");
           	 theForm.p4.focus(); 
                return false; 
        }
         if(theForm.s4.value.length>200){
         	alert("The Fourth Secondary responsibility should be less than 200 characters");
        	 	theForm.s4.focus(); 
             return false; 
         }
         
         if(theForm.p5.value==''){
    	   	 alert("Please enter the Fifth primary responsibility");
    	   	 theForm.p5.focus(); 
    	        return false; 
    	 }
         if(theForm.p5.value.length<120){
        	 alert("The Fifth primary responsibility should be more than 120 characters");
        	 theForm.p5.focus(); 
             return false; 
        }
         if(theForm.p5.value.length>200){
           	 alert("The Fifth primary responsibility should be less than 200 characters");
           	 theForm.p5.focus(); 
                return false; 
        }
         if(theForm.s5.value.length>200){
         	alert("The Fifth Secondary responsibility should be less than 200 characters");
        	 	theForm.s5.focus(); 
             return false; 
     }
              return true;
}
function validateUpdation(theForm)
{

	var fromPage=document.getElementById("status").value;
	
	var status="Unconfirmed";
	
	if(status==fromPage) 
  	{
	   	alert('Change the status before update'); 
	    theForm.status.focus(); 
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
    return true;
	}