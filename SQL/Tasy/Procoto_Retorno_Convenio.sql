select at.nr_atendimento,
cp.nr_interno_conta,
obter_protocolo_conpaci(cp.nr_interno_conta) as protocolo,
obter_nome_pf(at.cd_pessoa_fisica),
obter_nome_convenio(c.cd_convenio) as convenio,
c.nr_doc_convenio,
obter_nome_estab(obter_estab_atend(c.nr_atendimento)) as estabelecimento,
obter_valor_dominio(12,at.ie_tipo_atendimento) as tipo_atendimento,
cp.ie_status_acerto 
from atendimento_paciente at,
atend_categoria_convenio c,
conta_paciente cp
where at.nr_atendimento = c.nr_atendimento
and cp.nr_atendimento = c.nr_atendimento
and at.dt_entrada between inicio_dia(:dt_inical) and fim_dia(:dt_final)
order by 1