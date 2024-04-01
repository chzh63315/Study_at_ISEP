
public class Dependents {
    private int dno;
    private String dname;
    private String dfirst;
    private int empNo;


    public Dependents() {
    }

    public Dependents(int dno, String dname, String dfirst, int empNo) {
        this.dno = dno;
        this.dname = dname;
        this.dfirst = dfirst;
        this.empNo = empNo;
    }

    // Getters and setters
    public int getDno() {
        return dno;
    }

    public void setDno(int dno) {
        this.dno = dno;
    }

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public String getDfirst() {
        return dfirst;
    }

    public void setDfirst(String dfirst) {
        this.dfirst = dfirst;
    }

    public int getEmpNo() {
        return empNo;
    }

    public void setEmpNo(int empNo) {
        this.empNo = empNo;
    }

    @Override
    public String toString() {
        return "Dependents {" +
                "dno=" + dno +
                ", dname='" + dname + '\'' +
                ", dfirst='" + dfirst + '\'' +
                ", empNo=" + empNo +
                '}';
    }
}