package pack.eminent.encryption;

/*import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.security.Key;
import java.security.SecureRandom;
import java.security.Security;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;*/


import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.language.RefinedSoundex;


public class Encryption
{
	public static String encrypt(String input)throws Exception{
		
        RefinedSoundex rs = new RefinedSoundex();
        String encrypted = rs.encode(input);
       
         byte[] convert = input.getBytes();
      
        Base64 b64 = new Base64();
        byte[] cv = b64.encode(convert);
        
        int append =  0;
        for (byte element : cv) {
             
             append = append + element;
             
         }
           encrypted = encrypted + append;
            
	   return encrypted;
    }
	
   
   
    /*Connection con;
    PreparedStatement ps;
    Statement st;
    ResultSet rs;

    public boolean saveKeytoDB()throws Exception
    {
    	boolean exists = false;
    	Security.addProvider( new com.sun.crypto.provider.SunJCE() );
    	KeyGenerator generator = KeyGenerator.getInstance("DES", "SunJCE" ); 
	
    	generator.init(56, new SecureRandom());
    	Key key = generator.generateKey();

    	try
    	{
		    ByteArrayOutputStream keyStore 		= new ByteArrayOutputStream();
		    ObjectOutputStream keyObjectStream 	= new ObjectOutputStream(keyStore);
		    keyObjectStream.writeObject(key);
		    byte[] keyBytes=keyStore.toByteArray();
		    ByteArrayInputStream keyArrayStream = new ByteArrayInputStream(keyBytes);
				
		    con = MakeConnection.getConnection();
			
		    st = con.createStatement();
		    rs = st.executeQuery("select * from encryption_key");

		    if(!rs.next())
		    {
				ps = con.prepareStatement("INSERT into ENCRYPTION_KEY(KEY_GENERATED) VALUES(?)",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ps.setBinaryStream(1, keyArrayStream, keyBytes.length);
		
				ps.executeUpdate();
				con.setAutoCommit(true);
				System.out.println("Key Has been inserted:\t");
				exists = true;
		    }
		    else
		    {
		    	//System.out.println("Key Already Exists!");
		    }
	}
	catch (Exception e)
	{
	    System.err.println (e); 
	}
	finally
	{
    	    if(con!=null)
    	       	con.close();
    	    if(ps!=null)
    	      	ps.close();
    	    if(st!=null)
    	    	st.close();
    	    if(rs!=null)
    	    	rs.close();
    	    
	}
	return exists;
	
    }
 
    public Key getKey() throws SQLException
    {
    	Security.addProvider( new com.sun.crypto.provider.SunJCE() );
    	Key key = null;
    	Statement st = null;
    	Connection connection = null;
    	ResultSet rs = null;
    	try
    	{
		    saveKeytoDB();
		    connection = MakeConnection.getConnection();
				
		    st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		    
		    rs = st.executeQuery("SELECT KEY_GENERATED FROM  ENCRYPTION_KEY");
		    if(rs.next())
		    {
				Blob key_blob = rs.getBlob("KEY_GENERATED");
				InputStream key_stream = key_blob.getBinaryStream();
				ObjectInputStream keyObjectStream =  new ObjectInputStream(key_stream);
				key = (Key)keyObjectStream.readObject();
		    }
    	}
    	catch (Exception e)
    	{
    		System.err.println("could not read private key");
    	}
    	finally
    	{
    		if(st!=null)
    			st.close();
    		if(rs!=null)
    			rs.close();
    		if(connection!=null)
    			connection.close();
    		
    	}

	return key;
    }
    public String encrypt(String input)throws Exception
    {
    	Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, getKey());
		byte[]inputBytes = input.getBytes("UTF8");
		byte[] outputBytes = cipher.doFinal(inputBytes);
		BASE64Encoder encoder = new BASE64Encoder();
		String base64 = encoder.encode(outputBytes);
		return base64;
    }
    
    public String decrypt(String decoded)throws Exception
    {
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] decoded_bytes = decoder.decodeBuffer(decoded);
		
		Cipher decodecipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
		decodecipher.init(Cipher.DECRYPT_MODE,getKey());
		byte[] decrypted = decodecipher.doFinal(decoded_bytes);
		
		String s = new String(decrypted,"UTF8");
		
		//System.out.println("Decrypted:\t"+s);
		//System.out.println("Encrypted:\t"+decoded);
		return s;
    }*/
}

