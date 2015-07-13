package com.bit.twitter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.bit.twitter.model.Member;

public class MemberDAO {
	
	public static Member selectMemberInfo(String loginId, String loginPw) throws Exception {
		Member member = null;
		
		String sql = "SELECT * FROM t_member WHERE email=? AND login_pw=?";
		
		Connection conn = ConnectionContext.getConnection();
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, loginId);
		pstmt.setString(2, loginPw);
		
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			member = new Member();
			member.setMemberSeq(rs.getBigDecimal("member_seq"));
			member.setEmail(rs.getString("email"));
			member.setLoginPw(rs.getString("login_pw"));
			member.setName(rs.getString("name"));
			member.setNickname(rs.getString("nickname"));
			member.setRegDtm(rs.getDate("reg_dtm"));
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return member;
	}
	
}





