package com.kosa.app.notice.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.app.notice.domain.Notice;

@Repository("noticeDAO")
public class NoticeDAOImpl implements NoticeDAO {

	@Autowired
	private SqlSession sqlSession;

	// 1. 공지사항 목록
	@Override
	public List<Notice> getNoticeAllList() throws Exception {
		return sqlSession.selectList("mapper.notice.getNoticeAllList");
	} // getNoticeAllList

	// 2.공지사항 상세보기 ( noticeId로 값 받아오기)
	@Override
	public Notice getNoticeById(int noticeId) throws Exception {
		return sqlSession.selectOne("mapper.notice.getNoticeById", noticeId);
	} // getgetNoticeById

	// 3. 공지사항 글쓰기
	@Override
	public boolean insertNotice(Notice notice) throws Exception {
		return 0 != sqlSession.insert("mapper.notice.insertNotice", notice);
	} // insertNotice

	// 4.공지사항 수정
	@Override
	public int updateNotice(int noticeId, String title, String contents) throws Exception {
		return sqlSession.update("mapper.notice.updateNotice", noticeId);
	} // updateNotice

	// 5.공지사항 삭제
	@Override
	public boolean deleteNotice(String noticeIds) throws Exception {
		return 0 != sqlSession.delete("mapper.notice.deleteNotice", noticeIds);
	} // deleteNotice

	// 6. 조회수 증가
	@Override
	public int increaseViewCount(int noticeId) throws Exception {
		return sqlSession.update("mapper.notice.viewCount", noticeId);
	} // viewCount


	// 7. 상단 5개 출력
	@Override
	public List<Notice> noticeTop5() throws Exception {
		return sqlSession.selectList("mapper.notice.noticeTop5");
		} // noticeTop5

	// 8.공지사항 고정
	@Override
	public int setNoticeFixed(String noticeIds, char fixedYN) throws Exception {
		return sqlSession.update("mapper.notice.setNoticeFixed", noticeIds);
	} // noticeTop5


	// 9. 검색확인
	@Override
	public int getTotalCount(Notice notice) throws Exception {
		System.out.println("Notice.service.getTotalCount() 함수 호출됨");
		return sqlSession.selectOne("mapper.notice.getTotalCount", notice);
	}

	// 10. 페이징
	@Override
	public List<Notice> getNoticeList(Notice notice) throws Exception {
		return sqlSession.selectList("mapper.notice.getNoticeList2", notice);
		}
}
