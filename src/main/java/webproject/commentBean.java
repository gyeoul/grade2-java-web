package webproject;

import java.util.Date;

public class commentBean {
	private Integer cno;
	private Integer bno;
	private Integer bcno;
	private String cwriter;
	private String ccontent;
	private Date cdate;
	
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	
	public Integer getCno() {
		return cno;
	}
	public void setCno(Integer cno) {
		this.cno = cno;
	}
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public String getCwriter() {
		return cwriter;
	}
	public void setCwriter(String cwriter) {
		this.cwriter = cwriter;
	}
	public String getCcontent() {
		return ccontent;
	}
	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}
	public Integer getBcno() {
		return bcno;
	}
	public void setBcno(Integer bcno) {
		this.bcno = bcno;
	}
}
