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
		
		System.out.println("���̹�:" + naverAuthUrl);

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
		System.out.println("����� callback");
		OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        //�α��� ����� ������ �о�´�.
	    apiResult = naverLoginBO.getUserProfile(oauthToken);
	    JSONParser parser = new JSONParser();
	    Object obj = parser.parse(apiResult);
	    JSONObject jsonObj = (JSONObject) obj;
	    //3. ������ �Ľ�
	    //Top���� �ܰ� _response �Ľ�
	    JSONObject response_obj = (JSONObject)jsonObj.get("response");
	    //response�� nickname�� �Ľ�
	    String nickname = (String)response_obj.get("nickname");
	    System.out.println(nickname);
	    //4.�Ľ� �г��� �������� ����
	    session.setAttribute("sessionId",nickname); //���� ����
	    model.addAttribute("result", apiResult);
	    return "login/naverSuccess";

	    
	}
	//�α׾ƿ�
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session)throws IOException {
		System.out.println("����� logout");
		session.invalidate();
		return "redirect:http://localhost:8090/getBoardList";
	}


}


