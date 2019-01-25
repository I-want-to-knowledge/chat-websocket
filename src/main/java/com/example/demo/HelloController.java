package com.example.demo;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 测试boot
 *
 * @author YanZhen 2018-04-23 13:43:51 HelloController
 */
@Controller
public class HelloController {

	@RequestMapping("/index")
	public String index(Map<String, Object> map, HttpServletRequest request) {
		map.put("name", "Test WebSocket");
//		map.put("ip", request.getLocalAddr());
		map.put("ip", "39.96.23.254");// 公网ip
		map.put("port", request.getServerPort());
		map.put("path", request.getServletPath());
		System.out.println(map.toString());
		return "index";
	}
}
