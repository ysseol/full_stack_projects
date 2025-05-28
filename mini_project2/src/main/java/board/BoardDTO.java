package board;

public class BoardDTO {
	private int num;
	private String id;
	private String title;
	private String content;
	private String reg_date;
	
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
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getReg_date() {
		return reg_date;
	}
	
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public BoardDTO() {
	}
	
	public BoardDTO(String id, String title, String content) {
		this.id = id;
		this.title = title;
		this.content = content;
	}

	public BoardDTO(String id, String title, String content, String reg_date) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "BoardDTO [id=" + id + ", title=" + title + ", content=" + content + ", reg_date=" + reg_date + "]";
	}
	
}
