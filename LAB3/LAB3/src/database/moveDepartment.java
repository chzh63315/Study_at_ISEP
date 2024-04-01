package database;

import java.sql.*;

public class moveDepartment {
    public static void moveDepartment(Connection connection, int Empno, int Deptno)
    {
        String command ="UPDATE EMP SET DEPTNO = ? WHERE EMPNO =? ";
        try (PreparedStatement updateEmp = connection.prepareStatement(command))
        {
            updateEmp.setInt(1,Deptno);
            updateEmp.setInt(2,Empno);
            updateEmp.execute();
            System.out.println("ENo"+ Empno + "is now in the Dept N" + Deptno);
        }catch(Exception exception){
            exception.printStackTrace();
        }
    }


}

