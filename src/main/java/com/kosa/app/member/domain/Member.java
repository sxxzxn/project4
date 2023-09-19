package com.kosa.app.member.domain;

import java.io.Serializable;
import java.util.Objects;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member implements Serializable {
	private static final long serialVersionUID = -1036524153261734687L;

	private String uid;
	private String name;
	private String pwd;
	private String address;
	private String phone;
	private String age;
	private String gender;
	private String email;
	
	String[] uids;

	public Member(String uid, String name, String pwd) {
		this.uid = uid;
		this.name = name;
		this.pwd = pwd;
	}

	public Member(String uid, String name, String pwd, String address, String phone, String age, String gender, String email) {
		this.uid = uid;
		this.name = name;
		this.pwd = pwd;
		this.address = address;
		this.phone = phone;
		this.age = age;
		this.gender = gender;
		this.email = email;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Member other = (Member) obj;
		return Objects.equals(uid, other.uid);
	}

	@Override
	public int hashCode() {
		return Objects.hash(uid);
	}

	public boolean isEqualPwd(Member member) {
		return pwd.equals(pwd);
	}
}
