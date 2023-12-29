package pack.eminent.encryption;

import com.eminent.util.DateIterator;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.ResourceBundle;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author admin
 */
public class GetServerLog {

    String logtext = "";
    String notpadText = "";
    static org.apache.log4j.Logger logger = null;

    static {
        logger = Logger.getLogger(GetServerLog.class.getName());
    }
    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String path = rb.getString("LogFilepath");

    public void getLogFile() {

        try {
            FileInputStream fstream = new FileInputStream(path);

            BufferedReader br = new BufferedReader(new InputStreamReader(fstream));

            String line = "";

            while ((line = br.readLine()) != null) {
                logtext = logtext + "<br/>" + line;
            }

        } catch (Exception e) {
            logger.error("Error server log: " + e.getMessage());
        }

    }

    public void setAll(HttpServletRequest request) {

        getLogFile();
    }

    public void getexportToNtopad(HttpServletRequest request) {
        getnotepadLogFile();
    }

    public void getnotepadLogFile() {

        try {
            FileInputStream fstream = new FileInputStream(path);

            BufferedReader br = new BufferedReader(new InputStreamReader(fstream));

            String line = "";

            while ((line = br.readLine()) != null) {
                notpadText = notpadText + "\n" + line;
            }

        } catch (Exception e) {
            logger.error("Error server log: " + e.getMessage());
        }

    }

    public byte[] zipFiles(File directory, String[] files, HttpServletRequest request) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            String fromdate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

          
            ZipOutputStream zos = new ZipOutputStream(baos);
            byte bytes[] = new byte[4096];

            for (String fileName : files) {
                  Iterator<Date> dateslist = new DateIterator(sdf.parse(fromdate), sdf.parse(toDate));
                while (dateslist.hasNext()) {
                    Date oneOfDate = dateslist.next();
                    String oneDate = sdf.format(oneOfDate);
                    if (fileName.contains(oneDate)) {
                        try (FileInputStream fis = new FileInputStream(directory.getPath()
                                + "/" + fileName);
                                BufferedInputStream bis = new BufferedInputStream(fis)) {

                            zos.putNextEntry(new ZipEntry(fileName));

                            int bytesRead;
                            while ((bytesRead = bis.read(bytes)) != -1) {
                                zos.write(bytes, 0, bytesRead);
                            }
                            zos.closeEntry();
                        }
                    }
                }
            }
            zos.flush();
            baos.flush();
            zos.close();
            baos.close();
        } catch (ParseException | IOException e) {
            logger.error(e.getMessage());
        }
        return baos.toByteArray();
    }

    public String getLogtext() {
        return logtext;
    }

    public String getNotpadText() {

        return notpadText;
    }

}
