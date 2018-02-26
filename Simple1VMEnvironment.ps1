
Login-Azure -SubscriptionName 'Pay-As-You-Go-Action-Pack'

# Create an AZURE Resoruce Group.
Create-ResourceGroup -Name Agile2018_RG -Location "EASTUS2" | 
    # Create a Virtual Network

    Create-VirtualNetwork -Name "simpleVM1Vnet" -AddressSpace  192.169.0.0/16 |
     
      # Create NSG
        Create-NetworkSecurityGroup -Name "NSG-SimpleVMFrontEnd" -rgName "Agile2018_RG"

            # Create NSG Rules
            $rules = Create-NSGRule -Name "Allow_Http" -Port 80 -Priority 100 -SourceAddressPrefix Internet -Access Allow | Create-NSGRule -Name "Allow_RDP" -SourceAddressPrefix Internet -Port 3389 -Priority 101 -Access Allow
            $cred = Get-Credential

                    # Add Network Security Rule
                    Add-NetworkSecurityRule -NsgName "NSG-SimpleVMFrontEnd" -RGName "Agile2018_RG" -Rules $rules
                    
                    # Create Second Widows VM
                    Create-WindowsVM -VMName "vmsimple1" -RGName "Agile2018_RG" -StorageAccountName "storageagile2018" -NSGName "NSG-SimpleVMFrontEnd" -SubNetName "backEndSubNet" -SQLServer "No"