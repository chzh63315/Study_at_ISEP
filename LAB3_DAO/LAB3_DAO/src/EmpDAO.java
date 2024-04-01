import java.sql.*;

 class EmpDAO extends DAO<Emp> {

    public EmpDAO(Connection connect) {
        super(connect);
    }

    @Override
    public Emp find(int id) {
        Emp employee = null;
        String sql = "SELECT * FROM emp WHERE empno = ?";

        try (PreparedStatement pstmt = connect.prepareStatement(sql)) {
            pstmt.setLong(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    employee = new Emp();
                    employee.setEmpNo(rs.getLong("empno"));
                    employee.setEname(rs.getString("ename"));
                    employee.setEfirst(rs.getString("efirst"));
                    employee.setJob(rs.getString("job"));
                    employee.setHireDate(rs.getDate("hiredate"));
                    employee.setSal(rs.getInt("sal"));
                    employee.setComm(rs.getInt("comm"));
                    employee.setTel(rs.getInt("tel"));

                    // Check if the manager ID is present and valid
                    int mgrId = rs.getInt("mgr");
                    if (!rs.wasNull() && mgrId != 0) {
                        Emp manager = find(mgrId); // Recursive call to build the manager
                        employee.setMgr(manager);
                    }

                    // Assuming department information is also stored in the employees table
                    // and you have a method in DeptDAO to find a department by its ID
                    Dept department = new DeptDAO(connect).find(rs.getInt("deptno"));
                    employee.setDepartment(department);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return employee;
    }

     @Override
     public boolean create(Emp object) {
         return false;
     }

     @Override
     public boolean update(Emp object) {
         return false;
     }

     @Override
     public boolean delete(Emp object) {
         return false;
     }

}
