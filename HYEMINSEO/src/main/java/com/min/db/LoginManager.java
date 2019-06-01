package com.min.db;
import java.io.Reader;
import java.util.HashMap;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import com.min.vo.MemberVo;
public class LoginManager {
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
	public static MemberVo loginMember(HashMap map){
		MemberVo mbv = null;
		SqlSession session = factory.openSession(true);
		mbv = session.selectOne("member.loginCheck", map);
		session.close();
		return mbv;
	}
	public static int joinMember(MemberVo mbv){
		int r = -1;
		SqlSession session = factory.openSession(true);
		r = session.insert("member.joinMember", mbv);
		session.close();
		return r;
	}
	public static int joinCheck(String member_email){
		int r = -1;
		SqlSession session = factory.openSession(true);
		r =  session.selectOne("member.joinCheck", member_email);
		session.close();
		return r;
	}
	public static int nickCheck(String member_nickname){
		int r = -1;
		SqlSession session = factory.openSession(true);
		r =  session.selectOne("member.nickCheck", member_nickname);
		session.close();
		return r;
	}
	// 회원 정보 수정
	public static int updateMember(MemberVo mbv){
		int r = -1;
		SqlSession session = factory.openSession(true);
		r =  session.update("member.updateMember", mbv);
		session.close();
		return r;
	}
	// 회원 정보 끌어오기
	public static MemberVo sessionSelect(HashMap map){
		MemberVo mbv = null;
		SqlSession session = factory.openSession();
		mbv = session.selectOne("member.sessionCheck", map);
		session.close();
		return mbv;
	}
	// 비밀번호 확인
	public static int updatePwd(HashMap map){
		int r = -1;
		SqlSession session = factory.openSession(true);
		r = session.selectOne("member.updatePwd", map);
		session.close();
		return r;
	}
	// 비밀번호 변경
	public static int updateNewPwd(HashMap map){
		int r = -1;
		SqlSession session = factory.openSession(true);
		r = session.update("member.updateNewPwd", map);
		session.close();
		return r;
	}
	public static int deleteMember(HashMap map){
		int r = -1;
		SqlSession session = factory.openSession(true);
		r = session.delete("member.deleteMember", map);
		session.close();
		return r;
	}
}
