SELECT 
    Contrato,
    TaskOutlineNumber,
    TaskId,
    ProjectName,
    TaskName,
    
    -- 🎯 Identificação dos problemas específicos
    CASE WHEN TaskId IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_TaskId,
    CASE WHEN ProjectName IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_ProjectName,
    CASE WHEN TaskName IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_TaskName,
    CASE WHEN Disciplina IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_Disciplina,
    CASE WHEN TipoLiberação IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_TipoLiberação,
    CASE WHEN TaskEarlyStart IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_TaskEarlyStart,
    CASE WHEN TaskEarlyFinish IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_TaskEarlyFinish,
    CASE WHEN TaskDuration IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_TaskDuration,
    CASE WHEN TaskActualStartDate IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_TaskActualStartDate,
    CASE WHEN TaskActualFinishDate IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_TaskActualFinishDate,
    CASE WHEN TaskActualDuration IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_TaskActualDuration,
    CASE WHEN EconomiasPrevistas IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_EconomiasPrevistas,
    CASE WHEN EconomiasRealizadas IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_EconomiasRealizadas,
    CASE WHEN Coordenador IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_Coordenador,
    CASE WHEN PEPNível4 IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_PEPNível4,
    CASE WHEN CódWBS IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_CódWBS,
    CASE WHEN Município IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_Município,
    CASE WHEN Pendência IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_Pendência,
    CASE WHEN Item IS NULL THEN '❌ CORRIGIR' ELSE '✅ OK' END as Acao_Item,
    
    -- 📋 Lista resumida dos campos para corrigir
    CONCAT(
        CASE WHEN TaskId IS NULL THEN 'TaskId, ' ELSE '' END,
        CASE WHEN ProjectName IS NULL THEN 'ProjectName, ' ELSE '' END,
        CASE WHEN TaskName IS NULL THEN 'TaskName, ' ELSE '' END,
        CASE WHEN Disciplina IS NULL THEN 'Disciplina, ' ELSE '' END,
        CASE WHEN TipoLiberação IS NULL THEN 'TipoLiberação, ' ELSE '' END,
        CASE WHEN TaskEarlyStart IS NULL THEN 'TaskEarlyStart, ' ELSE '' END,
        CASE WHEN TaskEarlyFinish IS NULL THEN 'TaskEarlyFinish, ' ELSE '' END,
        CASE WHEN TaskDuration IS NULL THEN 'TaskDuration, ' ELSE '' END,
        CASE WHEN TaskActualStartDate IS NULL THEN 'TaskActualStartDate, ' ELSE '' END,
        CASE WHEN TaskActualFinishDate IS NULL THEN 'TaskActualFinishDate, ' ELSE '' END,
        CASE WHEN TaskActualDuration IS NULL THEN 'TaskActualDuration, ' ELSE '' END,
        CASE WHEN EconomiasPrevistas IS NULL THEN 'EconomiasPrevistas, ' ELSE '' END,
        CASE WHEN EconomiasRealizadas IS NULL THEN 'EconomiasRealizadas, ' ELSE '' END,
        CASE WHEN Coordenador IS NULL THEN 'Coordenador, ' ELSE '' END,
        CASE WHEN PEPNível4 IS NULL THEN 'PEPNível4, ' ELSE '' END,
        CASE WHEN CódWBS IS NULL THEN 'CódWBS, ' ELSE '' END,
        CASE WHEN Município IS NULL THEN 'Município, ' ELSE '' END,
        CASE WHEN Pendência IS NULL THEN 'Pendência, ' ELSE '' END,
        CASE WHEN Item IS NULL THEN 'Item, ' ELSE '' END
    ) as CamposParaCorrigir,
    
    -- 📊 Prioridade de correção
    CASE 
        WHEN (CASE WHEN TaskId IS NULL THEN 1 ELSE 0 END +
              CASE WHEN ProjectName IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskName IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Disciplina IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TipoLiberação IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskEarlyStart IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskEarlyFinish IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskDuration IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualStartDate IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualFinishDate IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualDuration IS NULL THEN 1 ELSE 0 END +
              CASE WHEN EconomiasPrevistas IS NULL THEN 1 ELSE 0 END +
              CASE WHEN EconomiasRealizadas IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Coordenador IS NULL THEN 1 ELSE 0 END +
              CASE WHEN PEPNível4 IS NULL THEN 1 ELSE 0 END +
              CASE WHEN CódWBS IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Município IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Pendência IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Item IS NULL THEN 1 ELSE 0 END) >= 10 THEN '🔴 ALTA'
        WHEN (CASE WHEN TaskId IS NULL THEN 1 ELSE 0 END +
              CASE WHEN ProjectName IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskName IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Disciplina IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TipoLiberação IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskEarlyStart IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskEarlyFinish IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskDuration IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualStartDate IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualFinishDate IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualDuration IS NULL THEN 1 ELSE 0 END +
              CASE WHEN EconomiasPrevistas IS NULL THEN 1 ELSE 0 END +
              CASE WHEN EconomiasRealizadas IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Coordenador IS NULL THEN 1 ELSE 0 END +
              CASE WHEN PEPNível4 IS NULL THEN 1 ELSE 0 END +
              CASE WHEN CódWBS IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Município IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Pendência IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Item IS NULL THEN 1 ELSE 0 END) >= 5 THEN '🟠 MÉDIA'
        ELSE '🟡 BAIXA'
    END as PrioridadeCorrecao

FROM tasks
WHERE (
    TaskId IS NULL OR
    ProjectName IS NULL OR
    TaskName IS NULL OR
    Disciplina IS NULL OR
    TipoLiberação IS NULL OR
    TaskEarlyStart IS NULL OR
    TaskEarlyFinish IS NULL OR
    TaskDuration IS NULL OR
    TaskActualStartDate IS NULL OR
    TaskActualFinishDate IS NULL OR
    TaskActualDuration IS NULL OR
    EconomiasPrevistas IS NULL OR
    EconomiasRealizadas IS NULL OR
    Coordenador IS NULL OR
    PEPNível4 IS NULL OR
    CódWBS IS NULL OR
    Município IS NULL OR
    Pendência IS NULL OR
    Item IS NULL
  )
ORDER BY 
    CASE 
        WHEN (CASE WHEN TaskId IS NULL THEN 1 ELSE 0 END +
              CASE WHEN ProjectName IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskName IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Disciplina IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TipoLiberação IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskEarlyStart IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskEarlyFinish IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskDuration IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualStartDate IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualFinishDate IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualDuration IS NULL THEN 1 ELSE 0 END +
              CASE WHEN EconomiasPrevistas IS NULL THEN 1 ELSE 0 END +
              CASE WHEN EconomiasRealizadas IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Coordenador IS NULL THEN 1 ELSE 0 END +
              CASE WHEN PEPNível4 IS NULL THEN 1 ELSE 0 END +
              CASE WHEN CódWBS IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Município IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Pendência IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Item IS NULL THEN 1 ELSE 0 END) >= 10 THEN 1
        WHEN (CASE WHEN TaskId IS NULL THEN 1 ELSE 0 END +
              CASE WHEN ProjectName IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskName IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Disciplina IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TipoLiberação IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskEarlyStart IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskEarlyFinish IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskDuration IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualStartDate IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualFinishDate IS NULL THEN 1 ELSE 0 END +
              CASE WHEN TaskActualDuration IS NULL THEN 1 ELSE 0 END +
              CASE WHEN EconomiasPrevistas IS NULL THEN 1 ELSE 0 END +
              CASE WHEN EconomiasRealizadas IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Coordenador IS NULL THEN 1 ELSE 0 END +
              CASE WHEN PEPNível4 IS NULL THEN 1 ELSE 0 END +
              CASE WHEN CódWBS IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Município IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Pendência IS NULL THEN 1 ELSE 0 END +
              CASE WHEN Item IS NULL THEN 1 ELSE 0 END) >= 5 THEN 2
        ELSE 3
    END,
    TaskOutlineNumber;