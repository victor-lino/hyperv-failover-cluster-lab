@echo off
title Monitoramento de Failover - VM-CLUSTER01
color 0A

echo.
echo ==============================================================
echo Iniciando teste de conectividade continua para validar HA...
echo Alvo: VM-CLUSTER01 (IP: 192.168.17.191)
echo Pressione CTRL+C para cancelar.
echo ==============================================================
echo.

:: Dispara ping continuo para o IP da VM
ping 192.168.17.191 -t

pause