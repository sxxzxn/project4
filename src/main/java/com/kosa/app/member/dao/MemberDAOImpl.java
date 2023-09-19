package com.kosa.app.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.app.member.domain.Member;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private  SqlSession sqlSession;

    @Override
    //로그인
    public Member login(Member member) throws Exception {
    	return sqlSession.selectOne("mapper.member.login", member);
	} // login


	// 아이디 중복확인
	// 일치하는 아이디 값이 있는지 확인
	@Override
	public boolean existUid(Member member) throws Exception {
		Member existMember = sqlSession.selectOne("mapper.member.existUid", member);
		return existMember != null;
	}
	
	
	// 아이디찾기
	@Override
	public Member findUid(Member member) throws Exception {
		Member findUidMember = sqlSession.selectOne("mapper.member.findUid", member);
		return findUidMember;
	}
	
	// 비밀번호찾기
	@Override
	public Member findPwd(Member member) throws Exception {
		Member findFwdMember = sqlSession.selectOne("mapper.member.findFwd", member);
		return findFwdMember;
	}
	
	// 비밀번호확인
	@Override
	public boolean checkPwd(Member member) throws Exception {
		Member checkPwdMember = sqlSession.selectOne("mapper.member.checkPwd", member);
		return checkPwdMember != null;
	}

	// 회원가입
	@Override
	public int insert(Member member) {
		return sqlSession.insert("mapper.member.insert", member);
	}
		 
		
//	@Override
//	// 전체회원정보
//	public List<Member> getMemberAllList() throws Exception {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		// POINT
//		List<Member> memberlist = new ArrayList<Member>();
//		
//		try {
//			conn = getConnection();
//			String sql = "select memberid, name, pwd, address, phone, age, gender from member";
//			pstmt = conn.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			
//			while (rs.next()) {
//				Member member = new Member(); // 하나의 row 담기 위한 객체
//				member.setUid(rs.getString("memberid"));
//				member.setName(rs.getString("name"));
//				member.setPwd(rs.getString("pwd"));
//				member.setAddress(rs.getString("address"));
//				member.setPhone(rs.getString("phone"));
//				member.setAge(rs.getString("age"));
//				member.setGender(rs.getString("gender"));
//				memberlist.add(member); // 배열에 객체 담는 것
//			}
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		} finally {
//			rs.close();
//			pstmt.close();
//			conn.close();
//		}
//		
//		return memberlist;
//	}
	@Override
	// 회원정보수정
	public int updateMember(Member member) throws Exception {
		return sqlSession.update("mapper.member.updateMember", member);
	}
//
////        if (rowCount == 1) {
////            System.out.println("회원 정보가 성공적으로 수정되었습니다.");
////        } else {
////            System.out.println("회원 정보 수정에 실패했습니다.");
//	}
//
	@Override
	// 회원탈퇴
	public int deleteMember(Member member) throws Exception {
		return sqlSession.delete("mapper.member.deleteMember", member);
	}
//
//
//	
//	@Override
//	public int deleteMembers(String[] uids) throws Exception {
//		System.out.println("member.memberDAOImpl.deleteMembers() 함수 호출됨");
//		
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		StringBuilder params = new StringBuilder();
//		int result;
//		
//		
//		if(uids.length >= 1) {
//			params.append("('");
//			params.append(uids[0]);
//			for(int i=1;i<uids.length;i++) {
//			    params.append("','").append(uids[i]);
//			}
//
//			params.append("')");
//		}
//		try {
//			conn = getConnection();
//			String sql = "delete from member where memberid in "+ params.toString();
//			pstmt = conn.prepareStatement(sql);
//			result = pstmt.executeUpdate();
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			throw e;
//			
//		} finally {
//			if (pstmt != null)
//				pstmt.close();
//			if (conn != null)
//				conn.close();
//		}
//		
//		return result;
//		
//	}
	
}
