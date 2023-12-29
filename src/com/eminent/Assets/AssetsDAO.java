package com.eminent.Assets;


import java.util.List;

public interface AssetsDAO {

    public List<String> findAllMACaddresses(String IpAddress,String text,String machinename);

    public void delete(String IpAddress,String machinename);
    
public int getAssetCount();
}
