<%-- 
    Document   : escalationQustions
    Created on : 14 Oct, 2020, 3:58:42 PM
    Author     : vanithaalliraj
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <style>
            b{
                font:bold;
            }
            tr{
                height:21;
            }
        </style>
    </head>
    <body>
        <table style="background-color: #E8EEF7;width: 100%">
            <tr>
                <td style="width: 70%"><b>Is requirement provided clearly?</b></td>
                <td><input type="radio" name="que1" value="Yes">Yes<input type="radio" name="que1" value="No">No</td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is QA-BTC reviewed to make the requirement understandable to all?</b></td>
                <td><input type="radio" name="que2" value="Yes">Yes<input type="radio" name="que2" value="No">No</td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is the issue highlighted in WRM before escalation?</b></td>
                <td><input type="radio" name="que3" value="Yes">Yes<input type="radio" name="que3" value="No">No</td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is the WRM highlighted issue planned daily?</b></td>
                <td><input type="radio" name="que4" value="Yes">Yes<input type="radio" name="que4" value="No">No</td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is the issue escalated in production?</b></td>
                <td><input type="radio" name="que5" value="Yes">Yes<input type="radio" name="que5" value="No">No</td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is the issue replicable in quality?</b></td>
                <td><input type="radio" name="que6" value="Yes">Yes<input type="radio" name="que6" value="No">No</td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is access to Development,Quality and Production provided?</b></td>
                <td><input type="radio" name="que7" value="Yes">Yes<input type="radio" name="que7" value="No">No</td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is sufficient authorization provided with debug option to resolve this issue?</b></td>
                <td><input type="radio" name="que8" value="Yes">Yes<input type="radio" name="que8" value="No">No</td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is sufficient time provided to resolve this issue?</b></td>
                <td><input type="radio" name="que9" value="Yes">Yes<input type="radio" name="que9" value="No">No</td>
            </tr>
            <tr>
                <td style="width: 70%"><b>Is the issue escalated questioning the capability of Eminentlabs?</b></td>
                <td><input type="radio" name="que10" value="Yes">Yes<input type="radio" name="que10" value="No">No</td>
            </tr>
            <tr><td colspan="2">
            <center> <input type="button" class="escBut ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Enter" ></center>
                </td>
            </tr>
        </table>

    </body>
    <style>
        .error2{
            color: red;
        }
        .addtarget{ 
            border: 1px solid #79b7e7;
            background: #d0e5f5 ;
            font-weight: bold;
            color: #1d5987;
            cursor: pointer;
            border-radius: 2px;
            margin-left:50px;
        }

    </style>
    <script>
 $("input[name='que1'],input[name='que3'],input[name='que7'],input[name='que9']").click(function () {
        $('span.error2').remove();
        if ($("input[name='que1']:checked").val() === 'No' || $("input[name='que3']:checked").val() === 'No' || $("input[name='que7']:checked").val() === 'No'|| $("input[name='que9']:checked").val() === 'No') {
            $("<span class='error2'>You cannot escalate this issue</span>").insertAfter(".escBut");
			$(".escBut").attr('disabled',true);
        }else{
			$(".escBut").attr('disabled',false);
		}
    });
        $(".escBut").on("click", function () {
        $('span.error2').remove();

      if ($('input[type="radio"]:checked').size() <10){  
        $("<span class='error2'>Please answer all the questions</span>").insertAfter(".escBut");
        } else{
        $("#que1").val($("input[name='que1']:checked").val());
        $("#que2").val($("input[name='que2']:checked").val());
        $("#que3").val($("input[name='que3']:checked").val());
        $("#que4").val($("input[name='que4']:checked").val());
        $("#que5").val($("input[name='que5']:checked").val());
        $("#que6").val($("input[name='que6']:checked").val());
        $("#que7").val($("input[name='que7']:checked").val());
        $("#que8").val($("input[name='que8']:checked").val());
        $("#que9").val($("input[name='que9']:checked").val());
        $("#que10").val($("input[name='que10']:checked").val());
        $(".esclQues").dialog("close");
        }

        });

    </script>
</html>
