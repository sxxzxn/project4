package com.kosa.app.notice.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Notice implements Serializable {
    private static final long serialVersionUID = -1234567890L;

    private int noticeId; 		// 게시글번호
    private String title; 		// 제목
    private String contents; 	// 내용
    private String writerUid; 	// 글쓴이
    private Date regDate; 		// 작성날짜
    private Date modDate; 		// 수정날짜
    private int viewCount; 		// 조회수
    private String deleteYN; 	// 삭제유무
    private String fixedYN; 	// 고정유무
    
    
    public Notice(int noticeId, String title, String contents, String writerUid, Date regDate, Date modDate, int viewCount, String
    		deleteYN, String fixedYN) {
        this.noticeId = noticeId;
        this.title = title;
        this.contents = contents;
        this.writerUid = writerUid;
        this.regDate = regDate;
        this.modDate = modDate;
        this.viewCount = viewCount;
        this.deleteYN = deleteYN;
        this.fixedYN = fixedYN;
    }

    public Notice(int noticeId, String title, Date regDate) {
        this.noticeId = noticeId;
        this.title = title;
        this.regDate = regDate;
    }

    public Notice(String title, String contents, String writerUid) {
        this.title = title;
        this.contents = contents;
        this.writerUid = writerUid;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Notice other = (Notice) obj;
        return noticeId == other.noticeId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(noticeId);
    }
  //검색필드
  	private String searchTitle = "";
  	
  	//페이징
  	private int pageNo = 1;     //현재 페이지 번호
  	private int totalCount;     //전체 건수  
  	private int totalPageSize;  //전체 페이지수  
  	private int pageLength = 10;//한페이지의 길이 
  	private int navSize = 10;   //페이지 하단에 출력되는 페이지의 항목수 
  	private int navStart = 0;   //페이지 하단에 출력되는 페이지 시작 번호 : NavStart = (PageNo / NavSize) * NavSize + 1
  	private int navEnd = 0;     //페이지 하단에 출력되는 페이지 끝 번호 : NavEnd = (PageNo / NavSize + 1) * NavSize
  	
  	public String getContentsHTML() {
  		return contents.replace("\n", "<br/>");
  	}
  	
  	public void setTotalCount(int totalCount) {
  		this.totalCount = totalCount;
  		
  		//2. 전체 페이지 건수를 계산한다 
  		totalPageSize = (int) Math.ceil((double) totalCount / pageLength);
  		
  		//3. 페이지 네비게이터 시작 페이지를 계산한다
  		navStart = ((pageNo - 1) / navSize) * navSize + 1;
  		
  		//4. 페이지 네비게이터 끝 페이지를 계산한다
  		navEnd = ((pageNo - 1) / navSize + 1) * navSize;
  		
  		//5. 전체 페이지 보다 크면 전체 페이지 값을 변경한다
  		if (navEnd >= totalPageSize) {
  			navEnd = totalPageSize;
  		}
  	}
  	
  	public int getStartNo() {
  		return (pageNo - 1) * pageLength + 1; 
  	}
  	
  	public int getEndNo() {
  		return pageNo * pageLength; 
  	}
}

