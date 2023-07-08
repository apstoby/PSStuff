# Introduction
# This is the easiest way for me to use the power of the command line with little effort
# This belongs in my personal repo but can be used anywhere
# Lots to do before it is clean and professional, but that is not my goal here!
# Last Updated 1/7/2023

# Initialisation
# $target should be a recognised computer in the domain
$target = "localhost"

# Functions
Function Menu {
    param (
        [string]$Title = "$target Time"
    )
    Clear-Host
    Write-Host -ForegroundColor Green "===== $Title ===="
    Write-Host -ForegroundColor DarkGray "===================="
    Write-Host -ForegroundColor DarkGreen "Q. Press q to Quit"
    Write-Host -ForegroundColor Green "1. Press 1 to check status on $target"
    Write-Host -ForegroundColor Blue "2. Press 2 to get Event Logs from $target"
    Write-Host -ForegroundColor DarkBlue  "3. Press 3 for Bob"
    Write-Host -ForegroundColor Red   "4. Press 4 to get the configuration of $target"
    Write-Host -ForegroundColor DarkRed "5. Press 5 to search more than one place ..."
    Write-Host -ForegroundColor DarkYellow "6. Press 6 to search company records ..."
    Write-Host -ForegroundColor DarkMagenta "7. Press 7 to setup Powershell environment."
    Write-Host -ForegroundColor DarkGreen "Q. Press q to Quit"

    do {
        Write-Host ""
        $choice = Read-Host "Make your choice"
        switch ($choice) {
            1 { check }
            2 { events }
            3 { bob }
            4 { read_config}
            5 { search_plus}
            6 { search_company}
            7 { set_env}
        }
    } until (
        $choice -eq 'q'
    )
}

Function bob {
    param()
    $state = "Initialised"
    try {
        Write-Host -ForegroundColor Blue "Bob Happened"
        # Open new session as localadmin, you really shouldnt run this as admin but someone will
        if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
            {  
            $arguments = "& '" +$myinvocation.mycommand.definition + "'"
            Start-Process powershell -Verb runAs -ArgumentList $arguments
            Write-Host -ForegroundColor Blue "Bob Totally Happened"
            Break
            }
        $state = "Initialised Plus One"
        Write-Host -ForegroundColor Blue "Bob Totally, Fully Happened"
        #Enter-PSSession -computerName $target
        Write-Host -ForegroundColor Blue "Bob Totally, Fully Happened"
    }
    catch {
        <#Do this if a terminating exception happens#>
        $state = "Initialised Plus Error"
    }
    finally {
        <#Do this after the try block regardless of whether an exception occurred or not#>
        Write-Host "Final Status is $state"
    }
}

# Check the status of a machine
Function check {
    param()
    $state = "Checking"
    try {
        Write-Host -ForegroundColor Red "Check for response"
        # Check for updates here
        Test-Connection $target

        Write-Host -ForegroundColor Red "Check for updates"
        #Get-WindowsEdition
        #get-windowsupdate requires install-module ...
        wmic qfe list
        
        Write-Host -ForegroundColor Red "Check for Errors"
        # Check for event log errors here       
        #get-eventlog
        #get-winevent
        
        Write-Host -ForegroundColor Red "Check for more info"
        # Check for more info here      
        # maybe test-path?
        # maybe get-item and get-content?
        # maybe get-process
        # maybe get-service
        # maybe more?
        # check registry keys?
        $state = "Checked."
    }
    catch {
        <#Do this if a terminating exception happens#>
        $state = "Exception Happened."
    }
    finally {
        <#Do this after the try block regardless of whether an exception occurred or not#>
        Write-Host "Status is $state"
    }
}

# Check event logs with get-eventlogs
Function events {
    param()
    $state = "Events"
    try {
        Write-Host -ForegroundColor Blue "Events Happened"
        Get-Error -newest 3
        # Show event log here, maybe last 50, error and warning only?
        Get-WinEvent -ListLog *
        # try $error | get-error
        #Get-EventLog -LogName System -EntryType Error
    }
    catch {
        <#Do this if a terminating exception happens#>
    }
    finally {
        <#Do this after the try block regardless of whether an exception occurred or not#>
        Write-Host "Status is $state"
    }
}

Function read_config {
    param()
    $state = "Configured"
    try {
        Write-Host -ForegroundColor Green "Config is ..."
    }
    catch {
        <#Do this if a terminating exception happens#>
    }
    finally {
        <#Do this after the try block regardless of whether an exception occurred or not#>
        Write-Host "Status is $state"
    }
}

Function search_plus {
    param()
    $state = "Searching"
    try {
        Write-Host -ForegroundColor Yellow "Mr Worldwide"
    }
    catch {
        <#Do this if a terminating exception happens#>
    }
    finally {
        <#Do this after the try block regardless of whether an exception occurred or not#>
        Write-Host "Status is $state"
    }
}

# Company Lookup and Reputation check as search_company
Function search_company {
    param()
    $state = "Searching Company"
    try {
        Write-Host -ForegroundColor Yellow "Check all business registers"
    }
    catch {
        <#Do this if a terminating exception happens#>
    }
    finally {
        <#Do this after the try block regardless of whether an exception occurred or not#>
        Write-Host "Status is $state"
    }
}

# Company Lookup and Reputation check as search_company
Function set_env {
    param()
    $state = "Environment Raw"
    try {
        Write-Host -ForegroundColor Yellow "Check all requirements"
        pwsh -version

        # Windows verions
        Get-ComputerInfo | Select-Object CSCaption, CSDNSName, CsDomain, CsManufacturer, CsModel, CsName, CsProcessors, OSName, OsType, OsOperatingSKU, OSVersion, OSArchitecture, OSInstallDate, OSOrganization, OSRegisteredUser, OsStatus, WindowsCurrentVersion, WindowsEditionID, WindowsInstallationType, WindowsRegisteredOrganization, WindowsRegisteredOwner, LogonServer, TimeZone

        # Update-Help
        #Update-Help -Confirm
        Write-Host -ForegroundColor Yellow "Check for upgrades"
        #update-installed
        winget
        #winget upgrade Powershell 7-x64
        Write-Host -ForegroundColor Red "If you wish to upgrade you must run each manually, or contact your admin for --all."

        #Get-Module
        Get-Module -ListAvailable

        $state = "Environment Refreshed"
    }
    catch {
        <#Do this if a terminating exception happens#>
    }
    finally {
        <#Do this after the try block regardless of whether an exception occurred or not#>
        Write-Host "Status is $state"
    }
}

# Main here
Clear-Host
#(Get-Host).UI.RawUI.BackgroundColor = "Black"
#Clear-Host
Write-Host -foregroundColor Blue It all Starts here - last chance to bail out!
Write-Host -foregroundColor Red "Target is $target"
Write-Host
Read-Host "Press enter to continue" #pause
# Show menu until q is chosen
Menu



