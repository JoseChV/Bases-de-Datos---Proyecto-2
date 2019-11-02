package scripts;

public class Main {

	public static void main(String[] args) throws Exception {
		Neo4JConnection c = new Neo4JConnection("bolt://localhost:7687", "neo4j", "1234");

		c.getRecommended(5);

		c.close();

	}

}
