package com.frone.cadastro_igreja.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.frone.cadastro_igreja.dto.LoginRequest;
import com.frone.cadastro_igreja.dto.LoginResponse;
import com.frone.cadastro_igreja.service.AuthService;


@RestController
@RequestMapping("/api/auth")
public class AuthController {
	
	private final AuthService authService;
	
	public AuthController(AuthService authService) {
		
		this.authService = authService;
		
	}
	
	@PostMapping("/login")
	public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest request){
		
		LoginResponse response = authService.login(request);
		
		if(response.getIdUsuario()==null) {
			
			return ResponseEntity.status(401).body(response);
		}
		
		return ResponseEntity.ok(response);
		
	}
	
}
