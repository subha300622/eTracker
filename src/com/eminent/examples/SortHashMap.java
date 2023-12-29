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
public class SortHashMap extends HashMap {
    public Iterator iterator() {
        Collection collection = this.values();
        Object[] array = collection.toArray();
        Arrays.sort(array);
        return Arrays.asList(array).iterator();
    }

    public static void main(String[] args){
        HashMap yourMap= new HashMap<Integer,Integer>();

        SortHashMap map=new SortHashMap();

        map.put(101, 10);
        map.put(102, 17567);
        map.put(103, 786);
        map.put(104, 768);
        map.put(105, 0);
        map.put(106, 1560);
        map.put(107, 9680);
        map.put(108, 0);
        map.put(109, 100);

        Iterator iter = map.iterator();
        while (iter.hasNext()) {
            

        }



        yourMap.put(101, 10);
        yourMap.put(102, 17567);
        yourMap.put(103, 786);
        yourMap.put(104, 768);
        yourMap.put(105, 0);
        yourMap.put(106, 1560);
        yourMap.put(107, 9680);
        yourMap.put(108, 0);
        yourMap.put(109, 100);

      

    List yourMapKeys = new ArrayList(yourMap.keySet());
    List yourMapValues = new ArrayList(yourMap.values());
    TreeSet sortedSet = new TreeSet(yourMapKeys);
    Object[] sortedArray = sortedSet.toArray();
    int size = sortedArray.length;

    for (int i=0; i<size; i++) {
       map.put
          (yourMapKeys.get(yourMapValues.indexOf(sortedArray[i])),
           sortedArray[i]);
    }
    Set ref = map.keySet();
    Iterator it = ref.iterator();

    while (it.hasNext()) {
      int file = (Integer)it.next();
      int value= (Integer)(map.get(file));

    }




        

    }

}
