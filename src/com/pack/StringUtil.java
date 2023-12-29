// Decompiled by DJ v3.5.5.77 Copyright 2003 Atanas Neshkov  Date: 10/9/2006 6:26:14 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   StringUtil.java

package com.pack;


public class StringUtil
{

    
    public static String encodeHtmlTag(String tag)
    {
        if(tag == null) {
			return null;
		}
        int length = tag.length();
        StringBuffer encodedTag = new StringBuffer(2 * length);
        for(int i = 0; i < length; i++)
        {
            char c = tag.charAt(i);
            if(c == '<')
            {
                encodedTag.append("&lt;");
                continue;
            }
            if(c == '>')
            {
                encodedTag.append("&gt;");
                continue;
            }
            if(c == '&')
            {
                encodedTag.append("&amp;");
                continue;
            }
            if(c == '"')
            {
                encodedTag.append("&quot;");
                continue;
            }
            if(c == ' ') {
				encodedTag.append("&nbsp;");
			} else {
				encodedTag.append(c);
			}
        }

        return encodedTag.toString();
    }

    
    public static String escapeHtmlTag(String tag)
    {
        if(tag == null) {
			return null;
		}
        int length = tag.length();
        StringBuffer encodedTag = new StringBuffer(2 * length);
        for(int i = 0; i < length; i++)
        {
            char c = tag.charAt(i);
            if(c == '<')
            {
                encodedTag.append("&lt;");
                continue;
            }
            if(c == '>')
            {
                encodedTag.append("&gt;");
                continue;
            }
            if(c == '&')
            {
                encodedTag.append("&amp;");
                continue;
            }
            if(c == '"')
            {
                encodedTag.append("&quot;");
                continue;
            }
             else {
		encodedTag.append(c);
	     }
        }

        return encodedTag.toString();
    }
public static String convertSpecialCharacters(String tag)
    {
        if(tag == null) {
			return null;
		}
        int length = tag.length();
        StringBuffer encodedTag = new StringBuffer(2 * length);
        for(int i = 0; i < length; i++)
        {
            char c = tag.charAt(i);
            
 /*            if(c == ' ')
            {
                encodedTag.append("_");
                continue;
            }
  */
             if(c == '.')
            {
                if(i!=tag.lastIndexOf(".")){
                    encodedTag.append("_");
                    continue;
                }
            }
             if(c == '—')
            {
                encodedTag.append("_");
                continue;
            }
            if(c == '#')
            {
                encodedTag.append("_");
                continue;
            }
            if(c == '%')
            {
                encodedTag.append("_");
                continue;
            }
            if(c == '&')
            {
                encodedTag.append("_");
                continue;
            }
              if(c == ';')
            {
                encodedTag.append("_");
                continue;
            }
             if(c == '-')
            {
                encodedTag.append("_");
                continue;
            }
            if(c == '"')
            {
                encodedTag.append("&quot;");
                continue;
            }
             else {
		encodedTag.append(c);
	     }
        }

        return encodedTag.toString();
    }

    public static String fixSqlFieldValue(String value)
    {
        if(value == null) {
			return null;
		}
        int length = value.length();
        StringBuffer fixedValue = new StringBuffer((int)(length * 1.1000000000000001D));
        for(int i = 0; i < length; i++)
        {
            char c = value.charAt(i);
            if(c == '\'') {
				fixedValue.append("''");
			} else {
				fixedValue.append(c);
			}
        }

        return fixedValue.toString();
    }
    
    public static String convertToFloatString(String version){
        
        
        StringBuffer modifyVersion = null;
        int position = version.indexOf('.'); 
        int alternate = version.lastIndexOf('.');
               
        while(position != alternate){
            modifyVersion = new StringBuffer(version);
            modifyVersion = modifyVersion.deleteCharAt(alternate);
            version = modifyVersion.toString();
            alternate = version.lastIndexOf('.');
        }
        
       return version; 
    }
    
}