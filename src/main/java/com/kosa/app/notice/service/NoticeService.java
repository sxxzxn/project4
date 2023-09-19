package com.kosa.app.notice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.app.notice.dao.NoticeDAO;
import com.kosa.app.notice.dao.NoticeDAOImpl;
import com.kosa.app.notice.domain.Notice;
@Service
public class NoticeService {
	
	@Autowired
	private NoticeDAO noticeDAO;
	
	
	public NoticeService() {
	}

	//1. 공지사항 목록
	public List<Notice> getNoticeAllList() throws Exception {
		System.out.println("NoticeService.setNoticeDAO() 함수 호출됨");
		return noticeDAO.getNoticeAllList();
	}

	//2.공지사항 상세보기
	public Notice getNoticeById(int noticeId) throws Exception {
		System.out.println("Notice.service.getNotice() 함수 호출됨");
		return noticeDAO.getNoticeById(noticeId);
	}

	//3. 공지사항 글쓰기
	public boolean insertNotice(Notice notice)throws Exception {
		System.out.println("notice.service.noticeInsert() 함수 호출됨");
		return noticeDAO.insertNotice(notice);
	}
	
	//4.공지사항 수정
	public int updateNotice(int noticeId, String title, String contents) throws Exception {
		return noticeDAO.updateNotice(noticeId, title, contents);
	}

	//5.공지사항 삭제
	public boolean deleteNotice(String noticeIds)  throws Exception {
		System.out.println("notice.service.noticeDelete() 함수 호출됨");
		return noticeDAO.deleteNotice(noticeIds);
	}

	//6. 조회수 증가
	public int increaseViewCount(int noticeId) throws Exception {
		System.out.println("notice.service.viewCount() 함수 호출됨");
		return noticeDAO.increaseViewCount(noticeId);
	}

	//7. 상단 5개 출력
	public List<Notice> noticeTop5() throws Exception {
		System.out.println("notice.service.noticeTop5() 함수 호출됨");
		return noticeDAO.noticeTop5();
	}

	//8. 공지사항 고정
	public int setNoticeFixed(String noticeIds, char fixedYN) throws Exception {
		return noticeDAO.setNoticeFixed(noticeIds, fixedYN);
	}

	//8.1 고정해제
	public int unsetNoticeFixed(String noticeIds) throws Exception {
		// setNoticeFixed 메서드를 호출하여 fixed_yn 값을 'N'으로 업데이트합니다.
		return setNoticeFixed(noticeIds, 'N');
	}
	
	//9.검색
	public static void main(String [] args) throws Exception {
		NoticeService noticeService = new NoticeService();
		noticeService.noticeDAO = new NoticeDAOImpl();
		Notice notice = new Notice();
		notice.setPageNo(11);
		
		Map<String, Object> result =  noticeService.getNoticePageList(notice);
		
		System.out.println(result);
		
	}
	
	//10.페이징
	public Map<String, Object> getNoticePageList(Notice notice) throws Exception {
		System.out.println("NoticeService.setNoticeDAO() 함수 호출됨");
		//1. 전체 건수를 얻는다
		notice.setTotalCount(noticeDAO.getTotalCount(notice));
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("notice", notice);
		result.put("noticeList", noticeDAO.getNoticeList(notice));
		
		return result;
		
	} // getNoticeList


	


	
	
}
