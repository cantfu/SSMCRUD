package com.cantfu.crud.test;

import org.junit.Test;

import java.util.HashSet;

/**
 * OtherTest
 *
 * @author cantfu
 * @date 2019/3/29
 */
public class OtherTest {
    @Test
    public void numTest(){
        int a = -5;
        int b = 5;
        int key = 1;
        for (int i = 0; i < 32; i++) {
            if ((i & 3) == 0) {
                System.out.print(" ");
            }
            System.out.print(((key << 1)&b) == 0?0:1);
        }
        System.out.println();
        for (int i = 0; i < 32; i++) {
            if ((i & 3) == 0) {

                System.out.print(" ");
            }
            System.out.print(((key << 1)&a) == 0?0:1);
        }
    }
    @Test
    public void setTest(){
        HashSet hashSet = new HashSet();
        hashSet.add(1);
        hashSet.add(2);
        hashSet.add(1);
        System.out.println(hashSet.size());
        for (Object o : hashSet) {
            System.out.println(o);
        }
    }
}
