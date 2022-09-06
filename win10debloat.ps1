Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

# GUI Specs
Write-Host "Checking winget..."

# Check if winget is installed
if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe){
    'Winget Already Installed'
}  
else{
    # Installing winget from the Microsoft Store
	Write-Host "Winget not found, installing it now."
    $ResultText.text = "`r`n" +"`r`n" + "Installing Winget... Please Wait"
	Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
	$nid = (Get-Process AppInstaller).Id
	Wait-Process -Id $nid
	Write-Host Winget Installed
    $ResultText.text = "`r`n" +"`r`n" + "Winget Installed - Ready for Next Task"
}

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050,1000)
$Form.text                       = "Windows Toolbox By mtv47"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#e9e9e9")
$Form.AutoScaleDimensions     = '192, 192'
$Form.AutoScaleMode           = "Dpi"
$Form.AutoSize                = $True
$Form.AutoScroll              = $True
$Form.ClientSize              = '1050, 1000'
$Form.FormBorderStyle         = 'FixedSingle'

$Form.Width                   = $objImage.Width
$Form.Height                  = $objImage.Height


$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 939
$Panel1.width                    = 219
$Panel1.location                 = New-Object System.Drawing.Point(6,54)


# ------------------------------------------------------------------------------------------------
# Utilities Menu

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Install"
$Label1.AutoSize                 = $true
$Label1.width                    = 230
$Label1.height                   = 25
$Label1.location                 = New-Object System.Drawing.Point(126,11)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Utilities"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(89,11)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))


# Windows Terminal

$winterminal                     = New-Object system.Windows.Forms.Button
$winterminal.text                = "Windows Terminal"
$winterminal.width               = 211
$winterminal.height              = 30
$winterminal.location            = New-Object System.Drawing.Point(3,32)
$winterminal.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$winterminal.Add_Click({
    Write-Host "Installing New Windows Terminal"
    $ResultText.text = "`r`n" +"`r`n" + "Installing New Windows Terminal... Please Wait" 
    winget install -e Microsoft.WindowsTerminal | Out-Host
    if($?) { Write-Host "Installed New Windows Terminal" }
    $ResultText.text = "`r`n" + "Finished Installing New Windows Terminal" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# PowerToys

$powertoys                       = New-Object system.Windows.Forms.Button
$powertoys.text                  = "PowerToys"
$powertoys.width                 = 211
$powertoys.height                = 30
$powertoys.location              = New-Object System.Drawing.Point(4,67)
$powertoys.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$powertoys.Add_Click({
    Write-Host "Installing Microsoft PowerToys"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Microsoft PowerToys... Please Wait" 
    winget install -e Microsoft.PowerToys | Out-Host
    if($?) { Write-Host "Installed Microsoft PowerToys" }
    $ResultText.text = "`r`n" + "Finished Installing Microsoft PowerToys" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# 7-Zip

$7zip                            = New-Object system.Windows.Forms.Button
$7zip.text                       = "7-Zip"
$7zip.width                      = 211
$7zip.height                     = 30
$7zip.location                   = New-Object System.Drawing.Point(4,102)
$7zip.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$7zip.Add_Click({
    Write-Host "Installing 7-Zip Compression Tool"
    $ResultText.text = "`r`n" +"`r`n" + "Installing 7-Zip Compression Tool... Please Wait" 
    winget install -e 7zip.7zip | Out-Host
    if($?) { Write-Host "Installed 7-Zip Compression Tool" }
    $ResultText.text = "`r`n" + "Finished Installing 7-Zip Compression Tool" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Etcher

$etcher                          = New-Object system.Windows.Forms.Button
$etcher.text                     = "Etcher USB Creator"
$etcher.width                    = 211
$etcher.height                   = 30
$etcher.location                 = New-Object System.Drawing.Point(4,136)
$etcher.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$etcher.Add_Click({
    Write-Host "Installing Etcher USB Imager"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Etcher USB Imager... Please Wait" 
    winget install -e Balena.Etcher | Out-Host
    Write-Host "Installed Etcher USB Imager"
    $ResultText.text = "`r`n" + "Finished Installing Etcher USB Imager" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Putty

$putty                           = New-Object system.Windows.Forms.Button
$putty.text                      = "PuTTY & WinSCP"
$putty.width                     = 211
$putty.height                    = 30
$putty.location                  = New-Object System.Drawing.Point(4,170)
$putty.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$putty.Add_Click({
    Write-Host "Installing PuTTY & WinSCP"
    $ResultText.text = "`r`n" +"`r`n" + "Installing PuTTY & WinSCP... Please Wait" 
    winget install -e PuTTY.PuTTY | Out-Host
    winget install -e WinSCP.WinSCP | Out-Host
    Write-Host "Installed PuTTY & WinSCP"
    $ResultText.text = "`r`n" + "Finished Installing PuTTY & WinSCP" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Advanced IP Scanner

$advancedipscanner               = New-Object system.Windows.Forms.Button
$advancedipscanner.text          = "Advanced IP Scanner"
$advancedipscanner.width         = 211
$advancedipscanner.height        = 30
$advancedipscanner.location      = New-Object System.Drawing.Point(3,203)
$advancedipscanner.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$advancedipscanner.Add_Click({
    Write-Host "Installing Advanced IP Scanner"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Advanced IP Scanner... Please Wait" 
    winget install -e Famatech.AdvancedIPScanner | Out-Host
    Write-Host "Installed Advanced IP Scanner"
    $ResultText.text = "`r`n" + "Finished Installing Advanced IP Scanner" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# CPU-Z

$cpuZ                            = New-Object system.Windows.Forms.Button
$cpuZ.text                       = "CPU-Z"
$cpuZ.width                      = 211
$cpuZ.height                     = 30
$cpuZ.location                   = New-Object System.Drawing.Point(3,237)
$cpuZ.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$cpuZ.Add_Click({
    Write-Host "Installing CPU-Z"
    $ResultText.text = "`r`n" +"`r`n" + "Installing CPU-Z... Please Wait" 
    winget install -e CPUID.CPU-Z | Out-Host
    Write-Host "Installed CPU-Z"
    $ResultText.text = "`r`n" + "Finished Installing CPU-Z" + "`r`n" + "`r`n" + "Ready for Next Task"
})

# GPU-Z

$gpuZ                            = New-Object system.Windows.Forms.Button
$gpuZ.text                       = "GPU-Z"
$gpuZ.width                      = 211
$gpuZ.height                     = 30
$gpuZ.location                   = New-Object System.Drawing.Point(3,271)
$gpuZ.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$gpuZ.Add_Click({
    Write-Host "Installing GPU-Z"
    $ResultText.text = "`r`n" +"`r`n" + "Installing GPU-Z... Please Wait" 
    winget install -e TechPowerUp.GPU-Z | Out-Host
    Write-Host "Installed GPU-Z"
    $ResultText.text = "`r`n" + "Finished Installing GPU-Z" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# HWiNFO

$hwinfotool                      = New-Object system.Windows.Forms.Button
$hwinfotool.text                 = "HWiNFO"
$hwinfotool.width                = 211
$hwinfotool.height               = 30
$hwinfotool.location             = New-Object System.Drawing.Point(3,305)
$hwinfotool.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$hwinfotool.Add_Click({
    Write-Host "Installing HWiNFO"
    $ResultText.text = "`r`n" +"`r`n" + "Installing HWiNFO... Please Wait" 
    winget install -e HWiNFO.HWiNFO | Out-Host
    Write-Host "Installed HWiNFO"
    $ResultText.text = "`r`n" + "Finished Installing HWiNFO" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# CrystalDiskInfo

$crystaldiskinfo                 = New-Object system.Windows.Forms.Button
$crystaldiskinfo.text            = "CrystalDiskInfo"
$crystaldiskinfo.width           = 211
$crystaldiskinfo.height          = 30
$crystaldiskinfo.location        = New-Object System.Drawing.Point(3,339)
$crystaldiskinfo.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$crystaldiskinfo.Add_Click({
    Write-Host "Installing CrystalDiskInfo"
    $ResultText.text = "`r`n" +"`r`n" + "Installing CrystalDiskInfo... Please Wait" 
    winget install -e CrystalDewWorld.CrystalDiskInfo | Out-Host
    Write-Host "Installed CrystalDiskInfo"
    $ResultText.text = "`r`n" + "Finished Installing CrystalDiskInfo" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# CrystalDiskMark

$crystaldiskmark                 = New-Object system.Windows.Forms.Button
$crystaldiskmark.text            = "CrystalDiskMark"
$crystaldiskmark.width           = 211
$crystaldiskmark.height          = 30
$crystaldiskmark.location        = New-Object System.Drawing.Point(3,373)
$crystaldiskmark.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$crystaldiskmark.Add_Click({
    Write-Host "Installing CrystalDiskMark"
    $ResultText.text = "`r`n" +"`r`n" + "Installing CrystalDiskMark... Please Wait" 
    winget install -e CrystalDewWorld.CrystalDiskMark | Out-Host
    Write-Host "Installed CrystalDiskMark"
    $ResultText.text = "`r`n" + "Finished Installing CrystalDiskMark" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# RevoUninstaller

$revouninstaller                 = New-Object system.Windows.Forms.Button
$revouninstaller.text            = "RevoUninstaller"
$revouninstaller.width           = 211
$revouninstaller.height          = 30
$revouninstaller.location        = New-Object System.Drawing.Point(3,407)
$revouninstaller.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$revouninstaller.Add_Click({
    Write-Host "Installing RevoUninstaller"
    $ResultText.text = "`r`n" +"`r`n" + "Installing RevoUninstaller... Please Wait" 
    winget install -e VSRevoGroup.RevoUninstaller | Out-Host
    Write-Host "Installed RevoUninstaller"
    $ResultText.text = "`r`n" + "Finished Installing RevoUninstaller" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# NVCleanstall

$nvcleanstall                    = New-Object system.Windows.Forms.Button
$nvcleanstall.text               = "NVCleanstall"
$nvcleanstall.width              = 211
$nvcleanstall.height             = 30
$nvcleanstall.location           = New-Object System.Drawing.Point(3,441)
$nvcleanstall.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$nvcleanstall.Add_Click({
    Write-Host "Installing NVCleanstall"
    $ResultText.text = "`r`n" +"`r`n" + "Installing NVCleanstall... Please Wait" 
    winget install -e TechPowerUp.NVCleanstall | Out-Host
    Write-Host "Installed NVCleanstall"
    $ResultText.text = "`r`n" + "Finished Installing NVCleanstall" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Malwarebytes

$malwarebytes                    = New-Object system.Windows.Forms.Button
$malwarebytes.text               = "Malwarebytes"
$malwarebytes.width              = 211
$malwarebytes.height             = 30
$malwarebytes.location           = New-Object System.Drawing.Point(3,475)
$malwarebytes.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$malwarebytes.Add_Click({
    Write-Host "Installing Malwarebytes"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Malwarebytes... Please Wait" 
    winget install -e Malwarebytes.Malwarebytes | Out-Host
    Write-Host "Installed Malwarebytes"
    $ResultText.text = "`r`n" + "Finished Installing Malwarebytes" + "`r`n" + "`r`n" + "Ready for Next Task"
})

# ------------------------------------------------------------------------------------------------
# Web Browsers Menu
$Label9                          = New-Object system.Windows.Forms.Label
$Label9.text                     = "Web Browsers"
$Label9.AutoSize                 = $true
$Label9.width                    = 25
$Label9.height                   = 10
$Label9.location                 = New-Object System.Drawing.Point(67,546)
$Label9.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))


# Brave

$brave                           = New-Object system.Windows.Forms.Button
$brave.text                      = "Brave Browser"
$brave.width                     = 212
$brave.height                    = 30
$brave.location                  = New-Object System.Drawing.Point(4,566)
$brave.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$brave.Add_Click({
    Write-Host "Installing Brave Browser"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Brave... Please Wait" 
    winget install -e BraveSoftware.BraveBrowser | Out-Host
    if($?) { Write-Host "Installed Brave Browser" }
    $ResultText.text = "`r`n" + "Finished Installing Brave" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Firefox

$firefox                         = New-Object system.Windows.Forms.Button
$firefox.text                    = "LibreWolf"
$firefox.width                   = 212
$firefox.height                  = 30
$firefox.location                = New-Object System.Drawing.Point(4,601)
$firefox.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$firefox.Add_Click({
    Write-Host "Installing LibreWolf"
    $ResultText.text = "`r`n" +"`r`n" + "Installing LibreWolf... Please Wait" 
    winget install -e LibreWolf.LibreWolf | Out-Host
    if($?) { Write-Host "Installed LibreWolf" }
    $ResultText.text = "`r`n" + "Finished Installing LibreWolf" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Chrome

$gchrome                         = New-Object system.Windows.Forms.Button
$gchrome.text                    = "Google Chrome"
$gchrome.width                   = 212
$gchrome.height                  = 30
$gchrome.location                = New-Object System.Drawing.Point(3,634)
$gchrome.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$gchrome.Add_Click({
    Write-Host "Installing Google Chrome"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Google Chrome... Please Wait" 
    winget install -e Google.Chrome | Out-Host
    if($?) { Write-Host "Installed Google Chrome" }
    $ResultText.text = "`r`n" + "Finished Installing Google Chrome" + "`r`n" + "`r`n" + "Ready for Next Task"
})

# ------------------------------------------------------------------------------------------------
# Video and Image Menu
$Label8                          = New-Object system.Windows.Forms.Label
$Label8.text                     = "Video and Image Tools"
$Label8.AutoSize                 = $true
$Label8.width                    = 25
$Label8.height                   = 10
$Label8.location                 = New-Object System.Drawing.Point(41,677)
$Label8.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))


# GIMP

$gimp                            = New-Object system.Windows.Forms.Button
$gimp.text                       = "GIMP (Image Editor)"
$gimp.width                      = 212
$gimp.height                     = 30
$gimp.location                   = New-Object System.Drawing.Point(3,701)
$gimp.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$gimp.Add_Click({
    Write-Host "Installing Gimp Image Editor"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Gimp Image Editor... Please Wait" 
    winget install -e GIMP.GIMP | Out-Host
    Write-Host "Installed Gimp Image Editor"
    $ResultText.text = "`r`n" + "Finished Installing Gimp Image Editor" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# VLC

$vlc                             = New-Object system.Windows.Forms.Button
$vlc.text                        = "VLC"
$vlc.width                       = 212
$vlc.height                      = 30
$vlc.location                    = New-Object System.Drawing.Point(4,735)
$vlc.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$vlc.Add_Click({
    Write-Host "Installing VLC Media Player"
    $ResultText.text = "`r`n" +"`r`n" + "Installing VLC Media Player... Please Wait" 
    winget install -e VideoLAN.VLC | Out-Host
    if($?) { Write-Host "Installed VLC Media Player" }
    $ResultText.text = "`r`n" + "Finished Installing VLC Media Player" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Spotify

$spotify                         = New-Object system.Windows.Forms.Button
$spotify.text                    = "Spotify"
$spotify.width                   = 212
$spotify.height                  = 30
$spotify.location                = New-Object System.Drawing.Point(4,769)
$spotify.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$spotify.Add_Click({
    Write-Host "Installing Spotify"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Spotify... Please Wait" 
    winget install -e Spotify.Spotify | Out-Host
    if($?) { Write-Host "Installed Spotify" }
    $ResultText.text = "`r`n" + "Finished Installing Spotify" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# ------------------------------------------------------------------------------------------------
# Coding Menu

$Label7                          = New-Object system.Windows.Forms.Label
$Label7.text                     = "Coding Tools"
$Label7.AutoSize                 = $true
$Label7.width                    = 25
$Label7.height                   = 10
$Label7.location                 = New-Object System.Drawing.Point(60,832)
$Label7.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))


# Github Desktop

$githubdesktop                   = New-Object system.Windows.Forms.Button
$githubdesktop.text              = "Github Desktop"
$githubdesktop.width             = 211
$githubdesktop.height            = 30
$githubdesktop.location          = New-Object System.Drawing.Point(4,853)
$githubdesktop.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$githubdesktop.Add_Click({
    Write-Host "Installing Git and GitHub Desktop"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Git and GitHub Desktop... Please Wait" 
    winget install -e Git.Git | Out-Host
    winget install -e GitHub.GitHubDesktop | Out-Host
    Write-Host "Installed Git and Github Desktop"
    $ResultText.text = "`r`n" + "Finished Installing Git and GitHub Desktop" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# VS Code

$vscode                          = New-Object system.Windows.Forms.Button
$vscode.text                     = "VS Code"
$vscode.width                    = 211
$vscode.height                   = 30
$vscode.location                 = New-Object System.Drawing.Point(4,887)
$vscode.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$vscode.Add_Click({
    Write-Host "Installing Visual Studio Code"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Visual Studio Code... Please Wait" 
    winget install -e Microsoft.VisualStudioCode --source winget | Out-Host
    if($?) { Write-Host "Installed Visual Studio Code" }
    $ResultText.text = "`r`n" + "Finished Installing Visual Studio Code" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# ------------------------------------------------------------------------------------------------
# Other Installs Menu
$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 938
$Panel2.width                    = 211
$Panel2.location                 = New-Object System.Drawing.Point(240,54)

# ------------------------------------------------------------------------------------------------
# Communication Menu
$Label11                         = New-Object System.Windows.Forms.Label
$Label11.text                    = "Communication"
$Label11.width                   = 230
$Label11.height                  = 25
$Label11.location                = New-Object System.Drawing.Point(57,5)
$Label11.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

# Discord

$discord                         = New-Object system.Windows.Forms.Button
$discord.text                    = "Discord"
$discord.width                   = 211
$discord.height                  = 30
$discord.location                = New-Object System.Drawing.Point(3,33)
$discord.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$discord.Add_Click({
    Write-Host "Installing Discord"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Discord... Please Wait" 
    winget install -e Discord.Discord | Out-Host
    if($?) { Write-Host "Installed Discord" }
    $ResultText.text = "`r`n" + "Finished Installing Discord" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Telegram

$telegram                        = New-Object system.Windows.Forms.Button
$telegram.text                   = "Telegram"
$telegram.width                  = 211
$telegram.height                 = 30
$telegram.location               = New-Object System.Drawing.Point(3,67)
$telegram.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$telegram.Add_Click({
    Write-Host "Installing Telegram"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Telegram... Please Wait" 
    winget install -e Telegram.TelegramDesktop | Out-Host
    if($?) { Write-Host "Installed Telegram" }
    $ResultText.text = "`r`n" + "Finished Installing Telegram" + "`r`n" + "`r`n" + "Ready for Next Task"
})




# ------------------------------------------------------------------------------------------------
# System Menu
$Panel3                          = New-Object system.Windows.Forms.Panel
$Panel3.height                   = 381
$Panel3.width                    = 220
$Panel3.location                 = New-Object System.Drawing.Point(464,54)

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "System Tweaks"
$Label3.AutoSize                 = $true
$Label3.width                    = 230
$Label3.height                   = 25
$Label3.location                 = New-Object System.Drawing.Point(450,11)
$Label3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',24)


# DarkMode

$darkmode                        = New-Object system.Windows.Forms.Button
$darkmode.text                   = "Dark Mode"
$darkmode.width                  = 205
$darkmode.height                 = 30
$darkmode.location               = New-Object System.Drawing.Point(7,32)
$darkmode.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$darkmode.Add_Click({
    Write-Host "Enabling Dark Mode"
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
    Write-Host "Enabled Dark Mode"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Dark Mode"
})


# LightMode

$lightmode                       = New-Object system.Windows.Forms.Button
$lightmode.text                  = "Light Mode"
$lightmode.width                 = 205
$lightmode.height                = 30
$lightmode.location              = New-Object System.Drawing.Point(7,64)
$lightmode.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$lightmode.Add_Click({
    Write-Host "Switching Back to Light Mode"
    Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme
    Write-Host "Switched Back to Light Mode"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Light Mode"
})


# PerformamnceFX

$performancefx                   = New-Object system.Windows.Forms.Button
$performancefx.text              = "Performance Visual FX"
$performancefx.width             = 205
$performancefx.height            = 30
$performancefx.location          = New-Object System.Drawing.Point(7,100)
$performancefx.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$performancefx.Add_Click({
    Write-Host "Adjusting visual effects for performance..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 200
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0))
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0
    Write-Host "Adjusted visual effects for performance"
    $ResultText.text = "`r`n" +"`r`n" + "Adjusted VFX for performance"
})


# AppearanceFX

$appearancefx                    = New-Object system.Windows.Forms.Button
$appearancefx.text               = "Appearance Visual FX"
$appearancefx.width              = 205
$appearancefx.height             = 30
$appearancefx.location           = New-Object System.Drawing.Point(7,134)
$appearancefx.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$appearancefx.Add_Click({
	Write-Output "Adjusting visual effects for appearance..."
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 400
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](158,30,7,128,18,0,0,0))
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 1
    $ResultText.text = "`r`n" +"`r`n" + "Visual effects are set for appearance (Defaults)"
})


# ----------------------------------------------------------------------------------------------------------------------
# Old Pannels

$ncpa                            = New-Object system.Windows.Forms.Button
$ncpa.text                       = "Network Connections"
$ncpa.width                      = 211
$ncpa.height                     = 30
$ncpa.location                   = New-Object System.Drawing.Point(7,179)
$ncpa.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$ncpa.Add_Click({
    cmd /c ncpa.cpl
})

$oldcontrolpanel                 = New-Object system.Windows.Forms.Button
$oldcontrolpanel.text            = "Win7 Control Panel"
$oldcontrolpanel.width           = 211
$oldcontrolpanel.height          = 30
$oldcontrolpanel.location        = New-Object System.Drawing.Point(7,213)
$oldcontrolpanel.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldcontrolpanel.Add_Click({
    cmd /c control
})


$oldpower                        = New-Object system.Windows.Forms.Button
$oldpower.text                   = "Win7 Power Panel"
$oldpower.width                  = 211
$oldpower.height                 = 30
$oldpower.location               = New-Object System.Drawing.Point(7,247)
$oldpower.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldpower.Add_Click({
    cmd /c powercfg.cpl
})


$oldsoundpanel                   = New-Object system.Windows.Forms.Button
$oldsoundpanel.text              = "Win7 Sound Panel"
$oldsoundpanel.width             = 211
$oldsoundpanel.height            = 30
$oldsoundpanel.location          = New-Object System.Drawing.Point(7,282)
$oldsoundpanel.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldsoundpanel.Add_Click({
    cmd /c mmsys.cpl
})


$oldsystempanel                  = New-Object system.Windows.Forms.Button
$oldsystempanel.text             = "Win7 System Panel"
$oldsystempanel.width            = 211
$oldsystempanel.height           = 30
$oldsystempanel.location         = New-Object System.Drawing.Point(7,318)
$oldsystempanel.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldsystempanel.Add_Click({
    cmd /c sysdm.cpl
})


# ------------------------------------------------------------------------------------------------------------------------------
# Windows Update

$Panel4                          = New-Object system.Windows.Forms.Panel
$Panel4.height                   = 328
$Panel4.width                    = 340
$Panel4.location                 = New-Object System.Drawing.Point(699,54)

$Label15                         = New-Object system.Windows.Forms.Label
$Label15.text                    = "Windows Update"
$Label15.AutoSize                = $true
$Label15.width                   = 25
$Label15.height                  = 10
$Label15.location                = New-Object System.Drawing.Point(732,11)
$Label15.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

# Only security updates

$securitywindowsupdate           = New-Object system.Windows.Forms.Button
$securitywindowsupdate.text      = "Security Updates Only"
$securitywindowsupdate.width     = 300
$securitywindowsupdate.height    = 30
$securitywindowsupdate.location  = New-Object System.Drawing.Point(24,32)
$securitywindowsupdate.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$securitywindowsupdate.Add_Click({
    Write-Host "Disabling driver offering through Windows Update..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
    Write-Host "Disabling Windows Update automatic restart..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Write-Host "Disabled driver offering through Windows Update"
    $ResultText.text = "`r`n" +"`r`n" + "Set Windows Update to Sane Settings"
})

# All updates

$windowsupdatefix                = New-Object system.Windows.Forms.Button
$windowsupdatefix.text           = "Windows Update Reset"
$windowsupdatefix.width          = 300
$windowsupdatefix.height         = 30
$windowsupdatefix.location       = New-Object System.Drawing.Point(25,66)
$windowsupdatefix.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$windowsupdatefix.Add_Click({
    Write-Host "1. Stopping Windows Update Services..." 
    Stop-Service -Name BITS 
    Stop-Service -Name wuauserv 
    Stop-Service -Name appidsvc 
    Stop-Service -Name cryptsvc 
    
    Write-Host "2. Remove QMGR Data file..." 
    Remove-Item "$env:allusersprofile\Application Data\Microsoft\Network\Downloader\qmgr*.dat" -ErrorAction SilentlyContinue 
    
    Write-Host "3. Renaming the Software Distribution and CatRoot Folder..." 
    Rename-Item $env:systemroot\SoftwareDistribution SoftwareDistribution.bak -ErrorAction SilentlyContinue 
    Rename-Item $env:systemroot\System32\Catroot2 catroot2.bak -ErrorAction SilentlyContinue 
    
    Write-Host "4. Removing old Windows Update log..." 
    Remove-Item $env:systemroot\WindowsUpdate.log -ErrorAction SilentlyContinue 
    
    Write-Host "5. Resetting the Windows Update Services to defualt settings..." 
    "sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)" 
    "sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)" 
    
    Set-Location $env:systemroot\system32 
    
    Write-Host "6. Registering some DLLs..." 
    regsvr32.exe /s atl.dll 
    regsvr32.exe /s urlmon.dll 
    regsvr32.exe /s mshtml.dll 
    regsvr32.exe /s shdocvw.dll 
    regsvr32.exe /s browseui.dll 
    regsvr32.exe /s jscript.dll 
    regsvr32.exe /s vbscript.dll 
    regsvr32.exe /s scrrun.dll 
    regsvr32.exe /s msxml.dll 
    regsvr32.exe /s msxml3.dll 
    regsvr32.exe /s msxml6.dll 
    regsvr32.exe /s actxprxy.dll 
    regsvr32.exe /s softpub.dll 
    regsvr32.exe /s wintrust.dll 
    regsvr32.exe /s dssenh.dll 
    regsvr32.exe /s rsaenh.dll 
    regsvr32.exe /s gpkcsp.dll 
    regsvr32.exe /s sccbase.dll 
    regsvr32.exe /s slbcsp.dll 
    regsvr32.exe /s cryptdlg.dll 
    regsvr32.exe /s oleaut32.dll 
    regsvr32.exe /s ole32.dll 
    regsvr32.exe /s shell32.dll 
    regsvr32.exe /s initpki.dll 
    regsvr32.exe /s wuapi.dll 
    regsvr32.exe /s wuaueng.dll 
    regsvr32.exe /s wuaueng1.dll 
    regsvr32.exe /s wucltui.dll 
    regsvr32.exe /s wups.dll 
    regsvr32.exe /s wups2.dll 
    regsvr32.exe /s wuweb.dll 
    regsvr32.exe /s qmgr.dll 
    regsvr32.exe /s qmgrprxy.dll 
    regsvr32.exe /s wucltux.dll 
    regsvr32.exe /s muweb.dll 
    regsvr32.exe /s wuwebv.dll 
    
    Write-Host "7) Removing WSUS client settings..." 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f 
    
    Write-Host "8) Resetting the WinSock..." 
    netsh winsock reset 
    netsh winhttp reset proxy 
    
    Write-Host "9) Delete all BITS jobs..." 
    Get-BitsTransfer | Remove-BitsTransfer 
    
    Write-Host "10) Attempting to install the Windows Update Agent..." 
    if($arch -eq 64){ 
        wusa Windows8-RT-KB2937636-x64 /quiet 
    } 
    else{ 
        wusa Windows8-RT-KB2937636-x86 /quiet 
    } 
    
    Write-Host "11) Starting Windows Update Services..." 
    Start-Service -Name BITS 
    Start-Service -Name wuauserv 
    Start-Service -Name appidsvc 
    Start-Service -Name cryptsvc 
    
    Write-Host "12) Forcing discovery..." 
    wuauclt /resetauthorization /detectnow 
    
    Write-Host "Process complete. Please reboot your computer."
    $ResultText.text = "`r`n" +"`r`n" + "Process complete. Please reboot your computer."

})


# ------------------------------------------------------------------------------------------------------------------------------
# Windows Bloatware
$WarningLabel                    = New-Object system.Windows.Forms.Label
$WarningLabel.text               = "Warning! This will break Microsoft Store"
$WarningLabel.AutoSize           = $true
$WarningLabel.width              = 25
$WarningLabel.height             = 10
$WarningLabel.location           = New-Object System.Drawing.Point(12,856)
$WarningLabel.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',8)

$Bloatware = @(
    #Unnecessary Windows 10 AppX Apps
    "Microsoft.3DBuilder"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.AppConnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingTranslator"
    "Microsoft.BingWeather"
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.BingTravel"
    "Microsoft.MinecraftUWP"
    "Microsoft.GamingServices"
    # "Microsoft.WindowsReadingList"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"
    "Microsoft.Office.Lens"
    "Microsoft.Office.Sway"
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.SkypeApp"
    "Microsoft.Wallet"
    "Microsoft.Whiteboard"
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.XboxApp"
    "Microsoft.ConnectivityStore"
    "Microsoft.CommsPhone"
    "Microsoft.ScreenSketch"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGameCallableUI"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.MixedReality.Portal"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.YourPhone"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"

    #Sponsored Windows 10 AppX Apps
    #Add sponsored/featured apps to remove in the "*AppName*" format
    "*EclipseManager*"
    "*ActiproSoftwareLLC*"
    "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
    "*Duolingo-LearnLanguagesforFree*"
    "*PandoraMediaInc*"
    "*CandyCrush*"
    "*BubbleWitch3Saga*"
    "*Wunderlist*"
    "*Flipboard*"
    "*Twitter*"
    "*Facebook*"
    "*Royal Revolt*"
    "*Sway*"
    "*Speed Test*"
    "*Dolby*"
    "*Viber*"
    "*ACGMediaPlayer*"
    "*Netflix*"
    "*OneCalendar*"
    "*LinkedInforWindows*"
    "*HiddenCityMysteryofShadows*"
    "*Hulu*"
    "*HiddenCity*"
    "*AdobePhotoshopExpress*"
    "*HotspotShieldFreeVPN*"

    #Optional: Typically not removed but you can if you need to for some reason
    "*Microsoft.Advertising.Xaml*"
    #"*Microsoft.MSPaint*"
    #"*Microsoft.MicrosoftStickyNotes*"
    #"*Microsoft.Windows.Photos*"
    #"*Microsoft.WindowsCalculator*"
    #"*Microsoft.WindowsStore*"
)


# Remove bloated apps

$removebloat                     = New-Object system.Windows.Forms.Button
$removebloat.text                = "Remove MS Store Apps"
$removebloat.width               = 204
$removebloat.height              = 34
$removebloat.location            = New-Object System.Drawing.Point(3,898)
$removebloat.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$removebloat.Add_Click({
    Write-Host "Removing Bloatware"

    foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $Bloat| Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
        Write-Host "Trying to remove $Bloat."
        $ResultText.text = "`r`n" +"`r`n" + "Trying to remove $Bloat."
    }

    Write-Host "Finished Removing Bloatware Apps"
    $ResultText.text = "`r`n" +"`r`n" + "Finished Removing Bloatware Apps"
})


# Reinstate bloatware

$reinstallbloat                  = New-Object system.Windows.Forms.Button
$reinstallbloat.text             = "Reinstall MS Store Apps"
$reinstallbloat.width            = 205
$reinstallbloat.height           = 30
$reinstallbloat.location         = New-Object System.Drawing.Point(3,813)
$reinstallbloat.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$reinstallbloat.Add_Click({
    Write-Host "Reinstalling Bloatware"

    foreach ($app in $Bloatware) {
        Write-Output "Trying to add $app"
        $ResultText.text = "`r`n" +"`r`n" + "Trying to add $app"
        Add-AppxPackage -DisableDevelopmentMode -Register "$($(Get-AppxPackage -AllUsers $app).InstallLocation)\AppXManifest.xml"
    }

    Write-Host "Finished Reinstalling Bloatware Apps"
    $ResultText.text = "`r`n" +"`r`n" + "Finished Reinstalling Bloatware Apps"
})


# ------------------------------------------------------------------------------------------------------------------------------
# Outputs

$ResultText                      = New-Object system.Windows.Forms.TextBox
$ResultText.multiline            = $true
$ResultText.width                = 382
$ResultText.height               = 130
$ResultText.location             = New-Object System.Drawing.Point(576,491)
$ResultText.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label10                         = New-Object system.Windows.Forms.Label
$Label10.text                    = "Current Status:"
$Label10.AutoSize                = $true
$Label10.width                   = 25
$Label10.height                  = 10
$Label10.location                = New-Object System.Drawing.Point(658,448)
$Label10.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',24)


# ------------------------------------------------------------------------------------------------------------------------------
# Add the controls to the form

$Form.controls.AddRange(@($Panel1,$Panel2,$Label3,$Label15,$Panel4,$Label1,$Panel3,$ResultText,$Label10))
$Panel1.controls.AddRange(@($brave,$firefox,$7zip,$adobereade,$gchrome,$vlc,$powertoys,$winterminal,$vscode,$Label2,$gimp,$Label7,$Label8,$Label9,$advancedipscanner,$putty,$etcher,$githubdesktop,$cpuZ,$gpuZ,$hwinfotool,$CrystalDiskInfo,$spotify,$crystaldiskmark,$revouninstaller,$nvcleanstall,$malwarebytes))
$Panel2.controls.AddRange(@($Label11,$discord,$telegram))
$Panel3.controls.AddRange(@($darkmode,$performancefx,$lightmode,$removebloat,$reinstallbloat,$WarningLabel,$appearancefx,$ncpa,$oldcontrolpanel,$oldsoundpanel,$oldsystempanel,$oldpower))
$Panel4.controls.AddRange(@($securitywindowsupdate,$windowsupdatefix))

[void]$Form.ShowDialog()