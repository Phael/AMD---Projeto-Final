USE master
GO

DROP DATABASE Consultorio
GO

CREATE DATABASE Consultorio 
ON PRIMARY
(
	NAME = Consultorio_DB,
	FILENAME = N'C:\Banco\DB\Consultorio_DB.mdf',
	SIZE = 25MB,
	MAXSIZE = UNLIMITED			
)
LOG ON
(
	NAME = Consultorio_Log,
	FILENAME = N'C:\Banco\Log\Consultorio_Log.ldf',
	SIZE = 10MB,
	MAXSIZE = 2048GB,
	FILEGROWTH = 5mb
)
GO

SP_HELPDB Consultorio
GO

CREATE TABLE tb_clinicas
(
	email varchar(50),
	cnpj varchar(25) NOT NULL,
	fax varchar(20),
	complemento varchar(50),
	endere�o varchar(50),
	id_clinica int identity PRIMARY KEY,
	cep varchar(15),
	telefone varchar(20),
	nome varchar(50) NOT NULL,
	bairro varchar(50),
	numero int,
	id_cidade int identity
)
GO

CREATE TABLE tb_funcionarios 
(
	id_funcionario int identity PRIMARY KEY,
	bairro varchar(50),
	cep varchar(15),
	endere�o varchar(20),
	telefone varchar(20),
	celular varchar(20),
	rg varchar(16) NOT NULL,
	nr varchar NOT NULL,
	nome varchar(50) NOT NULL,
	cpf varchar(16) NOT NULL,
	data_de_cadastro datetime NOT NULL,
	login varchar(15) NOT NULL,
	senha varchar(10) NOT NULL,
	id_cidade int identity,
	id_clinica int identity,
	id_cargo int identity,

	FOREIGN KEY(id_clinica) REFERENCES tb_clinicas (id_clinica)
)
GO

CREATE TABLE tb_estados 
(
	nome varchar(50) NOT NULL,
	id_uf int identity PRIMARY KEY
)
GO

CREATE TABLE tb_cidades 
(
	id_cidade int identity PRIMARY KEY,
	nome varchar(50) NOT NULL,
	id_uf int identity,
	
	FOREIGN KEY(id_uf) REFERENCES tb_estados (id_uf)
)
GO

CREATE TABLE  tb_locais_enc 
(
	observa��es varchar(80),
	nome_local varchar(80),
	cep varchar(15),
	bairro varchar(20),
	numero int,
	id_local_enc int identity PRIMARY KEY,
	endere�o varchar(50) NOT NULL,
	id_cidade int identity ,
	
	FOREIGN KEY(id_cidade) REFERENCES tb_cidades (id_cidade)
)
GO

CREATE TABLE tb_pacientes 
(
	id_paciente int identity PRIMARY KEY,
	numero int,
	cidade varchar(50),
	nome_pai varchar(50),
	endere�o varchar(50),
	rg varchar(15),
	nr_convenio varchar(30),
	nome_mae varchar(50),
	data_de_cadastro datetime,
	bairro varchar(50),
	celular varchar(20),
	Nome varchar(50),
	telefone varchar(20),
	cep varchar(12),
	cpf varchar(18),
	id_convenio int identity,
	id_cidade int identity,
	
	FOREIGN KEY(id_cidade) REFERENCES tb_cidades (id_cidade)
)
GO

CREATE TABLE tb_consultas 
(
	id_consulta int identity PRIMARY KEY,
	data_consulta datetime,
	horario datetime,
	id_paciente int identity,
	id_convenio int identity,
	id_medico int identity,
	
	FOREIGN KEY(id_paciente) REFERENCES tb_pacientes (id_paciente)
)
GO

CREATE TABLE tb_receitas 
(
	Observa��es varchar(80),
	data_receita datetime,
	id_receita int identity PRIMARY KEY,
	id_medico int identity,
	id_medicamento int identity
)
GO

CREATE TABLE tb_medicamentos 
(
	id_medicamento int identity PRIMARY KEY,
	generico varchar(50),
	nome_lab_produzido varchar(50),
	contra_indica��es varchar(50),
	nome varchar(50)
)
GO

CREATE TABLE tb_cargos 
(
	descri��o_do_cargo varchar(80),
	id_cargo int identity PRIMARY KEY,
	nome varchar(50)
)
GO

CREATE TABLE tb_convenios 
(
	id_convenio int identity PRIMARY KEY,
	nome_convenio varchar(50)
)
GO

CREATE TABLE tb_laudos 
(
	desc_laudo varchar(80),
	horario_laudo datetime,
	data_laudo datetime,
	id_laudo int identity PRIMARY KEY,
	id_paciente int identity,
	id_medico int identity,
	
	FOREIGN KEY(id_paciente) REFERENCES tb_pacientes (id_paciente)
)
GO

CREATE TABLE tb_medicos 
(
	id_medico int identity PRIMARY KEY,
	rg varchar(15),
	Login varchar(15),
	data_de_cadastro datetime,
	cep varchar(15),
	bairro varchar(50),
	endere�o varchar(50),
	telefone varchar(20),
	nome varchar(20),
	celular varchar(20),
	cpf varchar(18),
	numero int,
	Senha varchar(10),
	Especialidade varchar(50),
	email varchar(50),
	crm varchar(50),
	id_cidade int identity,
	
	FOREIGN KEY(id_cidade) REFERENCES tb_cidades (id_cidade)
)
GO

ALTER TABLE tb_clinicas ADD FOREIGN KEY(id_cidade) REFERENCES tb_cidades (id_cidade)
ALTER TABLE tb_funcionarios ADD FOREIGN KEY(id_cidade) REFERENCES tb_cidades (id_cidade)
ALTER TABLE tb_funcionarios ADD FOREIGN KEY(id_cargo) REFERENCES tb_cargos (id_cargo)
ALTER TABLE tb_pacientes ADD FOREIGN KEY(id_convenio) REFERENCES tb_convenios (id_convenio)
ALTER TABLE tb_consultas ADD FOREIGN KEY(id_convenio) REFERENCES tb_convenios (id_convenio)
ALTER TABLE tb_consultas ADD FOREIGN KEY(id_medico) REFERENCES tb_medicos (id_medico)
ALTER TABLE tb_receitas ADD FOREIGN KEY(id_medico) REFERENCES tb_medicos (id_medico)
ALTER TABLE tb_receitas ADD FOREIGN KEY(id_medicamento) REFERENCES tb_medicamentos (id_medicamento)
ALTER TABLE tb_laudos ADD FOREIGN KEY(id_medico) REFERENCES tb_medicos (id_medico)

