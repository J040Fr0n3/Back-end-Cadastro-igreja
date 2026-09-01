package com.frone.cadastro_igreja.controller;


import org.springframework.web.bind.annotation.*;

import com.frone.cadastro_igreja.entity.Usuario;
import com.frone.cadastro_igreja.repository.UsuarioRepository;

import java.util.Optional;

@RestController
@RequestMapping("/teste")
public class TesteController {

    private final UsuarioRepository usuarioRepository;

    public TesteController(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @GetMapping("/usuario/{cpf}")
    public Optional<Usuario> buscarUsuario(@PathVariable String cpf) {

        return usuarioRepository.findByCpf(cpf);
    }
}