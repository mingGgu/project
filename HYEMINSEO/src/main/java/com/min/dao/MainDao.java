package com.min.dao;
import java.util.HashMap;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.min.db.LoginManager;
import com.min.db.MainManager;
import com.min.vo.BadVo;
import com.min.vo.GoodVo;
import com.min.vo.MemberVo;
import com.min.vo.MovieVo;
import com.min.vo.ZzimVo;
@Repository
public class MainDao {
	public List<MovieVo> main(){
		return MainManager.main();
	}
	public List<MovieVo> zzimList(HashMap map){
		return MainManager.zzimList(map);
	}
	public List<MovieVo> goodList(HashMap map){
		return MainManager.goodList(map);
	}
	public List<MovieVo> boxOffice(){
		return MainManager.boxOffice();
	}
	public List<MovieVo> listMV(){
		return MainManager.listMovie();
	}
	public List<MovieVo> searchMV(HashMap map){
		return MainManager.searchMovie(map);
	}
	public List<ZzimVo> checkZ(HashMap map){
		return MainManager.checkZ(map);
	}
	public int zzim(HashMap map){ 
		return MainManager.zzim(map);
	}
	public int nzzim(HashMap map){ 
		return MainManager.nzzim(map);
	}
	public List<GoodVo> checkG(HashMap map){
		return MainManager.checkG(map);
	}
	public int good(HashMap map){ 
		return MainManager.good(map);
	}
	public int ngood(HashMap map){ 
		return MainManager.ngood(map);
	}
	public List<BadVo> checkB(HashMap map){
		return MainManager.checkB(map);
	}
	public int bad(HashMap map){ 
		return MainManager.bad(map);
	}
	public int nbad(HashMap map){ 
		return MainManager.nbad(map);
	}

	public MemberVo loginMember(HashMap map){
		return LoginManager.loginMember(map);
	}
	public int insertjoin(MemberVo mbv){ 
		return LoginManager.joinMember(mbv);
	}
	public int joinCheck(String member_email){
		return LoginManager.joinCheck(member_email);
	}
	public int nickCheck(String member_nickname){
		return LoginManager.nickCheck(member_nickname);
	}
	public int updateMember(MemberVo mbv){
		return LoginManager.updateMember(mbv);
	}
	public int updatePwd(HashMap map){
		return LoginManager.updatePwd(map);
	}
	public int updateNewPwd(HashMap map){
		return LoginManager.updateNewPwd(map);
	}
	public MemberVo sessionCheck(HashMap map){
		return LoginManager.sessionSelect(map);
	}
	public int deleteMember(HashMap map){
		return LoginManager.deleteMember(map);
	}
}
