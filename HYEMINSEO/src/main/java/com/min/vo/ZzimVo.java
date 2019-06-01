package com.min.vo;
import java.util.Date;
public class ZzimVo {
	private int zzim_no;
	private int member_no;
	private int movie_no;
	private int movie_zzim;
	private Date zzim_date;
	public ZzimVo() {
	}
	public ZzimVo(int zzim_no, int member_no, int movie_no, int movie_zzim, Date zzim_date) {
		super();
		this.zzim_no = zzim_no;
		this.member_no = member_no;
		this.movie_no = movie_no;
		this.movie_zzim = movie_zzim;
		this.zzim_date = zzim_date;
	}
	public int getZzim_no() {
		return zzim_no;
	}
	public void setZzim_no(int zzim_no) {
		this.zzim_no = zzim_no;
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
	public int getMovie_zzim() {
		return movie_zzim;
	}
	public void setMovie_zzim(int movie_zzim) {
		this.movie_zzim = movie_zzim;
	}
	public Date getZzim_date() {
		return zzim_date;
	}
	public void setZzim_date(Date zzim_date) {
		this.zzim_date = zzim_date;
	}
}
