<#
.SYNOPSIS
Script para instalação dos pré-requisitos do Hyper-V Cluster.

.DESCRIPTION
Este script instala a role do Hyper-V, o recurso de Failover Clustering e as ferramentas de gerenciamento (RSAT) nos nós do Windows Server. Deve ser executado como Administrador no NODE01 e NODE02.
#>

Write-Host "Iniciando instalação das roles de Hyper-V e Failover Cluster..." -ForegroundColor Cyan

# Instala o Hyper-V e ferramentas de gerenciamento
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart:$false

# Instala o recurso de Failover Clustering
Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools

# Instala o Multipath I/O (Necessário para redundância iSCSI, se aplicável)
Install-WindowsFeature -Name Multipath-IO

Write-Host "Instalação concluída. É necessário reiniciar o servidor." -ForegroundColor Yellow