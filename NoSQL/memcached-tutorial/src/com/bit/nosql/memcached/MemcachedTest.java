package com.bit.nosql.memcached;

import net.spy.memcached.AddrUtil;
import net.spy.memcached.MemcachedClient;

public class MemcachedTest {
	
	public static void main(String[] args) throws Exception {
		
		MemcachedClient client = new MemcachedClient(
				AddrUtil.getAddresses("192.168.1.79:11211 192.168.1.83:11211 "
						+ "192.168.1.12:11211 192.168.1.88:11211"));
//		for (int i = 0; i < 10000; i++) {
//			client.set("a" + i, 0, i);
//		}
		
		System.out.println(client.get("a7000"));
		
	}
	
}
