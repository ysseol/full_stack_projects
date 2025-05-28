package member;

public class MemberDTO {
	private String userid;
	private String pwd;
	private String name;
	
	public String getUserid() {
		return userid;
	}
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getPwd() {
		return pwd;
	}
	
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public MemberDTO() {
	}
	
	public MemberDTO(String userid) {
		this.userid = userid;
	}
	
	public MemberDTO(String userid, String pwd) {
		this.userid = userid;
		this.pwd = pwd;
	}

	public MemberDTO(String userid, String pwd, String name) {
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
	}

	@Override
	public String toString() {
		return "MemberDTO [userid=" + userid + ", pwd=" + pwd + ", name=" + name + "]";
	}
	
}
