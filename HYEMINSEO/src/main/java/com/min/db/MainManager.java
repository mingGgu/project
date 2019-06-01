package com.min.db;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.min.vo.BadVo;
import com.min.vo.GoodVo;
import com.min.vo.MovieVo;
import com.min.vo.ZzimVo;
public class MainManager {
	public static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/min/db/sqlMapConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	// 메인에서 슬라이더 top3 반환하는 메소드
		public static List<MovieVo> main(){
			List<MovieVo> list = null;
			SqlSession session = factory.openSession();
			list = session.selectList("movie.main");
			session.close();
			return list;
		}
	// 메인에서 찜 목록 반환하는 메소드
	public static List<MovieVo> zzimList(HashMap map){
		List<MovieVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.mainZ", map);
		session.close();
		return list;
	}
	// 메인에서 좋아요 목록 반환하는 메소드
	public static List<MovieVo> goodList(HashMap map){
		List<MovieVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.mainG", map);
		session.close();
		return list;
	}
	// 메인에서 박스오피스 top10 반환하는 메소드
	public static List<MovieVo> boxOffice(){
		List<MovieVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.boxoffice");
		session.close();
		return list;
	}
	// 영화 정보 전체를 반환하는 메소드
	public static List<MovieVo> listMovie(){
		List<MovieVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.listMV");
		session.close();
		return list;
	}
	// 검색시 해당 영화 정보를 반환하는 메소드
	public static List<MovieVo> searchMovie(HashMap map){
		List<MovieVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.searchMV", map);
		session.close();
		return list;
	}
	
	// 회원별 찜 목록을 반환하는 메소드
	public static List<ZzimVo> checkZ(HashMap map){
		List<ZzimVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.checkZ", map);
		session.close();
		return list;
	}
	// 찜 버튼 클릭시 DB에 insert하는 메소드
	public static int zzim(HashMap map){
		int z = -1;
		SqlSession session = factory.openSession(true);
		z = session.insert("movie.zzim", map);
		session.close();
		return z;
	}
	// 찜 버튼 클릭시 DB에 delete하는 메소드
	public static int nzzim(HashMap map){
		int z = -1;
		SqlSession session = factory.openSession(true);
		z = session.delete("movie.nzzim", map);
		session.close();
		return z;
	}
	
	// 회원별 좋아요 목록을 반환하는 메소드
	public static List<GoodVo> checkG(HashMap map){
		List<GoodVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.checkG", map);
		session.close();
		return list;
	}
	// 좋아요 버튼 클릭시 DB에 insert하는 메소드
	public static int good(HashMap map){
		int g = -1;
		SqlSession session = factory.openSession(true);
		g = session.insert("movie.good", map);
		session.close();
		return g;
	}
	// 좋아요 버튼 클릭시 DB에 delete하는 메소드
	public static int ngood(HashMap map){
		int g = -1;
		SqlSession session = factory.openSession(true);
		g = session.delete("movie.ngood", map);
		session.close();
		return g;
	}
	
	// 회원별 싫어요 목록을 반환하는 메소드
	public static List<BadVo> checkB(HashMap map){
		List<BadVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.checkB", map);
		session.close();
		return list;
	}
	// 싫어요 버튼 클릭시 DB에 insert하는 메소드
	public static int bad(HashMap map){
		int b = -1;
		SqlSession session = factory.openSession(true);
		b = session.insert("movie.bad", map);
		session.close();
		return b;
	}
	// 싫어요 버튼 클릭시 DB에 delete하는 메소드
	public static int nbad(HashMap map){
		int b = -1;
		SqlSession session = factory.openSession(true);
		b = session.delete("movie.nbad", map);
		session.close();
		return b;
	}
}
