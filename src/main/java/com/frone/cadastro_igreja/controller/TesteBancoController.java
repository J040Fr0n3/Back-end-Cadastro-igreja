package com.frone.cadastro_igreja.controller;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class TesteBancoController {

    @PersistenceContext
    private EntityManager entityManager;

    @GetMapping("/tabelas")
    public List<String> listarTabelasDoBanco() {
        // Executa a query nativa do MySQL para listar as tabelas do schema atual (APK)
        @SuppressWarnings("unchecked")
        List<String> tabelas = entityManager.createNativeQuery("SHOW TABLES").getResultList();
        
        return tabelas;
    }
}