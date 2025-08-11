WITH dados_base AS (
    SELECT 
        Contrato,
        COUNT(*) as TotalRegistros,
        COUNT(TaskId) as NaoNulos_TaskId,
        COUNT(ProjectName) as NaoNulos_ProjectName,
        COUNT(TaskName) as NaoNulos_TaskName,
        COUNT(Disciplina) as NaoNulos_Disciplina,
        COUNT(TipoLiberação) as NaoNulos_TipoLiberação,
        COUNT(TaskEarlyStart) as NaoNulos_TaskEarlyStart,
        COUNT(TaskEarlyFinish) as NaoNulos_TaskEarlyFinish,
        COUNT(TaskDuration) as NaoNulos_TaskDuration,
        COUNT(TaskActualStartDate) as NaoNulos_TaskActualStartDate,
        COUNT(TaskActualFinishDate) as NaoNulos_TaskActualFinishDate,
        COUNT(TaskActualDuration) as NaoNulos_TaskActualDuration,
        COUNT(EconomiasPrevistas) as NaoNulos_EconomiasPrevistas,
        COUNT(EconomiasRealizadas) as NaoNulos_EconomiasRealizadas,
        COUNT(Coordenador) as NaoNulos_Coordenador,
        COUNT(PEPNível4) as NaoNulos_PEPNível4,
        COUNT(CódWBS) as NaoNulos_CódWBS,
        COUNT(Município) as NaoNulos_Município,
        COUNT(Pendência) as NaoNulos_Pendência,
        COUNT(Item) as NaoNulos_Item
    FROM tasks
    WHERE Contrato IS NOT NULL
    GROUP BY Contrato
)

SELECT 
    Contrato,
    TotalRegistros,
    
    -- 📊 TaskId
    TotalRegistros - NaoNulos_TaskId as QtdNulos_TaskId,
    CAST(ROUND(((TotalRegistros - NaoNulos_TaskId) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_TaskId,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_TaskId) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_TaskId) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_TaskId) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_TaskId) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_TaskId,
    
    -- 📊 ProjectName
    TotalRegistros - NaoNulos_ProjectName as QtdNulos_ProjectName,
    CAST(ROUND(((TotalRegistros - NaoNulos_ProjectName) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_ProjectName,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_ProjectName) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_ProjectName) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_ProjectName) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_ProjectName) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_ProjectName,
    
    -- 📊 TaskName
    TotalRegistros - NaoNulos_TaskName as QtdNulos_TaskName,
    CAST(ROUND(((TotalRegistros - NaoNulos_TaskName) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_TaskName,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_TaskName) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_TaskName) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_TaskName) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_TaskName) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_TaskName,
    
    -- 📊 Disciplina
    TotalRegistros - NaoNulos_Disciplina as QtdNulos_Disciplina,
    CAST(ROUND(((TotalRegistros - NaoNulos_Disciplina) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_Disciplina,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_Disciplina) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_Disciplina) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_Disciplina) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_Disciplina) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_Disciplina,
    
    -- 📊 TipoLiberação
    TotalRegistros - NaoNulos_TipoLiberação as QtdNulos_TipoLiberação,
    CAST(ROUND(((TotalRegistros - NaoNulos_TipoLiberação) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_TipoLiberação,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_TipoLiberação) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_TipoLiberação) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_TipoLiberação) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_TipoLiberação) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_TipoLiberação,
    
    -- 📊 TaskEarlyStart
    TotalRegistros - NaoNulos_TaskEarlyStart as QtdNulos_TaskEarlyStart,
    CAST(ROUND(((TotalRegistros - NaoNulos_TaskEarlyStart) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_TaskEarlyStart,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_TaskEarlyStart) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_TaskEarlyStart) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_TaskEarlyStart) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_TaskEarlyStart) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_TaskEarlyStart,
    
    -- 📊 TaskEarlyFinish
    TotalRegistros - NaoNulos_TaskEarlyFinish as QtdNulos_TaskEarlyFinish,
    CAST(ROUND(((TotalRegistros - NaoNulos_TaskEarlyFinish) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_TaskEarlyFinish,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_TaskEarlyFinish) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_TaskEarlyFinish) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_TaskEarlyFinish) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_TaskEarlyFinish) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_TaskEarlyFinish,
    
    -- 📊 TaskDuration
    TotalRegistros - NaoNulos_TaskDuration as QtdNulos_TaskDuration,
    CAST(ROUND(((TotalRegistros - NaoNulos_TaskDuration) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_TaskDuration,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_TaskDuration) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_TaskDuration) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_TaskDuration) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_TaskDuration) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_TaskDuration,
    
    -- 📊 TaskActualStartDate
    TotalRegistros - NaoNulos_TaskActualStartDate as QtdNulos_TaskActualStartDate,
    CAST(ROUND(((TotalRegistros - NaoNulos_TaskActualStartDate) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_TaskActualStartDate,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_TaskActualStartDate) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_TaskActualStartDate) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_TaskActualStartDate) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_TaskActualStartDate) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_TaskActualStartDate,
    
    -- 📊 TaskActualFinishDate
    TotalRegistros - NaoNulos_TaskActualFinishDate as QtdNulos_TaskActualFinishDate,
    CAST(ROUND(((TotalRegistros - NaoNulos_TaskActualFinishDate) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_TaskActualFinishDate,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_TaskActualFinishDate) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_TaskActualFinishDate) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_TaskActualFinishDate) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_TaskActualFinishDate) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_TaskActualFinishDate,
    
    -- 📊 TaskActualDuration
    TotalRegistros - NaoNulos_TaskActualDuration as QtdNulos_TaskActualDuration,
    CAST(ROUND(((TotalRegistros - NaoNulos_TaskActualDuration) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_TaskActualDuration,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_TaskActualDuration) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_TaskActualDuration) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_TaskActualDuration) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_TaskActualDuration) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_TaskActualDuration,
    
    -- 📊 EconomiasPrevistas
    TotalRegistros - NaoNulos_EconomiasPrevistas as QtdNulos_EconomiasPrevistas,
    CAST(ROUND(((TotalRegistros - NaoNulos_EconomiasPrevistas) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_EconomiasPrevistas,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_EconomiasPrevistas) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_EconomiasPrevistas) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_EconomiasPrevistas) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_EconomiasPrevistas) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_EconomiasPrevistas,
    
    -- 📊 EconomiasRealizadas
    TotalRegistros - NaoNulos_EconomiasRealizadas as QtdNulos_EconomiasRealizadas,
    CAST(ROUND(((TotalRegistros - NaoNulos_EconomiasRealizadas) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_EconomiasRealizadas,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_EconomiasRealizadas) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_EconomiasRealizadas) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_EconomiasRealizadas) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_EconomiasRealizadas) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_EconomiasRealizadas,
    
    -- 📊 Coordenador
    TotalRegistros - NaoNulos_Coordenador as QtdNulos_Coordenador,
    CAST(ROUND(((TotalRegistros - NaoNulos_Coordenador) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_Coordenador,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_Coordenador) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_Coordenador) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_Coordenador) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_Coordenador) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_Coordenador,
    
    -- 📊 PEPNível4
    TotalRegistros - NaoNulos_PEPNível4 as QtdNulos_PEPNível4,
    CAST(ROUND(((TotalRegistros - NaoNulos_PEPNível4) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_PEPNível4,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_PEPNível4) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_PEPNível4) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_PEPNível4) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_PEPNível4) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_PEPNível4,
    
    -- 📊 CódWBS
    TotalRegistros - NaoNulos_CódWBS as QtdNulos_CódWBS,
    CAST(ROUND(((TotalRegistros - NaoNulos_CódWBS) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_CódWBS,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_CódWBS) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_CódWBS) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_CódWBS) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_CódWBS) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_CódWBS,
    
    -- 📊 Município
    TotalRegistros - NaoNulos_Município as QtdNulos_Município,
    CAST(ROUND(((TotalRegistros - NaoNulos_Município) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_Município,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_Município) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_Município) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_Município) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_Município) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_Município,
    
    -- 📊 Pendência
    TotalRegistros - NaoNulos_Pendência as QtdNulos_Pendência,
    CAST(ROUND(((TotalRegistros - NaoNulos_Pendência) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_Pendência,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_Pendência) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_Pendência) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_Pendência) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_Pendência) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_Pendência,
    
    -- 📊 Item
    TotalRegistros - NaoNulos_Item as QtdNulos_Item,
    CAST(ROUND(((TotalRegistros - NaoNulos_Item) * 100.0 / TotalRegistros), 2) AS DECIMAL(5,2)) as PctNulos_Item,
    CASE 
        WHEN ((TotalRegistros - NaoNulos_Item) * 100.0 / TotalRegistros) = 0 THEN 'PERFEITO'
        WHEN ((TotalRegistros - NaoNulos_Item) * 100.0 / TotalRegistros) < 5 THEN 'BOM'
        WHEN ((TotalRegistros - NaoNulos_Item) * 100.0 / TotalRegistros) < 20 THEN 'MÉDIO'
        WHEN ((TotalRegistros - NaoNulos_Item) * 100.0 / TotalRegistros) < 50 THEN 'RUIM'
        ELSE 'CRÍTICO'
    END as Status_Item
    
FROM dados_base
ORDER BY Contrato;