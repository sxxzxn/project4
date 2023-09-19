package com.kosa.app.member.dao;

import com.kosa.app.member.domain.Member;

public interface MemberDAO {
	
	//1. 전체 회원 확인
//	List<Member> getMemberAllList() throws Exception; 
	
	//2. 회원가입
	int insert(Member member); 

	//3. 회원정보수정
	int updateMember(Member member) throws Exception; 

	//4. 회원탈퇴
	int deleteMember(Member member) throws Exception; 

	//5.아이디중복확인
	boolean existUid(Member member) throws Exception; 

	//6. 로그인
	Member login(Member member) throws Exception; 

	//7. 아이디찾기
	Member findUid(Member member) throws Exception; 

	//8. 비밀번호찾기
	Member findPwd(Member member) throws Exception; 

	//9. 비밀번호확인
	boolean checkPwd(Member member) throws Exception;

	//10.선택회원 삭제
//	int deleteMembers(String[] uids) throws Exception;



	
	
	

	





}
