/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function callversion() {
        xmlhttp = createRequest();

        if(xmlhttp != null) {

            var product= document.theForm.product.value;
            var url = "http://localhost/eTracker/CreateIssue/VersionDetails.jsp";
                url = url+"?product="+product;
                url = url+"&rand="+Math.random();

            xmlhttp.onreadystatechange = callbackversion;
            xmlhttp.open("GET", url, false);
            xmlhttp.send(null);



        }
 }

function callbackversion() {

     if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {


                    var name = xmlhttp.responseText;

                    var result = xmlhttp.responseText.split(";");
                    var results = result[1].split(",");
                    objLinkList 	= eval("document.theForm.version");
                    objLinkList.length=0;
                    for(i=0;i<results.length-1;i++) {
                           objLinkList.length++;
                           objLinkList[i].text =results[i];
                           objLinkList[i].value = results[i];
                    }
      }
}

function callmodule() {
        xmlhttp = createRequest();
        if(xmlhttp != null) {

            var product= document.theForm.product.value;
            var version=document.theForm.version.value;
            xmlhttp.open("GET","http://localhost/eTracker/CreateIssue/ModuleDetails.jsp?product="+product+"&version="+version+"&rand="+Math.random(1,10), false);
            xmlhttp.onreadystatechange = callbackmodule;
            xmlhttp.send(null);
        }
}

function callbackmodule() {

     if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    var name = xmlhttp.responseText;
                    var result = xmlhttp.responseText.split(";");
                    var results = result[1].split(",");
                    objLinkList 	= eval("document.theForm.module");
                    objLinkList.length=0;
                    for(i=0;i<results.length-1;i++) {
                        objLinkList.length++;
                        objLinkList[i].text =results[i];
                        objLinkList[i].value = results[i];
                    }

      }
}
