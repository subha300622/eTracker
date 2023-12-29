
package com.eminent.Assets;


import java.io.IOException;

import java.util.ArrayList;

import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

public class AssetsController extends HttpServlet {

    static Logger logger = null;

    public void setAll(HttpServletRequest request) {

    }

    static {
        logger = Logger.getLogger("assetController");
    }

    AssetsDAO assetDao = new AssetsDAOImpl();
    List<String> address = new ArrayList<String>();
    String machinename = "";
    boolean containIp = false;

    public void doAction(HttpServletRequest request) throws ServletException, IOException {
        Assets re = new Assets();
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        if (action.equalsIgnoreCase("delete")) {
            String IpAddress = request.getParameter("assetid");
            machinename = request.getParameter("machinename");
          //  System.out.print("iam in deletecontrolleer:" + IpAddress + "," + machinename);
            assetDao.delete(IpAddress, machinename);
        }
        if (action.equalsIgnoreCase("retrieve")) {
            String ipAddress = request.getParameter("ip");
            String text = request.getParameter("text");
            machinename = request.getParameter("machinename");
          //  System.out.print("iam in retrievecontroller:" + ipAddress + "," + text + "machinename is:" + machinename);
            address = assetDao.findAllMACaddresses(ipAddress, text, machinename);
          //  System.out.print("addres asize is:"+address.size());
            
            if (address.contains(ipAddress)) {
                containIp = false;
            } else {
                containIp = true;
            }

        }

    }
public int getAssetcount(){
    
        return assetDao.getAssetCount();
}
    public List<String> getAddress() {
        return address;
    }

    public void setAddress(List<String> address) {
        this.address = address;
    }

    public String getMachinename() {
        return machinename;
    }

    public void setMachinename(String machinename) {
        this.machinename = machinename;
    }

    public boolean isContainIp() {
        return containIp;
    }

    public void setContainIp(boolean containIp) {
        this.containIp = containIp;
    }

}
