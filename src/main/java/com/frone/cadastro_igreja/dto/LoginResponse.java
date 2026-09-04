package com.frone.cadastro_igreja.dto;

public class LoginResponse {
	
	private String mensagem;
	private Integer idUsuario;
	private String nome;
	
	public LoginResponse(String mensagem, Integer idusuario, String nome) {
		
		this.mensagem = mensagem;
		this.idUsuario = idusuario;
		this.nome = nome;
		
	}

	public String getMensagem() {
		return mensagem;
	}

	public Integer getIdUsuario() {
		return idUsuario;
	}

	public String getNome() {
		return nome;
	}
	
	
	
}
