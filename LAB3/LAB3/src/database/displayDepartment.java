package database;

import java.sql.*;

public class displayDepartment {

    public static void displayDepartment(Connection connexion) throws SQLException {
        Statement statement = connexion.createStatement();
        ResultSet resultat = statement.
                executeQuery( "SELECT deptno, dname,loc FROM dept" );
        while ( resultat.next() ) {
            int deptno = resultat.getInt( "deptno");
            String dname = resultat.getString( "dname" );
            String loc = resultat.getString("loc");
            System.out.println("Department " + deptno + " is for "
                    + dname + " and located in " + loc );
        }
        resultat.close();
    }

}
