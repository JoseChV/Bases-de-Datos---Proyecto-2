package scripts;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SQLServerConnection {
	private static Connection conn;

	public SQLServerConnection() throws SQLException {

		String connectionUrl = "jdbc:sqlserver://localhost;databaseName=test2;user=jose3;password=123";
		conn = DriverManager.getConnection(connectionUrl);
		System.out.println("Connected to SQL Server");

	}

	public void disconnect() throws SQLException {
		conn.close();
		System.out.println("Disconnected from SQL Server");

	}

	public ResultSet extract() throws SQLException {
		ResultSet resultSet = null;
		Statement statement = conn.createStatement();
		System.out.println("Extracting...");
		CallableStatement cstmt = conn.prepareCall("{call getItemRelation}");

		cstmt.execute();

		return cstmt.getResultSet();

	}
}
