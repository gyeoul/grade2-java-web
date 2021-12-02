package webproject;

import java.util.Date;

public class boardBean {
	private Integer bno;
	private String btag;
	private String btitle;
	private String bwriter;
	private Date bdate;
	private String bcontent;
	private String bimage;
	
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public String getBtag() {
		return btag;
	}
	public void setBtag(String btag) {
		this.btag = btag;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBwriter() {
		return bwriter;
	}
	public void setBwriter(String bwriter) {
		this.bwriter = bwriter;
	}
	public Date getBdate() {
		return bdate;
	}
	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public String getBimage() {
		return bimage;
	}
	public void setBimage(String bimage) {
		this.bimage = bimage;
	}
	public Integer getBreco() {
		return breco;
	}
	public void setBreco(Integer breco) {
		this.breco = breco;
	}
	private Integer breco;
	
	
}
