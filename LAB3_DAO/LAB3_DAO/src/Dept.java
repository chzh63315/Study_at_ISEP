public class Dept {
    private int Deptno;
    public int getDeptno() {
        return Deptno;
    }
    public void setDeptno(int deptno) {
        Deptno = deptno;
    }
    public String getDname() {
        return Dname;
    }
    public void setDname(String dname) {
        Dname = dname;
    }
    public String getLoc() {
        return loc;
    }
    public void setLoc(String loc) {
        this.loc = loc;
    }
    private String Dname;
    private String loc;
    public String toString(){
        return "Deptno : " + getDeptno() + " | Departement Name : " + getDname() + " | Departement location : " + getLoc();
    }

}