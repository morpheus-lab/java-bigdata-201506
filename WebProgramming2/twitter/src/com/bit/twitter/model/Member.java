package com.bit.twitter.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class Member implements Serializable {

	private BigDecimal memberSeq;
	private String email;
	private String loginPw;
	private String name;
	private String nickname;
	private Date regDtm;

	public BigDecimal getMemberSeq() {
		return memberSeq;
	}

	public void setMemberSeq(BigDecimal memberSeq) {
		this.memberSeq = memberSeq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLoginPw() {
		return loginPw;
	}

	public void setLoginPw(String loginPw) {
		this.loginPw = loginPw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public Date getRegDtm() {
		return regDtm;
	}

	public void setRegDtm(Date regDtm) {
		this.regDtm = regDtm;
	}

}
