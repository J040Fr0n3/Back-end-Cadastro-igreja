package com.frone.cadastro_igreja.security;

import java.util.Date;

import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;


@Service
public class JwtService {
	@Value("${jwt.secret}")
	private String secret;
	private final long EXPIRATION = 1000 * 60 * 60 * 24;
	
	private SecretKey getKey() {
		
		return Keys.hmacShaKeyFor(secret.getBytes());
		
	}
	
	public String gerarToken(Integer idUsuario, String nome) {
		
		Date agora = new Date();
		Date expiracao = new Date(agora.getTime() + EXPIRATION);
		
		return Jwts.builder()
				.setSubject(String.valueOf(idUsuario))
				.claim("nome", nome)
				.setIssuedAt(agora)
				.setExpiration(expiracao)
				.signWith(getKey())
				.compact();
		
	}
	
}
