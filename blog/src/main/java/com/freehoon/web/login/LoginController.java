package com.freehoon.web.login;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.freehoon.web.user.model.UserVO;
import com.github.scribejava.core.model.OAuth2AccessToken;



@Controller
@RequestMapping(value = "/login/*") 
public class LoginController {
	
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@RequestMapping(value = "/login", method = {RequestMethod.GET , RequestMethod.POST}) 
	public String loginForm(Model model , HttpSession session) throws Exception { 
		
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		
		System.out.println("네이버:" + naverAuthUrl);

		model.addAttribute("userVO", new UserVO());
		model.addAttribute("url", naverAuthUrl);


		return "login/login";
	}
	
	@RequestMapping(value = "/signupForm", method = RequestMethod.GET) 
	public String signupForm(Model model) throws Exception { 
		model.addAttribute("userVO", new UserVO()); 
		return "login/signupForm";
	}
	
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        //로그인 사용자 정보를 읽어온다.
	    apiResult = naverLoginBO.getUserProfile(oauthToken);
	    JSONParser parser = new JSONParser();
	    Object obj = parser.parse(apiResult);
	    JSONObject jsonObj = (JSONObject) obj;
	    //3. 데이터 파싱
	    //Top레벨 단계 _response 파싱
	    JSONObject response_obj = (JSONObject)jsonObj.get("response");
	    //response의 nickname값 파싱
	    String nickname = (String)response_obj.get("nickname");
	    System.out.println(nickname);
	    //4.파싱 닉네임 세션으로 저장
	    session.setAttribute("sessionId",nickname); //세션 생성
	    model.addAttribute("result", apiResult);
	    return "login/naverSuccess";

	    
	}
	//로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session)throws IOException {
		System.out.println("여기는 logout");
		session.invalidate();
		return "redirect:http://localhost:8090/getBoardList";
	}


}


