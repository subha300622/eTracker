/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

/**
 *
 * @author EMINENT
 */
public class SendSmsToMobile {

    public static boolean sendSMS(String content, String receiver) {
        boolean flag = true;
        try {
            String requestUrl = "http://alerts.sinfini.com/api/v3/index.php?method=sms&api_key=A86d0f86e7be9539def121b70e300bcbb&to=" + receiver + "&sender=ESPLBR&message=" + URLEncoder.encode(content, "UTF-8");
            URL url = new URL(requestUrl);
            HttpURLConnection uc = (HttpURLConnection) url.openConnection();
            uc.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
            flag = false;
        }
        return flag;
    }

}
