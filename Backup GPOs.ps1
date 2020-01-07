#Simple script to backup all GPOs to a selected folder

$path = "C:\Backups"

$gpos = get-gpo -all
$date = Get-Date -Format MMddyyHHmm
New-Item -ItemType Directory -Path $path -Name $date
$bpath = $path + "\" + $date
$gpos | % {Backup-GPO -Name $_.DisplayName -Path $bpath}
