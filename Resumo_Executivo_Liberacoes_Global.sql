WITH LicencasAmbientais AS (
    SELECT 
        rl.cdg_licenca AS cdg,
        fc.Contrato,
        tl.Sigla AS Sigla,
        CASE
            WHEN rl.data_reprogramada IS NULL
            THEN rl.prazo_licenca
            ELSE rl.data_reprogramada
        END AS "Data Prevista",
        fr.Descricao_Frente AS Frente,
        'Ambiental' AS Responsavel
    FROM 
        dbo.AMB_REG_LICENCA rl
        LEFT JOIN AMB_CAD_TIPO_LICENCA tl ON rl.tipo_licenca = tl.cdg_tipo_licenca
        LEFT JOIN AMB_CAD_ORGAO o ON tl.cdg_orgao = o.cdg_orgao
        LEFT JOIN FIN_Contratos fc ON rl.N_contrato = fc.Contrato
        LEFT JOIN AMB_VINC_LIC_FRENTE vf ON vf.cdg_licenca = rl.cdg_licenca
        LEFT JOIN LIB_CAD_Frente fr ON fr.Cdg_frente = vf.cdg_frente_vinc
    WHERE 
        rl.N_contrato NOT IN (
            'A licitar', 'TG-RS', 'TIC-RA', 'TIC-RB', 
            'TIC-RM', 'TIL-RN', 'TIN-RJ', 'TIN-RM', 
            'TIO-RV', 'TIP-RG'
        )
        AND o.sigla_orgao <> 'PM'
        AND N_Licitacao IS NOT NULL 
        AND N_Licitacao <> ''
        AND Coordenacao NOT IN ('Baixada','Localizadas 1', 'Localizadas 2')
        AND (data_reprogramada IS NOT NULL OR prazo_licenca IS NOT NULL)
),

Liberacoes AS (
    SELECT 
        lib.cdg_liberacao AS cdg,
        fc.Contrato,
        Agente AS Sigla, 
        CASE
            WHEN data_reprogramada IS NULL
            THEN data_prev_lib
            ELSE data_reprogramada
        END AS "Data Prevista",
        CASE
            WHEN fre.Descricao_frente IS NULL
            THEN num_processo
            ELSE fre.Descricao_frente
        END AS Frente,
        tl.tipo_impedimento AS Responsavel
    FROM 
        LIB_REG_Liberacao lib
        LEFT JOIN LIB_CAD_Agente ag ON lib.cdg_agente = ag.cdg_agente
        LEFT JOIN LIB_CAD_Tipo_Liberacao tl ON ag.cod_tipo = tl.cdg_access
        LEFT JOIN FIN_Contratos fc ON lib.num_contrato = fc.Contrato
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
)

SELECT 
    cdg,
    Contrato,
    REPLACE(Sigla, 'Concessionária - ', '') AS Tipo_Detalhe,
    "Data Prevista" AS 'Data Limite',
    Frente AS "Nome da Tarefa",
    Responsavel AS "Tipo de Liberação (grupos)"
FROM LicencasAmbientais

UNION ALL

SELECT 
    cdg,
    Contrato,
    REPLACE(Sigla, 'Concessionária - ', '') AS Tipo_Detalhe,
    "Data Prevista" AS 'Data Limite',
    Frente AS "Nome da Tarefa",
    Responsavel AS "Tipo de Liberação (grupos)"
FROM Liberacoes

ORDER BY Contrato, 'Data Limite';