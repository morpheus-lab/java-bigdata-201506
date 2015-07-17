package com.bit.nosql.redis;

import java.util.Iterator;
import java.util.Set;
import java.util.function.Consumer;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisExample {
	
	public static void main(String[] args) {
		
		try (JedisPool pool = new JedisPool(new JedisPoolConfig(),
				"192.168.1.79", 6379)) {
			
			try (Jedis jedis = pool.getResource()) {
				// �Ϲ� ���ڿ� ������ ����
				jedis.set("jedis", "awesome");
				
				// ������ ��ȸ
				String value = jedis.get("jedis");
				System.out.println("jedis: " + value);
				
				// Set Ÿ���� ������ ����
				jedis.zadd("z2", 10, "KOREA");
				jedis.zadd("z2", 20, "USA");
				jedis.zadd("z2", 30, "CHINA");
				jedis.zadd("z2", 30, "JAPAN");
				
				// Set Ÿ�� ������ ��ȸ
				Set<String> z2 = jedis.zrange("z2", 0, -1);
//				Iterator<String> iter = z2.iterator();
//				while (iter.hasNext()) {
//					System.out.println(iter.next());
//				}
				z2.forEach(new Consumer<String>() {
					@Override
					public void accept(String t) {
						System.out.println(t);
					}
				});
			}
			
		}
		
	}
	
}
