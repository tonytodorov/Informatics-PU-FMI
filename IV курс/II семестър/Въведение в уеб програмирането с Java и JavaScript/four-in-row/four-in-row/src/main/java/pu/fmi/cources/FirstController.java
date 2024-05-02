package pu.fmi.cources;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FirstController {

	@Autowired
	public GameService gameService;
	
	@ResponseBody
	@GetMapping("/")
	public String hello() {
		return "Hello!";
		
	}
}
