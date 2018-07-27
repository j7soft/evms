package egovframework.com.uat.uia.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovComponentChecker;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uat.uia.service.impl.fVO;
import egovframework.com.usr.board.service.NaverLoginBO;
import egovframework.com.uss.umt.service.impl.MberManageDAO;
import egovframework.com.utl.sim.service.EgovClntInfo;

/*
import com.gpki.gpkiapi.cert.X509Certificate;
import com.gpki.servlet.GPKIHttpServletRequest;
import com.gpki.servlet.GPKIHttpServletResponse;
*/

/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.8.26	정진오			IncludedInfo annotation 추가
 *  2011.09.07  서준식          스프링 시큐리티 로그인 및 SSO 인증 로직을 필터로 분리
 *  2011.09.25  서준식          사용자 관리 컴포넌트 미포함에 대한 점검 로직 추가
 *  2011.09.27  서준식          인증서 로그인시 스프링 시큐리티 사용에 대한 체크 로직 추가
 *  2011.10.27  서준식          아이디 찾기 기능에서 사용자 리름 공백 제거 기능 추가
 *  </pre>
 */
@Controller
public class EgovLoginController {

	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;

	/** EgovCmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;

	/* NaverLoginBO */
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO){
		this.naverLoginBO = naverLoginBO;
	}
	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovLoginController.class);

	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/loginUsr.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO,HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		request.getSession().setAttribute("loginVO", null);

        /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        System.out.println("진입");
        
        model.addAttribute("url",naverAuthUrl);
        //model.addAttribute("reurl",loginVO.getReUrl());
        
        //String ReUrl = request.getRequestURI();
        ////String ReUrl = (String)request.getHeader("Referer");
        ////model.addAttribute("reurl",ReUrl);
        
		return "jsp/login/EgovLoginUsr";
	}
	/**
	 * 일반(세션) 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/actionLogin.do")
	public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {
		if(loginVO.getId().trim().equals("webmaster")){
			loginVO.setUserSe("USR");
		}
		//String reurl = "http://61.97.54.228/introduce.do?type=MaterialsI"; 
		//String reurl = loginVO.getReUrl() ;
		// 1. 일반 로그인 처리
		LoginVO resultVO = loginService.actionLogin(loginVO);
		/*LoginVO resultVO = new LoginVO();
		resultVO.setId("webmaster");
		resultVO.setUserSe("USR");*/
		
		
		/*
		 * login 확인 logger 
		 * 
		 *  
		 * */
		
		/*LOGGER.debug("loginVO ID chk --------------------------------------------------------");
		LOGGER.debug("-----------------------------------------------------------------------");
		LOGGER.debug(loginVO.getId());
		LOGGER.debug("-----------------------------------------------------------------------");
		LOGGER.debug("loginVO ID chk --------------------------------------------------------");
		
		LOGGER.debug("resultVO ID chk --------------------------------------------------------");
		LOGGER.debug("-----------------------------------------------------------------------");
		LOGGER.debug(resultVO.getId());
		LOGGER.debug("-----------------------------------------------------------------------");
		LOGGER.debug("resultVO ID chk --------------------------------------------------------");
		
		
		LOGGER.debug("loginVO UserSe chk --------------------------------------------------------");
		LOGGER.debug("---------------------------------------------------------------------------");
		LOGGER.debug(loginVO.getUserSe());
		LOGGER.debug("---------------------------------------------------------------------------");
		LOGGER.debug("loginVO UserSe chk --------------------------------------------------------");
		
		LOGGER.debug("resultVO UserSe chk --------------------------------------------------------");
		LOGGER.debug("---------------------------------------------------------------------------");
		LOGGER.debug(resultVO.getUserSe());
		LOGGER.debug("---------------------------------------------------------------------------");
		LOGGER.debug("resultVO UserSe chk --------------------------------------------------------");*/
		
		
		//LOGGER.debug("resultVO getReUrl chk --------------------------------------------------------");	
		//LOGGER.debug(resultVO.getReUrl());
		//LOGGER.debug(loginVO.getReUrl());
		//LOGGER.debug("---------------------------------------------------------------------------");
		
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
			request.getSession().setAttribute("loginVO", resultVO);
			
			if(resultVO.getUserSe().equals("GNR")){
				request.getSession().setAttribute("loginVO", resultVO);
				//return "redirect:"+resultVO.getReUrl();
				return "redirect:/index.do";
			}else if(resultVO.getUserSe().equals("USR")){
				request.getSession().setAttribute("loginVO", resultVO);
				return "redirect:/admin.do";
			}else{
				return "redirect:/actionLogout.do";
			}
		} else {
			
			model.addAttribute("loginVO", null);
			
			model.addAttribute("message", "아이디나 패스워드가 일치하지 않습니다.");
			return "jsp/login/EgovLoginUsr";
		}
		
		// return "redirect:/admin.do";
	}
	@RequestMapping(value="admin.do")
	public String adminMain(HttpServletRequest request){
		LoginVO lvo = (LoginVO)request.getSession().getAttribute("loginVO");
		
		if(lvo.getUserSe().trim().equals("USR")){
			return "admin";	
		}else{
			request.getSession().setAttribute("loginVO", null);
			return "redirect:/404";
		}
	}

	/**
	 * 로그인 후 사용자 메인화면으로 들어간다
	 * @param
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	/*@RequestMapping(value = "/uat/uia/actionUsrMain.do")
	public String actionUsrMain(ModelMap model,HttpServletRequest request ) throws Exception {
		LoginVO lvo = (LoginVO) request.getSession().getAttribute("loginVO");
		System.out.println(lvo.toString());
		// 1. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "egovframework/com/uat/uia/EgovLoginUsr";
		}
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		LOGGER.debug("User Id : {}", user.getId());

		// 3. 메인 페이지 이동
		String main_page = Globals.MAIN_PAGE;

		LOGGER.debug("Globals.MAIN_PAGE > " + Globals.MAIN_PAGE);
		LOGGER.debug("main_page > {}", main_page);

		return  "redirect:/EgovContent.do";
		
	}*/
	
	/**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		LoginVO lvo = (LoginVO)request.getSession().getAttribute("loginVO");
		request.getSession().setAttribute("loginVO", null);
		return "redirect:/";
	}
	
	/**
	 * 18.4.25
	 * 회원탈퇴
	 * @param
	 * @return 메인화면
	 * @exception Exception
	 * 
	 * 차후 유지보수를 위해 UserManagement DAO에서 매핑을 받아서 처리하길 바람.
	 * 삭제에 필요한 param은 VO가아닌 VO.getUniqId();
	 * */

	/** mberManageDAO */
	@Resource(name="mberManageDAO")
	private MberManageDAO mberManageDAO;
	
	@RequestMapping(value = "/signout.do")
	public String actionSignout(HttpServletRequest request, ModelMap model) throws Exception {
		LoginVO lvo = (LoginVO)request.getSession().getAttribute("loginVO");
	
		//세션종료
		request.getSession().setAttribute("loginVO", null);
		//DBA, 테이블 row 삭제 진행
		mberManageDAO.deleteMber(lvo.getUniqId());
		
		
		
		return "redirect:/";
	}

	/**
	 * 아이디/비밀번호 찾기 화면으로 들어간다
	 * @param
	 * @return 아이디/비밀번호 찾기 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/egovIdPasswordSearch.do")
	public String idPasswordSearchView(ModelMap model) throws Exception {
		return "jsp/login/EgovIdPasswordSearch";
	}
	/**
	 * 아이디를 찾는다.
	 * @param vo - 이름, 이메일주소, 사용자구분이 담긴 LoginVO
	 * @return result - 아이디
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/searchId.do")
	public String searchId(@ModelAttribute("loginVO") LoginVO loginVO, ModelMap model) throws Exception {

		if (loginVO == null || loginVO.getName() == null || loginVO.getName().equals("") && loginVO.getEmail() == null || loginVO.getEmail().equals("")
				&& loginVO.getUserSe() == null || loginVO.getUserSe().equals("")) {
			return "jsp/error/egovError";
		}

		// 1. 아이디 찾기
		loginVO.setName(loginVO.getName().replaceAll(" ", ""));
		LoginVO resultVO = loginService.searchId(loginVO);

		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {

			model.addAttribute("resultInfo", "고객님의 아이디는 " + resultVO.getId() + " 입니다.");
			return "jsp/login/EgovIdResult";
		} else {
			model.addAttribute("resultInfo", "등록되지 않은 정보입니다. 다시 확인 후 시도해주세요.");
			return "jsp/login/EgovIdResult";
		}
	}

	/**
	 * 비밀번호를 찾는다.
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/searchPassword.do")
	public String searchPassword(@ModelAttribute("loginVO") LoginVO loginVO, ModelMap model) throws Exception {

		if (loginVO == null || loginVO.getId() == null || loginVO.getId().equals("") && loginVO.getName() == null || loginVO.getName().equals("") && loginVO.getEmail() == null
				|| loginVO.getEmail().equals("")) {
			return "egovframework/com/cmm/egovError";
		}

		// 1. 비밀번호 찾기
		boolean result = loginService.searchPassword(loginVO);

		// 2. 결과 리턴
		if (result) {
			model.addAttribute("resultInfo", "임시 비밀번호를 발송하였습니다.");
			return "jsp/login/EgovPasswordResult";
		} else {
			model.addAttribute("resultInfo", "등록되지 않은 정보입니다. 다시 확인 후 시도해주세요.");
			return "jsp/login/EgovPasswordResult";
		}
	}

	/**
	 * 개발 시스템 구축 시 발급된 GPKI 서버용인증서에 대한 암호화데이터를 구한다.
	 * 최초 한번만 실행하여, 암호화데이터를 EgovGpkiVariables.js의 ServerCert에 넣는다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/getEncodingData.do")
	public void getEncodingData() throws Exception {

		/*
		X509Certificate x509Cert = null;
		byte[] cert = null;
		String base64cert = null;
		try {
			x509Cert = Disk.readCert("/product/jeus/egovProps/gpkisecureweb/certs/SVR1311000011_env.cer");
			cert = x509Cert.getCert();
			Base64 base64 = new Base64();
			base64cert = base64.encode(cert);
			log.info("+++ Base64로 변환된 인증서는 : " + base64cert);

		} catch (GpkiApiException e) {
			e.printStackTrace();
		}
		*/
	}

	/**
	 * 인증서 DN추출 팝업을 호출한다.
	 * @return 인증서 등록 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/EgovGpkiRegist.do")
	public String gpkiRegistView(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		/** GPKI 인증 부분 */
		// OS에 따라 (local NT(로컬) / server Unix(서버)) 구분
		String os = System.getProperty("os.arch");
		LOGGER.debug("OS : {}", os);
		
		//String virusReturn = null;

		/*
		// 브라우저 이름을 받기위한 처리
		String webKind = EgovClntInfo.getClntWebKind(request);
		String[] ss = webKind.split(" ");
		String browser = ss[1];
		model.addAttribute("browser",browser);
		// -- 여기까지
		if (os.equalsIgnoreCase("x86")) {
		    //Local Host TEST 진행중
		} else {
		    if (browser.equalsIgnoreCase("Explorer")) {
		GPKIHttpServletResponse gpkiresponse = null;
		GPKIHttpServletRequest gpkirequest = null;

		try {
		    gpkiresponse = new GPKIHttpServletResponse(response);
		    gpkirequest = new GPKIHttpServletRequest(request);

		    gpkiresponse.setRequest(gpkirequest);
		    model.addAttribute("challenge", gpkiresponse.getChallenge());

		    return "egovframework/com/uat/uia/EgovGpkiRegist";

		} catch (Exception e) {
		    return "egovframework/com/cmm/egovError";
		}
		}
		}
		*/
		return "egovframework/com/uat/uia/EgovGpkiRegist";
	}

	/**
	 * 인증서 DN값을 추출한다
	 * @return result - dn값
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/actionGpkiRegist.do")
	public String actionGpkiRegist(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
/*
		*//** GPKI 인증 부분 *//*
		// OS에 따라 (local NT(로컬) / server Unix(서버)) 구분
		String os = System.getProperty("os.arch");
		LOGGER.debug("OS : {}", os);
		
		// String virusReturn = null;
		@SuppressWarnings("unused")
		String dn = "";

		// 브라우저 이름을 받기위한 처리
		String webKind = EgovClntInfo.getClntWebKind(request);
		String[] ss = webKind.split(" ");
		String browser = ss[1];
		model.addAttribute("browser", browser);
		
		// -- 여기까지
		if (os.equalsIgnoreCase("x86")) {
			// Local Host TEST 진행중
		} else {
			if (browser.equalsIgnoreCase("Explorer")) {
				GPKIHttpServletResponse gpkiresponse = null;
				GPKIHttpServletRequest gpkirequest = null;
				try {
					gpkiresponse = new GPKIHttpServletResponse(response);
					gpkirequest = new GPKIHttpServletRequest(request);
					gpkiresponse.setRequest(gpkirequest);
					X509Certificate cert = null;

					// byte[] signData = null;
					// byte[] privatekey_random = null;
					// String signType = "";
					// String queryString = "";

					cert = gpkirequest.getSignerCert();
					dn = cert.getSubjectDN();

					model.addAttribute("dn", dn);
					model.addAttribute("challenge", gpkiresponse.getChallenge());

					return "egovframework/com/uat/uia/EgovGpkiRegist";
				} catch (Exception e) {
					return "egovframework/com/cmm/egovError";
				}
			}
		}
		*/
		return "egovframework/com/uat/uia/EgovGpkiRegist";
	}
}