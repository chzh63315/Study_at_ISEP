
import java.math.BigDecimal;

public class Bonus {
    private String ename;
    private String job;
    private BigDecimal bonusAmount;

    public Bonus() {
    }

    public Bonus(String ename, String job, BigDecimal bonusAmount) {
        this.ename = ename;
        this.job = job;
        this.bonusAmount = bonusAmount;
    }

    // Getters and setters
    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public BigDecimal getBonusAmount() {
        return bonusAmount;
    }

    public void setBonusAmount(BigDecimal bonusAmount) {
        this.bonusAmount = bonusAmount;
    }

    @Override
    public String toString() {
        return "Bonus{" +
                "ename='" + ename + '\'' +
                ", job='" + job + '\'' +
                ", bonusAmount=" + bonusAmount +
                '}';
    }
}