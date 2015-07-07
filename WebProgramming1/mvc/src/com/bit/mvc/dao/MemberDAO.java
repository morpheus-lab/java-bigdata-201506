package com.bit.mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.bit.mvc.model.Member;

public class MemberDAO {

	public Member getMemberInfo(String id) {
		Member member = null;
		try {
			Connection conn = ConnectionContext.getConnection();
			String sql = "SELECT * FROM member WHERE id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);	// 메소드 파라미터 id를 sql 첫 번째 ?에 세팅
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				member = new Member();
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("password"));
				member.setEmail(rs.getString("email"));
				member.setPhone(rs.getString("phone"));
				member.setRegDate(rs.getDate("reg_date"));
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}

}
