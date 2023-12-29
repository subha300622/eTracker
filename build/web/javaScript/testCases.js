//                alert('Loading...')
                function addRow(tablename) {
  //                      alert("Name of the table"+tablename);
                        var table = document.getElementById(tablename);
                 	var rowCount = table.rows.length;
   //                      alert("No of Rows"+rowCount);
			var row1 = table.insertRow(rowCount-1);
                        if(rowCount==7){
                            if(tablename=="testcases"){
                            table.deleteRow(7);
    //                        alert('Removing last row');
                            }else{
                               table.rows[7].cells[3].innerHTML='';
                            }
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
                        sub.src="./images/remove.gif";
                        sub.style.background="background:url('../image/remove.gif') no-repeat"

                        sub.id="remove";
                        sub.alt="Remove";
                        sub.onclick=new Function("javascript:removeRow('"+tablename+"','id"+rowCount+"');");


			cell4.appendChild(result);
                        cell4.appendChild(sub);

                        row1.appendChild(cell1);
                        row1.appendChild(cell2);
                        row1.appendChild(cell3);
                        row1.appendChild(cell4);

		}
                function removeRow(tablename,rowCount) {
                    var tables = document.getElementById(tablename);
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
                function addMoreTestCases(){
                    var tables = document.getElementById("testcasesavailable");
                    var rows = tables.rows.length;
 //                   alert("No of Rows"+rows);
                    try{
                     for(var i=0;i<rows;i++){


                         tables.deleteRow(0);
                     }
                     var row1 = tables.insertRow(0);
                     var theBoldBit1 = document.createElement('b');

                     var cell1 =document.createElement('td');
                     cell1.align='center';
                     var lable1=document.createTextNode('S No');
                     theBoldBit1.appendChild(lable1);
                     cell1.appendChild(theBoldBit1);

                    var cell2 = document.createElement('td');
                     var theBoldBit2 = document.createElement('b');
                    cell2.align='center';
                    var lable2=document.createTextNode('Functionality');
                    theBoldBit2.appendChild(lable2);
                    cell2.appendChild(theBoldBit2);

                    var cell3 = document.createElement('td');
                      var theBoldBit3 = document.createElement('b');
                    cell3.align='center';
                    var lable3=document.createTextNode('Description');
                    theBoldBit3.appendChild(lable3);
                    cell3.appendChild(theBoldBit3);

                    var cell4 = document.createElement('td');
                    var theBoldBit4 = document.createElement('b');
                    cell4.align='center';
                    var lable4=document.createTextNode('Expected Result');
                    theBoldBit4.appendChild(lable4);
                    cell4.appendChild(theBoldBit4);

                    row1.appendChild(cell1);
                    row1.appendChild(cell2);
                    row1.appendChild(cell3);
                    row1.appendChild(cell4);

                     var row2 = tables.insertRow(1);

                        var cell21 =document.createElement('td');
                        cell21.id="id1";

                        var lable21=document.createTextNode("1");


                        cell21.appendChild(lable21);

			var cell22 = document.createElement('td');
                        cell22.align="center";
			var appre = document.createElement("textarea");
			appre.name="functionality";
                        appre.id="functionality";
                        appre.cols="25";
                        appre.rows="3";

			cell22.appendChild(appre);

                        var cell23 = document.createElement('td');
                        cell23.align="center";
			var desc = document.createElement("textarea");
			desc.name="description";
                        desc.id="description";
                        desc.cols="25";
                        desc.rows="3";
			cell23.appendChild(desc);

			var cell24 = document.createElement('td');
                        cell24.align="left";
			var result = document.createElement("textarea");
			result.name="expectedresult";
                        result.id="expectedresult";
                        result.cols="25";
                        result.rows="3";



			cell24.appendChild(result);


                        row2.appendChild(cell21);
                        row2.appendChild(cell22);
                        row2.appendChild(cell23);
                        row2.appendChild(cell24);

                         var row3 = tables.insertRow(2);
                         row3.id="add";
                         var cell34 =document.createElement('td');
                         var link2 =document.createElement('a');
                         link2.href="javascript:void(0);"
                         var text2=document.createTextNode('Remove All Test Cases');
                         link2.appendChild(text2);
                         link2.onclick=new Function("javascript:addComments('testcasesavailable');");
                         cell34.appendChild(link2);

                         var cell31 =document.createElement('td');
                         var comments =document.createElement('input');
                         comments.id="comments";
                         comments.name="comments";
                         comments.type="hidden";
                         comments.value="Adding Test Cases";

                          var cell30 =document.createElement('td');
                         var devtestcase =document.createElement('input');
                         devtestcase.id="testcaseindev";
                         devtestcase.name="testcaseindev";
                         devtestcase.type="hidden";
                         devtestcase.value="testcaseindev";
                          cell30.appendChild(devtestcase);

                         var cell33 =document.createElement('td');
                         var cell32 =document.createElement('td');
                         cell32.appendChild(comments);
                         cell31.align='center';
                         cell31.colspan='4';
                         var link =document.createElement('a');
                         link.href="javascript:void(0);"
                         var text=document.createTextNode('Add Test Case');
                         link.onclick=new Function("javascript:addRow('testcasesavailable');");
                         link.appendChild(text);
                         cell31.appendChild(link);

                         row3.appendChild(cell32);
                         row3.appendChild(cell33);
                         row3.appendChild(cell34);
                         row3.appendChild(cell31);
                         row3.appendChild(cell30);

                    }catch(e){
    //                    alert(e);
                    }
                }
                function addComments(){
                    var tables = document.getElementById("testcasesavailable");
                    var rows = tables.rows.length;

                    try{
                     for(var i=0;i<rows;i++){


                         tables.deleteRow(0);
                     }
                      var row3 = tables.insertRow(0);
                         row3.id="add";
                         var cell34 =document.createElement('td');

                         var cell31 =document.createElement('td');

                         cell31.align='right';
                         cell31.colspan='4';
                         var link =document.createElement('a');
                         link.href="javascript:void(0);"
                         var text=document.createTextNode('Add New Test Case');
                         link.onclick=new Function("javascript:addMoreTestCases('testcasesavailable');");
                         link.appendChild(text);
                         cell31.appendChild(link);



                         row3.appendChild(cell34);
                         row3.appendChild(cell31);
                         var row1 = tables.insertRow(1);
                         var theBoldBit1 = document.createElement('b');

                         var cell1 =document.createElement('td');
                         cell1.align='center';
                         var lable1=document.createTextNode('Comments');
                         theBoldBit1.appendChild(lable1);
                         cell1.appendChild(theBoldBit1);

                         var cell2 = document.createElement('td');
                         cell2.align="left";
			 var comments = document.createElement("textarea");
			 comments.name="comments";
                         comments.id="comments";
                         comments.cols="68";
                         comments.rows="3";
                         comments.maxLength="2000";

                         comments.onkeyup=new Function("javascript:textCounter(document.theForm.comments,document.theForm.remLen1,2000)");
                         comments.onkeydown=new Function("javascript:textCounter(document.theForm.comments,document.theForm.remLen1,2000)");
                         var remLen=document.createElement('input')
                         remLen.type="text";
                         remLen.size="3";
                         remLen.maxLength="4";
                         remLen.value="2000";
                         remLen.setAttribute("readonly","true");
                         remLen.id="remLen1";
                         remLen.name="remLen1";

                         cell2.appendChild(comments);
                         cell2.appendChild(remLen);var remLena=document.createElement('input');
                         remLena.type="hidden";
                         remLena.value="no editor";
                         remLena.id="nock";
                         remLena.name="nock";
                         
                         cell2.appendChild(comments);
                         cell2.appendChild(remLen);
                         cell2.appendChild(remLena);
                         row1.appendChild(cell1);
                         row1.appendChild(cell2);

                }
                catch(e){
 //                   alert(e);
                }
                }


