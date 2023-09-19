package com.kosa.app.board.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

import org.json.JSONObject;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board implements Serializable {
	private static final long serialVersionUID = -1234567890L;

	private int boardId;
	private int pid;
	private String title;
	private String contents;
	private String writerUid;
	private Date regDate;
	private Date modDate;
	private int viewCount;
	private char deleteYN;
	
	String[] boardIds;
	
	int moreNum;
	
	public Board(int boardId, String title, String contents, String writerUid, Date regDate, Date modDate,
			int viewCount, char deleteYN) {
		this.boardId = boardId;
		this.title = title;
		this.contents = contents;
		this.writerUid = writerUid;
		this.regDate = regDate;
		this.modDate = modDate;
		this.viewCount = viewCount;
		this.deleteYN = deleteYN;
	}

	public Board(int boardId, String title, Date regDate) {
		this.boardId = boardId;
		this.title = title;
		this.regDate = regDate;

	}

	public Board(String title, String contents, String writerUid) {

		this.title = title;
		this.contents = contents;
		this.writerUid = writerUid;

	}
	 public JSONObject toJsonObject() {
	        JSONObject jsonObject = new JSONObject();
	        jsonObject.put("boardId", this.boardId);
	        jsonObject.put("title", this.title);
	        jsonObject.put("contents", this.contents);
	        

	        return jsonObject;
	    }

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Board other = (Board) obj;
		return boardId == other.boardId;
	}

	@Override
	public int hashCode() {
		return Objects.hash(boardId);
	}
}
