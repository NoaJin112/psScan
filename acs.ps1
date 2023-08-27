$currentUser = Get-LocalUser
$arrayDisabledAccounts = @()
$arrayEnabledAccounts =@()

foreach ($user in $currentUser) {
    if ($user -eq $null) {
        Write-Output "Test"
        continue 
    }
    $fullName = $user.Name
    $lastLogon = $user.LastLogon
    $accountStatusEnabled = $user.Enabled


    if ($lastLogon -eq $null){
        $lastLogonInfo = "Nooit gebruik van gemaakt"
    }
    else {
        $lastLogonInfo = $lastLogon.ToString("yyyy-MM-dd HH:mm:ss")
    }

    $AccountInfo = @{
        fullName = $fullName
        accountStatus = $accountStatusEnabled
        lastLogon = $lastLogonInfo
    }

    if ($accountStatusEnabled){
        $arrayEnabledAccounts += $accountInfo
    }
    else{
        $arrayDisabledAccounts += $accountInfo
    }
}

$arrayDisabledAccounts | ForEach-Object {
    Write-Output "Full Name: $($_.FullName)"
    Write-Output "Account Status: Disabled"
    Write-Output "Last Logon: $($_.LastLogon)"
    Write-Output "--------------------------"
}

$arrayEnabledAccounts | ForEach-Object {
    Write-Output "Full Name: $($_.FullName)"
    Write-Output "Account Status: Enabled"
    Write-Output "Last Logon: $($_.LastLogon)"
    Write-Output "--------------------------"
    $currentServices = Read-Host "Please enter y/n if you want to see the services of account $($_.FullName)"
    Write-Output "$currentServices"
    if ($currentServices -eq "y" -or $currentServices -eq "yes"){
        $getServices = Get-Service
        Write-Output "Services:"
        $getServices | Format-Table Name, Status
        Write-Output "--------------------------"
    }
}
