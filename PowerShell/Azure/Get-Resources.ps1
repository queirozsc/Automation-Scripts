# Lista todas as máquinas virtuais
Get-AzResource -ResourceType Microsoft.Compute/VirtualMachines

# Lista todos os recursos por tag
Get-AzResource -Tag @{"Support Type"="Workdays"} -ResourceType Microsoft.Compute/VirtualMachines

# Lista todas as tags de um recurso
(Get-AzResource -ResourceId /subscriptions/13d3c53d-f785-418e-9ce7-919f8b109f88/resourceGroups/GatewayPowerBI/providers/Microsoft.Compute/virtualMachines/GatewayPowerBI).Tags

# Para a máquina virtual
Get-AzResource -ResourceId /subscriptions/13d3c53d-f785-418e-9ce7-919f8b109f88/resourceGroups/GatewayPowerBI/providers/Microsoft.Compute/virtualMachines/GatewayPowerBI | Stop-AzVM