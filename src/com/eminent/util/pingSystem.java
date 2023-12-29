package com.eminent.util;

import java.net.InetAddress;
import org.apache.log4j.Logger;
public class pingSystem {
	 static Logger logger=Logger.getLogger("pingSystem");
	public static String ping(String ipaddress) throws Exception{
             
		String status="NA";
		InetAddress sys=null;
		try{
			sys=InetAddress.getByName(ipaddress);
		}catch(Exception e){
                     logger.error(e.getMessage());
			return status;
                       
		}
		boolean available = sys.isReachable(100); 
		if(available==true){
			status="Working";
		}else{
			status="Not Working";
		}
		
		return status;
	}

}