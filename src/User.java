

public class User {
	private Integer id;
	private String name;
	private String gender;
	private String email;
	
	// firebase 연동으로 필드 추가
	private String fireBaseId;
	private String pw; 
	
	
	private Integer clsId; // clsid 필드 추가
	
	private Classes cls = new Classes();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setSex(String sex) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Classes getCls() {
		return cls;
	}

	public void setCls(Classes cls) {
		this.cls = cls;
	}

	
	//setter gettr 추가
	
	public Integer getClsId() {
		return clsId;
	}

	public void setClsId(Integer clsId) {
		this.clsId = clsId;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	
	
	
	public String getFireBaseId() {
		return fireBaseId;
	}

	public void setFireBaseId(String fireBaseId) {
		this.fireBaseId = fireBaseId;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", gender=" + gender + ", email=" + email + ", clsId=" + clsId
				+ ", fireBaseId=" + fireBaseId + ", pw=" + pw + ", cls=" + cls + "]";
	}

	
	
	

	
	
}
