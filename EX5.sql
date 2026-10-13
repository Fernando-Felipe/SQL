CREATE TABLE Depto (
    CodDepto   CHAR(5)      NOT NULL,
    NomeDepto  VARCHAR(40)  NOT NULL,
    CONSTRAINT pk_depto PRIMARY KEY (CodDepto)
);
 
CREATE TABLE Titulacao (
    CodTit   INTEGER      NOT NULL,
    NomeTit  VARCHAR(40)  NOT NULL,
    CONSTRAINT pk_titulacao PRIMARY KEY (CodTit)
);
 
CREATE TABLE Predio (
    CodPred   INTEGER      NOT NULL,
    NomePred  VARCHAR(40)  NOT NULL,
    CONSTRAINT pk_predio PRIMARY KEY (CodPred)
);

-----------------------------
CREATE TABLE Disciplina (
    CodDepto     CHAR(5)      NOT NULL,
    NumDisc      INTEGER      NOT NULL,
    NomeDisc     VARCHAR(10)  NOT NULL,
    CreditoDisc  INTEGER      NOT NULL,
    CONSTRAINT pk_disciplina PRIMARY KEY (CodDepto, NumDisc),
    CONSTRAINT fk_discipli_relation_depto
        FOREIGN KEY (CodDepto) REFERENCES Depto (CodDepto)
);
 

CREATE TABLE PreReq (
    CodDepto        CHAR(5)  NOT NULL,
    NumDisc         INTEGER  NOT NULL,
    CodDeptoPreReq  CHAR(5)  NOT NULL,
    NumDiscPreReq   INTEGER  NOT NULL,
    CONSTRAINT pk_prereq
        PRIMARY KEY (CodDepto, NumDisc, CodDeptoPreReq, NumDiscPreReq),
    CONSTRAINT fk_prereq_tem_pre_discipli
        FOREIGN KEY (CodDepto, NumDisc)
        REFERENCES Disciplina (CodDepto, NumDisc),
    CONSTRAINT fk_prereq_eh_pre_discipli
        FOREIGN KEY (CodDeptoPreReq, NumDiscPreReq)
        REFERENCES Disciplina (CodDepto, NumDisc),
		
    CONSTRAINT ck_prereq_nao_recursivo
        CHECK (CodDepto <> CodDeptoPreReq OR NumDisc <> NumDiscPreReq)
);

CREATE TABLE Professor (
    CodProf    INTEGER      NOT NULL,
    CodDepto   CHAR(5)      NOT NULL,
    CodTit     INTEGER      NOT NULL,
    NomeProf   VARCHAR(40)  NOT NULL,
    CONSTRAINT pk_professor PRIMARY KEY (CodProf),
    CONSTRAINT fk_professor_relation_depto
        FOREIGN KEY (CodDepto) REFERENCES Depto (CodDepto),
    CONSTRAINT fk_professor_relation_titulacao
        FOREIGN KEY (CodTit) REFERENCES Titulacao (CodTit)
);


CREATE TABLE Sala (
    CodPred        INTEGER      NOT NULL,
    NumSala        INTEGER      NOT NULL,
    DescricaoSala  VARCHAR(40),
    CapacSala      INTEGER      NOT NULL,
    CONSTRAINT pk_sala PRIMARY KEY (CodPred, NumSala),
    CONSTRAINT fk_sala_relation_predio
        FOREIGN KEY (CodPred) REFERENCES Predio (CodPred)
);

CREATE TABLE Turma (
    AnoSem     INTEGER  NOT NULL,
    CodDepto   CHAR(5)  NOT NULL,
    NumDisc    INTEGER  NOT NULL,
    SiglaTur   CHAR(2)  NOT NULL,
    CapacTur   INTEGER  NOT NULL,
    CONSTRAINT pk_turma PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTur),
    CONSTRAINT fk_turma_relation_discipli
        FOREIGN KEY (CodDepto, NumDisc)
        REFERENCES Disciplina (CodDepto, NumDisc),
    CONSTRAINT ck_turma_anosem_formato
        CHECK (AnoSem BETWEEN 19000 AND 99999 AND AnoSem % 10 IN (1, 2))
);

CREATE TABLE Horario (
    AnoSem       INTEGER  NOT NULL,
    CodDepto     CHAR(5)  NOT NULL,
    NumDisc      INTEGER  NOT NULL,
    SiglaTur     CHAR(2)  NOT NULL,
    DiaSem       INTEGER  NOT NULL,
    HoraInicio   INTEGER  NOT NULL,
    NumSala      INTEGER  NOT NULL,
    CodPred      INTEGER  NOT NULL,
    NumHoras     INTEGER  NOT NULL,
    CONSTRAINT pk_horario
        PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio),
    CONSTRAINT fk_horario_relation_turma
        FOREIGN KEY (AnoSem, CodDepto, NumDisc, SiglaTur)
        REFERENCES Turma (AnoSem, CodDepto, NumDisc, SiglaTur),
    CONSTRAINT fk_horario_relation_sala
        FOREIGN KEY (CodPred, NumSala)
        REFERENCES Sala (CodPred, NumSala),
    CONSTRAINT ck_horario_diasem
        CHECK (DiaSem BETWEEN 1 AND 7)
);

CREATE TABLE ProfTurma (
    AnoSem    INTEGER  NOT NULL,
    CodDepto  CHAR(5)  NOT NULL,
    NumDisc   INTEGER  NOT NULL,
    SiglaTur  CHAR(2)  NOT NULL,
    CodProf   INTEGER  NOT NULL,
    CONSTRAINT pk_profturma
        PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf),
    CONSTRAINT fk_profturm_profturma_turma
        FOREIGN KEY (AnoSem, CodDepto, NumDisc, SiglaTur)
        REFERENCES Turma (AnoSem, CodDepto, NumDisc, SiglaTur),
    CONSTRAINT fk_profturm_profturma_professor
        FOREIGN KEY (CodProf) REFERENCES Professor (CodProf)
);
