create database if not exists Hospital;

use Hospital;

create table if not exists especialidade(
	id_especialidade int(11) auto_increment primary key,
    nome_especialidade varchar(100)
);

create table if not exists convenio(
	id_convenio int(11) auto_increment primary key,
    nome_convenio varchar(100),
    cnpj_convenio varchar(14),
    tempo_carencia varchar(100)
);

CREATE TABLE IF NOT EXISTS medico(
	id_medico int(11) auto_increment primary key,
    nome_medico varchar(125) not null,
    cpf_medico int(15) unique not null,
    crm varchar(13)unique not null,
    email_medico varchar(100),
    cargo varchar(100) NOT NULL,
    especialidade_id INT NOT NULL,
    foreign key(especialidade_id) references especialidade (id_especialidade) on delete cascade on update cascade 
);

create table if not exists paciente(
	id_paciente int(11) auto_increment primary key,
    nome_paciente varchar(125) not null,
    dt_nasc_paciente date,
    cpf_paciente int(15) unique not null,
    rg_paciente varchar(11) not null,
    email_paciente varchar(100),
    convenio_id int(11) default null,
    foreign key(convenio_id) references convenio (id_convenio) on delete cascade on update cascade 
);

create table if not exists enfermeiro(
	id_enfermeiro int(11) auto_increment primary key,
    nome_enfermeiro varchar(125) not null,
    cpf_enfermeiro int(11) unique not null,
    cre varchar(13)unique not null
);

create table if not exists consulta(
	id_consulta int(11) auto_increment primary key,
    data_consulta date not null,
    hora_consulta time not null,
    valor_consulta decimal,
    convenio_id int(11) default null,
    medico_id int(11) not null,
    paciente_id int(11) not null,
    especialidade_id int(11) not null,
    foreign key(convenio_id) references convenio (id_convenio) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade,
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(especialidade_id) references especialidade (id_especialidade) on delete cascade on update cascade
);

create table if not exists receita(
	id_receita int(11) auto_increment primary key,
    medicamento varchar(200),
    qtd_medicamento int(11),
    instrucao_uso text(220),
    consulta_id int(11) not null,
    foreign key(consulta_id) references consulta (id_consulta) on delete cascade on update cascade
);

create table if not exists tipo_quarto(
	id_tipo int(11) auto_increment primary key,
    valor_diario decimal(8, 2) not null,
    desc_quarto varchar(100) default null
);

create table if not exists quarto(
	id_quarto int(11) auto_increment primary key,
    numero int(11) not null,
    tipo_id int(11) not null,
    foreign key(tipo_id) references tipo_quarto (id_tipo) on delete cascade on update cascade
);

create table if not exists internacao(
	id_internacao int(11) auto_increment primary key,
    data_entrada date not null,
    data_prev_alta date not null,
    data_efet_alta date not null,
    desc_procedimentos text,
    paciente_id int(11) not null,
    medico_id int(11) not null,
    quarto_id int(11) not null, 
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade,
    foreign key(quarto_id) references quarto (id_quarto) on delete cascade on update cascade
);

create table if not exists plantao(
	id_plantao int(11) auto_increment primary key,
    data_plantao date,
    hora_plantao time,
    internacao_id int(11) not null,
    enfermeiro_id int(11) not null,
    foreign key(internacao_id) references internacao (id_internacao) on delete cascade on update cascade,
    foreign key(enfermeiro_id) references enfermeiro (id_enfermeiro) on delete cascade on update cascade
);

create table if not exists endereco(
	id_endereco int(11) auto_increment primary key,
    logradouro varchar(100) not null,
    cep int(8)not null,
    bairro varchar(100) not null,
    cidade varchar(100)not null,
    estado varchar(100)not null,
    medico_id int(11) default null,
    paciente_id int(11) default null,
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade
);

create table if not exists telefone(
	id_telefone int(11) auto_increment primary key,
    ddd int(3) not null,
    numero int(9) not null,
    medico_id int(11) default null,
    paciente_id int(11) default null,
    foreign key(paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
    foreign key(medico_id) references medico (id_medico) on delete cascade on update cascade
);

-- Inserindo dados na tabela Convenio
--
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(1, 'Alice', '9852143614751', '30 dias');
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(2, 'Unimed', '47810596327845', '24 horas');
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(3, 'Cuidar', '36149520784195', '24 das');
insert into convenio(id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) values(4, 'MaisSaude', '29814536710254', '180 dias');


-- Inserindo dados na tabela Especialidade
--
insert into especialidade(id_especialidade, nome_especialidade) values(1, 'Pediatria');
insert into especialidade(id_especialidade, nome_especialidade) values(2, 'Clínica');
insert into especialidade(id_especialidade, nome_especialidade) values(3, 'Gastroenterologia');
insert into especialidade(id_especialidade, nome_especialidade) values(4, 'Dermatologia');
insert into especialidade(id_especialidade, nome_especialidade) values(5, 'Cardiologia');
insert into especialidade(id_especialidade, nome_especialidade) values(6, 'Neurologia');
insert into especialidade(id_especialidade, nome_especialidade) values(7, 'Ortopedia');


-- Inserindo dados na tabela Tipo de quarto
--
insert into tipo_quarto(id_tipo, valor_diario, desc_quarto) values(1, '1000.00', 'Apartamento');
insert into tipo_quarto(id_tipo, valor_diario, desc_quarto) values(2, '700.00', 'Quartos duplos');
insert into tipo_quarto(id_tipo, valor_diario, desc_quarto) values(3, '500.00', 'Enfermaria');


-- Inserindo dados na tabela Medico
--
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(1, 'Miguel Borges', 1472581234, 745896, 'miguelborges@gmail.com', 'Residente', 6); 
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(2, 'Heitor Felix', '74126956', '123789', 'heitorfelix@gmail.com', 'Residente', 7);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(3, 'Raphael Pinheiros de Azevedo', '78531045', '569745', 'raphael.azevedo@gmail.com', 'Interno', 1);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(4, 'Cristina Gouvea da Silva', '47965816', '459781', 'cristinagouvea@gmail.com', 'Residente', 5);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(5, 'Carlos Monteiro de Sousa', '14736985', '123780', 'cralosmonteiro@hotmail.com', 'Especialista', 6);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(6, 'Izabel Stevens', '36407814', '014698', 'izabelstevens@gmail.com', 'Residente', 2);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(7, 'David de Oliveira Machado', '12047896', '814362', 'davidmachado@gmail.com', 'Interno', 3);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(8, 'Vitor Santos dos Anjos', '47158296', '654782', 'vitor.anjos@gmail.com', 'Especialista', 1);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(9, 'Miranda Chagas Nascimento', '47915768', '487127', 'mirandaChagas@gmail.com', 'Especialista', 2);
insert into medico(id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id) values(10, 'Eduardo Reis de Carvalho', '78469512', '147548', 'miguelreis@gmail.com', 'Residente', 4);


-- Inserindo dados na tabela Paciente
--
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(1, 'Aline Dias de Sousa', '1994-08-21', '74951847', '1462085-x', 'aline.dias02@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(2, 'Maria Eduarda Silva', '1970-08-21', '87165493', '1459870', 'eduarda.silva123@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(3, 'Lucio Franco dos Santos', '200-01-11', '19874623', '3278451', 'franco.lucio@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(4, 'Flavio Conceição dos Santos', '1997-12-03', '65982365', '8541795', 'flaviosantos457@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(5, 'José Fernando de Melo', '2002-05-04', '14785296', '2684197', 'josefernando@gmail.com', 3);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(6, 'Jackeline Costa', '1985-02-25', '65987436', '145987-x', 'jackelinecosta@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(7, 'Daniela Alves da Silva', '1988-09-01', '65983063', '74859615', 'dani.alves@gmail.com', 2);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(8, 'Ruan Santiago', '2004-10-16', '85964723', '4569874', 'santiago43@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(9, 'Leandro Ferreira', '1970-01-30', '36985269', '25647891', 'leandro.ferreira@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(10, 'Gabriela Alcantra da Souza', '1999-07-12', '36502178', '12097452', 'gabriela.souza@gmail.com', 2);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(11, 'Caio Xavier', '2002-06-23', '03269856', '69812045', 'xavier57@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(12, 'João Gabriel Pereira ', '1985-12-23', '63025789', '3265471', 'gabrielpereira@gmail.com', 1);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(13, 'Ana Lúcia de Almeida', '1991-07-03', '85479623', '2436598', 'analucia@gmail.com', 4);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(14, 'Michael Guedes de Oliveira', '2001-03-29', '25316489', '25419876', 'michaelguedes@gmail.com', null);
insert into paciente(id_paciente, nome_paciente, dt_nasc_paciente, cpf_paciente, rg_paciente, email_paciente, convenio_id) values(15, 'Viviane Lima de Andrade', '1996-04-15', '56784985', '73564189', 'vivianelima@gmail.com', 3);


-- Inserindo dados na tabela Telefone
--
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(1, 11, 40028922, 1, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(2, 11, 40089655, 2, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(3, 11, 75589644, 3, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(4, 11, 41587622, 4, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(5, 11, 46685711, 5, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(6, 11, 40028922, 6, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(7, 11, 74851987, 7, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(8, 11, 58749684, 8, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(9, 11, 41879655, 9, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(10, 11, 14487522, 10, null);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(11, 11, 985632001, null, 1);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(12, 11, 998654789, null, 2);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(13, 11, 987569856, null, 3);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(14, 11, 987654021, null, 4);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(15, 11, 958620347, null, 5);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(16, 11, 985314758, null, 6);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(17, 11, 987654259, null, 7);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(18, 11, 974851471, null, 8);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(19, 11, 914032569, null, 9);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(20, 11, 963266587, null, 10);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(21, 11, 941178546, null, 11);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(22, 11, 985864127, null, 12);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(23, 11, 963568891, null, 13);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(24, 11, 987475812, null, 14);
insert into telefone(id_telefone, ddd, numero, medico_id, paciente_id) values(25, 11, 987745876, null, 15);


-- Inserindo dados na tabela Endereco
--
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(1, 'Rua Cardeal Arcoverde', 05407-003, 'Pinheiros', 'São Paulo', 'São Paulo', null, 1);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(2, 'R. Jesuíno Arruda', 04532-082, 'Itaim Bibi', 'São Paulo', 'São Paulo', null, 2);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(3, 'Rua Romano Schiesari', 05018-020, 'Sumaré', 'São Paulo', 'São Paulo', null, 3);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(4, 'R. da Consolação',  3325-3181 , 'Cerqueira César', 'São Paulo', 'São Paulo', 1, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(5, 'R. São Joaquim', 01508-001, 'Liberdade', 'São Paulo', 'São Paulo', 2, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(6, 'R. Batataes', 01423-010, 'Jardim Paulista', 'São Paulo', 'São Paulo', 3, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(7, 'R. Abílio Soares', 04005-001, 'Paraíso', 'São Paulo', 'São Paulo', 4, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(8, 'R. Alvarenga', 05509-001, 'Butatã', 'São Paulo', 'São Paulo', 5, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(9, 'R. Gago Coutinho', 02577-020, 'Vila Yara', 'Osasco', 'São Paulo', 6, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(10, 'R. Froben', 05315-010, 'Vila Leopoldina', 'São Paulo', 'São Paulo', 7, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(11, 'R. Mipibu', 05049-030, 'Vila Romana', 'São Paulo', 'São Paulo', null, 8);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(12, 'R. Conselheiro Ramalho', 01325-001, 'Bela Vista', 'São Paulo', 'São Paulo', null, 9);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(13, 'Av. Tiradentes', 16400-050, 'Jardim Santa Edwirges', 'Guarulhos', 'São Paulo', null, 10);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(14, 'R. Damianopolis', 07070-111, 'Vila Galvão', 'Guarulhos', 'São Paulo', 8, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(15, 'R. Ismael Neri', 02335-001, 'Água Fria', 'São Paulo', 'São Paulo', 9, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(16, 'Av. Joaquina Ramalho', 02065-010, 'Vila Guilherme', 'São Paulo', 'São Paulo', 10, null);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(17, 'R. Dias da Silva', 02114-001, 'Vila Maria', 'São Paulo', 'São Paulo', null, 4);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(18, 'Av. Pedroso da Silveira', 03028-050, 'Pari', 'São Paulo', 'São Paulo', null, 5);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(19, 'R. Maria Joaquina', 03016-010, 'Brás', 'São Paulo', 'São Paulo', null, 6);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(20, 'R. da Graça', 0659-511, 'Bom Retiro', 'São Paulo', 'São Paulo', null, 7);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(21, 'R. Brg. Galvão', 01154-000, 'Barra Funda', 'São Paulo', 'São Paulo', null, 11);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(22, 'R. Dom Bento pickel', 02555-000, 'Casa Verde Alta', 'São Paulo', 'São Paulo', null, 12);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(23, 'Av. Lasar Segall', 02543-010, 'Vila Celeste', 'São Paulo', 'São Paulo', null, 13);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(24, 'Av. Imirim', 02464-600, 'Imirim', 'São Paulo', 'São Paulo', null, 14);
insert into endereco(id_endereco, logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values(25, 'R. Maria do Carmo', 03206-010, 'Vila Alpina', 'São Paulo', 'São Paulo', null, 15);


-- Inserindo dados na tabela Enfermeiro
--
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(1, 'Stephanie Sousa', 74851574, '415879');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(2, 'Josué Armandes', 58749617, '254109');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(3, 'Angelo Domingues', 78032145, '012478');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(4, 'Bruna de Araujo', 10479547, '960124');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(5, 'Angelo Domingues', 87459612, '784169');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(6, 'Joaquim Afonso de Sousa', 20147896, '894175');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(7, 'Priscila de Almeida', 12047953, '784196');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(8, 'Douglas Silva', 2143608, '254987');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(9, 'Pedro Augusto', 74198569, '120478');
insert into enfermeiro(id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) values(10, 'Angelina do Anjos', 88742514, '251369');


-- Inserindo dados na tabela Consulta
--
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(1, '2015-01-01', '13:40:00', '200.00', 3, 10, 5, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(2, '2017-08-29', '08:00:00', '150.00', 4, 7, 13, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(3, '2015-10-03', '12:30:00', '200.00', 1, 9, 4, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(4, '2018-02-10', '09:30:00', '230.00', 1, 7, 12, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(5, '2018-02-10', '11:00:00', '200.00', 4, 4, 11, 5);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(6, '2020-01-30', '18:00:00', '250.00', 1, 9, 4, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(7, '2021-06-13', '15:30:00', '200.00', null, 7, 1, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(8, '2022-01-01', '14:30:00', '200.00', null, 10, 3, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(9, '2018-07-14', '08:30:00', '250.00', null, 7, 14, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(10, '2019-05-08', '18:00:00', '250.00', null, 6, 14, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(11, '2019-11-16', '08:45:00', '250.00', 4, 4, 13, 5);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(12, '2016-12-07', '15:00:00', '200.00', 4, 9, 11, 2);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(13, '2018-11-12', '09:30:00', '250.00', 3, 7, 5, 3);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(14, '2021-02-20', '12:15:00', '250.00', null, 10, 3, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(15, '2021-02-20', '12:15:00', '250.00', null, 10, 3, 4);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(16, '2021-02-20', '12:15:00', '250.00', 1, 10, 2, 6);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(17, '2017-08-22', '14:15:00', '200.00', 1, 1, 6, 6);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(18, '2022-01-01', '08:45:00', '200.00', 2, 2, 7, 7);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(19, '2019-02-15', '17:00:00', '250.00', null, 8, 8, 1);
insert into consulta(id_consulta, data_consulta, hora_consulta, valor_consulta, convenio_id, medico_id, paciente_id, especialidade_id) values(20, '2021-11-29', '11:20:00', '200.00', null, 5, 9, 6);


-- Inserindo dados na tabela Receita
--
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(2, 'Roacutan, Pycnogenol', '2', 'Tomar um comprimido de roacutan uma vez ao dia. Tomar um comprimido de Pycnogenol uma vez ao dia', 1);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(11, 'Omeprazol e Ibuprofeno', '2', 'Tomar 1 vez ao dia de manhã, durante 4 semanas. Tomar 1 comprimido de ibuprofene a cada 4 horas.', 2);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(1, 'Dipirona 1g', '1', 'Tomar um comprimido a cada 6 horas. Não tomar mais de 4 comprimidos no dia', 3);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(3, 'Omeprazol, Dipirona', '2', 'Tomar 1 comprimido de omeprazol uma vez ao dia de manhã, durante 4 semanas. Tomar um comprimido de dipirona a cada 6 horas. Não tomar mais de 4 comprimidos no dia', 4);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(4, 'Dipirona, Ibuprofeno, Seki Xarope ', '3', 'Tomar um comprimido de dipirona a cada 6 horas. Não tomar mais de 4 comprimidos no dia, Tomar 1 comprimido de ibuprofene a cada 4 horas. Tomar o xarope se houver tosse', 5);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(5, 'Diurético, Metoprolol', '2', 'Tomar 2 comprimidos de Diurético de 50 mg + 50 mg por dia. Tomar o Metoprolol uma vez ao dia', 6);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(6, 'Omeprazol e Ibuprofeno', '2', 'Tomar 1 vez ao dia de manhã, durante 4 semanas. Tomar 1 comprimido de ibuprofene a cada 4 horas.', 7);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(7, 'Roacutan, Pycnogenol', '2', 'Tomar um comprimido de roacutan uma vez ao dia. Tomar um comprimido de Pycnogenol uma vez ao dia', 8);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(8, 'Omeprazol, Dipirona', '2', 'Tomar 1 comprimido de omeprazol uma vez ao dia de manhã, durante 4 semanas. Tomar um comprimido de dipirona a cada 6 horas. Não tomar mais de 4 comprimidos no dia', 9);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(9, 'Dipirona, Ibuprofeno', '2', 'Tomar um comprimido de dipirona a cada 6 horas. Não tomar mais de 4 comprimidos no dia, Tomar 1 comprimido de ibuprofene a cada 4 horas. Tomar o xarope se houver tosse', 10);
insert into receita(id_receita, medicamento, qtd_medicamento,instrucao_uso, consulta_id) values(10, 'Diurético, Metoprolol', '2', 'Tomar 2 comprimidos de Diurético de 50 mg + 50 mg por dia. Tomar o Metoprolol uma vez ao dia', 11);


-- Inserindo dados na tabela Quarto
--
insert into quarto(id_quarto, numero, tipo_id) values(1, 02, 1);
insert into quarto(id_quarto, numero, tipo_id) values(2, 03, 2);
insert into quarto(id_quarto, numero, tipo_id) values(3, 04, 3);
insert into quarto(id_quarto, numero, tipo_id) values(4, 05, 3);
insert into quarto(id_quarto, numero, tipo_id) values(5, 10, 1);


-- Inserindo dados na tabela Internacao
--
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (1, '2015-01-01', '2015-01-15', '2015-01-15', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make', 8, 5, 2);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (2, '2020-05-21', '2020-05-29', '2020-05-25', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make', 1, 10, 5);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (3, '2016-08-18', '2016-08-30', '2016-08-26', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make', 8, 5, 2);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (4, '2018-07-02', '2018-07-10', '2018-07-15', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make', 15, 3, 1);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (5, '2022-01-01', '2022-01-05', '2022-01-04', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make', 1, 6, 3);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (6, '2019-02-22', '2019-02-27', '2019-02-27', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make', 7, 9, 4);
insert into internacao(id_internacao, data_entrada, data_prev_alta, data_efet_alta, desc_procedimentos, paciente_id, medico_id, quarto_id) values (7, '2020-03-14', '2020-03-20', '2020-03-19', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make', 13, 8,5);


-- Inserindo dados na tabela Plantão
--
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (1, '2015-01-01', '05:00:00', 1, 2);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (2, '2015-01-01', '18:00:00', 1, 7);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (3, '2020-05-21', '10:00:00', 2, 8);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (4, '2016-08-18', '18:30:00', 3, 5);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (5, '2016-08-19', '06:00:00', 3, 1);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (6, '2018-07-02', '08:40:00', 4, 9);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (7, '2018-07-02', '22:00:00', 4, 7);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (8, '2022-01-01', '15:00:00', 5, 6);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (9, '2022-01-02', '05:00:00', 5, 3);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (10, '2020-05-21', '20:00:00', 2, 3);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (11, '2019-02-22', '23:30:00', 6, 4);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (12, '2019-02-23', '10:00:00', 6, 8);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (13, '2020-02-22', '09:00:00', 7, 3);
insert into plantao(id_plantao, data_plantao, hora_plantao, internacao_id, enfermeiro_id) values (14, '2020-02-22', '20:30:00', 7, 1);


-- Adicionando mais uma coluna 'em_atividade' na tabela medico
--
alter table medico add em_atividade varchar(100);

update medico set em_atividade = 'Ativo' where id_medico = 1;
update medico set em_atividade = 'Inativo' where id_medico = 2;
update medico set em_atividade = 'Ativo' where id_medico = 3;
update medico set em_atividade = 'Ativo' where id_medico = 4;
update medico set em_atividade = 'Ativo' where id_medico = 5;
update medico set em_atividade = 'Inativo' where id_medico = 6;
update medico set em_atividade = 'Ativo' where id_medico = 7;
update medico set em_atividade = 'Ativo' where id_medico = 8;
update medico set em_atividade = 'Ativo' where id_medico = 9;
update medico set em_atividade = 'Ativo' where id_medico = 10;


-- Consultando o banco
--

-- 1 
select *, AVG(valor_consulta) from consulta group by year(data_consulta) = 2020 having convenio_id;


-- 2 
select * from internacao where data_efet_alta > data_prev_alta;


-- 3 
select * from consulta inner join receita on consulta.id_consulta = receita.consulta_id inner join paciente 
on paciente.id_paciente = consulta.paciente_id 
order by receita.id_receita limit 1;


-- 4 
select *, MAX(valor_consulta), MIN(valor_consulta) from consulta group by convenio_id is null;


-- 5 
select *, DATEDIFF(data_efet_alta, data_entrada) dias_internado, tipo_quarto.valor_diario, DATEDIFF(data_efet_alta, data_entrada) * tipo_quarto.valor_diario valor_total from internacao inner join quarto 
on internacao.quarto_id = quarto.id_quarto inner join tipo_quarto 
on quarto.tipo_id = tipo_quarto.id_tipo;


-- 6 
select i.id_internacao, i.data_entrada, i.desc_procedimentos, q.numero from internacao i inner join quarto q 
on q.id_quarto = i.quarto_id where q.tipo_id = 1; 


-- 7 
select p.nome_paciente, c.data_consulta, e.nome_especialidade from consulta c inner join paciente p 
on p.id_paciente = c.paciente_id inner join especialidade e 
on e.id_especialidade = c.especialidade_id 
where c.especialidade_id <> 1 and year(c.data_consulta) - year(p.dt_nasc_paciente) < 19 and year(c.data_consulta) - year(p.dt_nasc_paciente) > 0 
order by c.data_consulta ;


-- 8 não vai
select p.nome_paciente, m.nome_medico, i.data_entrada, i.desc_procedimentos, q.id_quarto
from internacao i
inner join medico m 
on m.id_medico = i.medico_id
inner join paciente p
on p.id_paciente = i.paciente_id
inner join quarto q
on q.id_quarto = i.quarto_id
where q.tipo_id = 3 and m.especialidade_id = 3;


-- 9 
select m.nome_medico, m.crm, count(c.medico_id) as 'Qntd de consultas' from medico m inner join consulta c 
on c.medico_id = m.id_medico group by c.medico_id;


-- 10 
insert into medico(nome_medico, cpf_medico, crm, email_medico, cargo, especialidade_id, em_atividade) values('Gabriel Augusto', 45679312, 123456, 'gabriel.augusto@gmail.com', 'Especialista', 3, 'Ativo');
insert into endereco(logradouro, cep, bairro, cidade, estado, medico_id, paciente_id) values('R. Itapiru', 04143-010, 'Vila da Saúde', 'São Paulo', 'São Paulo', 11, null);
insert into telefone(ddd, numero, medico_id, paciente_id) values(11, 943658977, 11, null);

select * from medico where nome_medico like '%Gabriel%';


-- 11 
select enf.nome_enfermeiro, enf.cre, COUNT(p.enfermeiro_id) as Participacao from enfermeiro enf
inner join plantao p on p.enfermeiro_id = enf.id_enfermeiro group by enf.id_enfermeiro having Participacao > 1;

