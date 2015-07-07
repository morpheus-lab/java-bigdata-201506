package com.bit.mvc.dao;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionContext {

	private static DataSource ds;	// 커넥션 풀
	
	public static Connection getConnection() throws SQLException, NamingException {
		if (ds == null) {
			InitialContext ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora");
		}
		return ds.getConnection();
	}

}




