package com.min.vo;
public class MovieVo {
	private int movie_no;
	private String movie_title;
	private String movie_titleEng;
	private String movie_genre;
	private String movie_nation;
	private String movie_runtime;
	private String movie_grade;
	private String movie_opendate;
	private String movie_director;
	private String movie_actor;
	private String movie_image_url;
	private String movie_play_url;
	private String movie_content;
	private int movie_nowplaying;
	private int movie_nowrank;
	public MovieVo() {
	}
	public MovieVo(int movie_no, String movie_title, String movie_titleEng, String movie_genre,
			String movie_nation, String movie_runtime, String movie_grade, String movie_opendate, String movie_director,
			String movie_actor, String movie_image_url, String movie_play_url, String movie_content,
			int movie_nowplaying, int movie_nowrank) {
		super();
		this.movie_no = movie_no;
		this.movie_title = movie_title;
		this.movie_titleEng = movie_titleEng;
		this.movie_genre = movie_genre;
		this.movie_nation = movie_nation;
		this.movie_runtime = movie_runtime;
		this.movie_grade = movie_grade;
		this.movie_opendate = movie_opendate;
		this.movie_director = movie_director;
		this.movie_actor = movie_actor;
		this.movie_image_url = movie_image_url;
		this.movie_play_url = movie_play_url;
		this.movie_content = movie_content;
		this.movie_nowplaying = movie_nowplaying;
		this.movie_nowrank = movie_nowrank;
	}
	public int getMovie_no() {
		return movie_no;
	}
	public void setMovie_no(int movie_no) {
		this.movie_no = movie_no;
	}
	public String getMovie_title() {
		return movie_title;
	}
	public void setMovie_title(String movie_title) {
		this.movie_title = movie_title;
	}
	public String getMovie_titleEng() {
		return movie_titleEng;
	}
	public void setMovie_titleEng(String movie_titleEng) {
		this.movie_titleEng = movie_titleEng;
	}
	public String getMovie_genre() {
		return movie_genre;
	}
	public void setMovie_genre(String movie_genre) {
		this.movie_genre = movie_genre;
	}
	public String getMovie_nation() {
		return movie_nation;
	}
	public void setMovie_nation(String movie_nation) {
		this.movie_nation = movie_nation;
	}
	public String getMovie_runtime() {
		return movie_runtime;
	}
	public void setMovie_runtime(String movie_runtime) {
		this.movie_runtime = movie_runtime;
	}
	public String getMovie_grade() {
		return movie_grade;
	}
	public void setMovie_grade(String movie_grade) {
		this.movie_grade = movie_grade;
	}
	public String getMovie_opendate() {
		return movie_opendate;
	}
	public void setMovie_opendate(String movie_opendate) {
		this.movie_opendate = movie_opendate;
	}
	public String getMovie_director() {
		return movie_director;
	}
	public void setMovie_director(String movie_director) {
		this.movie_director = movie_director;
	}
	public String getMovie_actor() {
		return movie_actor;
	}
	public void setMovie_actor(String movie_actor) {
		this.movie_actor = movie_actor;
	}
	public String getMovie_image_url() {
		return movie_image_url;
	}
	public void setMovie_image_url(String movie_image_url) {
		this.movie_image_url = movie_image_url;
	}
	public String getMovie_play_url() {
		return movie_play_url;
	}
	public void setMovie_play_url(String movie_play_url) {
		this.movie_play_url = movie_play_url;
	}
	public String getMovie_content() {
		return movie_content;
	}
	public void setMovie_content(String movie_content) {
		this.movie_content = movie_content;
	}
	public int getMovie_nowplaying() {
		return movie_nowplaying;
	}
	public void setMovie_nowplaying(int movie_nowplaying) {
		this.movie_nowplaying = movie_nowplaying;
	}
	public int getMovie_nowrank() {
		return movie_nowrank;
	}
	public void setMovie_nowrank(int movie_nowrank) {
		this.movie_nowrank = movie_nowrank;
	}
}
