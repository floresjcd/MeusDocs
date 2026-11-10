-- ============================================================
-- SCRIPT DE LABORATÓRIO SQL - BANCO DE DADOS ESCOLA
-- Compatível com MySQL / MariaDB (XAMPP - phpMyAdmin)
-- Baseado no Slide 16 do Guia CREATE TABLE
-- ============================================================

-- 1. Criar e selecionar o Banco de Dados
CREATE DATABASE IF NOT EXISTS escola;
USE escola;

-- 2. Limpar tabelas caso já existam (ordem respeitando as Chaves Estrangeiras)
DROP TABLE IF EXISTS matriculas;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS alunos;

-- 3. Criar Tabela: alunos
CREATE TABLE alunos (
  id_aluno INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  data_nascimento DATE,
  email VARCHAR(100) UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Criar Tabela: cursos
CREATE TABLE cursos (
  id_curso INT AUTO_INCREMENT PRIMARY KEY,
  nome_curso VARCHAR(100) NOT NULL,
  carga_horaria INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Criar Tabela: matriculas (Tabela Associativa N:M)
CREATE TABLE matriculas (
  id_aluno INT,
  id_curso INT,
  data_matricula DATE,
  PRIMARY KEY (id_aluno, id_curso),
  FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_curso) REFERENCES cursos(id_curso) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- INSERÇÃO DE DADOS DE TESTE (DML - INSERT)
-- ============================================================

-- Inserir Alunos
INSERT INTO alunos (nome, data_nascimento, email) VALUES
('Ana Silva', '2002-05-15', 'ana.silva@email.com'),
('Bruno Costa', '2000-11-20', 'bruno.costa@email.com'),
('Carla Souza', '2003-01-10', 'carla.souza@email.com');

-- Inserir Cursos
INSERT INTO cursos (nome_curso, carga_horaria) VALUES
('Banco de Dados SQL', 60),
('Programação PHP', 80),
('Desenvolvimento Web', 40);

-- Inserir Matrículas
INSERT INTO matriculas (id_aluno, id_curso, data_matricula) VALUES
(1, 1, '2026-02-01'), -- Ana matriculada em Banco de Dados SQL
(1, 2, '2026-02-02'), -- Ana matriculada em Programação PHP
(2, 1, '2026-02-01'), -- Bruno matriculado em Banco de Dados SQL
(3, 3, '2026-02-05'); -- Carla matriculada em Desenvolvimento Web

-- ============================================================
-- CONSULTAS DE VERIFICAÇÃO (DML - SELECT)
-- ============================================================

-- Listar todas as matrículas com os nomes dos alunos e cursos
SELECT 
    a.nome AS Aluno,
    c.nome_curso AS Curso,
    m.data_matricula AS Data_Matricula
FROM matriculas m
INNER JOIN alunos a ON m.id_aluno = a.id_aluno
INNER JOIN cursos c ON m.id_curso = c.id_curso;
