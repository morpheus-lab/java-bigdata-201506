package com.bit.twitter.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.bit.twitter.model.Twit;

public class TwitDAO {
	
	public static int insertTwit(BigDecimal memberSeq, String content) throws Exception {
		String sql = "INSERT INTO t_twit(twit_seq, writer_seq, content) "
				+ "VALUES(seq_twit.NEXTVAL, ?, ?)";
		Connection conn = ConnectionContext.getConnection();
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setBigDecimal(1, memberSeq);
		pstmt.setString(2, content);
		
		int result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	/**
	 *  전체 타임라인 조회
	 */
	public static List<Twit> selectTwit() throws Exception {
		List<Twit> list = new ArrayList<>();
		
		String sql = "SELECT * FROM t_twit WHERE rownum < 11 ORDER BY twit_seq DESC";
		Connection conn = ConnectionContext.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Twit t = new Twit(rs.getBigDecimal("twit_seq"),
								rs.getBigDecimal("writer_seq"),
								rs.getString("content"),
								rs.getDate("reg_dtm"));
			list.add(t);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return list;
	}
	
}
















