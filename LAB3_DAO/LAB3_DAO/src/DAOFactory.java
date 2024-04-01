import java.sql.Connection;

public class DAOFactory {
    private final Connection connection;

    public DAOFactory(Connection connection) {
        this.connection = connection;
    }

    public DeptDAO getDeptDAO() {
        return new DeptDAO(connection);
    }

    public EmpDAO getEmpDAO() {
        return new EmpDAO(connection);
    }

    public DependentsDAO getDependentsDAO() {
        return new DependentsDAO(connection);
    }

    public BonusDAO getBonusDAO() {
        return new BonusDAO(connection);
    }
*/
}
