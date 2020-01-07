#Add AGPM Service account to all GPOs
#Add the name of the AGPM Service account in the format domain\samaccountname

$agpmserviceaccount = "contoso\agpm_svc"

$gpos = Get-gpo -All
$gpos | % {
    Set-GPPermission -TargetName $agpmserviceaccount -PermissionLevel GpoEditDeleteModifySecurity -TargetType User -Name $_.DisplayName
}