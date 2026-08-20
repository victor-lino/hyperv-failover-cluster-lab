# Setup de Hardware e Configurações de BIOS

*(For the English version, please scroll down)*

## 🛑 O Desafio de Recursos (Gargalo de Hardware)
A execução de um laboratório de Failover Cluster exige alta capacidade de processamento, memória e I/O de disco, pois envolve rodar simultaneamente:
* 2x Nós Hyper-V (Windows Server)
* 1x Domain Controller (Windows Server)
* 1x Storage Compartilhado (TrueNAS)

Inicialmente, o ambiente foi projetado em um notebook (Intel Core i3 de 11ª Geração, 16 GB RAM, 2 SSDs, 3 HDs). No entanto, o hardware se mostrou insustentável. A falta de núcleos de processamento e o esgotamento rápido dos 16 GB de RAM causavam lentidão extrema, inviabilizando testes dinâmicos de failover.

## 🚀 A Solução: Workstation Principal
Para suportar a carga exigente, o laboratório foi inteiramente migrado para uma máquina de alta performance, que lidou com a demanda com extrema fluidez:
* **Processador:** AMD Ryzen 7 5700X3D (Essencial para lidar com múltiplas vCPUs).
* **Memória:** 32 GB RAM 3600 MHz (Garantindo folga para alocação do TrueNAS e Windows Servers).
* **Placa de Vídeo:** NVIDIA RTX 2070 Super.
* **Armazenamento (6 TB Total):** Distribuição inteligente mesclando SSDs, 1 NVMe e HDs. Os Sistemas Operacionais das VMs foram alocados no NVMe/SSD para garantir IOPS alto, enquanto os discos virtuais de dados ficaram nos HDs.

## ⚙️ Configurações Necessárias na BIOS
Para que o Hyper-V (Nested Virtualization) funcionasse corretamente sobre o processador AMD, ajustes críticos foram realizados na BIOS da placa-mãe ASUS TUF Gaming B550M:
1. **SVM Mode (Secure Virtual Machine):** Ativado na aba *Advanced > CPU Configuration*. Esta função habilita o AMD-V, a tecnologia de virtualização de hardware necessária para o Hyper-V.
2. **IOMMU:** Habilitado para otimizar o mapeamento de memória e a comunicação direta de hardware com as VMs.
3. **Perfil de RAM (DOCP):** Ativado para garantir que os módulos de memória operassem em sua capacidade total de 3600 MHz, eliminando gargalos de comunicação com o Ryzen.