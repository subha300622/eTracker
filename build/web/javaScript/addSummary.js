 function addRow(tablename) {

                        var table = document.getElementById(tablename);
                 	var rowCount = table.rows.length;
   //                      alert("No of Rows"+rowCount);
			var row1 = table.insertRow(rowCount-1);
//                        if(rowCount==7){
//                            if(tablename=="testcases"){
//                            table.deleteRow(7);
//    //                        alert('Removing last row');
//                            }else{
//                               table.rows[7].cells[3].innerHTML='';
//                            }
//                        }
                        var idno=rowCount-1;
                        rowCount=rowCount-1;
			row1.id="id"+idno;
                        var cell1 =document.createElement('td');
                        cell1.id="cellid"+idno;

                        var lable1=document.createTextNode(idno);


                        cell1.appendChild(lable1);

			var cell2 = document.createElement('td');
                        cell2.align="left";
			var appre = document.createElement("textarea");
			appre.name="project";
                        appre.id="project";
                        appre.cols="25";
                        appre.rows="3";

			cell2.appendChild(appre);

                        var cell3 = document.createElement('td');
                        cell3.align="left";
			var desc = document.createElement("textarea");
			desc.name="module";
                        desc.id="module";
                        desc.cols="25";
                        desc.rows="3";
			cell3.appendChild(desc);

			var cell4 = document.createElement('td');
                        cell4.align="left";
			var result = document.createElement("textarea");
			result.name="task";
                        result.id="task";
                        result.cols="25";
                        result.rows="3";
                        cell4.appendChild(result);

                        var cell5 = document.createElement('td');
                        cell5.align="left";
			var role = document.createElement("textarea");
			role.name="role";
                        role.id="role";
                        role.cols="25";
                        role.rows="3";

                        cell5.appendChild(role);

                        var sub = document.createElement("img");
                        sub.src="../images/remove.gif";
                        sub.style.background="background:url('../image/remove.gif') no-repeat"

                        sub.id="remove";
                        sub.alt="Remove";
                        sub.onclick=new Function("javascript:removeRow('"+tablename+"','id"+rowCount+"');");


			
                        cell5.appendChild(sub);

                        row1.appendChild(cell1);
                        row1.appendChild(cell2);
                        row1.appendChild(cell3);
                        row1.appendChild(cell4);
                        row1.appendChild(cell5);

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