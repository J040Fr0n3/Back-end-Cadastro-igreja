package com.frone.cadastro_igreja.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.frone.cadastro_igreja.entity.Usuario;

import java.util.Optional;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

    Optional<Usuario> findByCpf(String cpf);
}
