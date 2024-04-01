//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
package database;
import java.sql.*;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        /* Load JDBC Driver. */
        try {
            Class.forName( "org.postgresql.Driver" );
        } catch ( ClassNotFoundException e ) {
            e.printStackTrace();
        }

        String url = "jdbc:postgresql://localhost/ISEP2024";
        String user = "postgres";
        String pass = "123456";
        Connection connexion = null;

        try {
            connexion = DriverManager.getConnection( url, user, pass );
            System.out.println("Bdd Connected");  /* Requests to bdd will be here */

            /*
            displayDepartment.displayDepartment(connexion);

            Scanner sc = new Scanner(System.in);
            System.out.println("Enter an E ID");
            int Empno = sc.nextInt();
            System.out.println("Enter D ID");
            int Deptno = sc.nextInt();
            moveDepartment.moveDepartment(connexion,Empno,Deptno);

            Scanner scanner = new Scanner(System.in);
            System.out.println("Enter TableName");
            String tableName = scanner.nextLine();
            displayTable.displayTable(connexion, tableName);
            */


        } catch ( SQLException e ) {
            e.printStackTrace();
        } finally {
            if ( connexion != null )
                try {
                    connexion.close();
                } catch ( SQLException ignore ) {
                    ignore.printStackTrace();
                }
        }
    }
}

