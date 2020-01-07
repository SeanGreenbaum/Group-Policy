# Using the selected group policy object name, remove Domain Computers and Authenticated Users from having permissions

$policyname = "My Loopback Policy"
$gpo = get-gpo -Name $policyname
if (Get-GPPermission -Name $gpo.DisplayName -all | ? {$_.Trustee.Name -eq "Domain Computers"})
{
    Write-Host "Removing Domain Computers from policy" $gpo.DisplayName  -ForegroundColor Green -NoNewline
    $null = Set-GPPermission -TargetName "Domain Computers" -Replace -PermissionLevel None -TargetType Group -Name $policyname
    if (!(Get-GPPermission -Name $gpo.DisplayName -all | ? {$_.Trustee.Name -eq "Domain Computers"}))
    {
        Write-Host "........Success" -ForegroundColor Green
    }
    else
    {
        Write-Host ".........Failed" -ForegroundColor Red
    }
}
if (Get-GPPermission -Name $gpo.DisplayName -all | ? {$_.Trustee.Name -eq "Authenticated Users"})
{
    Write-Host ("Removing Authenticated Users from policy " + $gpo.DisplayName + ".........") -ForegroundColor Green -NoNewline
    $ADSI = [ADSI] "LDAP://$($gpo.Path)"
    $ADSI.psbase.ObjectSecurity.Access | ForEach-Object {
        if ($_.IdentityReference –eq 'NT AUTHORITY\Authenticated Users') {
            $ADSI.psbase.ObjectSecurity.RemoveAccessRule($_)
        }
    }
    $result = $ADSI.psbase.CommitChanges()
}