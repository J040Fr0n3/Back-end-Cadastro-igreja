package com.frone.cadastro_igreja.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "status", schema = "APK")
public class Status {

    @Id
    @Column(name = "idstatus")
    private Integer idstatus;

    @Column(name = "nome")
    private String nome;

    public Status() {
    }

    public Integer getIdstatus() {
        return idstatus;
    }

    public void setIdstatus(Integer idstatus) {
        this.idstatus = idstatus;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}
