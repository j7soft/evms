package egovframework.com.uat.uia.service.impl;

import java.io.Serializable;

import egovframework.com.cmm.ComDefaultVO;

public class comVO implements Serializable {

	private static final long serialVersionUID = -5817021412630105195L;
	
	private String code="";
	private String code1="";
	private String value="";
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCode1() {
		return code1;
	}
	public void setCode1(String code1) {
		this.code1 = code1;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	
	
	
}
