# Arquitetura e Topologia de Rede (Network Topology)

A infraestrutura foi desenhada utilizando a sub-rede `192.168.17.0/24`. Abaixo está o mapeamento completo dos IPs e funções de cada nó do cluster e dependências.

| Hostname | IP Address | Role / Função | Sistema Operacional |
| :--- | :--- | :--- | :--- |
| **DC01** | `192.168.17.10` | Domain Controller (Active Directory & DNS) | Windows Server 2025 |
| **NODE01** | `192.168.17.11` | Hyper-V Host 1 (Cluster Node) | Windows Server 2025 |
| **NODE02** | `192.168.17.12` | Hyper-V Host 2 (Cluster Node) | Windows Server 2025 |
| **TrueNAS** | `192.168.17.137` | iSCSI Shared Storage / Quorum | TrueNAS Core / Scale |
| **CLUSTER** | `192.168.17.40` | Cluster Virtual IP (VIP) | N/A |
| **VM-CLUSTER01** | `192.168.17.191` | Máquina Virtual em Alta Disponibilidade (HA) | Windows 11 / Server |

### Detalhes de Conectividade
* **DNS:** Todos os nós (NODE01, NODE02 e TrueNAS) apontam para o DC01 (`192.168.17.10`) como servidor DNS primário para resolução de nomes do domínio `cluster.local`.
* **Storage:** O TrueNAS fornece o Cluster Shared Volume (CSV) via protocolo iSCSI, mapeado no Initiator de ambos os nós Hyper-V.