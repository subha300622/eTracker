/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.util.*;


/**
 *
 * @author Tamilvelan
 */
public class testSortMap {
    public static void main (String[] args) {
          Calendar cal =Calendar.getInstance();
    int currentYear=cal.get(Calendar.YEAR);
    int currentMonth=cal.get(Calendar.MONTH);


Map yourMap = new HashMap();
//m.put ("IGGHHG", new Integer(232353453));
//m.put ("ASDF", new Integer(345555000));
//m.put ("DSF", new Integer(345555000));
//m.put ("XYZ", new Integer(45555555));
//m.put ("AAA", new Integer(0));

     yourMap.put("101", 10);
        yourMap.put("102", 17567);
        yourMap.put("103", 786);
        yourMap.put("104", 768);
        yourMap.put("105", 0);
        yourMap.put("106", 1560);
        yourMap.put("107", 9680);
        yourMap.put("108", 0);
        yourMap.put("109", 100);

ArrayList outputList = sortMap(yourMap);
int count = 0;
count = outputList.size();
while(count > 0) {
Map.Entry entry = (Map.Entry) outputList.get(--count);

}
}

/**
* This method will use Arrays.sort for sorting Map
* @param map
* @return outputList of Map.Entries
*/
public static ArrayList sortMap(Map map) {
ArrayList outputList = null;
int count = 0;
Set set = null;
Map.Entry[] entries = null;
// Logic:
// get a set from Map
// Build a Map.Entry[] from set
// Sort the list using Arrays.sort
// Add the sorted Map.Entries into arrayList and return

set = (Set) map.entrySet();
Iterator iterator = set.iterator();
entries = new Map.Entry[set.size()];
while(iterator.hasNext()) {
entries[count++] = (Map.Entry) iterator.next();
}

// Sort the entries with your own comparator for the values:
Arrays.sort(entries, new Comparator() {
public int compareTo(Object lhs, Object rhs) {
Map.Entry le = (Map.Entry)lhs;
Map.Entry re = (Map.Entry)rhs;
return ((Comparable)le.getValue()).compareTo((Comparable)re.getValue());
}

public int compare(Object lhs, Object rhs) {
Map.Entry le = (Map.Entry)lhs;
Map.Entry re = (Map.Entry)rhs;
return ((Comparable)le.getValue()).compareTo((Comparable)re.getValue());
}
});
outputList = new ArrayList();
for(int i = 0; i < entries.length; i++) {
outputList.add(entries[i]);
}
return outputList;
}//End of sortMap

}
