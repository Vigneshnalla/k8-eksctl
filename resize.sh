#!/bin/bash

# Resize the partition
sudo growpart /dev/nvme0n1 4

# Extend the logical volume for root
sudo lvextend -l +50%FREE /dev/RootVG/rootVol

# Extend the logical volume for /var
sudo lvextend -l +50%FREE /dev/RootVG/varVol

# Grow the XFS filesystem for root
sudo xfs_growfs /

# Grow the XFS filesystem for /var
sudo xfs_growfs /var


# Check the block device information
echo "Displaying updated block device information..."
lsblk