package com.bit.nosql.redis.twitter.model;

public class Twit {
	
	private String twitSeq;
	private String userSeq;
	private String userName;
	private String datetime;
	private String message;
	
	public Twit() {}

	public Twit(String twitSeq, String userSeq, String userName,
			String datetime, String message) {
		this.twitSeq = twitSeq;
		this.userSeq = userSeq;
		this.userName = userName;
		this.datetime = datetime;
		this.message = message;
	}
	
	public Twit(String twitSeq, String rawData, String userName) {	// 123|2015-07-20|Hello~~ Everybody~
		this.twitSeq = twitSeq;
		
		String[] fields = rawData.split("\\|", 3);
		this.userSeq = fields[0];
		this.datetime = fields[1];
		this.message = fields[2];
		
		this.userName = userName;
	}

	public String getTwitSeq() {
		return twitSeq;
	}

	public void setTwitSeq(String twitSeq) {
		this.twitSeq = twitSeq;
	}

	public String getUserSeq() {
		return userSeq;
	}

	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}
