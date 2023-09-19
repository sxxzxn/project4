package com.kosa.app.notice.dao;

import java.util.List;

import com.kosa.app.notice.domain.Notice;


public interface NoticeDAO {
	//1. 공지사항 목록
    List<Notice> getNoticeAllList() throws Exception;   
    
    //2.공지사항 상세보기
    Notice getNoticeById(int noticeId) throws Exception; 
    
    //3. 공지사항 글쓰기
    boolean insertNotice(Notice notice) throws Exception;    
    
    //4.공지사항 수정
    int updateNotice(int noticeId, String title, String contents) throws Exception;  
    
    //5.공지사항 삭제
    boolean deleteNotice(String noticeId) throws Exception;    
    
    //6. 조회수 증가
    int increaseViewCount(int noticeId) throws Exception; 
	
    //7. 상단 5개 출력
    List<Notice> noticeTop5() throws Exception;
	
    //8. 공지사항 고정
    int setNoticeFixed(String noticeIds, char fixedYN) throws Exception; 
    
    //9. 검색확인
    public int getTotalCount(Notice notice) throws Exception;
    
    //10.페이징
    public List<Notice> getNoticeList(Notice notice) throws Exception ;
}

