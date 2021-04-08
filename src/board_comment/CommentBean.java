package board_comment;

import java.sql.Timestamp;

public class CommentBean {

	private int num;
	private int cNum;
	
	private String id;
	private String passwd;
	private String comment;
	private Timestamp date;
	
	
	public int getcNum() {
		return cNum;
	}
	public void setcNum(int cNum) {
		this.cNum = cNum;
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return passwd;
	}
	public void setPwd(String pwd) {
		this.passwd = pwd;
	}
	
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
	
	
}
