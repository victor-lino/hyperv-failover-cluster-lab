# Laboratório de Alta Disponibilidade: Windows Server Hyper-V Cluster

*(For the English version, please read the [README.md](README.md))*

<p align="center">
  <img src="images/architecture-overview.png" alt="Arquitetura do Hyper-V Cluster" width="100%">
</p>

## 🎯 Objetivo do Projeto
Este laboratório simula um ambiente corporativo de missão crítica. O objetivo foi configurar um Cluster de Alta Disponibilidade (HA) utilizando Microsoft Hyper-V e um storage compartilhado via TrueNAS. A arquitetura garante que as máquinas virtuais permaneçam operacionais e migrem automaticamente (via Failover e Live Migration) em caso de falha de hardware em um dos hosts.

## 💻 Ambiente de Laboratório e Hardware
Para suportar o peso da virtualização de toda a infraestrutura, o laboratório precisou ser migrado de um notebook para uma workstation principal com maior capacidade de processamento e leitura/escrita. 

O ambiente rodou perfeitamente sobre a seguinte configuração de hardware:
* **Processador:** AMD Ryzen 7 5700X3D
* **Placa-mãe:** ASUS TUF Gaming B550M
* **Vídeo:** NVIDIA RTX 2070 Super
* **Armazenamento:** Distribuição inteligente de discos virtuais utilizando 1 drive NVMe (para ganho de IOPS nos SOs) e 4 HDDs SATA (para simulação do storage de massa).

## 🏗️ Topologia e Endereçamento (Rede 192.168.17.0/24)
* **DC01 (Domain Controller):** 192.168.17.10
* **NODE01 (Host Hyper-V 1):** 192.168.17.11
* **NODE02 (Host Hyper-V 2):** 192.168.17.12
* **TrueNAS (Storage Virtual):** 192.168.17.137
* **CLUSTER (IP Virtual):** 192.168.17.40
* **VM-CLUSTER01 (Máquina Virtual em HA):** 192.168.17.191

## 🚀 Resultados e Validação

**1. Cluster e Storage Online**
O Failover Cluster Manager reconhecendo os nós e os discos compartilhados.
![Dashboard do Cluster](images/01-cluster-dashboard-storage.png)

**2. Estado Normal (VM no NODE01)**
Máquina virtual operando e acessível através do host primário (`NODE01`).
![VM Ativa no Node 01](images/03-vm-active-node01.jpg)

**3. Simulação de Falha e Transição**
Ao simular a queda do NODE01, o cluster assume o controle (status *Unmonitored*) e inicia o failover para o host secundário.
![Failover em Andamento](images/11-cluster-vm-unmonitored-node02.png)

**4. Alta Disponibilidade Concluída (VM no NODE02)**
A máquina virtual assume as operações no NODE02 de forma automática, garantindo a continuidade do serviço.
![VM Migrada para Node 02](images/04-vm-migrated-node02.jpg)

**5. Validação de Conectividade (Downtime Mínimo)**
O teste de ping na VM confirma uma interrupção muito breve (perda de poucos pacotes) até a retomada total do serviço durante o failover.
![Retorno do Ping](images/05-ping-failover-validation.png)