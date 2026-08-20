# Troubleshooting: TrueNAS Network `Tx Unit Hang`

*(For the English version, please scroll down)*

## 🛑 O Problema
Durante os testes de estresse e migração do Hyper-V Cluster, o nó de storage (TrueNAS) apresentou quedas intermitentes de conexão iSCSI. 

Ao analisar o console do TrueNAS, foi identificado o seguinte log de erro na interface de rede (`ens33`):
> `e1000 0000:02:01.0 ens33: Detected Tx Unit Hang`

## 🔍 Análise e Impacto
O erro `Tx Unit Hang` (Fila de Transmissão Travada) é um problema conhecido ao utilizar o adaptador de rede virtualizado legado (família `e1000`) em hypervisors sob alta carga de I/O.
Como o TrueNAS estava fornecendo o *Cluster Shared Volume (CSV)* via iSCSI, esse travamento na placa de rede causava a perda de comunicação entre os nós do Hyper-V e o storage, forçando o cluster a entrar em estado de falha e derrubando as VMs.

## ✅ Solução Aplicada
Para garantir a estabilidade da comunicação iSCSI, a resolução envolve evitar o travamento da fila de hardware virtual:
1. **Alteração do Adaptador Virtual:** Substituição do adaptador de rede legado (e1000) pelo adaptador nativo/sintético do Hyper-V, que possui melhor integração e performance.
2. **Offloading de Rede:** (Opcional) Desabilitar o *Hardware Checksum Offloading* (TSO/GSO) nas configurações de rede da interface da VM, forçando o processamento via software para evitar o *hang* no driver virtual.

Após a correção, o tráfego iSCSI estabilizou e o Failover Cluster pôde realizar o *Live Migration* sem interrupções de storage.

---