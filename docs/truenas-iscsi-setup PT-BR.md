# Configuração de Storage Compartilhado (iSCSI) no TrueNAS

*(For the English version, please scroll down)*

Para que o Hyper-V Cluster funcione, os nós precisam ler e escrever no mesmo disco simultaneamente. Para isso, configuramos um *Cluster Shared Volume (CSV)* utilizando o protocolo iSCSI no TrueNAS.

## 1. Configuração no TrueNAS (Storage Node - `192.168.17.137`)

### A. Criação do Disco Virtual (Zvol)
1. No painel do TrueNAS, acesse **Storage > Pools**.
2. No seu Pool principal, clique em **Add Zvol**.
3. Defina um nome (ex: `zvol-cluster-quorum` ou `zvol-cluster-data`) e o tamanho desejado para o disco.

### B. Configuração do Serviço iSCSI (Sharing > Block Shares)
1. **Portals:** Crie um portal vinculado ao IP do TrueNAS (`192.168.17.137`) na porta padrão `3260`.
2. **Initiators:** Configure para permitir conexões da sub-rede do laboratório (`192.168.17.0/24`) ou especifique os IPs do NODE01 (`192.168.17.11`) e NODE02 (`192.168.17.12`).
3. **Extents:** Crie um *Extent* do tipo "Device" e aponte para o Zvol criado no passo A.
4. **Targets:** Crie o alvo (Target) vinculando o *Portal*, o *Initiator Group* e adicione o *Extent* a este Target.
5. Em **Services**, certifique-se de que o serviço **iSCSI** está em execução (*Running*) e marcado para iniciar com o sistema (*Start Automatically*).

## 2. Configuração no Windows Server (NODE01 e NODE02)

Este processo deve ser feito em **ambos** os nós do Hyper-V:
1. Abra o **iSCSI Initiator** (Iniciador iSCSI) no Windows Server.
2. Na aba **Targets**, digite o IP do TrueNAS (`192.168.17.137`) no campo *Target* e clique em **Quick Connect**.
3. O Target criado no TrueNAS deve aparecer como `Connected`.

## 3. Preparação do Disco e Cluster Shared Volume (CSV)
1. No **NODE01**, abra o **Disk Management** (Gerenciamento de Disco).
2. O novo disco iSCSI aparecerá como *Offline*. Clique com o botão direito para deixá-lo **Online** e inicialize-o em formato **GPT**.
3. Crie um "New Simple Volume" e formate-o em **NTFS** ou **ReFS**.
4. Abra o **Failover Cluster Manager**.
5. Vá em *Storage > Disks* e clique em **Add Disk**. Selecione o disco recém-formatado.
6. Clique com o botão direito no disco adicionado e selecione **Add to Cluster Shared Volumes**. O disco agora estará acessível para ambos os nós no caminho `C:\ClusterStorage\Volume1`.