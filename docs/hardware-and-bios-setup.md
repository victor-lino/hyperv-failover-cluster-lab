# Hardware Setup and BIOS Configuration

## 🛑 The Resource Challenge (Hardware Bottleneck)
Running a Failover Cluster lab demands high processing power, memory, and disk I/O, as it requires simultaneously running:
* 2x Hyper-V Nodes (Windows Server)
* 1x Domain Controller (Windows Server)
* 1x Shared Storage (TrueNAS)

Initially, the environment was deployed on a laptop (11th Gen Intel Core i3, 16 GB RAM, 2 SSDs, 3 HDDs). However, this hardware proved insufficient. The lack of CPU cores and the rapid exhaustion of the 16 GB of RAM caused extreme lag, making dynamic failover tests impossible.

## 🚀 The Solution: Main Workstation
To handle the heavy load, the lab was entirely migrated to a high-performance machine, which handled the demand smoothly:
* **CPU:** AMD Ryzen 7 5700X3D (Crucial for handling multiple vCPUs).
* **Memory:** 32 GB RAM 3600 MHz (Ensuring enough headroom for TrueNAS and Windows Server allocation).
* **GPU:** NVIDIA RTX 2070 Super.
* **Storage (6 TB Total):** Smart distribution mixing SSDs, 1 NVMe, and HDDs. VM Operating Systems were placed on the NVMe/SSD to ensure high IOPS, while virtual data disks were stored on the HDDs.

## ⚙️ Necessary BIOS Configurations
For Hyper-V (and Nested Virtualization) to function correctly on the AMD processor, critical adjustments were made in the ASUS TUF Gaming B550M motherboard BIOS:
1. **SVM Mode (Secure Virtual Machine):** Enabled under the *Advanced > CPU Configuration* tab. This feature turns on AMD-V, the hardware virtualization technology required by Hyper-V.
2. **IOMMU:** Enabled to optimize memory mapping and direct hardware communication for the VMs.
3. **RAM Profile (DOCP):** Enabled to ensure the memory modules operated at their full 3600 MHz capacity, eliminating communication bottlenecks with the Ryzen CPU.