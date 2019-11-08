package scripts;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ETL {
	
	private ArrayList data = null;
	
	public void extractAndTransform() throws SQLException {
		SQLServerConnection sqlConn = new SQLServerConnection();
		
		
		
		ResultSet resultSet = sqlConn.extract(); 

		data = new ArrayList();
		ArrayList sublist = null;
		int billId = 0;
		boolean flag = false;
		
		while (resultSet.next()) {
			System.out.println("loop");
			if (billId != resultSet.getInt(2)) {
				billId = resultSet.getInt(2);
				System.out.println("current bill: " + billId);
				if(flag) {
					data.add(sublist);
					System.out.println("fila insertada");
				}
				sublist = new ArrayList();
				System.out.println("nueva sublista");
				flag = true;
			}
			sublist.add(resultSet.getInt(1));
			System.out.println("articulo: " + resultSet.getInt(1));
		}
		data.add(sublist);
		System.out.println(data.toString());
		
		sqlConn.disconnect();
	}
	
	public void load() throws Exception {
		Neo4JConnection neo4j = new Neo4JConnection();
		
		int size = data.size();
		int cont = 0;
		boolean flag;
		int i;
		
		while (cont < size) {
			ArrayList sublist = (ArrayList) data.get(cont);
			int sublistSize = sublist.size();
			int subcont = 0;
			flag = true;
			i = 1;
			while (flag) {
				if (sublistSize == 1) {
					neo4j.createItem((int) sublist.get(0));
					System.out.println("item solito creado: " + sublist.get(0));
					flag = false;
				}else {
					neo4j.createRelation((int) sublist.get(subcont), (int) sublist.get(subcont + i));
					System.out.println("relacion: " + sublist.get(subcont) + " " + sublist.get(subcont + i));
					i++;
					if(subcont + i == sublistSize) {
						i = 1;
						subcont++;
						if(subcont + 1 == sublistSize) {
							flag = false;
						}
					}
				}
				
			}
			cont++;
			
		}
		neo4j.close();
		System.out.println("done");
		
	}
	
	
}
