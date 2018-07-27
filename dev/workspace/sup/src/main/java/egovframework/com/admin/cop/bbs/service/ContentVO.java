package egovframework.com.admin.cop.bbs.service;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

/**
 * 컨텐츠 관리를 위한 VO 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *   2009.06.29  한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class ContentVO implements Serializable {

	private String BANNER_ID;
	private String BANNER_NM;
	private String LINK_URL;
	private String BANNER_IMAGE;
	private String BANNER_DC;
	private String REFLCT_AT;
	private String FRST_REGISTER_ID;
	private String FRST_REGIST_PNTTM;
	private String LAST_UPDUSR_ID;
	private String LAST_UPDT_PNTTM;
	private String BANNER_IMAGE_FILE;
	private int SORT_ORDR;
	private String NTT_NO;
	private String POSITION;
	private String FDATE;
	private String SDATE;
	private String TITLE;
	private String FTYPE;
	private String RANK;
	MultipartFile file;
	private String b_file;
	
	
	
	public String getB_file() {
		return b_file;
	}
	public void setB_file(String b_file) {
		this.b_file = b_file;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public String getRANK() {
		return RANK;
	}
	public void setRANK(String RANK) {
		this.RANK = RANK;
	}
	public String getBANNER_ID() {
		return BANNER_ID;
	}
	public void setBANNER_ID(String bANNER_ID) {
		BANNER_ID = bANNER_ID;
	}
	public String getBANNER_NM() {
		return BANNER_NM;
	}
	public void setBANNER_NM(String bANNER_NM) {
		BANNER_NM = bANNER_NM;
	}
	public String getLINK_URL() {
		return LINK_URL;
	}
	public void setLINK_URL(String lINK_URL) {
		LINK_URL = lINK_URL;
	}
	public String getBANNER_IMAGE() {
		return BANNER_IMAGE;
	}
	public void setBANNER_IMAGE(String bANNER_IMAGE) {
		BANNER_IMAGE = bANNER_IMAGE;
	}
	public String getBANNER_DC() {
		return BANNER_DC;
	}
	public void setBANNER_DC(String bANNER_DC) {
		BANNER_DC = bANNER_DC;
	}
	public String getREFLCT_AT() {
		return REFLCT_AT;
	}
	public void setREFLCT_AT(String rEFLCT_AT) {
		REFLCT_AT = rEFLCT_AT;
	}
	public String getFRST_REGISTER_ID() {
		return FRST_REGISTER_ID;
	}
	public void setFRST_REGISTER_ID(String fRST_REGISTER_ID) {
		FRST_REGISTER_ID = fRST_REGISTER_ID;
	}
	public String getFRST_REGIST_PNTTM() {
		return FRST_REGIST_PNTTM;
	}
	public void setFRST_REGIST_PNTTM(String fRST_REGIST_PNTTM) {
		FRST_REGIST_PNTTM = fRST_REGIST_PNTTM;
	}
	public String getLAST_UPDUSR_ID() {
		return LAST_UPDUSR_ID;
	}
	public void setLAST_UPDUSR_ID(String lAST_UPDUSR_ID) {
		LAST_UPDUSR_ID = lAST_UPDUSR_ID;
	}
	public String getLAST_UPDT_PNTTM() {
		return LAST_UPDT_PNTTM;
	}
	public void setLAST_UPDT_PNTTM(String lAST_UPDT_PNTTM) {
		LAST_UPDT_PNTTM = lAST_UPDT_PNTTM;
	}
	public String getBANNER_IMAGE_FILE() {
		return BANNER_IMAGE_FILE;
	}
	public void setBANNER_IMAGE_FILE(String bANNER_IMAGE_FILE) {
		BANNER_IMAGE_FILE = bANNER_IMAGE_FILE;
	}
	public int getSORT_ORDR() {
		return SORT_ORDR;
	}
	public void setSORT_ORDR(int sORT_ORDR) {
		SORT_ORDR = sORT_ORDR;
	}
	public String getNTT_NO() {
		return NTT_NO;
	}
	public void setNTT_NO(String nTT_NO) {
		NTT_NO = nTT_NO;
	}
	public String getPOSITION() {
		return POSITION;
	}
	public void setPOSITION(String pOSITION) {
		POSITION = pOSITION;
	}
	public String getFDATE() {
		return FDATE;
	}
	public void setFDATE(String fDATE) {
		FDATE = fDATE;
	}
	public String getSDATE() {
		return SDATE;
	}
	public void setSDATE(String sDATE) {
		SDATE = sDATE;
	}
	public String getTITLE() {
		return TITLE;
	}
	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}
	public String getFTYPE() {
		return FTYPE;
	}
	public void setFTYPE(String fTYPE) {
		FTYPE = fTYPE;
	}
	@Override
	public String toString() {
		return "ContentVO [BANNER_ID=" + BANNER_ID + ", BANNER_NM=" + BANNER_NM + ", LINK_URL=" + LINK_URL
				+ ", BANNER_IMAGE=" + BANNER_IMAGE + ", BANNER_DC=" + BANNER_DC + ", REFLCT_AT=" + REFLCT_AT
				+ ", FRST_REGISTER_ID=" + FRST_REGISTER_ID + ", FRST_REGIST_PNTTM=" + FRST_REGIST_PNTTM
				+ ", LAST_UPDUSR_ID=" + LAST_UPDUSR_ID + ", LAST_UPDT_PNTTM=" + LAST_UPDT_PNTTM + ", BANNER_IMAGE_FILE="
				+ BANNER_IMAGE_FILE + ", SORT_ORDR=" + SORT_ORDR + ", NTT_NO=" + NTT_NO + ", POSITION=" + POSITION
				+ ", FDATE=" + FDATE + ", SDATE=" + SDATE + ", TITLE=" + TITLE + ", FTYPE=" + FTYPE + "]";
	}
	
}