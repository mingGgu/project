package com.min.vo;
public class MemberVo {
	private int member_no;
	private String member_nickname;
	private String member_email;
	private String member_pwd;
	public MemberVo() {
	}
	public MemberVo(int member_no, String member_nickname, String member_email, String member_pwd) {
		super();
		this.member_no = member_no;
		this.member_nickname = member_nickname;
		this.member_email = member_email;
		this.member_pwd = member_pwd;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_pwd() {
		return member_pwd;
	}
	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}
}
