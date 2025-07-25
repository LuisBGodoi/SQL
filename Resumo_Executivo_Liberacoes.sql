SELECT 
	lib.cdg_liberacao,
	fc.Contrato,
	ag.abrev as Tipo, 
	Agente AS Sigla, 
	num_processo as "número liberação",
	CASE
        WHEN data_reprogramada IS NULL
        THEN data_prev_lib
        ELSE data_reprogramada
    END AS "Data Prevista",
	tl.tipo_impedimento as Responsavel,
	CASE
		WHEN fre.Descricao_frente IS NULL
		THEN num_processo
		ELSE fre.Descricao_frente
	END AS Frente
FROM 
	LIB_REG_Liberacao lib
	LEFT JOIN LIB_CAD_Agente ag ON lib.cdg_agente = ag.cdg_agente --Puxa o agente
	LEFT JOIN LIB_CAD_Tipo_Liberacao tl ON ag.cod_tipo = tl.cdg_access --Puxa o tipo de impedimento
	LEFT JOIN FIN_Contratos fc ON lib.num_contrato = fc.Contrato -- Puxa o contrato
	LEFT JOIN LIB_Liberacao_x_trecho libtre ON libtre.cdg_liberacao = lib.cdg_liberacao
	LEFT JOIN LIB_CAD_TRECHO tre ON tre.cdg_trecho = libtre.cdg_trecho
	LEFT JOIN LIB_CAD_FRENTE fre ON fre.cdg_frente = tre.cdg_frente
	WHERE 
	N_Licitacao IS NOT NULL 
	AND N_Licitacao <> ''
	AND Situacao_Contrato IN ('Em Execução','Suspenso')   
	AND lib_inativa = 0
    AND Coordenacao NOT IN ('Baixada','Localizadas 1', 'Localizadas 2')
	AND (data_reprogramada IS NOT NULL OR data_prev_lib IS NOT NULL)
	AND tipo_impedimento IN ('Dominial', 'Concessionária')


