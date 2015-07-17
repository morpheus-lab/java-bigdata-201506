package com.bit.nosql.tokyotyrant;

import net.spy.memcached.AddrUtil;
import net.spy.memcached.MemcachedClient;

public class TokyoTyrantTest {
	
	public static void main(String[] args) throws Exception {
		
		MemcachedClient client = new MemcachedClient(
				AddrUtil.getAddresses("192.168.1.79:1978"));
		
		System.out.println(client.get("tokyo"));
		
	}
	
}
