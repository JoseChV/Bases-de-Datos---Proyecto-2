package scripts;

public class Main {

	public static void main(String[] args) throws Exception {
		ETL etl = new ETL();
		etl.extractAndTransform();
		etl.load();
		
		
	}

}
