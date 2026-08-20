# Shared Storage (iSCSI) Setup in TrueNAS

## 1. TrueNAS Configuration (Storage Node - `192.168.17.137`)

### A. Creating the Virtual Disk (Zvol)
1. On the TrueNAS dashboard, go to **Storage > Pools**.
2. On your main Pool, click **Add Zvol**.
3. Name it (e.g., `zvol-cluster-quorum` or `zvol-cluster-data`) and set the desired size.

### B. iSCSI Service Configuration (Sharing > Block Shares)
1. **Portals:** Create a portal bound to the TrueNAS IP (`192.168.17.137`) on default port `3260`.
2. **Initiators:** Allow connections from the lab subnet (`192.168.17.0/24`) or strictly allow NODE01 (`192.168.17.11`) and NODE02 (`192.168.17.12`).
3. **Extents:** Create a "Device" *Extent* and map it to the Zvol created in Step A.
4. **Targets:** Create a Target linking the *Portal*, the *Initiator Group*, and associate the *Extent* to this Target.
5. Under **Services**, ensure the **iSCSI** service is *Running* and set to *Start Automatically*.

## 2. Windows Server Configuration (NODE01 and NODE02)

Perform these steps on **both** Hyper-V nodes:
1. Open the **iSCSI Initiator** in Windows Server.
2. In the **Targets** tab, enter the TrueNAS IP (`192.168.17.137`) and click **Quick Connect**.
3. The Target created in TrueNAS should now display as `Connected`.

## 3. Disk Preparation and Cluster Shared Volume (CSV)
1. On **NODE01**, open **Disk Management**.
2. The new iSCSI disk will show up as *Offline*. Right-click to bring it **Online** and initialize it as **GPT**.
3. Create a "New Simple Volume" and format it using **NTFS** or **ReFS**.
4. Open the **Failover Cluster Manager**.
5. Go to *Storage > Disks* and click **Add Disk**. Select the newly formatted disk.
6. Right-click the added disk and select **Add to Cluster Shared Volumes**. The disk is now highly available and accessible to both nodes at `C:\ClusterStorage\Volume1`.