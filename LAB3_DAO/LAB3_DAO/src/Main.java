import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {

    public static void main(String[] args) {
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

            System.out.println("Bdd Connected");

            /*

            DAO<Dept> departmentDao = new DeptDAO(connexion);
            Dept dept20 = departmentDao.find(20);
            System.out.println(dept20.toString());

            EmpDAO empDao = new EmpDAO(connexion);

            int empIdToFind = 7369;
            Emp employee = empDao.find(empIdToFind);

            if (employee != null) {
                System.out.println("Employee found: " + employee.toString());
            } else {
                System.out.println("Employee with ID " + empIdToFind + " not found.");
            }

            */


            DAOFactory daoFactory = new DAOFactory(connexion);


            EmpDAO empDao = daoFactory.getEmpDAO();
            Emp emp = empDao.find(7654);
            if (emp != null) {
                System.out.println("EMP IS: " + emp);
            } else {
                System.out.println("NOT FIND");
            }



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