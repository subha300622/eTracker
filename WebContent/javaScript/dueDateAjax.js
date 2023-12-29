/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function isDuedateCorrect() {
        xmlhttp = createRequest();
        if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
            xmlhttp = new XMLHttpRequest();
        }
        if(xmlhttp != null) {
            
            var dueDate = theForm.date.value;
            xmlhttp.open("GET","<%= request.getContextPath() %>/eTracker/CreateIssue/dueDateCheck.jsp?dueDate="+dueDate+"&rand="+Math.random(1,10), true);
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