package com.min.vo;
public class GoodVo {
	private int good_no;
	private int member_no;
	private int movie_no;
	private int movie_good;
	private int good_date;
	public GoodVo() {
	}
	public GoodVo(int good_no, int member_no, int movie_no, int movie_good, int good_date) {
		super();
		this.good_no = good_no;
		this.member_no = member_no;
		this.movie_no = movie_no;
		this.movie_good = movie_good;
		this.good_date = good_date;
	}
	public int getGood_no() {
		return good_no;
	}
	public void setGood_no(int good_no) {
		this.good_no = good_no;
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
	public int getMovie_good() {
		return movie_good;
	}
	public void setMovie_good(int movie_good) {
		this.movie_good = movie_good;
	}
	public int getGood_date() {
		return good_date;
	}
	public void setGood_date(int good_date) {
		this.good_date = good_date;
	}
}
