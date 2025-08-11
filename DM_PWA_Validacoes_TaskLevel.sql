CREATE VIEW Qualidadedados_Opcoes
AS
SELECT 
    Contrato,
    ProjectName,
    TaskOutlineNumber,
    TaskName,
    TaskOutlineLevel,
    TaskName_Level_3,
    TaskName_Level_4,
    TaskName_Level_5,
    TaskName_Level_6,
    Disciplina,
    TipoLibera��o,
    CASE TaskOutlineLevel
        -- N�vel 2: Lista espec�fica
        WHEN 2 THEN
            CASE 
                WHEN TaskName IN (
                    'ASSINATURA CONTRATO', 
                    'ASSINATURA DO CONTRATO', 
                    'ENTREGA DA EAP',  
                    'ENTREGA DE EAP', 
                    'AS', 
                    'TRABALHO SOCIAL',
                    'VARREDURA', 
                    'Plano de Gest�o de Obras (PGO)', 
                    'ENCERRAMENTO DO CONTRATO',
                    'ENCERRAMENTO DE CONTRATO'
                ) THEN 'SIM' 
                ELSE 'N�O' 
            END
            
        -- N�vel 3: Lista espec�fica
        WHEN 3 THEN
            CASE 
                WHEN TaskName IN (
                    'ELABORA��O PGO', 
                    'RELAT�RIO MENSAL',
                    'ESTA��O ELEVAT�RIA DE ESGOTO', 
                    'LINHA DE RECALQUE', 
                    'COLETOR TRONCO',
                    'COLETOR TRONCO SECUND�RIO', 
                    'INTERLIGA��O', 
                    'REDE COLETORA DE ESGOTO',
                    'CONDUTO FOR�ADO', 
                    'EMISS�RIO', 
                    'INTERCEPTOR',
                    'ESTA��O DE TRATAMENTO DE ESGOTO'
                )
                OR TaskName LIKE 'RELAT�RIO MENSAL%'
                THEN 'SIM' 
                ELSE 'N�O' 
            END
            
        -- N�vel 4: Validado por diferen�a
        WHEN 4 THEN
            CASE 
                WHEN TaskName NOT IN (
                    'ELABORA��O PGO', 'RELAT�RIO MENSAL', 'ESTA��O ELEVAT�RIA DE ESGOTO', 
                    'LINHA DE RECALQUE', 'COLETOR TRONCO', 'COLETOR TRONCO SECUND�RIO', 
                    'INTERLIGA��O', 'REDE COLETORA DE ESGOTO', 'CONDUTO FOR�ADO', 
                    'EMISS�RIO', 'INTERCEPTOR', 'ESTA��O DE TRATAMENTO DE ESGOTO',
                    'Projeto Executivo', 'Libera��es', 'Obra', 'Opera��o', 'Imobiliza��o'
                ) AND TaskName IS NOT NULL
                THEN 'SIM' 
                ELSE 'N�O' 
            END
            
        -- N�vel 5: Lista espec�fica
        WHEN 5 THEN
            CASE 
                WHEN TaskName IN (
                    'Projeto Executivo', 
                    'Libera��es', 
                    'Obra', 
                    'Opera��o', 
                    'Imobiliza��o'
                ) THEN 'SIM' 
                ELSE 'N�O' 
            END
            
        -- N�vel 6: Valida��o baseada no TaskName_Level_5
        WHEN 6 THEN
            CASE 
                WHEN TaskName_Level_5 = 'Projeto Executivo' THEN
                    CASE 
                        WHEN TaskName IN ('Entrega', 'Aprova��o') 
                        THEN 'SIM' 
                        ELSE 'N�O' 
                    END
                
                WHEN TaskName_Level_5 = 'Libera��es' THEN
                    CASE 
                        WHEN TaskName IN ('Libera��es Ambientais', 'Libera��es Dominiais', 'Libera��es Concession�rias') 
                        THEN 'SIM' 
                        ELSE 'N�O' 
                    END
                
                WHEN TaskName_Level_5 = 'Obra' THEN
                CASE 
                    WHEN  TaskName_Level_3 = 'ESTA��O ELEVAT�RIA DE ESGOTO' THEN 
                        CASE
                            WHEN TaskName IN ('Fornecimento','Obra Civil', 'Montagem')
                            THEN 'SIM'
                        END
                        ELSE
                            CASE   
                                WHEN TaskName IN ('Execu��o', 'Pontos de lan�amento', 'Liga��es', 'Obra Civil') THEN 'SIM' 
                                ELSE 'N�O' 
                            END
                END
                WHEN TaskName_Level_5 = 'Imobiliza��o' THEN
                    CASE 
                        WHEN TaskName IN ('Documenta��o T�cnica', 'Lan�amento Signos', 'Atestado de cadastro t�cnico') 
                        THEN 'SIM' 
                        ELSE 'N�O' 
                    END
                
                WHEN TaskName_Level_5 = 'Opera��o' THEN 'N�O - Opera��o n�o deve ter n�vel 6'
                
                ELSE 'N�O - Pai n�o mapeado'
            END
            
        -- N�vel 7: Apenas para TaskName_Level_5 = 'Libera��es'
        WHEN 7 THEN
            CASE 
                WHEN TaskName_Level_5 = 'Libera��es' THEN
                    CASE 
                        -- Padr�o: Autoriza��o [xxx] ([yyy])
                        WHEN TaskName LIKE 'Autoriza��o [%] ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Concession�ria' THEN 'SIM'
                                ELSE 'N�O - Disciplina deve ser Concession�ria'
                            END
                        
                        -- Padr�o: Desapropria��o ([xxx])
                        WHEN TaskName LIKE 'Desapropria��o ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Dominial' AND TipoLibera��o = 'Desapropria��o' THEN 'SIM'
                                ELSE 'N�O - Disciplina deve ser Dominial e TipoLiberacao deve ser Desapropria��o'
                            END
                        
                        -- Padr�o: Libera��o de faixa (Fx [xxx] - [yyy])
                        WHEN TaskName LIKE 'Libera��o de faixa (Fx [%] - [%])' THEN
                            CASE 
                                WHEN Disciplina = 'Dominial' AND TipoLibera��o = 'Faixa de servi�o' THEN 'SIM'
                                ELSE 'N�O - Disciplina deve ser Dominial e TipoLiberacao deve ser Faixa de servi�o'
                            END
                        
                        -- Padr�o: LP/LI ([xxx])
                        WHEN TaskName LIKE 'LP/LI ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Ambiental' AND TipoLibera��o = 'LP/LI' THEN 'SIM'
                                ELSE 'N�O - Disciplina deve ser Ambiental e TipoLiberacao deve ser LP/LI'
                            END
                        
                        -- Padr�o: LPIO ([xxx])
                        WHEN TaskName LIKE 'LPIO ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Ambiental' AND TipoLibera��o = 'LPIO' THEN 'SIM'
                                ELSE 'N�O - Disciplina deve ser Ambiental e TipoLiberacao deve ser LPIO'
                            END
                        
                        -- Padr�o: Interven��o de APP ([xxx])
                        WHEN TaskName LIKE 'Interven��o de APP ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Ambiental' AND TipoLibera��o = 'APP' THEN 'SIM'
                                ELSE 'N�O - Disciplina deve ser Ambiental e TipoLiberacao deve ser APP'
                            END
                        
                        -- Padr�o: Supress�o de Vegeta��o ([xxx])
                        WHEN TaskName LIKE 'Supress�o de Vegeta��o ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Ambiental' AND TipoLibera��o = 'APP' THEN 'SIM'
                                ELSE 'N�O - Disciplina deve ser Ambiental e TipoLiberacao deve ser APP'
                            END
                        
                        -- TaskName n�o corresponde a nenhum padr�o v�lido
                        ELSE 'N�O - Padr�o de nome inv�lido'
                    END
                
                -- N�vel 7 s� � v�lido para Libera��es
                -- Se TaskName_Level_6 for 'Pontos de lan�amento' n�o pode ser 'PL%' -- S� funcionar se EconomiasPrevistas <> 0
                WHEN TaskName_Level_6 = 'Pontos de lan�amento' AND EconomiasPrevistas <> 0 THEN 'SIM'
                ELSE 'SIM - N�vel 7 s� � v�lidado para TaskName_Level_5 = Libera��es e TaskName_Level_6 = PL'
            END
            
        -- Outros n�veis n�o configurados
        ELSE 'N�VEL N�O CONFIGURADO'
    END AS Validacao
FROM tasks
WHERE 
    TaskOutlineLevel IN (1,2,3,4,5,6,7) AND
    NOT (TaskName_Level_3 = 'RELAT�RIO MENSAL' AND TaskName_Level_4 IS NOT NULL);