SELECT 
	rl.cdg_licenca,
    fc.Contrato as Contrato,
    tl.tipo_licenca as Tipo,
    o.sigla_orgao as Sigla,
    rl.num_licenca as "Número de licença",
    CASE
        WHEN rl.data_reprogramada IS NULL
        THEN rl.prazo_licenca
        ELSE rl.data_reprogramada
    END AS "Data Prevista"
FROM 
    dbo.AMB_REG_LICENCA rl
    LEFT JOIN AMB_CAD_TIPO_LICENCA tl ON rl.tipo_licenca = tl.cdg_tipo_licenca --Puxa o tipo de licenca
    LEFT JOIN AMB_CAD_ORGAO o ON tl.cdg_orgao = o.cdg_orgao -- Puxa o orgao
    LEFT JOIN FIN_Contratos fc ON rl.N_contrato = fc.Contrato -- Puxa o contrato
WHERE 
    rl.num_licenca IS NOT NULL
    AND rl.num_licenca <> ''
    AND rl.N_contrato NOT IN (
        'A licitar', 'TG-RS', 'TIC-RA', 'TIC-RB', 
        'TIC-RM', 'TIL-RN', 'TIN-RJ', 'TIN-RM', 
        'TIO-RV', 'TIP-RG'
    )
	AND o.sigla_orgao <> 'PM'