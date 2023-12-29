<%-- 
    Document   : downloadTree
    Created on : Mar 13, 2014, 7:27:13 PM
    Author     : E0288
--%>

<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.poi.ss.usermodel.PrintSetup"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="com.eminent.bpm.BpmUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
    </head>
    <body>
        <% Logger logger = Logger.getLogger("downloadTree");
            int spId = Integer.parseInt(request.getParameter("spId"));
            String downLoad[][] = BpmUtil.getTree(spId);
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet("Sample sheet");
            sheet.autoSizeColumn(2);
            Map<String, Object[]> data = new LinkedHashMap<String, Object[]>();
            data.put("1", new Object[]{"Sub Process", "Scenario", "Scenario Type", "Variant", "Variant Type", "Test Case", "Test Case Type", "Test Step", "Test Step Type", "Description", "Expected Result"});
        %>

        <%
            String sp = "", tempSp = "";
            String sc = "", tempSc = "";
            String sct = "", tempSct = "";
            String vt = "", tempVt = "";
            String vtt = "", tempVtt = "";
            String tc = "", tempTc = "";
            String tct = "", tempTct = "";
            String ts = "", tempTs = "";
            String tst = "", tempTst = "";
            String td = "", tempTd = "";
            String er = "", tempEr = "";
            for (int i = 0; i < downLoad.length; i++) {

                sp = downLoad[i][0];
                sc = downLoad[i][1];
                vt = downLoad[i][2];
                tc = downLoad[i][3];
                ts = downLoad[i][4];
                td = downLoad[i][5];
                er = downLoad[i][6];
                sct = downLoad[i][7];
                vtt = downLoad[i][8];
                tct = downLoad[i][9];
                tst = downLoad[i][10];
                
                if (sp == null) {
                    sp = "";
                }
                if (sc == null) {
                    sc = "";
                }
                if (sct == null) {
                    sct = "";
                }
                if (vt == null) {
                    vt = "";
                }
                 if (vtt == null) {
                    vtt = "";
                }   
                if (tc == null) {
                    tc = "";
                }
                if (tct == null) {
                    tct = "";
                }
                if (ts == null) {
                    ts = "";
                }
                if (tst == null) {
                    tst = "";
                }

                if (!sp.equalsIgnoreCase(tempSp)) {
                    tempSp = sp;
                } else {
                    tempSp = "";
                }
                
//                
                if (!sc.equalsIgnoreCase(tempSc)) {
                    tempSc = sc;
                    tempSct = sct;
                } else {
                    tempSc = "";
                    tempSct ="";
                }
                
               
                if (!vt.equalsIgnoreCase(tempVt)) {
                    tempVt = vt;
                   tempVtt = vtt;
                } else {
                    if (tempSc.equalsIgnoreCase("")) {
                        tempVt = "";
                        
                    } else {
                        tempVt = vt;
                       
                    }
                    tempVtt = "";
                }
                
                
               
                
                if (!tc.equalsIgnoreCase(tempTc)) {
                    tempTc = tc;
                     tempTct = tct;
                } else {
                    if (tempVt.equalsIgnoreCase("")) {
                        tempTc = "";
                    } else {
                        tempTc = tc;
                    }
                     tempTct = "";
                }
               
                
                
                if (!ts.equalsIgnoreCase(tempTs)) {
                    tempTs = ts;
                    tempTst = tst;
                   
                } else {
                    if (tempTc.equalsIgnoreCase("")) {
                        tempTs = "";
                    } else {
                        tempTs = ts;
                    }
                     tempTst = "";
                }
                 
               

                tempTd = td;
                tempEr = er;
                if (tempTd == null) {
                    tempTd = "";
                }
                if (tempEr == null) {
                    tempEr = "";
                }

                String rownnum = String.valueOf(i + 2);
                data.put(rownnum, new Object[]{tempSp, tempSc, tempSct, tempVt, tempVtt, tempTc, tempTct, tempTs, tempTst, tempTd, tempEr});
                tempSp = sp;
                tempSc = sc;
                tempSct = sct;
                tempVt = vt;
                tempVtt = vtt;
                tempTc = tc;
                tempTct = tct;
                tempTs = ts;
                tempTst = tst;

            }
            Set<String> keyset = data.keySet();
            int rownum = 0;
            for (String key : keyset) {
                Row row = sheet.createRow(rownum++);
                row.setHeightInPoints((2 * sheet.getDefaultRowHeightInPoints()));

                Object[] objArr = data.get(key);
                int cellnum = 0;
                for (Object obj : objArr) {
                    Cell cell = row.createCell(cellnum++);

                    if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    }
                }
            }
            for (int columnIndex = 0; columnIndex < 10; columnIndex++) {
                sheet.autoSizeColumn(columnIndex);

            }

            try {
                FileOutputStream outs
                        = new FileOutputStream(new File(this.getServletContext().getRealPath("/") + "downloadTree.xls"));
                workbook.write(outs);
                outs.close();

            } catch (FileNotFoundException e) {
                logger.error(e.getMessage());
            } catch (IOException e) {
                logger.error(e.getMessage());
            }
        %>

        <jsp:forward page="/downloadTree.xls"></jsp:forward>

    </body>
</html>
