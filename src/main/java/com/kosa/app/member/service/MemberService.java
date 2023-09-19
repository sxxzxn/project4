package com.kosa.app.member.service;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.app.member.dao.MemberDAO;
import com.kosa.app.member.domain.Member;

@Service
public class MemberService {
	
	// db와 연동관련 업무
	@Autowired
	private MemberDAO memberDAO;

//	// 전체정보조회
//	public List<Member> getMemberAllList() throws Exception {
//		return memberDAO.getMemberAllList();
//	}

	// 회원가입
	public JSONObject insert(Member member) {
		JSONObject jsonResult = new JSONObject();
		if (memberDAO.insert(member) == 1) {
			jsonResult.put("status", true);
			jsonResult.put("message", "회원 가입이 성공되었습니다");
		} else {
			jsonResult.put("status", false);
			jsonResult.put("message", "아이디 중복으로 회원 가입이 실패되었습니다");
		}
		return jsonResult;
	}

	// 회원정보수정
		public JSONObject updateMember(Member member) throws Exception {
			JSONObject jsonResult = new JSONObject();
			if (memberDAO.updateMember(member) == 1) {
				jsonResult.put("status", true);
				jsonResult.put("message", "수정완료");
			} else {
				jsonResult.put("status", false);
				jsonResult.put("message", "수정실패");
			}

			return jsonResult;
		}

	// 회원탈퇴
	public JSONObject deleteMember(Member member) throws Exception {
		JSONObject jsonResult = new JSONObject();

		if (memberDAO.deleteMember(member) == 1) {
			jsonResult.put("status", true);
			jsonResult.put("message", "회원 탈퇴가 완료되었습니다.");
		} else {
			jsonResult.put("status", false);
			jsonResult.put("message", "회원 탈퇴에 실패했습니다.");
		}

		return jsonResult;
	}

	// 중복아이디확인
	public boolean existUid(Member member) throws Exception {
		return memberDAO.existUid(member);
	}

	// 로그인
	public Member login(Member member) throws Exception {
		return  memberDAO.login(member);
	}

	// 아이디찾기
	public JSONObject findUid(Member member) throws Exception {

		JSONObject jsonObject = new JSONObject();
		Member findUidMember = memberDAO.findUid(member);

		if (findUidMember != null) {
			System.out.println("아이디" + findUidMember.getUid());
			jsonObject.put("status", true);
			jsonObject.put("message", "아이디를 찾았습니다. \n 회원님의 아이디는" + findUidMember.getUid() + "입니다.");
			jsonObject.put("uid", findUidMember.getUid()); // 아이디 값을 추가
		} else {
			jsonObject.put("status", false);
			jsonObject.put("message", "일치하는 아이디가 없습니다.");
		}

		return jsonObject;
	}
	
	
	// 비밀번호찾기
	public JSONObject findPwd(Member member) throws Exception {
		
		JSONObject jsonObject = new JSONObject();
		Member findFwdMember = memberDAO.findPwd(member);

		if (findFwdMember != null) {
			System.out.println("비밀번호" + findFwdMember);
			jsonObject.put("status", true);
			jsonObject.put("message", "비밀번호를 찾았습니다. \n 회원님의 비밀번호는" + findFwdMember.getPwd() + "입니다.");
			jsonObject.put("fwd", findFwdMember.getPwd());
		} else {
			jsonObject.put("status", false);
			jsonObject.put("message", "일치하는 비밀번호가 없습니다.");
		}

		return jsonObject;
	}

	// 현재 로그인한 회원의 비밀번호 확인
	public boolean checkPwd(Member member, HttpSession session) throws Exception {
		System.out.println("service");
		return memberDAO.checkPwd(member);

	}
	
	// 관리자 로그인 후 회원 탈퇴
//	public JSONObject deleteMembers(String[] deleteMembers) throws Exception {
//		JSONObject jsonResult = new JSONObject();
//		
//		if (memberDAO.deleteMembers(deleteMembers) > 0) {
//			jsonResult.put("status", true);
//			jsonResult.put("message", "선택한 회원 탈퇴가 완료되었습니다.");
//		} else {
//			jsonResult.put("status", false);
//			jsonResult.put("message", "선택한 회원 탈퇴에 실패했습니다.");
//		}
//		
//		return jsonResult;
//	}

	
}

