-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema APK
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema APK
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `APK` DEFAULT CHARACTER SET utf8mb3 ;
USE `APK` ;

-- -----------------------------------------------------
-- Table `APK`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`status` (
  `idstatus` INT NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idstatus`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`crianca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`crianca` (
  `idcrianca` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `dt_nascimento` DATE NULL DEFAULT NULL,
  `observacoes` LONGTEXT NULL DEFAULT NULL,
  `dt_cadastro` DATE NOT NULL,
  `idstatus` INT NOT NULL,
  PRIMARY KEY (`idcrianca`),
  INDEX `fk_crianca_status1_idx` (`idstatus` ASC) VISIBLE,
  CONSTRAINT `fk_crianca_status1`
    FOREIGN KEY (`idstatus`)
    REFERENCES `APK`.`status` (`idstatus`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`tipo_evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`tipo_evento` (
  `idtipo_evento` INT NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo_evento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`usuario` (
  `idusuario` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `dt_nascimento` DATE NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `senha_hash` VARCHAR(150) NOT NULL,
  `dt_cadastro` DATE NOT NULL,
  `dt_ult_acess` DATE NOT NULL,
  `idstatus` INT NOT NULL,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_status_idx` (`idstatus` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_status`
    FOREIGN KEY (`idstatus`)
    REFERENCES `APK`.`status` (`idstatus`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`evento` (
  `idevento` INT NOT NULL,
  `titulo` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` LONGTEXT NULL DEFAULT NULL,
  `inicio` DATETIME NULL DEFAULT NULL,
  `fim` DATETIME NULL DEFAULT NULL,
  `local` VARCHAR(150) NULL DEFAULT NULL,
  `idtipo_evento` INT NOT NULL,
  `idstatus` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idevento`),
  INDEX `fk_evento_tipo_evento1_idx` (`idtipo_evento` ASC) VISIBLE,
  INDEX `fk_evento_status1_idx` (`idstatus` ASC) VISIBLE,
  INDEX `fk_evento_usuario1_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_evento_status1`
    FOREIGN KEY (`idstatus`)
    REFERENCES `APK`.`status` (`idstatus`),
  CONSTRAINT `fk_evento_tipo_evento1`
    FOREIGN KEY (`idtipo_evento`)
    REFERENCES `APK`.`tipo_evento` (`idtipo_evento`),
  CONSTRAINT `fk_evento_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `APK`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`publico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`publico` (
  `idpublico` INT NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idpublico`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`evento_publico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`evento_publico` (
  `idevento` INT NOT NULL,
  `idpublico` INT NOT NULL,
  PRIMARY KEY (`idevento`, `idpublico`),
  INDEX `fk_evento_publico_publico1_idx` (`idpublico` ASC) VISIBLE,
  CONSTRAINT `fk_evento_publico_evento1`
    FOREIGN KEY (`idevento`)
    REFERENCES `APK`.`evento` (`idevento`),
  CONSTRAINT `fk_evento_publico_publico1`
    FOREIGN KEY (`idpublico`)
    REFERENCES `APK`.`publico` (`idpublico`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`turma` (
  `idturma` INT NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` LONGTEXT NULL DEFAULT NULL,
  `sala` VARCHAR(45) NULL DEFAULT NULL,
  `dia_semana` DATE NULL DEFAULT NULL,
  `hr_inicio` TIME NULL DEFAULT NULL,
  `hr_final` TIME NULL DEFAULT NULL,
  `dt_criacao` DATE NULL DEFAULT NULL,
  `idstatus` INT NOT NULL,
  PRIMARY KEY (`idturma`),
  INDEX `fk_turma_status1_idx` (`idstatus` ASC) VISIBLE,
  CONSTRAINT `fk_turma_status1`
    FOREIGN KEY (`idstatus`)
    REFERENCES `APK`.`status` (`idstatus`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`frequencia_crianca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`frequencia_crianca` (
  `idfrequencia_crianca` INT NOT NULL,
  `dt_freq` DATE NULL DEFAULT NULL,
  `presente` VARCHAR(45) NULL DEFAULT NULL,
  `hr_entrada` DATETIME NULL DEFAULT NULL,
  `hr_saida` DATETIME NULL DEFAULT NULL,
  `obs` LONGTEXT NULL DEFAULT NULL,
  `idcrianca` INT NOT NULL,
  `idturma` INT NOT NULL,
  PRIMARY KEY (`idfrequencia_crianca`),
  INDEX `fk_frequencia_crianca_crianca1_idx` (`idcrianca` ASC) VISIBLE,
  INDEX `fk_frequencia_crianca_turma1_idx` (`idturma` ASC) VISIBLE,
  CONSTRAINT `fk_frequencia_crianca_crianca1`
    FOREIGN KEY (`idcrianca`)
    REFERENCES `APK`.`crianca` (`idcrianca`),
  CONSTRAINT `fk_frequencia_crianca_turma1`
    FOREIGN KEY (`idturma`)
    REFERENCES `APK`.`turma` (`idturma`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`frequencia_voluntario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`frequencia_voluntario` (
  `idfrequencia_voluntario` INT NOT NULL,
  `idusuario` INT NOT NULL,
  `idturma` INT NOT NULL,
  `dt_freq` DATE NULL DEFAULT NULL,
  `hr_entrada` DATETIME NULL DEFAULT NULL,
  `hr_saida` DATETIME NULL DEFAULT NULL,
  `obs` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idfrequencia_voluntario`),
  INDEX `fk_frequencia_voluntario_usuario1_idx` (`idusuario` ASC) VISIBLE,
  INDEX `fk_frequencia_voluntario_turma1_idx` (`idturma` ASC) VISIBLE,
  CONSTRAINT `fk_frequencia_voluntario_turma1`
    FOREIGN KEY (`idturma`)
    REFERENCES `APK`.`turma` (`idturma`),
  CONSTRAINT `fk_frequencia_voluntario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `APK`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`matricula` (
  `idmatricula` INT NOT NULL,
  `dt_entrada` DATE NULL DEFAULT NULL,
  `dt_saida` DATE NULL DEFAULT NULL,
  `idcrianca` INT NOT NULL,
  `idturma` INT NOT NULL,
  `idstatus` INT NOT NULL,
  PRIMARY KEY (`idmatricula`),
  INDEX `fk_matricula_crianca1_idx` (`idcrianca` ASC) VISIBLE,
  INDEX `fk_matricula_turma1_idx` (`idturma` ASC) VISIBLE,
  INDEX `fk_matricula_status1_idx` (`idstatus` ASC) VISIBLE,
  CONSTRAINT `fk_matricula_crianca1`
    FOREIGN KEY (`idcrianca`)
    REFERENCES `APK`.`crianca` (`idcrianca`),
  CONSTRAINT `fk_matricula_status1`
    FOREIGN KEY (`idstatus`)
    REFERENCES `APK`.`status` (`idstatus`),
  CONSTRAINT `fk_matricula_turma1`
    FOREIGN KEY (`idturma`)
    REFERENCES `APK`.`turma` (`idturma`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`tipo_obs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`tipo_obs` (
  `idtipo_obs` INT NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo_obs`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`visibilidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`visibilidade` (
  `idvisibilidade` INT NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idvisibilidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`observacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`observacao` (
  `idobservacao` INT NOT NULL,
  `idcrianca` INT NOT NULL,
  `idusuario` INT NOT NULL,
  `idtipo_obs` INT NOT NULL,
  `idvisibilidade` INT NOT NULL,
  `data_hora` DATETIME NULL DEFAULT NULL,
  `texto` LONGTEXT NULL DEFAULT NULL,
  `idstatus` INT NOT NULL,
  PRIMARY KEY (`idobservacao`),
  INDEX `fk_observacao_crianca1_idx` (`idcrianca` ASC) VISIBLE,
  INDEX `fk_observacao_usuario1_idx` (`idusuario` ASC) VISIBLE,
  INDEX `fk_observacao_tipo_obs1_idx` (`idtipo_obs` ASC) VISIBLE,
  INDEX `fk_observacao_visibilidade1_idx` (`idvisibilidade` ASC) VISIBLE,
  INDEX `fk_observacao_status1_idx` (`idstatus` ASC) VISIBLE,
  CONSTRAINT `fk_observacao_crianca1`
    FOREIGN KEY (`idcrianca`)
    REFERENCES `APK`.`crianca` (`idcrianca`),
  CONSTRAINT `fk_observacao_status1`
    FOREIGN KEY (`idstatus`)
    REFERENCES `APK`.`status` (`idstatus`),
  CONSTRAINT `fk_observacao_tipo_obs1`
    FOREIGN KEY (`idtipo_obs`)
    REFERENCES `APK`.`tipo_obs` (`idtipo_obs`),
  CONSTRAINT `fk_observacao_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `APK`.`usuario` (`idusuario`),
  CONSTRAINT `fk_observacao_visibilidade1`
    FOREIGN KEY (`idvisibilidade`)
    REFERENCES `APK`.`visibilidade` (`idvisibilidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`responsavel_crianca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`responsavel_crianca` (
  `idresponsavel_crianca` INT NOT NULL,
  `parentesco` VARCHAR(45) NULL DEFAULT NULL,
  `resp_principal` VARCHAR(10) NULL DEFAULT NULL,
  `pode_buscar` VARCHAR(10) NULL DEFAULT NULL,
  `idusuario` INT NOT NULL,
  `idcrianca` INT NOT NULL,
  PRIMARY KEY (`idresponsavel_crianca`),
  INDEX `fk_responsavel_crianca_usuario1_idx` (`idusuario` ASC) VISIBLE,
  INDEX `fk_responsavel_crianca_crianca1_idx` (`idcrianca` ASC) VISIBLE,
  CONSTRAINT `fk_responsavel_crianca_crianca1`
    FOREIGN KEY (`idcrianca`)
    REFERENCES `APK`.`crianca` (`idcrianca`),
  CONSTRAINT `fk_responsavel_crianca_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `APK`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`tipo_usuario` (
  `idtipo_usuario` INT NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`turma_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`turma_usuario` (
  `idturma` INT NOT NULL,
  `idusuario` INT NOT NULL,
  `responsavel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idturma`, `idusuario`),
  INDEX `fk_turma_usuario_usuario1_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_turma_usuario_turma1`
    FOREIGN KEY (`idturma`)
    REFERENCES `APK`.`turma` (`idturma`),
  CONSTRAINT `fk_turma_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `APK`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `APK`.`usuario_tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`usuario_tipo_usuario` (
  `idusuario` INT NOT NULL,
  `idtipo_usuario` INT NOT NULL,
  PRIMARY KEY (`idusuario`, `idtipo_usuario`),
  INDEX `fk_usuario_tipo_usuario_tipo_usuario1_idx` (`idtipo_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_tipo_usuario_tipo_usuario1`
    FOREIGN KEY (`idtipo_usuario`)
    REFERENCES `APK`.`tipo_usuario` (`idtipo_usuario`),
  CONSTRAINT `fk_usuario_tipo_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `APK`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `APK` ;

-- -----------------------------------------------------
-- Placeholder table for view `APK`.`vw_crianca_responsaveis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`vw_crianca_responsaveis` (`idcrianca` INT, `crianca` INT, `dt_nascimento` INT, `idresponsavel` INT, `responsavel` INT, `email` INT, `telefone` INT, `parentesco` INT, `resp_principal` INT, `pode_buscar` INT);

-- -----------------------------------------------------
-- Placeholder table for view `APK`.`vw_crianca_turma_atual`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`vw_crianca_turma_atual` (`idmatricula` INT, `idcrianca` INT, `crianca` INT, `idturma` INT, `turma` INT, `sala` INT, `dia_semana` INT, `hr_inicio` INT, `hr_final` INT, `dt_entrada` INT, `dt_saida` INT, `status_matricula` INT);

-- -----------------------------------------------------
-- Placeholder table for view `APK`.`vw_dashboard_turmas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`vw_dashboard_turmas` (`idturma` INT, `turma` INT, `sala` INT, `dia_semana` INT, `hr_inicio` INT, `hr_final` INT, `total_criancas` INT, `total_voluntarios` INT);

-- -----------------------------------------------------
-- Placeholder table for view `APK`.`vw_eventos_publicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`vw_eventos_publicos` (`idevento` INT, `titulo` INT, `descricao` INT, `inicio` INT, `fim` INT, `local` INT, `idtipo_evento` INT, `tipo_evento` INT, `idstatus` INT, `status` INT, `idcriador` INT, `criador` INT, `idpublico` INT, `publico` INT);

-- -----------------------------------------------------
-- Placeholder table for view `APK`.`vw_frequencia_crianca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`vw_frequencia_crianca` (`idfrequencia_crianca` INT, `dt_freq` INT, `presente` INT, `hr_entrada` INT, `hr_saida` INT, `obs` INT, `idcrianca` INT, `crianca` INT, `idturma` INT, `turma` INT);

-- -----------------------------------------------------
-- Placeholder table for view `APK`.`vw_frequencia_voluntario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`vw_frequencia_voluntario` (`idfrequencia_voluntario` INT, `dt_freq` INT, `hr_entrada` INT, `hr_saida` INT, `obs` INT, `idusuario` INT, `voluntario` INT, `idturma` INT, `turma` INT);

-- -----------------------------------------------------
-- Placeholder table for view `APK`.`vw_observacoes_crianca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`vw_observacoes_crianca` (`idobservacao` INT, `data_hora` INT, `texto` INT, `idcrianca` INT, `crianca` INT, `idusuario` INT, `autor` INT, `idtipo_obs` INT, `tipo_observacao` INT, `idvisibilidade` INT, `visibilidade` INT, `idstatus` INT, `status` INT);

-- -----------------------------------------------------
-- Placeholder table for view `APK`.`vw_turma_criancas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`vw_turma_criancas` (`idturma` INT, `turma` INT, `idcrianca` INT, `crianca` INT, `dt_nascimento` INT, `dt_entrada` INT, `dt_saida` INT, `status_matricula` INT);

-- -----------------------------------------------------
-- Placeholder table for view `APK`.`vw_turma_voluntarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`vw_turma_voluntarios` (`idturma` INT, `turma` INT, `sala` INT, `idusuario` INT, `voluntario` INT, `responsavel` INT, `email` INT, `telefone` INT);

-- -----------------------------------------------------
-- Placeholder table for view `APK`.`vw_usuario_perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APK`.`vw_usuario_perfil` (`idusuario` INT, `nome` INT, `cpf` INT, `email` INT, `telefone` INT, `dt_nascimento` INT, `dt_cadastro` INT, `dt_ult_acess` INT, `status` INT, `idtipo_usuario` INT, `tipo_usuario` INT, `descricao_tipo` INT);

-- -----------------------------------------------------
-- View `APK`.`vw_crianca_responsaveis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `APK`.`vw_crianca_responsaveis`;
USE `APK`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`joao`@`localhost` SQL SECURITY DEFINER VIEW `APK`.`vw_crianca_responsaveis` AS select `c`.`idcrianca` AS `idcrianca`,`c`.`nome` AS `crianca`,`c`.`dt_nascimento` AS `dt_nascimento`,`u`.`idusuario` AS `idresponsavel`,`u`.`nome` AS `responsavel`,`u`.`email` AS `email`,`u`.`telefone` AS `telefone`,`rc`.`parentesco` AS `parentesco`,`rc`.`resp_principal` AS `resp_principal`,`rc`.`pode_buscar` AS `pode_buscar` from ((`APK`.`crianca` `c` join `APK`.`responsavel_crianca` `rc` on((`rc`.`idcrianca` = `c`.`idcrianca`))) join `APK`.`usuario` `u` on((`u`.`idusuario` = `rc`.`idusuario`)));

-- -----------------------------------------------------
-- View `APK`.`vw_crianca_turma_atual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `APK`.`vw_crianca_turma_atual`;
USE `APK`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`joao`@`localhost` SQL SECURITY DEFINER VIEW `APK`.`vw_crianca_turma_atual` AS select `m`.`idmatricula` AS `idmatricula`,`c`.`idcrianca` AS `idcrianca`,`c`.`nome` AS `crianca`,`t`.`idturma` AS `idturma`,`t`.`nome` AS `turma`,`t`.`sala` AS `sala`,`t`.`dia_semana` AS `dia_semana`,`t`.`hr_inicio` AS `hr_inicio`,`t`.`hr_final` AS `hr_final`,`m`.`dt_entrada` AS `dt_entrada`,`m`.`dt_saida` AS `dt_saida`,`s`.`nome` AS `status_matricula` from (((`APK`.`matricula` `m` join `APK`.`crianca` `c` on((`c`.`idcrianca` = `m`.`idcrianca`))) join `APK`.`turma` `t` on((`t`.`idturma` = `m`.`idturma`))) join `APK`.`status` `s` on((`s`.`idstatus` = `m`.`idstatus`))) where (`m`.`dt_saida` is null);

-- -----------------------------------------------------
-- View `APK`.`vw_dashboard_turmas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `APK`.`vw_dashboard_turmas`;
USE `APK`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`joao`@`localhost` SQL SECURITY DEFINER VIEW `APK`.`vw_dashboard_turmas` AS select `t`.`idturma` AS `idturma`,`t`.`nome` AS `turma`,`t`.`sala` AS `sala`,`t`.`dia_semana` AS `dia_semana`,`t`.`hr_inicio` AS `hr_inicio`,`t`.`hr_final` AS `hr_final`,count(distinct `m`.`idcrianca`) AS `total_criancas`,count(distinct `tu`.`idusuario`) AS `total_voluntarios` from ((`APK`.`turma` `t` left join `APK`.`matricula` `m` on(((`m`.`idturma` = `t`.`idturma`) and (`m`.`dt_saida` is null)))) left join `APK`.`turma_usuario` `tu` on((`tu`.`idturma` = `t`.`idturma`))) group by `t`.`idturma`,`t`.`nome`,`t`.`sala`,`t`.`dia_semana`,`t`.`hr_inicio`,`t`.`hr_final`;

-- -----------------------------------------------------
-- View `APK`.`vw_eventos_publicos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `APK`.`vw_eventos_publicos`;
USE `APK`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`joao`@`localhost` SQL SECURITY DEFINER VIEW `APK`.`vw_eventos_publicos` AS select `e`.`idevento` AS `idevento`,`e`.`titulo` AS `titulo`,`e`.`descricao` AS `descricao`,`e`.`inicio` AS `inicio`,`e`.`fim` AS `fim`,`e`.`local` AS `local`,`te`.`idtipo_evento` AS `idtipo_evento`,`te`.`nome` AS `tipo_evento`,`s`.`idstatus` AS `idstatus`,`s`.`nome` AS `status`,`u`.`idusuario` AS `idcriador`,`u`.`nome` AS `criador`,`p`.`idpublico` AS `idpublico`,`p`.`nome` AS `publico` from (((((`APK`.`evento` `e` join `APK`.`tipo_evento` `te` on((`te`.`idtipo_evento` = `e`.`idtipo_evento`))) join `APK`.`status` `s` on((`s`.`idstatus` = `e`.`idstatus`))) join `APK`.`usuario` `u` on((`u`.`idusuario` = `e`.`idusuario`))) join `APK`.`evento_publico` `ep` on((`ep`.`idevento` = `e`.`idevento`))) join `APK`.`publico` `p` on((`p`.`idpublico` = `ep`.`idpublico`)));

-- -----------------------------------------------------
-- View `APK`.`vw_frequencia_crianca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `APK`.`vw_frequencia_crianca`;
USE `APK`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`joao`@`localhost` SQL SECURITY DEFINER VIEW `APK`.`vw_frequencia_crianca` AS select `f`.`idfrequencia_crianca` AS `idfrequencia_crianca`,`f`.`dt_freq` AS `dt_freq`,`f`.`presente` AS `presente`,`f`.`hr_entrada` AS `hr_entrada`,`f`.`hr_saida` AS `hr_saida`,`f`.`obs` AS `obs`,`c`.`idcrianca` AS `idcrianca`,`c`.`nome` AS `crianca`,`t`.`idturma` AS `idturma`,`t`.`nome` AS `turma` from ((`APK`.`frequencia_crianca` `f` join `APK`.`crianca` `c` on((`c`.`idcrianca` = `f`.`idcrianca`))) join `APK`.`turma` `t` on((`t`.`idturma` = `f`.`idturma`)));

-- -----------------------------------------------------
-- View `APK`.`vw_frequencia_voluntario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `APK`.`vw_frequencia_voluntario`;
USE `APK`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`joao`@`localhost` SQL SECURITY DEFINER VIEW `APK`.`vw_frequencia_voluntario` AS select `f`.`idfrequencia_voluntario` AS `idfrequencia_voluntario`,`f`.`dt_freq` AS `dt_freq`,`f`.`hr_entrada` AS `hr_entrada`,`f`.`hr_saida` AS `hr_saida`,`f`.`obs` AS `obs`,`u`.`idusuario` AS `idusuario`,`u`.`nome` AS `voluntario`,`t`.`idturma` AS `idturma`,`t`.`nome` AS `turma` from ((`APK`.`frequencia_voluntario` `f` join `APK`.`usuario` `u` on((`u`.`idusuario` = `f`.`idusuario`))) join `APK`.`turma` `t` on((`t`.`idturma` = `f`.`idturma`)));

-- -----------------------------------------------------
-- View `APK`.`vw_observacoes_crianca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `APK`.`vw_observacoes_crianca`;
USE `APK`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`joao`@`localhost` SQL SECURITY DEFINER VIEW `APK`.`vw_observacoes_crianca` AS select `o`.`idobservacao` AS `idobservacao`,`o`.`data_hora` AS `data_hora`,`o`.`texto` AS `texto`,`c`.`idcrianca` AS `idcrianca`,`c`.`nome` AS `crianca`,`u`.`idusuario` AS `idusuario`,`u`.`nome` AS `autor`,`tobs`.`idtipo_obs` AS `idtipo_obs`,`tobs`.`nome` AS `tipo_observacao`,`v`.`idvisibilidade` AS `idvisibilidade`,`v`.`nome` AS `visibilidade`,`s`.`idstatus` AS `idstatus`,`s`.`nome` AS `status` from (((((`APK`.`observacao` `o` join `APK`.`crianca` `c` on((`c`.`idcrianca` = `o`.`idcrianca`))) join `APK`.`usuario` `u` on((`u`.`idusuario` = `o`.`idusuario`))) join `APK`.`tipo_obs` `tobs` on((`tobs`.`idtipo_obs` = `o`.`idtipo_obs`))) join `APK`.`visibilidade` `v` on((`v`.`idvisibilidade` = `o`.`idvisibilidade`))) join `APK`.`status` `s` on((`s`.`idstatus` = `o`.`idstatus`)));

-- -----------------------------------------------------
-- View `APK`.`vw_turma_criancas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `APK`.`vw_turma_criancas`;
USE `APK`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`joao`@`localhost` SQL SECURITY DEFINER VIEW `APK`.`vw_turma_criancas` AS select `t`.`idturma` AS `idturma`,`t`.`nome` AS `turma`,`c`.`idcrianca` AS `idcrianca`,`c`.`nome` AS `crianca`,`c`.`dt_nascimento` AS `dt_nascimento`,`m`.`dt_entrada` AS `dt_entrada`,`m`.`dt_saida` AS `dt_saida`,`s`.`nome` AS `status_matricula` from (((`APK`.`turma` `t` join `APK`.`matricula` `m` on((`m`.`idturma` = `t`.`idturma`))) join `APK`.`crianca` `c` on((`c`.`idcrianca` = `m`.`idcrianca`))) join `APK`.`status` `s` on((`s`.`idstatus` = `m`.`idstatus`)));

-- -----------------------------------------------------
-- View `APK`.`vw_turma_voluntarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `APK`.`vw_turma_voluntarios`;
USE `APK`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`joao`@`localhost` SQL SECURITY DEFINER VIEW `APK`.`vw_turma_voluntarios` AS select `t`.`idturma` AS `idturma`,`t`.`nome` AS `turma`,`t`.`sala` AS `sala`,`u`.`idusuario` AS `idusuario`,`u`.`nome` AS `voluntario`,`tu`.`responsavel` AS `responsavel`,`u`.`email` AS `email`,`u`.`telefone` AS `telefone` from ((`APK`.`turma` `t` join `APK`.`turma_usuario` `tu` on((`tu`.`idturma` = `t`.`idturma`))) join `APK`.`usuario` `u` on((`u`.`idusuario` = `tu`.`idusuario`)));

-- -----------------------------------------------------
-- View `APK`.`vw_usuario_perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `APK`.`vw_usuario_perfil`;
USE `APK`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`joao`@`localhost` SQL SECURITY DEFINER VIEW `APK`.`vw_usuario_perfil` AS select `u`.`idusuario` AS `idusuario`,`u`.`nome` AS `nome`,`u`.`cpf` AS `cpf`,`u`.`email` AS `email`,`u`.`telefone` AS `telefone`,`u`.`dt_nascimento` AS `dt_nascimento`,`u`.`dt_cadastro` AS `dt_cadastro`,`u`.`dt_ult_acess` AS `dt_ult_acess`,`s`.`nome` AS `status`,`tu`.`idtipo_usuario` AS `idtipo_usuario`,`tu`.`nome` AS `tipo_usuario`,`tu`.`descricao` AS `descricao_tipo` from (((`APK`.`usuario` `u` join `APK`.`status` `s` on((`s`.`idstatus` = `u`.`idstatus`))) join `APK`.`usuario_tipo_usuario` `utu` on((`utu`.`idusuario` = `u`.`idusuario`))) join `APK`.`tipo_usuario` `tu` on((`tu`.`idtipo_usuario` = `utu`.`idtipo_usuario`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
