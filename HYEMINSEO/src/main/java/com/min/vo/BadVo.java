package com.min.vo;
import java.util.Date;
public class BadVo {
	private int bad_no;
	private int member_no;
	private int movie_no;
	private int movie_bad;
	private Date bad_date;
	public BadVo() {
	}
	public BadVo(int bad_no, int member_no, int movie_no, int movie_bad, Date bad_date) {
		super();
		this.bad_no = bad_no;
		this.member_no = member_no;
		this.movie_no = movie_no;
		this.movie_bad = movie_bad;
		this.bad_date = bad_date;
	}
	public int getBad_no() {
		return bad_no;
	}
	public void setBad_no(int bad_no) {
		this.bad_no = bad_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public int getMovie_no() {
		return movie_no;
	}
	public void setMovie_no(int movie_no) {
		this.movie_no = movie_no;
	}
	public int getMovie_bad() {
		return movie_bad;
	}
	public void setMovie_bad(int movie_bad) {
		this.movie_bad = movie_bad;
	}
	public Date getBad_date() {
		return bad_date;
	}
	public void setBad_date(Date bad_date) {
		this.bad_date = bad_date;
	}
}
