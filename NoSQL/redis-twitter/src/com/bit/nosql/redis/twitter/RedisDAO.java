package com.bit.nosql.redis.twitter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.bit.nosql.redis.twitter.model.Twit;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisDAO implements ServletContextListener {
	
	private static JedisPool pool;

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		pool = new JedisPool(new JedisPoolConfig(), "192.168.1.79");
	}
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		if (pool != null)
			pool.destroy();
	}
	
	public static void registerUserInfo(String loginId, String loginPw, String userName) {
		try (Jedis jedis = pool.getResource()) {
			String nextUserSeq = jedis.incr("user_seq").toString();
			
			jedis.hset("user_info", nextUserSeq + ":loginId", loginId);
			jedis.hset("user_info", nextUserSeq + ":loginPw", CryptoUtil.sha256Digest(loginPw));
			jedis.hset("user_info", nextUserSeq + ":userName", userName);
			jedis.hset("user_info", loginId + ":user_seq", nextUserSeq);
		}
	}
	
	public static boolean idAvailable(String loginId) {
		boolean available = false;
		try (Jedis jedis = pool.getResource()) {
			String userSeq = jedis.hget("user_info", loginId + ":user_seq");
			if (userSeq == null) {	// 존재하지 않는 아이디. 즉, 사용가능
				available = true;
			}
		}
		return available;
	}
	
	public static String login(String loginId, String loginPw) {
		String userSeq = null;
		try (Jedis jedis = pool.getResource()) {
			userSeq = jedis.hget("user_info", loginId + ":user_seq");
			if (userSeq != null) {
				// 아이디가 존재하는 경우만 들어옴
				String hashedUserPw = jedis.hget("user_info", userSeq + ":loginPw");
				if (!hashedUserPw.equals(CryptoUtil.sha256Digest(loginPw))) {
					// 로그인 실패
					userSeq = null;
				}
				// 로그인 성공한 경우 조회한 userSeq 갖고 나감
			}
		}
		return userSeq;
	}
	
	public static String getUserNameByUserSeq(String userSeq) {
		String userName = null;
		try (Jedis jedis = pool.getResource()) {
			userName = jedis.hget("user_info", userSeq + ":userName");
		}
		return userName;
	}
	
	public static void twit(String userSeq, String message) {
		try (Jedis jedis = pool.getResource()) {
			Long twitSeq = jedis.incr("twit_seq");
			// 트윗 정보 등록
			jedis.set("twit:" + twitSeq,
						userSeq + "|"
						+ LocalDateTime.now().toString() + "|"
						+ message);
			
			// 전체 타임라인에 twit_seq 등록
			jedis.lpush("timeline", twitSeq.toString());
			
			// 사용자 타임라인에 twit_seq 등록
			jedis.lpush("timeline:" + userSeq, twitSeq.toString());
			
			// 팔로워 타임라인에 twit_seq 등록
			// TODO: 팔로우 기능 추가 후 작성
			
			// 사용자 트윗 목록(자기가 쓴 글만 나옴)에 twit_seq 등록
			jedis.lpush(userSeq + ":twits", twitSeq.toString());
		}
	}
	
	// 전체 타임라인의 트윗 조회
	public static List<Twit> getAllTwits() {
		List<Twit> twits = new ArrayList<>();
		try (Jedis jedis = pool.getResource()) {
			List<String> timeline = jedis.lrange("timeline", 0, -1);	// twit_seq의 리스트
			for (String twitSeq : timeline) {
				String twitRawData = jedis.get("twit:" + twitSeq);
				String[] fields = twitRawData.split("\\|", 3);
				String userSeq = fields[0];
				String datetime = fields[1];
				String message = fields[2];
				String userName = jedis.hget("user_info", userSeq + ":userName");
				Twit twit = new Twit(twitSeq, userSeq, userName, datetime, message);
				twits.add(twit);
			}
		}
		return twits;
	}
	
	// 사용자별 타임라인의 트윗 조회
	public static List<Twit> getTwits(String userSeq) {
		List<Twit> twits = new ArrayList<>();
		try (Jedis jedis = pool.getResource()) {
			List<String> timeline = jedis.lrange("timeline:" + userSeq, 0, -1);	// twit_seq의 리스트
			for (String twitSeq : timeline) {
				String twitRawData = jedis.get("twit:" + twitSeq);
				String[] fields = twitRawData.split("\\|", 3);
				String writerUserSeq = fields[0];
				String datetime = fields[1];
				String message = fields[2];
				String userName = jedis.hget("user_info", userSeq + ":userName");
				Twit twit = new Twit(twitSeq, writerUserSeq, userName, datetime, message);
				twits.add(twit);
			}
		}
		return twits;
	}
	
	// 특정 사용자 개인 트윗 목록 조회 (이 사용자가 쓴 트윗만 조회)
	public static List<Twit> getPersonalTwits(String userSeq) {
		List<Twit> twits = new ArrayList<>();
		try (Jedis jedis = pool.getResource()) {
			List<String> timeline = jedis.lrange(userSeq + ":twits", 0, -1);	// twit_seq의 리스트
			for (String twitSeq : timeline) {
				String twitRawData = jedis.get("twit:" + twitSeq);
				String[] fields = twitRawData.split("\\|", 3);
				String writerUserSeq = fields[0];
				String datetime = fields[1];
				String message = fields[2];
				String userName = jedis.hget("user_info", userSeq + ":userName");
				Twit twit = new Twit(twitSeq, writerUserSeq, userName, datetime, message);
				twits.add(twit);
			}
		}
		return twits;
	}

	public static void follow(String followee, String follower) {
		try (Jedis jedis = pool.getResource()) {
			jedis.sadd(followee + ":followers", follower);
			jedis.sadd(follower + ":following", followee);
		}
	}
	
	public static boolean isFollowing(String followee, String follower) {
		boolean isFollowing = false;
		if (followee != null && follower != null) {
			try (Jedis jedis = pool.getResource()) {
				isFollowing = jedis.sismember(follower + ":following", followee);
			}
		}
		return isFollowing;
	}
	
	public static void unfollow(String followee, String follower) {
		try (Jedis jedis = pool.getResource()) {
			
		}
	}
	
}




















