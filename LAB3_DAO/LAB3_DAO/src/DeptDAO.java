import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DeptDAO extends DAO<Dept>{
    public DeptDAO(Connection connection){
        super(connection);
    }

    public Dept find(int deptno){
        Dept dept01 = new Dept();
        try{
            PreparedStatement findDept = connect.prepareStatement("SELECT * FROM DEPT WHERE deptno = ?");
            findDept.setInt(1,deptno);
            ResultSet result = findDept.executeQuery();
            while(result.next()){
                //met un while pour au cas ou on reccup plusieurs resultat ou des truc innatendu
                dept01.setDeptno(result.getInt("deptno"));
                dept01.setDname(result.getString("dname"));
                dept01.setLoc(result.getString("loc"));
            }
            result.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return dept01;
    }

    @Override
    public boolean create(Dept object) {
        return false;
    }

    @Override
    public boolean update(Dept object) {
        return false;
    }

    @Override
    public boolean delete(Dept object) {
        return false;
    }
}