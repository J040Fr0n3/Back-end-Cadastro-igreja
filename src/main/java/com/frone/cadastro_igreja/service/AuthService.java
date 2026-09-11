package com.frone.cadastro_igreja.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.frone.cadastro_igreja.dto.LoginRequest;
import com.frone.cadastro_igreja.dto.LoginResponse;
import com.frone.cadastro_igreja.entity.Usuario;
import com.frone.cadastro_igreja.repository.UsuarioRepository;

@Service
public class AuthService {
	
	private final UsuarioRepository usuarioRepository;
	private final JwtService jwtService;
	private final PasswordEncoder passwordEncoder;
	
	public AuthService(UsuarioRepository usuarioRepository, JwtService jwtService, PasswordEncoder passwordEncoder) {
		
		this.usuarioRepository = usuarioRepository;
		this.jwtService = jwtService;
		this.passwordEncoder = passwordEncoder;
		
	}
	
	public LoginResponse login(LoginRequest request) {
		
		Usuario usuario = usuarioRepository.findByCpf(request.getCpf()).orElse(null);
		
		if(usuario == null) {
			
			return new LoginResponse("Usuario ou senha inválidos", null);
			
		};
		
		if(!passwordEncoder.matches(request.getSenha(), usuario.getSenhaHash())) {
			
			return new LoginResponse("Usuario ou senha inválidos", null);
			
		}
		
		String token = jwtService.gerarToken(usuario.getIdusuario(), usuario.getNome());
		
		return new LoginResponse("Login realizado com sucesso", token);
		
	}
	
}
