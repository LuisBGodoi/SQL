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
	tl.tipo_impedimento as Responsavel
FROM 
	LIB_REG_Liberacao lib
	LEFT JOIN LIB_CAD_Agente ag ON lib.cdg_agente = ag.cdg_agente --Puxa o agente
	LEFT JOIN LIB_CAD_Tipo_Liberacao tl ON ag.cod_tipo = tl.cdg_access --Puxa o tipo de impedimento
	LEFT JOIN FIN_Contratos fc ON lib.num_contrato = fc.Contrato -- Puxa o contrato
	WHERE 
	N_Licitacao IS NOT NULL 
	AND N_Licitacao <> ''
	AND Situacao_Contrato IN ('Em Execução','Suspenso')   
	AND lib_inativa = 0
    AND Coordenacao NOT IN ('Baixada','Localizadas 1', 'Localizadas 2')


