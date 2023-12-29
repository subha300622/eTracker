
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


    function AppendTD() {
        var td = document.createElement("td");
        td.className='';
        td.setAttribute("height", "24px");
        td.setAttribute("align", "left");
        return td;
    }



    function AppendRow() {
        //var tblObj = document.getElementById('mainTable');
        var tblBody = document.getElementById('mainBody');

        //alert(tblBody.childNodes.length);
        var ttlRows = tblBody.childNodes.length;
        var index = ttlRows;

        //Creating a new row
        var tr = document.createElement('tr');
        tr.setAttribute("id", "lastRow");

        //adding title as first column
        var td1 = AppendTD();

        //Creating text node
        var title = document.createTextNode("Rate your Satisfaction");
        var bold = document.createElement("b");
        bold.appendChild(title);
        td1.appendChild(bold);
        tr.appendChild(td1);

        //adding second column
        var td2 = AppendTD();

        //adding select button to second column
        var drop = document.createElement('select');
        drop.setAttribute("id", "feedback");
        drop.setAttribute("name", "feedback");
        drop.setAttribute("align", "left");
        //drop.setAttribute("onchange", "addInputBox();");

        //Generating drop down values
        var down = document.createElement('option');
        down.text = "Select";
        down.value = "Select";
        down.selected = true;
        var down1 = document.createElement('option');
        down1.text = "Excellent";
        down1.value = "Excellent";
        var down2 = document.createElement('option');
        down2.text = "Good";
        down2.value = "Good";
        var down3 = document.createElement('option');
        down3.text = "Average";
        down3.value = "Average";
        var down4 = document.createElement('option');
        down4.text = "Need Improvement";
        down4.value = "Need Improvement";

        //Adding drop down values to the select box
        drop.options.add(down);
        drop.options.add(down1);
        drop.options.add(down2);
        drop.options.add(down3);
        drop.options.add(down4);

        //Appending select box to the cell
        td2.appendChild(drop);

        //Appending cell to the respective row
        tr.appendChild(td2);

            var td3 = AppendTD();
            //adding input button
            var input = document.createElement('input');
            input.setAttribute("id", "feedbackString");
            input.setAttribute("name", "feedbackString");
            input.setAttribute("type", "text");
            input.setAttribute("size", "63");
            input.setAttribute("maxLength", "200");
            input.setAttribute("align", "left");
            td3.setAttribute("colSpan", "4");
            td3.appendChild(input);
            tr.appendChild(td3);

        //Appending cell to the respective tbody element
        tblBody.appendChild(tr);

    }

    function addInputBox() {
        if(document.getElementById('issuestatus').value == 'Closed' && document.getElementById('feedback').value == 'Need Improvement') {
       //     alert('Inside addInputBox');
            var objBody = document.getElementById('mainBody');
            var lastRow = objBody.lastChild;
            //adding a cell in last row
            var td3 = AppendTD();
            //adding input button
            var input = document.createElement('input');
            input.setAttribute("id", "feedbackString");
            input.setAttribute("name", "feedbackString");
            input.setAttribute("type", "text");
            input.setAttribute("size", "65");
            input.setAttribute("maxlength", "65");
            input.setAttribute("align", "left");
            td3.setAttribute("colspan", "3");   
            td3.appendChild(input);
            lastRow.appendChild(td3);
        }


    }

        var beforeAppendRowCount = 0;
        var callCount = 1;
      //Calculating the original rowcount of tBody
      function originalRowCount() {

        if(callCount == 1) {
            var objBody = document.getElementById('mainBody');
            var length = objBody.childNodes.length;

            //Calculating the number of rows excluding text node and 1 represents Element as a node type
            for (i = 0; i < length; i++ ) {
                if(objBody.childNodes[i].nodeType == 1) {
                    beforeAppendRowCount++;
                }
            }
            callCount++;
        }
      }
   

     function newRow() {


        var status = document.getElementById("issuestatus").value;
        var objBody = document.getElementById('mainBody');
        var length = objBody.childNodes.length;

        //Calculating the number of rows excluding text node and 1 represents Element as a node type
        var elementLength = 0;
        for (i = 0; i < length; i++ ) {
            if(objBody.childNodes[i].nodeType == 1) {
                elementLength++;
            }
        }
        //alert(beforeAppendRowCount);
        //alert(elementLength);
        //If the status is closed and the feedback row is not added, New row will be appended
        if(status == 'Closed' && elementLength == beforeAppendRowCount ) {
            //Calling the function to add a row
            AppendRow();
        } else if(elementLength  == (beforeAppendRowCount + 1) ) {
            // Deleting the last row
            objBody.deleteRow(-1);
          }
          
    }


        