package com.frone.cadastro_igreja.service;

import org.springframework.stereotype.Service;

import com.frone.cadastro_igreja.dto.LoginRequest;
import com.frone.cadastro_igreja.dto.LoginResponse;
import com.frone.cadastro_igreja.entity.Usuario;
import com.frone.cadastro_igreja.repository.UsuarioRepository;

@Service
public class AuthService {
	
	private final UsuarioRepository usuarioRepository;
	
	public AuthService(UsuarioRepository usuarioRepository) {
		this.usuarioRepository = usuarioRepository;
	}
	
	public LoginResponse login(LoginRequest request) {
		
		Usuario usuario = usuarioRepository.findByCpf(request.getCpf()).orElse(null);
		
		if(usuario == null) {
			return new LoginResponse("Usuario ou Senha Inválidos", null, null);
		}
		
		//Senha=Senha Mudar para hash futuramente
		if(!usuario.getSenhaHash().equals(request.getSenha())) {
			
			return new LoginResponse("Usuario ou Senha Inválidos", null, null);
			
		}
		
		return new LoginResponse("Login realizado com sucesso", usuario.getIdusuario(), usuario.getNome());
	}
	
}
