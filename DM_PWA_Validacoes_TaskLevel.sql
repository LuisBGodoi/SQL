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
    TipoLiberação,
    CASE TaskOutlineLevel
        -- Nível 2: Lista específica
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
                    'Plano de Gestão de Obras (PGO)', 
                    'ENCERRAMENTO DO CONTRATO',
                    'ENCERRAMENTO DE CONTRATO'
                ) THEN 'SIM' 
                ELSE 'NÃO' 
            END
            
        -- Nível 3: Lista específica
        WHEN 3 THEN
            CASE 
                WHEN TaskName IN (
                    'ELABORAÇÃO PGO', 
                    'RELATÓRIO MENSAL',
                    'ESTAÇÃO ELEVATÓRIA DE ESGOTO', 
                    'LINHA DE RECALQUE', 
                    'COLETOR TRONCO',
                    'COLETOR TRONCO SECUNDÁRIO', 
                    'INTERLIGAÇÃO', 
                    'REDE COLETORA DE ESGOTO',
                    'CONDUTO FORÇADO', 
                    'EMISSÁRIO', 
                    'INTERCEPTOR',
                    'ESTAÇÃO DE TRATAMENTO DE ESGOTO'
                )
                OR TaskName LIKE 'RELATÓRIO MENSAL%'
                THEN 'SIM' 
                ELSE 'NÃO' 
            END
            
        -- Nível 4: Validado por diferença
        WHEN 4 THEN
            CASE 
                WHEN TaskName NOT IN (
                    'ELABORAÇÃO PGO', 'RELATÓRIO MENSAL', 'ESTAÇÃO ELEVATÓRIA DE ESGOTO', 
                    'LINHA DE RECALQUE', 'COLETOR TRONCO', 'COLETOR TRONCO SECUNDÁRIO', 
                    'INTERLIGAÇÃO', 'REDE COLETORA DE ESGOTO', 'CONDUTO FORÇADO', 
                    'EMISSÁRIO', 'INTERCEPTOR', 'ESTAÇÃO DE TRATAMENTO DE ESGOTO',
                    'Projeto Executivo', 'Liberações', 'Obra', 'Operação', 'Imobilização'
                ) AND TaskName IS NOT NULL
                THEN 'SIM' 
                ELSE 'NÃO' 
            END
            
        -- Nível 5: Lista específica
        WHEN 5 THEN
            CASE 
                WHEN TaskName IN (
                    'Projeto Executivo', 
                    'Liberações', 
                    'Obra', 
                    'Operação', 
                    'Imobilização'
                ) THEN 'SIM' 
                ELSE 'NÃO' 
            END
            
        -- Nível 6: Validação baseada no TaskName_Level_5
        WHEN 6 THEN
            CASE 
                WHEN TaskName_Level_5 = 'Projeto Executivo' THEN
                    CASE 
                        WHEN TaskName IN ('Entrega', 'Aprovação') 
                        THEN 'SIM' 
                        ELSE 'NÃO' 
                    END
                
                WHEN TaskName_Level_5 = 'Liberações' THEN
                    CASE 
                        WHEN TaskName IN ('Liberações Ambientais', 'Liberações Dominiais', 'Liberações Concessionárias') 
                        THEN 'SIM' 
                        ELSE 'NÃO' 
                    END
                
                WHEN TaskName_Level_5 = 'Obra' THEN
                CASE 
                    WHEN  TaskName_Level_3 = 'ESTAÇÃO ELEVATÓRIA DE ESGOTO' THEN 
                        CASE
                            WHEN TaskName IN ('Fornecimento','Obra Civil', 'Montagem')
                            THEN 'SIM'
                        END
                        ELSE
                            CASE   
                                WHEN TaskName IN ('Execução', 'Pontos de lançamento', 'Ligações', 'Obra Civil') THEN 'SIM' 
                                ELSE 'NÃO' 
                            END
                END
                WHEN TaskName_Level_5 = 'Imobilização' THEN
                    CASE 
                        WHEN TaskName IN ('Documentação Técnica', 'Lançamento Signos', 'Atestado de cadastro técnico') 
                        THEN 'SIM' 
                        ELSE 'NÃO' 
                    END
                
                WHEN TaskName_Level_5 = 'Operação' THEN 'NÃO - Operação não deve ter nível 6'
                
                ELSE 'NÃO - Pai não mapeado'
            END
            
        -- Nível 7: Apenas para TaskName_Level_5 = 'Liberações'
        WHEN 7 THEN
            CASE 
                WHEN TaskName_Level_5 = 'Liberações' THEN
                    CASE 
                        -- Padrão: Autorização [xxx] ([yyy])
                        WHEN TaskName LIKE 'Autorização [%] ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Concessionária' THEN 'SIM'
                                ELSE 'NÃO - Disciplina deve ser Concessionária'
                            END
                        
                        -- Padrão: Desapropriação ([xxx])
                        WHEN TaskName LIKE 'Desapropriação ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Dominial' AND TipoLiberação = 'Desapropriação' THEN 'SIM'
                                ELSE 'NÃO - Disciplina deve ser Dominial e TipoLiberacao deve ser Desapropriação'
                            END
                        
                        -- Padrão: Liberação de faixa (Fx [xxx] - [yyy])
                        WHEN TaskName LIKE 'Liberação de faixa (Fx [%] - [%])' THEN
                            CASE 
                                WHEN Disciplina = 'Dominial' AND TipoLiberação = 'Faixa de serviço' THEN 'SIM'
                                ELSE 'NÃO - Disciplina deve ser Dominial e TipoLiberacao deve ser Faixa de serviço'
                            END
                        
                        -- Padrão: LP/LI ([xxx])
                        WHEN TaskName LIKE 'LP/LI ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Ambiental' AND TipoLiberação = 'LP/LI' THEN 'SIM'
                                ELSE 'NÃO - Disciplina deve ser Ambiental e TipoLiberacao deve ser LP/LI'
                            END
                        
                        -- Padrão: LPIO ([xxx])
                        WHEN TaskName LIKE 'LPIO ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Ambiental' AND TipoLiberação = 'LPIO' THEN 'SIM'
                                ELSE 'NÃO - Disciplina deve ser Ambiental e TipoLiberacao deve ser LPIO'
                            END
                        
                        -- Padrão: Intervenção de APP ([xxx])
                        WHEN TaskName LIKE 'Intervenção de APP ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Ambiental' AND TipoLiberação = 'APP' THEN 'SIM'
                                ELSE 'NÃO - Disciplina deve ser Ambiental e TipoLiberacao deve ser APP'
                            END
                        
                        -- Padrão: Supressão de Vegetação ([xxx])
                        WHEN TaskName LIKE 'Supressão de Vegetação ([%])' THEN
                            CASE 
                                WHEN Disciplina = 'Ambiental' AND TipoLiberação = 'APP' THEN 'SIM'
                                ELSE 'NÃO - Disciplina deve ser Ambiental e TipoLiberacao deve ser APP'
                            END
                        
                        -- TaskName não corresponde a nenhum padrão válido
                        ELSE 'NÃO - Padrão de nome inválido'
                    END
                
                -- Nível 7 só é válido para Liberações
                -- Se TaskName_Level_6 for 'Pontos de lançamento' não pode ser 'PL%' -- Só funcionar se EconomiasPrevistas <> 0
                WHEN TaskName_Level_6 = 'Pontos de lançamento' AND EconomiasPrevistas <> 0 THEN 'SIM'
                ELSE 'SIM - Nível 7 só é válidado para TaskName_Level_5 = Liberações e TaskName_Level_6 = PL'
            END
            
        -- Outros níveis não configurados
        ELSE 'NÍVEL NÃO CONFIGURADO'
    END AS Validacao
FROM tasks
WHERE 
    TaskOutlineLevel IN (1,2,3,4,5,6,7) AND
    NOT (TaskName_Level_3 = 'RELATÓRIO MENSAL' AND TaskName_Level_4 IS NOT NULL);