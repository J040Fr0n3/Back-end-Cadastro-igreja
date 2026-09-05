package com.frone.cadastro_igreja.service;

import org.springframework.stereotype.Service;

import com.frone.cadastro_igreja.dto.LoginRequest;
import com.frone.cadastro_igreja.dto.LoginResponse;
import com.frone.cadastro_igreja.entity.Usuario;
import com.frone.cadastro_igreja.repository.UsuarioRepository;
import com.frone.cadastro_igreja.security.JwtService;

@Service
public class AuthService {
	
	private final UsuarioRepository usuarioRepository;
	private final JwtService jwtService;
	
	public AuthService(UsuarioRepository usuarioRepository, JwtService jwtService) {
		
		this.usuarioRepository = usuarioRepository;
		this.jwtService = jwtService;
		
	}
	
	public LoginResponse login(LoginRequest request) {
		
		Usuario usuario = usuarioRepository.findByCpf(request.getCpf()).orElse(null);
		
		if(usuario == null) {
			
			return new LoginResponse("Usuario ou senha inválidos", null);
			
		};
		
		if(!usuario.getSenhaHash().equals(request.getSenha())) {
			
			return new LoginResponse("Usuario ou senha inválidos", null);
			
		}
		
		String token = jwtService.gerarToken(usuario.getIdusuario(), usuario.getNome());
		
		return new LoginResponse("Login realizado com sucesso", token);
		
	}
	
}
