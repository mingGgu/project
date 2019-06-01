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
	// ���ο��� �����̴� top3 ��ȯ�ϴ� �޼ҵ�
		public static List<MovieVo> main(){
			List<MovieVo> list = null;
			SqlSession session = factory.openSession();
			list = session.selectList("movie.main");
			session.close();
			return list;
		}
	// ���ο��� �� ��� ��ȯ�ϴ� �޼ҵ�
	public static List<MovieVo> zzimList(HashMap map){
		List<MovieVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.mainZ", map);
		session.close();
		return list;
	}
	// ���ο��� ���ƿ� ��� ��ȯ�ϴ� �޼ҵ�
	public static List<MovieVo> goodList(HashMap map){
		List<MovieVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.mainG", map);
		session.close();
		return list;
	}
	// ���ο��� �ڽ����ǽ� top10 ��ȯ�ϴ� �޼ҵ�
	public static List<MovieVo> boxOffice(){
		List<MovieVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.boxoffice");
		session.close();
		return list;
	}
	// ��ȭ ���� ��ü�� ��ȯ�ϴ� �޼ҵ�
	public static List<MovieVo> listMovie(){
		List<MovieVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.listMV");
		session.close();
		return list;
	}
	// �˻��� �ش� ��ȭ ������ ��ȯ�ϴ� �޼ҵ�
	public static List<MovieVo> searchMovie(HashMap map){
		List<MovieVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.searchMV", map);
		session.close();
		return list;
	}
	
	// ȸ���� �� ����� ��ȯ�ϴ� �޼ҵ�
	public static List<ZzimVo> checkZ(HashMap map){
		List<ZzimVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.checkZ", map);
		session.close();
		return list;
	}
	// �� ��ư Ŭ���� DB�� insert�ϴ� �޼ҵ�
	public static int zzim(HashMap map){
		int z = -1;
		SqlSession session = factory.openSession(true);
		z = session.insert("movie.zzim", map);
		session.close();
		return z;
	}
	// �� ��ư Ŭ���� DB�� delete�ϴ� �޼ҵ�
	public static int nzzim(HashMap map){
		int z = -1;
		SqlSession session = factory.openSession(true);
		z = session.delete("movie.nzzim", map);
		session.close();
		return z;
	}
	
	// ȸ���� ���ƿ� ����� ��ȯ�ϴ� �޼ҵ�
	public static List<GoodVo> checkG(HashMap map){
		List<GoodVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.checkG", map);
		session.close();
		return list;
	}
	// ���ƿ� ��ư Ŭ���� DB�� insert�ϴ� �޼ҵ�
	public static int good(HashMap map){
		int g = -1;
		SqlSession session = factory.openSession(true);
		g = session.insert("movie.good", map);
		session.close();
		return g;
	}
	// ���ƿ� ��ư Ŭ���� DB�� delete�ϴ� �޼ҵ�
	public static int ngood(HashMap map){
		int g = -1;
		SqlSession session = factory.openSession(true);
		g = session.delete("movie.ngood", map);
		session.close();
		return g;
	}
	
	// ȸ���� �Ⱦ�� ����� ��ȯ�ϴ� �޼ҵ�
	public static List<BadVo> checkB(HashMap map){
		List<BadVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("movie.checkB", map);
		session.close();
		return list;
	}
	// �Ⱦ�� ��ư Ŭ���� DB�� insert�ϴ� �޼ҵ�
	public static int bad(HashMap map){
		int b = -1;
		SqlSession session = factory.openSession(true);
		b = session.insert("movie.bad", map);
		session.close();
		return b;
	}
	// �Ⱦ�� ��ư Ŭ���� DB�� delete�ϴ� �޼ҵ�
	public static int nbad(HashMap map){
		int b = -1;
		SqlSession session = factory.openSession(true);
		b = session.delete("movie.nbad", map);
		session.close();
		return b;
	}
}
