package com.eminent.examples;
import java.net.InetAddress;
public class pingSystem {
	
	public static String ping(String ipaddress) throws Exception{
		String status="NA";
		InetAddress sys=null;
		try{
			sys=InetAddress.getByName(ipaddress);
		}catch(Exception e){
			return status;
		}
		boolean available = sys.isReachable(10000); 
		if(available==true){
			status="true";
		}else{
			status="false";
		}
		
		return status;
	}

}
