package scripts;

import org.neo4j.driver.v1.AuthTokens;
import org.neo4j.driver.v1.Driver;
import org.neo4j.driver.v1.GraphDatabase;
import org.neo4j.driver.v1.Record;
import org.neo4j.driver.v1.Session;
import org.neo4j.driver.v1.StatementResult;
import org.neo4j.driver.v1.Transaction;

public class Neo4JConnection implements AutoCloseable {
	private final Driver driver;

	public Neo4JConnection() {
		driver = GraphDatabase.driver("bolt://localhost:7687", AuthTokens.basic("neo4j", "1234"));
	}

	@Override
	public void close() throws Exception {
		driver.close();
	}

	public void createItem(int idItem) {
		Session session = driver.session();

		try (Transaction tx = session.beginTransaction()) {
			tx.run("MERGE (a:Item {id:" + idItem + " })");
			tx.success();
		}
	}

	public void createRelation(int idItem1, int idItem2) {
		Session session = driver.session();

		try (Transaction tx = session.beginTransaction()) {
			tx.run("MERGE (a:Item {id:" + idItem1 + " })" + "MERGE (b:Item {id:" + idItem2 + " })"
					+ "MERGE (a) - [:BoughtWith] -> (b)" + "MERGE (b) - [:BoughtWith] -> (a)");

			tx.success();
		}
	}

	public void deleteAll() {
		Session session = driver.session();

		try (Transaction tx = session.beginTransaction()) {
			tx.run("MATCH (n) DETACH DELETE n");

			tx.success();
		}
	}

	public void getRecommended(int idItem) {

		Session session = driver.session();

		try (Transaction tx = session.beginTransaction()) {
			StatementResult result = tx.run("MATCH (a:Item {id:" + idItem + "})-[r]->(b)" + "RETURN b.id");

			tx.success();

			while (result.hasNext()) {
				Record record = result.next();
				int id = record.get(0).asInt();
				System.out.println(id);
			}

		}

	}
}
