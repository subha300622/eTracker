/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.examples;

/**
 *
 * @author Tamilvelan
 */

import java.net.HttpURLConnection;
import java.net.URL;
import java.io.*;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;


public class send_sms {
	
	public void addSslCertificate() throws NoSuchAlgorithmException, KeyManagementException{
		
		TrustManager[] trustAllCerts = new TrustManager[] {
				   new X509TrustManager() {
				      public java.security.cert.X509Certificate[] getAcceptedIssuers() {
				        return null;
				      }

				      public void checkClientTrusted(X509Certificate[] chain,
							String authType) throws CertificateException {
						
						
					}

					public void checkServerTrusted(X509Certificate[] chain,
							String authType) throws CertificateException {
						
					}

				   }
				};

				SSLContext sc = SSLContext.getInstance("SSL");
				sc.init(null, trustAllCerts, new java.security.SecureRandom());
				HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

				// Create all-trusting host name verifier
				HostnameVerifier allHostsValid = new HostnameVerifier() {
				    public boolean verify(String hostname, SSLSession session) {
						
						return false;
					}
				};
				// Install the all-trusting host verifier
				HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
				/*
				 * end of the fix
				 */
	  
	
		
	}
	
     //  declaring class variable
	     static String api_key ;
	     static String sender_id;
	     static String api_url;
	     static String start;
	     static String method;
	     String time;
		 String mob_no;
		 String message;
		 String unicode;
		 String dlr_url;
		 String type;
		 // function to set sender id
	     public static  void setsender_id(String sid)
			{      
	    	 					sender_id=sid;
								return;

		    }
	       // function to set api_key key  
	     public static  void setapi_key(String apk)
			{ 	
				// checking for valid working key
	    	 					api_key=apk;
								return;
							}
	     
	     // function to set method
	     public static  void setmethod(String mt)
			{ 	
				// checking for valid working key
							 method=mt;
								return;
							}
							
		    
		    // function to set Api url
	      public static  void setapi_url(String ap)
			{   
				//checking for valid url format
				String check= ap;
				String str=check.substring(0,7);
//			    System.out.println(""+str );
				String t="http://";
				String s="https:/";
				String st="https://";
				if(str.equals(t))
					 { 
					 	start=t;
						api_url=check.substring(7);
					}
				else if(check.substring(0,8).equals(st))
				{ 
				start=st;
                api_url=check.substring(8);
				}
				else if(str.equals(s))
					{ 
					start=st;
	                api_url=check.substring(7);
					}
			 	else
				   { 
					 start=t;
	                 api_url=ap;
					}
	        }
	        //function to set parameter import java.net.URLEncoder;
	     public  void setparams(String ap,String mt,String apk,String sd)
			{ 
			    setapi_key(apk);
			    //System.out.println(wk);
			    setsender_id(sd);
			    setapi_url(ap);
			    setmethod(mt);
			}
			/*function to send sms 
			  @ Simple message : last two field are set to null
			  @ Unicode message :set unicode parameter to one
			  @ Scheduled message : give time in 'ddmmyyyyhhmm' format
			*/
		  public String process_sms(String mob_no,String message,String dlr_url,String unicode,String time) throws IOException, KeyManagementException, NoSuchAlgorithmException
			{   	
			  addSslCertificate();
				message=URLEncoder.encode(message, "UTF-8");			
			 	if (unicode==null)
					 unicode="0";
					unicode="&unicode="+unicode;
				if (time==null)
					 time="";
					else time="&time="+URLEncoder.encode(time, "UTF-8");
		        URL url = new URL(""+start+api_url+"/v3/?method="+method+"&api_key="+api_key+"&sender="+sender_id+"&to="+mob_no+"&message="+message+unicode+time+"&dlr_url="+dlr_url+"&format=xml" );
			    
//		        System.out.println("url look like " + url );
			    HttpURLConnection con = (HttpURLConnection) url.openConnection();
			    con.setRequestMethod("POST");
			    con.setDoOutput(true);
			    con.getOutputStream();
			    con.getInputStream();
			    BufferedReader rd;
			    String line;
	            String result = "";
	            rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
	           while ((line = rd.readLine()) != null)
	            {
	               result += line;
	            }
		        rd.close(); 
//		        System.out.println("Result is" + result);
				return result;
				
				
			}
			//function for checking message delivery status
	     public String messagedelivery_status(String mid) throws Exception
			{
				URL url = new URL("http://"+api_url+"/api/v3/?method="+method+".groupstatus&api_key="+api_key+"&groupid="+mid+"&format=json");
//				System.out.println("url look like " + url );		 
		        HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("POST");
				con.setDoOutput(true);
			    con.getOutputStream();
				con.getInputStream();
				BufferedReader rd;
				String line;
		        String result = "";
		        rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
		        while ((line = rd.readLine()) != null)
		          {
		            result += line;
		          }
		        rd.close(); 
//		        System.out.println("Result is" + result);
		        return result;
	        }
	        
	  		//function for checking group delivery status
	     public String groupdelivery_status(String gid) throws Exception
			{
				URL url = new URL("http://"+api_url+"/api/v3/?method="+method+".groupstatus&api_key="+api_key+"&groupid="+gid+"&format=xml");
//				System.out.println("url look like " + url );		
		        HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("POST");
				con.setDoOutput(true);
				con.getOutputStream();
				con.getInputStream();
				BufferedReader rd;
				String line;
		        String result = "";
		        rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            while ((line = rd.readLine()) != null)
	             {
		            result += line;
//					System.out.println("Result is" + result);
	             }
		        rd.close(); 
//		        System.out.println("Result is" + result);
		        return result;  
	        }
	     
	     public  void unicode_sms(String mob_no,String message,String dlr_url,String unicode) throws IOException, KeyManagementException, NoSuchAlgorithmException
			{
	    	 process_sms(mob_no, message, dlr_url, unicode, time=null);  				
									
			}

	     
	     public  void send_sms(String mob_no,String message,String dlr_url) throws IOException, KeyManagementException, NoSuchAlgorithmException
			{
	    	 process_sms(mob_no, message, dlr_url, unicode=null, time=null);  				
									
			}
	     
	     public  void schedule_sms(String mob_no,String message,String dlr_url,String unicode,String time) throws IOException, KeyManagementException, NoSuchAlgorithmException
			{
	    	 process_sms(mob_no, message, dlr_url, unicode, time);  				
									
			}
	     
	     public  void schedule_sms(String mob_no,String message,String dlr_url,String time) throws IOException, KeyManagementException, NoSuchAlgorithmException
			{
	    	 process_sms(mob_no, message, dlr_url, unicode=null, time);  				
									
			}
        public static void main(String[] args) throws Exception
        {
        send_sms smsObj = new send_sms();
        smsObj.setparams("api-alerts.solutionsinfini.com","sms","Ada6a6d5d089fc3330a3f2b6c65275b33","SIDEMO");
        smsObj.send_sms("9886438038", "Service Request Created", "");
//        smsObj.schedule_sms("99xxxxxxxx", "message", "http://www.yourdomainname.domain/yourdlrpage&custom=XX","YYYY-MM-DD HH:MM:SS");
//        smsObj.unicode_sms("99xxxxxxxx", "message", "http://www.yourdomainname.domain/yourdlrpage&custom=XX","1");
 //       smsObj.messagedelivery_status("1xxx-x");
  //      smsObj.groupdelivery_status("1xxx");
        //smsObj.setsender_id("txxxxx");
        //smsObj.setworking_key("1ixxxxxxxxxxxxxx");
        //smsObj.setapi_url("URL");
        }
	     
}
