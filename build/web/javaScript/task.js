function trim(str)  {
    while (str.charAt(str.length - 1)==" ")
        str = str.substring(0, str.length - 1);
    while (str.charAt(0)==" ")
        str = str.substring(1, str.length);
    return str;
}
function validate(){
    if(document.getElementById('project').value=='--Select One--'){
        alert('Please Select a project to create Test Cases');
        document.getElementById('project').focus();
        return false;
    }
    if(document.getElementById('module').value=='--Select One--'){
        alert('Please Select a module to create Test Cases');
        document.getElementById('module').focus();
        return false;
    }
    if(document.getElementById('addplan').checked==1){
        if(document.getElementById('testplan').value=='--Select One--'){
            alert('Please Select a Plan to add Test Cases');
            document.getElementById('testplan').focus();
            return false;
        }
    }
    var func=document.getElementsByName("functionality");
    var desc=document.getElementsByName("description");
    var rslt=document.getElementsByName("expectedresult");
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
    monitorSubmit();
}        
function addIssueMom() {
    var table = document.getElementById('userissue');
    var rowCount = table.rows.length;
    //   alert("No of Rows"+rowCount);

 
    if(rowCount==8){
        $('#addissue').hide();
    }
    if(rowCount<9){
        var row1 = table.insertRow(rowCount);
    
        //       table.deleteRow(8);
   




        var idno=rowCount;
        //                     alert("Id No"+idno);
        rowCount=rowCount;
        row1.id="id"+idno;




        var cell1 =document.createElement('td');
        cell1.id="cellid"+idno;
        cell1.width="25px";
        var lable1=document.createTextNode(idno);


        cell1.appendChild(lable1);

        var cell2 = document.createElement('td');
        cell2.align="left";
        var appre = document.createElement("input");
        appre.name="issue";
        appre.size="25";
        appre.maxLength="12"  
        appre.setAttribute("onblur", "checkIssue();");
        cell2.appendChild(appre);

   

        var sub = document.createElement("img");
        sub.src="../images/remove.gif";

        sub.id="remove";
        sub.alt="Remove";
        sub.onclick=new Function("javascript:removeIssue('id"+rowCount+"');");
        
        sub.title="Remove Issue"
        cell2.appendChild(sub);


        row1.appendChild(cell1);
        row1.appendChild(cell2);
    }

}
function removeIssue(row){
    //  alert(row)
    
    var tables = document.getElementById("userissue");
    var rows = tables.rows.length;
    var removed='false';
    if(rows==9){
        $('#addissue').show();
    }
    for(var i=0;i<rows;i++){
        //          alert("Table Value-->"+tables.rows[i].id);
        
        if(tables.rows[i] != undefined){
            if(tables.rows[i].id==row)
            {
                tables.deleteRow(i);
                i--;
                removed=true;
            }
            if(removed==true){
                //            alert("I value"+i+"Rows"+row);
                if(i<(rows-1)){
                    tables.rows[i].cells[0].innerHTML=i;
                }

            }
            
        }
        
    }
}
function addTask() {
    var table = document.getElementById('usertask');
    var rowCount = table.rows.length;
    //   alert("No of Rows"+rowCount);
    if(rowCount==8){
        $('#addtask').hide();
    }
    if(rowCount<9){
        var row1 = table.insertRow(rowCount);
    
        //       table.deleteRow(8);
   
        var idno=rowCount;
        //                     alert("Id No"+idno);
        rowCount=rowCount;
        row1.id="id"+idno;
        var cell1 =document.createElement('td');
        cell1.id="cellid"+idno;
        cell1.width="25px";
        var lable1=document.createTextNode(idno);


        cell1.appendChild(lable1);

        var cell2 = document.createElement('td');
        cell2.align="left";
        var appre = document.createElement("input");
        appre.name="task";
        appre.size="25";
        
        cell2.appendChild(appre);
        var sub = document.createElement("img");
        sub.src="../images/remove.gif";

        sub.id="remove";
        sub.alt="Remove";
        sub.onclick=new Function("javascript:removeTask('id"+rowCount+"');");
        sub.title="Remove task"
        cell2.appendChild(sub);

        row1.appendChild(cell1);
        row1.appendChild(cell2);
    }
    

}
function removeTask(row){
    //  alert(row)
    var tables = document.getElementById("usertask");
    var rows = tables.rows.length;
    var removed='false';
    if(rows==9){
        $('#addtask').show();
    }
    for(var i=0;i<rows;i++){
        //           alert("Table Value-->"+tables.rows[i].id);
        if(tables.rows[i] != undefined){
            if(tables.rows[i].id==row)
            {
                tables.deleteRow(i);
                removed=true;
            }
            if(removed==true){
                //            alert("I value"+i+"Rows"+row);
                if(i<(rows-1)){
                    tables.rows[i].cells[0].innerHTML=i;
                }

            }
        }
    }                                
}
