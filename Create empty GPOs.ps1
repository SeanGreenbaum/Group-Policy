#Create empty GPOs based on names in an array

$GPOs = "Default Workstations Policy", "Default Servers Policy", "Default Users Policy", "HR Users Policy", "SQL Servers Policy", "DMZ Servers Policy", "IIS Servers Policy"
ForEach ($gpo in $gpos)
{
    New-GPO -Name $gpo
}
