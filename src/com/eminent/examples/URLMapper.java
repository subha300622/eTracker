/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.examples;

import com.eminent.issue.IssueImageUrl;
import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.ModelDAO;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Tamilvelan
 */
public class URLMapper {

    public static List<String> extractUrls(String text) {
        List<String> containedUrls = new ArrayList<String>();
        String urlRegex = "((https?|ftp|gopher|telnet|file):((//)|(\\\\))+[\\w\\d:#@%/;$()~_?\\+-=\\\\\\.&]*)";
        Pattern pattern = Pattern.compile(urlRegex, Pattern.CASE_INSENSITIVE);
        Matcher urlMatcher = pattern.matcher(text);

        while (urlMatcher.find()) {
            containedUrls.add(text.substring(urlMatcher.start(0),
                    urlMatcher.end(0)));
        }

        return containedUrls;
    }

    public static void saveImage(String imageUrl, String imageName, String issueId,String rowid) {
        InputStream is = null;
        OutputStream os = null;
        try {
            URL url = new URL(imageUrl);
            String destName = "D:\\Resources\\Etracker_AttachedFiles\\" + imageName + ".jpg";
            is = url.openStream();
            os = new FileOutputStream(destName);

            byte[] b = new byte[2048];
            int length;

            while ((length = is.read(b)) != -1) {
                os.write(b, 0, length);
            }
            IssueImageUrl iiu = new IssueImageUrl();
            iiu.setIssueId(issueId);
            iiu.setIssueRowId(rowid);
            iiu.setOrginialUrl(imageUrl);
            iiu.setLocalUrl("\\eTracker\\Etracker_AttachedFiles\\" + imageName + ".jpg");
            iiu.setAddedOn(new Date());
              ModelDAO.saveOrUpdate(DAOConstants.Entity_ISSUE_IMAGE_URL, iiu);
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } finally {
            try {
                is.close();
                os.close();

            } catch (IOException ex) {
                Logger.getLogger(URLMapper.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static void main(String[] args) {
        List<String> extractedUrls = extractUrls("Hi&nbsp;<span style=\"padding-bottom:0px!important;background-image:url(&quot;&quot;)\">Saravanan</span>,<br />\n"
                + " <br />\n"
                + " On overview of Ledger Code: 2310051 (Axis Bank A/c No. 2561) for the month of April-2014, it is found that transaction &nbsp;Doc. No. 10004227 dated 29.04.2014 is not reflecting in T-Code&nbsp;<span style=\"padding-bottom:0px!important;background-image:url(&quot;&quot;)\">ZBANK</span>.<br />\n"
                + " <br />\n"
                + " <span style=\"padding-bottom:0px!important;background-image:url(&quot;&quot;)\">Please</span> find the attachment &nbsp;for your reference, request to clarify on the same.<img src=\"https://ci6.googleusercontent.com/proxy/RnNZfQn2o2xpggJQqefCOervMbPIci5mujDPJnvl43kv6Rtxjyh5gHN_JKVzeU-aaGz3pePFgxfoAAtZJZNx8mveVTc-11j98EfuAJVcumUenA=s0-d-e1-ft#https://ssl.gstatic.com/ui/v1/icons/mail/images/cleardot.gif\" />\n"
                + " <div class=\"yj6qo ajU\">\n"
                + " 	<div aria-label=\"Show trimmed content\" class=\"ajR\" data-tooltip=\"Show trimmed content\" id=\":16u\" role=\"button\" tabindex=\"0\">\n"
                + " 		<img class=\"ajT\" src=\"https://ssl.gstatic.com/ui/v1/icons/mail/images/cleardot.gif\" /></div>\n"
                + " </div>\n"
                + " <br />\n"
                + " ");
        try {
            int count = 1;
            for (String url1 : extractedUrls) {
                System.out.println(url1);
                if (url1.contains("googleusercontent.com")) {
                    System.out.println("googleusercontent.com");
                    saveImage(url1, count + ".AAAENJAABAAAMz8AAJ", "E02062014004","");
                    count++;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
