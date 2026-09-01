package com.frone.cadastro_igreja.entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "usuario", schema = "APK")
public class Usuario {

    @Id
    @Column(name = "idusuario")
    private Integer idusuario;

    @Column(name = "nome", nullable = false, length = 50)
    private String nome;

    @Column(name = "cpf", nullable = false, length = 11)
    private String cpf;

    @Column(name = "dt_nascimento")
    private LocalDate dtNascimento;

    @Column(name = "email", length = 45)
    private String email;

    @Column(name = "telefone", nullable = false)
    private Integer telefone;

    @Column(name = "senha_hash", nullable = false, length = 150)
    private String senhaHash;

    @Column(name = "dt_cadastro", nullable = false)
    private LocalDate dtCadastro;

    @Column(name = "dt_ult_acess", nullable = false)
    private LocalDate dtUltAcess;

    @ManyToOne
    @JoinColumn(name = "idstatus", nullable = false)
    private Status status;


    public Usuario() {
    }


    public Integer getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(Integer idusuario) {
        this.idusuario = idusuario;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public LocalDate getDtNascimento() {
        return dtNascimento;
    }

    public void setDtNascimento(LocalDate dtNascimento) {
        this.dtNascimento = dtNascimento;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getTelefone() {
        return telefone;
    }

    public void setTelefone(Integer telefone) {
        this.telefone = telefone;
    }

    public String getSenhaHash() {
        return senhaHash;
    }

    public void setSenhaHash(String senhaHash) {
        this.senhaHash = senhaHash;
    }

    public LocalDate getDtCadastro() {
        return dtCadastro;
    }

    public void setDtCadastro(LocalDate dtCadastro) {
        this.dtCadastro = dtCadastro;
    }

    public LocalDate getDtUltAcess() {
        return dtUltAcess;
    }

    public void setDtUltAcess(LocalDate dtUltAcess) {
        this.dtUltAcess = dtUltAcess;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}
