package com.bit.nosql.redis.twitter;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class CryptoUtil {
	
	public static String sha256Digest(String plainText) {
		String digest = "";
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(plainText.getBytes());
			byte[] byteData = md.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			digest = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			digest = null;
			e.printStackTrace();
		}
		return digest;
	}
	
	public static void main(String[] args) {
		System.out.println(sha256Digest("1"));
	}
	
}
