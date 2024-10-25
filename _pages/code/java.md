---
title: "Javascript"
permalink: /code/java/
toc: true
author_profile: false
layout: code
---




# Structure

```java

package mariadb; // name of the file

// ---------------------------- Import libraries --------------------------
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.sql.Statement;
import java.sql.*;


// ---------------------------- code --------------------------
public class mariadb {

    public static void main(String[] args) {

	}

	public class mariadb {
		// A CLASS
    }

	// ---------------------------- function --------------------------
    public static int nrow(ResultSet rs) {
		// a function
    }

} // end mariadb
```

# Libraries

Insert a library, e.g a .jar (jdbc, mariadb driver)

## mariadb

For Intellij IDEA:

- File / Project structure / Modules / Dependencies / '+' add a library and choose your .jar


# Build

## Gradle

Gradlew is a wrapper and is coming from Genedata.
To create a zip file of the built, use `gradlew distZip`.
Use additional parameters to see errors : `gradlew distZip --debug` or `gradlew distZip --debug | grep error`.

# Function

In your main function

nrow -----------------------------------------------

```java
	public static int nrow(ResultSet rs) {
        // number rows
        int nrow = 0;
        try {
            rs.last();
            nrow = rs.getRow();
            rs.beforeFirst();
        } catch(Exception ex) {
            return 0;
        }
        return nrow;
    }
```

ReadDB mariadb -------------------------------------
```java
	public class mariadb {
		// JDBC driver name and database URL

		static final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
		static final String DB_URL = "jdbc:mariadb://10.13.20.9/Mapping_R";

		//  Database credentials
		static final String USER = "hts";
		static final String PASS = "uspfhdc";

		public static void main(String[] args) {

			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;

			try {
				//STEP 2: Register JDBC driver
				Class.forName(JDBC_DRIVER);

				//STEP 3: Open a connection
				System.out.println("Connecting to a selected database...");
				conn = DriverManager.getConnection(
						DB_URL, USER, PASS);
				System.out.println("Connected database successfully...");

				//STEP 4: Execute a query
					// ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY https://stackoverflow.com/questions/7886462/how-to-get-row-count-using-resultset-in-java
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

				rs = stmt.executeQuery("select * from CPidmapping_20190207 where CP='HDC_0002581'");
				while (rs.next()) {
					String CP = rs.getString("CP");
					String row = rs.getString("row");
					String col = rs.getString("col");
					String CPid = rs.getString("CPid");
					String CCM = rs.getString("CCM");
					// print the results
					System.out.format("%s, %s, %s, %s, %s\n", CP, row, col, CPid, CCM);
				}

			} catch (SQLException se) {
				//Handle errors for JDBC
				se.printStackTrace();
			} catch (Exception e) {
				//Handle errors for Class.forName
				e.printStackTrace();
			} finally {
				//finally block used to close resources
				try {
					if (stmt != null) {
						conn.close();
					}
				} catch (SQLException se) {
				}// do nothing
				try {
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException se) {
					se.printStackTrace();
				}//end finally try
			}//end try
			System.out.println("Goodbye!");
		} //end main
	} // end mariadb
```
