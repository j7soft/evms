package egovframework.com.admin.bbs.cont.service;

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
public class SupContentVO implements Serializable {

	private String NTT_ID;
	private String BBS_ID;
	private String NTT_NO;
	private String NTT_SJ;
	private String NTT_CN;
	private String ANSWER_AT;
	private int PARNTSCTT_NO;
	private int ANSWER_LC;
	private int SORT_ORDR;
	private String USE_AT;
	private int RDCNT;
	private String NTCE_BGNDE;
	private String NTCE_ENDDE;
	private String NTCR_ID;
	private String NTCR_NM;
	private String PASSWORD;
	private String ATCH_FILE_ID;
	private String FRST_REGIST_PNTTM;
	private String FRST_REGISTER_ID;
	private String LAST_UPDT_PNTTM;
	private String LAST_UPDUSR_ID;
	private String POSITION;
	private String TITLE;
	private String PTB;
	private String FTYPE;
	private String TERM;
	private String PUSHDATE;
	private String THUMBNAIL;
	private String ATTACHMENT;
	private String CONTENT;
	private String VIDEO;
	private String HEAD_SIGN;
	private String ONOFF;
	private String MBER_ID;
	private String APPROVAL;
	private String BOOK_DATE;
	private String PRICE;
	private String CNT;
	private String FDATE;
	private String SDATE;
	private String FDAY;
	private String SDAY;
	private String FTIME;
	private String STIME;
	private String COMPANIES;
	private String EMAIL_AGREE;
	private String TEAMNAME;
	private String CRNUM;
	private String TEAMCONTENT;
	private String ADDRESS;
	private String EVENTNAME;
	private String TARGET;
	private String ENTRYFEE;
	private String ITEM;
	private String AFFILIATION;
	private String TEL_SEC;
	private String FOBJECT;
	private String STARTING;
	private String REQUEST;
	private String REQURIEMENT;
	private String BUS;
	private String NAME;
	private String SIMPLECONTENT;
	private String PLACE;
	private String MIMAGE;
	private String IMAGE;
	private String DETAIL;
	private String FFILE;
	private String RUNTIME;
	private String FYEAR;
	private String CAPTAINNAME;
	private String FORM;
	private String MAKEYEAR;
	private String FLOOR;
	private String ROOM;
	private String MOVEDATE;
	private String MOVEPLAN;
	private String ITEM_OBJECT;
	private String ITEM_SUBJECT;
	private String CHARGE_TEL;
	private String OFFICE_TEL;
	private String EMAIL;
	private String HOMEPAGE;
	private String LOGO;
	private String ITEM_IMAGE;
	private String INTRO;
	MultipartFile file;
	MultipartFile mfile;
	MultipartFile lfile;
	MultipartFile file1;
	MultipartFile file2;
	MultipartFile file3;
	MultipartFile file4;
	MultipartFile file5;
	MultipartFile file6;
	MultipartFile file7;
	MultipartFile file8;
	MultipartFile file9;
	MultipartFile file10;
	MultipartFile file11;
	MultipartFile file12;
	//조인 추가 VO
	private String lname;
	private String email;
	private String tel;
	private String id;
	public String getNTT_ID() {
		return NTT_ID;
	}
	public void setNTT_ID(String nTT_ID) {
		NTT_ID = nTT_ID;
	}
	public String getBBS_ID() {
		return BBS_ID;
	}
	public void setBBS_ID(String bBS_ID) {
		BBS_ID = bBS_ID;
	}
	public String getNTT_NO() {
		return NTT_NO;
	}
	public void setNTT_NO(String nTT_NO) {
		NTT_NO = nTT_NO;
	}
	public String getNTT_SJ() {
		return NTT_SJ;
	}
	public void setNTT_SJ(String nTT_SJ) {
		NTT_SJ = nTT_SJ;
	}
	public String getNTT_CN() {
		return NTT_CN;
	}
	public void setNTT_CN(String nTT_CN) {
		NTT_CN = nTT_CN;
	}
	public String getANSWER_AT() {
		return ANSWER_AT;
	}
	public void setANSWER_AT(String aNSWER_AT) {
		ANSWER_AT = aNSWER_AT;
	}
	public int getPARNTSCTT_NO() {
		return PARNTSCTT_NO;
	}
	public void setPARNTSCTT_NO(int pARNTSCTT_NO) {
		PARNTSCTT_NO = pARNTSCTT_NO;
	}
	public int getANSWER_LC() {
		return ANSWER_LC;
	}
	public void setANSWER_LC(int aNSWER_LC) {
		ANSWER_LC = aNSWER_LC;
	}
	public int getSORT_ORDR() {
		return SORT_ORDR;
	}
	public void setSORT_ORDR(int sORT_ORDR) {
		SORT_ORDR = sORT_ORDR;
	}
	public String getUSE_AT() {
		return USE_AT;
	}
	public void setUSE_AT(String uSE_AT) {
		USE_AT = uSE_AT;
	}
	public int getRDCNT() {
		return RDCNT;
	}
	public void setRDCNT(int rDCNT) {
		RDCNT = rDCNT;
	}
	public String getNTCE_BGNDE() {
		return NTCE_BGNDE;
	}
	public void setNTCE_BGNDE(String nTCE_BGNDE) {
		NTCE_BGNDE = nTCE_BGNDE;
	}
	public String getNTCE_ENDDE() {
		return NTCE_ENDDE;
	}
	public void setNTCE_ENDDE(String nTCE_ENDDE) {
		NTCE_ENDDE = nTCE_ENDDE;
	}
	public String getNTCR_ID() {
		return NTCR_ID;
	}
	public void setNTCR_ID(String nTCR_ID) {
		NTCR_ID = nTCR_ID;
	}
	public String getNTCR_NM() {
		return NTCR_NM;
	}
	public void setNTCR_NM(String nTCR_NM) {
		NTCR_NM = nTCR_NM;
	}
	public String getPASSWORD() {
		return PASSWORD;
	}
	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}
	public String getATCH_FILE_ID() {
		return ATCH_FILE_ID;
	}
	public void setATCH_FILE_ID(String aTCH_FILE_ID) {
		ATCH_FILE_ID = aTCH_FILE_ID;
	}
	public String getFRST_REGIST_PNTTM() {
		return FRST_REGIST_PNTTM;
	}
	public void setFRST_REGIST_PNTTM(String fRST_REGIST_PNTTM) {
		FRST_REGIST_PNTTM = fRST_REGIST_PNTTM;
	}
	public String getFRST_REGISTER_ID() {
		return FRST_REGISTER_ID;
	}
	public void setFRST_REGISTER_ID(String fRST_REGISTER_ID) {
		FRST_REGISTER_ID = fRST_REGISTER_ID;
	}
	public String getLAST_UPDT_PNTTM() {
		return LAST_UPDT_PNTTM;
	}
	public void setLAST_UPDT_PNTTM(String lAST_UPDT_PNTTM) {
		LAST_UPDT_PNTTM = lAST_UPDT_PNTTM;
	}
	public String getLAST_UPDUSR_ID() {
		return LAST_UPDUSR_ID;
	}
	public void setLAST_UPDUSR_ID(String lAST_UPDUSR_ID) {
		LAST_UPDUSR_ID = lAST_UPDUSR_ID;
	}
	public String getPOSITION() {
		return POSITION;
	}
	public void setPOSITION(String pOSITION) {
		POSITION = pOSITION;
	}
	public String getTITLE() {
		return TITLE;
	}
	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}
	public String getPTB() {
		return PTB;
	}
	public void setPTB(String pTB) {
		PTB = pTB;
	}
	public String getFTYPE() {
		return FTYPE;
	}
	public void setFTYPE(String fTYPE) {
		FTYPE = fTYPE;
	}
	public String getTERM() {
		return TERM;
	}
	public void setTERM(String tERM) {
		TERM = tERM;
	}
	public String getPUSHDATE() {
		return PUSHDATE;
	}
	public void setPUSHDATE(String pUSHDATE) {
		PUSHDATE = pUSHDATE;
	}
	public String getTHUMBNAIL() {
		return THUMBNAIL;
	}
	public void setTHUMBNAIL(String tHUMBNAIL) {
		THUMBNAIL = tHUMBNAIL;
	}
	public String getATTACHMENT() {
		return ATTACHMENT;
	}
	public void setATTACHMENT(String aTTACHMENT) {
		ATTACHMENT = aTTACHMENT;
	}
	public String getCONTENT() {
		return CONTENT;
	}
	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
	}
	public String getVIDEO() {
		return VIDEO;
	}
	public void setVIDEO(String vIDEO) {
		VIDEO = vIDEO;
	}
	public String getHEAD_SIGN() {
		return HEAD_SIGN;
	}
	public void setHEAD_SIGN(String hEAD_SIGN) {
		HEAD_SIGN = hEAD_SIGN;
	}
	public String getONOFF() {
		return ONOFF;
	}
	public void setONOFF(String oNOFF) {
		ONOFF = oNOFF;
	}
	public String getMBER_ID() {
		return MBER_ID;
	}
	public void setMBER_ID(String mBER_ID) {
		MBER_ID = mBER_ID;
	}
	public String getAPPROVAL() {
		return APPROVAL;
	}
	public void setAPPROVAL(String aPPROVAL) {
		APPROVAL = aPPROVAL;
	}
	public String getBOOK_DATE() {
		return BOOK_DATE;
	}
	public void setBOOK_DATE(String bOOK_DATE) {
		BOOK_DATE = bOOK_DATE;
	}
	public String getPRICE() {
		return PRICE;
	}
	public void setPRICE(String pRICE) {
		PRICE = pRICE;
	}
	public String getCNT() {
		return CNT;
	}
	public void setCNT(String cNT) {
		CNT = cNT;
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
	public String getFDAY() {
		return FDAY;
	}
	public void setFDAY(String fDAY) {
		FDAY = fDAY;
	}
	public String getSDAY() {
		return SDAY;
	}
	public void setSDAY(String sDAY) {
		SDAY = sDAY;
	}
	public String getFTIME() {
		return FTIME;
	}
	public void setFTIME(String fTIME) {
		FTIME = fTIME;
	}
	public String getSTIME() {
		return STIME;
	}
	public void setSTIME(String sTIME) {
		STIME = sTIME;
	}
	public String getCOMPANIES() {
		return COMPANIES;
	}
	public void setCOMPANIES(String cOMPANIES) {
		COMPANIES = cOMPANIES;
	}
	public String getEMAIL_AGREE() {
		return EMAIL_AGREE;
	}
	public void setEMAIL_AGREE(String eMAIL_AGREE) {
		EMAIL_AGREE = eMAIL_AGREE;
	}
	public String getTEAMNAME() {
		return TEAMNAME;
	}
	public void setTEAMNAME(String tEAMNAME) {
		TEAMNAME = tEAMNAME;
	}
	public String getCRNUM() {
		return CRNUM;
	}
	public void setCRNUM(String cRNUM) {
		CRNUM = cRNUM;
	}
	public String getTEAMCONTENT() {
		return TEAMCONTENT;
	}
	public void setTEAMCONTENT(String tEAMCONTENT) {
		TEAMCONTENT = tEAMCONTENT;
	}
	public String getADDRESS() {
		return ADDRESS;
	}
	public void setADDRESS(String aDDRESS) {
		ADDRESS = aDDRESS;
	}
	public String getEVENTNAME() {
		return EVENTNAME;
	}
	public void setEVENTNAME(String eVENTNAME) {
		EVENTNAME = eVENTNAME;
	}
	public String getTARGET() {
		return TARGET;
	}
	public void setTARGET(String tARGET) {
		TARGET = tARGET;
	}
	public String getENTRYFEE() {
		return ENTRYFEE;
	}
	public void setENTRYFEE(String eNTRYFEE) {
		ENTRYFEE = eNTRYFEE;
	}
	public String getITEM() {
		return ITEM;
	}
	public void setITEM(String iTEM) {
		ITEM = iTEM;
	}
	public String getAFFILIATION() {
		return AFFILIATION;
	}
	public void setAFFILIATION(String aFFILIATION) {
		AFFILIATION = aFFILIATION;
	}
	public String getTEL_SEC() {
		return TEL_SEC;
	}
	public void setTEL_SEC(String tEL_SEC) {
		TEL_SEC = tEL_SEC;
	}
	public String getFOBJECT() {
		return FOBJECT;
	}
	public void setFOBJECT(String fOBJECT) {
		FOBJECT = fOBJECT;
	}
	public String getSTARTING() {
		return STARTING;
	}
	public void setSTARTING(String sTARTING) {
		STARTING = sTARTING;
	}
	public String getREQUEST() {
		return REQUEST;
	}
	public void setREQUEST(String rEQUEST) {
		REQUEST = rEQUEST;
	}
	public String getREQURIEMENT() {
		return REQURIEMENT;
	}
	public void setREQURIEMENT(String rEQURIEMENT) {
		REQURIEMENT = rEQURIEMENT;
	}
	public String getBUS() {
		return BUS;
	}
	public void setBUS(String bUS) {
		BUS = bUS;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getSIMPLECONTENT() {
		return SIMPLECONTENT;
	}
	public void setSIMPLECONTENT(String sIMPLECONTENT) {
		SIMPLECONTENT = sIMPLECONTENT;
	}
	public String getPLACE() {
		return PLACE;
	}
	public void setPLACE(String pLACE) {
		PLACE = pLACE;
	}
	public String getMIMAGE() {
		return MIMAGE;
	}
	public void setMIMAGE(String mIMAGE) {
		MIMAGE = mIMAGE;
	}
	public String getIMAGE() {
		return IMAGE;
	}
	public void setIMAGE(String iMAGE) {
		IMAGE = iMAGE;
	}
	public String getDETAIL() {
		return DETAIL;
	}
	public void setDETAIL(String dETAIL) {
		DETAIL = dETAIL;
	}
	public String getFFILE() {
		return FFILE;
	}
	public void setFFILE(String fFILE) {
		FFILE = fFILE;
	}
	public String getRUNTIME() {
		return RUNTIME;
	}
	public void setRUNTIME(String rUNTIME) {
		RUNTIME = rUNTIME;
	}
	public String getFYEAR() {
		return FYEAR;
	}
	public void setFYEAR(String fYEAR) {
		FYEAR = fYEAR;
	}
	public String getCAPTAINNAME() {
		return CAPTAINNAME;
	}
	public void setCAPTAINNAME(String cAPTAINNAME) {
		CAPTAINNAME = cAPTAINNAME;
	}
	public String getFORM() {
		return FORM;
	}
	public void setFORM(String fORM) {
		FORM = fORM;
	}
	public String getMAKEYEAR() {
		return MAKEYEAR;
	}
	public void setMAKEYEAR(String mAKEYEAR) {
		MAKEYEAR = mAKEYEAR;
	}
	public String getFLOOR() {
		return FLOOR;
	}
	public void setFLOOR(String fLOOR) {
		FLOOR = fLOOR;
	}
	public String getROOM() {
		return ROOM;
	}
	public void setROOM(String rOOM) {
		ROOM = rOOM;
	}
	public String getMOVEDATE() {
		return MOVEDATE;
	}
	public void setMOVEDATE(String mOVEDATE) {
		MOVEDATE = mOVEDATE;
	}
	public String getMOVEPLAN() {
		return MOVEPLAN;
	}
	public void setMOVEPLAN(String mOVEPLAN) {
		MOVEPLAN = mOVEPLAN;
	}
	public String getITEM_OBJECT() {
		return ITEM_OBJECT;
	}
	public void setITEM_OBJECT(String iTEM_OBJECT) {
		ITEM_OBJECT = iTEM_OBJECT;
	}
	public String getITEM_SUBJECT() {
		return ITEM_SUBJECT;
	}
	public void setITEM_SUBJECT(String iTEM_SUBJECT) {
		ITEM_SUBJECT = iTEM_SUBJECT;
	}
	public String getCHARGE_TEL() {
		return CHARGE_TEL;
	}
	public void setCHARGE_TEL(String cHARGE_TEL) {
		CHARGE_TEL = cHARGE_TEL;
	}
	public String getOFFICE_TEL() {
		return OFFICE_TEL;
	}
	public void setOFFICE_TEL(String oFFICE_TEL) {
		OFFICE_TEL = oFFICE_TEL;
	}
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
	public String getHOMEPAGE() {
		return HOMEPAGE;
	}
	public void setHOMEPAGE(String hOMEPAGE) {
		HOMEPAGE = hOMEPAGE;
	}
	public String getLOGO() {
		return LOGO;
	}
	public void setLOGO(String lOGO) {
		LOGO = lOGO;
	}
	public String getITEM_IMAGE() {
		return ITEM_IMAGE;
	}
	public void setITEM_IMAGE(String iTEM_IMAGE) {
		ITEM_IMAGE = iTEM_IMAGE;
	}
	public String getINTRO() {
		return INTRO;
	}
	public void setINTRO(String iNTRO) {
		INTRO = iNTRO;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public MultipartFile getMfile() {
		return mfile;
	}
	public void setMfile(MultipartFile mfile) {
		this.mfile = mfile;
	}
	public MultipartFile getLfile() {
		return lfile;
	}
	public void setLfile(MultipartFile lfile) {
		this.lfile = lfile;
	}
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	public MultipartFile getFile2() {
		return file2;
	}
	public void setFile2(MultipartFile file2) {
		this.file2 = file2;
	}
	public MultipartFile getFile3() {
		return file3;
	}
	public void setFile3(MultipartFile file3) {
		this.file3 = file3;
	}
	public MultipartFile getFile4() {
		return file4;
	}
	public void setFile4(MultipartFile file4) {
		this.file4 = file4;
	}
	public MultipartFile getFile5() {
		return file5;
	}
	public void setFile5(MultipartFile file5) {
		this.file5 = file5;
	}
	public MultipartFile getFile6() {
		return file6;
	}
	public void setFile6(MultipartFile file6) {
		this.file6 = file6;
	}
	public MultipartFile getFile7() {
		return file7;
	}
	public void setFile7(MultipartFile file7) {
		this.file7 = file7;
	}
	public MultipartFile getFile8() {
		return file8;
	}
	public void setFile8(MultipartFile file8) {
		this.file8 = file8;
	}
	public MultipartFile getFile9() {
		return file9;
	}
	public void setFile9(MultipartFile file9) {
		this.file9 = file9;
	}
	public MultipartFile getFile10() {
		return file10;
	}
	public void setFile10(MultipartFile file10) {
		this.file10 = file10;
	}
	public MultipartFile getFile11() {
		return file11;
	}
	public void setFile11(MultipartFile file11) {
		this.file11 = file11;
	}
	public MultipartFile getFile12() {
		return file12;
	}
	public void setFile12(MultipartFile file12) {
		this.file12 = file12;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	
	

}