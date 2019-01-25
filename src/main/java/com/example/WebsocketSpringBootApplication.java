package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 *  启动
 *  访问：http://172.0.0.1:8899/index 登录用户1
 *  访问：http://172.0.0.1:8899/index 登录用户2
 *  ‘登录用户1’与‘登录用户2’进行通信
 *
 * @author YanZhen
 * 2018-11-27 14:02:52
 * WebsocketSpringBootApplication
 */
@SpringBootApplication
public class WebsocketSpringBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(WebsocketSpringBootApplication.class, args);
	}
}
