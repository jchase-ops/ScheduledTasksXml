# .ExternalHelp $PSScriptRoot\New-ScheduledTaskSettingsXml-help.xml
function New-ScheduledTaskSettingsXml {

    [CmdletBinding()]

    Param (

        [Parameter(Mandatory = $false, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $AllowHardTerminate = $true,

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $AllowStartOnDemand = $true,

        [Parameter(Mandatory = $false, Position = 2)]
        [ValidateScript({ $_ -le $(New-TimeSpan -Days 31) })]
        [System.TimeSpan]
        $DeleteExpiredTaskAfter,

        [Parameter(Mandatory = $false, Position = 3)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $DisallowStartIfOnBatteries = $true,

        [Parameter(Mandatory = $false, Position = 4)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $DisallowStartOnRemoteAppSession = $false,

        [Parameter(Mandatory = $false, Position = 5)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $Enabled = $true,

        [Parameter(Mandatory = $false, Position = 6)]
        [ValidateScript({ $_ -ge $(New-TimeSpan -Seconds 1) -and $_ -le $(New-TimeSpan -Days 31) })]
        [System.TimeSpan]
        $ExecutionTimeLimit = $(New-TimeSpan -Days 3),

        [Parameter(Mandatory = $false, Position = 7)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $Hidden = $false,

        [Parameter(Mandatory = $false, Position = 8)]
        [ValidateScript({ $_ -ge $(New-TimeSpan -Minutes 1) -and $_ -le $(New-TimeSpan -Hours 1) })]
        [System.TimeSpan]
        $Duration,

        [Parameter(Mandatory = $false, Position = 9)]
        [ValidateScript({ $_ -ge $(New-TimeSpan -Minutes 1) -and $_ -le $(New-TimeSpan -Days 31) })]
        [System.TimeSpan]
        $WaitTimeout,

        [Parameter(Mandatory = $false, Position = 10)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $StopOnIdleEnd = $true,

        [Parameter(Mandatory = $false, Position = 11)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $RestartOnIdle = $false,

        [Parameter(Mandatory = $false, Position = 12)]
        [ValidateSet('IgnoreNew', 'Parallel', 'Queue', 'StopExisting')]
        [System.String]
        $MultipleInstancesPolicy = 'IgnoreNew',

        [Parameter(Mandatory = $false, Position = 13)]
        [ValidateNotNullOrEmpty()]
        [AllowEmptyString()]
        [System.String]
        $NetworkProfileName,

        [Parameter(Mandatory = $false, Position = 14)]
        [ValidateRange(0, 10)]
        [System.UInt16]
        $Priority = 7,

        [Parameter(Mandatory = $false, Position = 15)]
        [ValidateScript({ $_ -ge $(New-TimeSpan -Minutes 1) -and $_ -le $(New-TimeSpan -Days 31) })]
        [System.TimeSpan]
        $RestartInterval,

        [Parameter(Mandatory = $false, Position = 16)]
        [ValidateRange(1, 999)]
        [System.UInt16]
        $RestartCount,

        [Parameter(Mandatory = $false, Position = 17)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $RunOnlyIfIdle = $false,

        [Parameter(Mandatory = $false, Position = 18)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $RunOnlyIfNetworkAvailable = $false,

        [Parameter(Mandatory = $false, Position = 19)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $StartWhenAvailable = $false,

        [Parameter(Mandatory = $false, Position = 20)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $StopIfGoingOnBatteries = $true,

        [Parameter(Mandatory = $false, Position = 21)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $UseUnifiedSchedulingEngine = $true,

        [Parameter(Mandatory = $false, Position = 22)]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $WakeToRun = $false
    )

    if ($null -eq $script:Config.Current.xmlDocument) {
        $script:Config.Current.xmlDocument = New-Object -TypeName System.Xml.XmlDocument
        [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.xmlDocument.CreateXmlDeclaration($script:Config.xmlversion, $script:Config.encoding, $null))
        $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)
        $script:Config.Current.taskElement.SetAttribute('version', '1.4')
        [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)
        $script:Config.Current.settingsElement = $script:Config.Current.xmlDocument.CreateElement('Settings', $script:Config.xmlns)
    }
    else {
        if ($null -eq $script:Config.Current.taskElement) {
            $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)
            $script:Config.Current.taskElement.SetAttribute('version', '1.4')
            [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)
            $script:Config.Current.settingsElement = $script:Config.Current.xmlDocument.CreateElement('Settings', $script:Config.xmlns)
        }
        else {
            if ($script:Config.Current.xmlDocument.GetElementsByTagName('Settings').Count -eq 0) {
                $script:Config.Current.settingsElement = $script:Config.Current.xmlDocument.CreateElement('Settings', $script:Config.xmlns)
            }
        }
    }

    $idleSettingsHash = New-Object -TypeName System.Collections.Hashtable
    'Duration', 'WaitTimeout', 'StopOnIdleEnd', 'RestartOnIdle' | ForEach-Object {
        try {
            $var = Get-Variable -Name $_ -ErrorAction Stop
            if ($null -ne $var.Value -and $var.Value -ne '') {
                if ($var.Value.GetType().Name -eq 'TimeSpan') {
                    $value = New-Object -TypeName System.Text.StringBuilder
                    [void]$value.Append('P')
                    if ($var.Value.Days -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%d'))D")
                    }
                    [void]$value.Append('T')
                    if ($var.Value.Hours -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%h'))H")
                    }
                    if ($var.Value.Minutes -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%m'))M")
                    }
                    if ($var.Value.Seconds -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%s'))S")
                    }
                    $idleSettingsHash.Add($var.Name, $value.ToString())
                }
                elseif ($var.Value.GetType().Name -eq 'Boolean') {
                    $idleSettingsHash.Add($var.Name, $var.Value.ToString().ToLower())
                }
                else {
                    $idleSettingsHash.Add($var.Name, $var.Value.ToLower())
                }
            }
        }
        catch { }
    }
    if ($idleSettingsHash.Count -ge 1) {
        $idleSettingsElement = $script:Config.Current.xmlDocument.CreateElement('IdleSettings', $script:Config.xmlns)
        ForEach ($key in $idleSettingsHash.Keys) {
            $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
            $element.InnerText = $idleSettingsHash.$key
            [void]$idleSettingsElement.AppendChild($element)
        }
    }

    $restartHash = New-Object -TypeName System.Collections.Hashtable
    'RestartInterval', 'RestartCount' | ForEach-Object {
        try {
            $var = Get-Variable -Name $_ -ErrorAction Stop
            if ($null -ne $var.Value -and $var.Value -ne '') {
                if ($var.Value.GetType().Name -eq 'TimeSpan') {
                    $value = New-Object -TypeName System.Text.StringBuilder
                    [void]$value.Append('P')
                    if ($var.Value.Days -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%d'))D")
                    }
                    [void]$value.Append('T')
                    if ($var.Value.Hours -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%h'))H")
                    }
                    if ($var.Value.Minutes -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%m'))M")
                    }
                    if ($var.Value.Seconds -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%s'))S")
                    }
                    $restartHash.Add('Interval', $value.ToString())
                }
                else {
                    $restartHash.Add('Count', $var.Value)
                }
            }
        }
        catch { }
    }
    if ($restartHash.Count -ge 1) {
        $restartElement = $script:Config.Current.xmlDocument.CreateElement('RestartOnFailure', $script:Config.xmlns)
        ForEach ($key in $restartHash.Keys) {
            $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
            $element.InnerText = $restartHash.$key
            [void]$restartElement.AppendChild($element)
        }
    }

    if ($RunOnlyIfNetworkAvailable -eq $true) {
        if ($NetworkProfileName) {
            $networkSettingsElement = $script:Config.Current.xmlDocument.CreateElement('NetworkSettings', $script:Config.xmlns)
            $nameElement = $script:Config.Current.xmlDocument.CreateElement('Name', $script:Config.xmlns)
            $nameElement.InnerText = $NetworkProfileName
            [void]$networkSettingsElement.AppendChild($nameElement)
            $idElement = $script:Config.Current.xmlDocument.CreateElement('Id', $script:Config.xmlns)
            $idElement.InnerText = $(Get-NetConnectionProfile -Name $NetworkProfileName).InstanceID
            [void]$networkSettingsElement.AppendChild($idElement)
        }
    }

    $settingsHash = New-Object -TypeName System.Collections.Hashtable

    'AllowHardTerminate', 'AllowStartOnDemand', 'DeleteExpiredTaskAfter', 'DisallowStartIfOnBatteries', 'DisallowStartOnRemoteAppSession', 'Enabled', `
        'ExecutionTimeLimit', 'Hidden', 'MultipleInstancesPolicy', 'Priority', 'RunOnlyIfIdle', 'RunOnlyIfNetworkAvailable', 'StartWhenAvailable', 'StopIfGoingOnBatteries', `
        'UseUnifiedSchedulingEngine', 'WakeToRun' | ForEach-Object {
        try {
            $var = Get-Variable -Name $_ -ErrorAction Stop
            if ($null -ne $var.Value -and $var.Value -ne '') {
                if ($var.Value.GetType().Name -eq 'TimeSpan') {
                    $value = New-Object -TypeName System.Text.StringBuilder
                    [void]$value.Append('P')
                    if ($var.Value.Days -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%d'))D")
                    }
                    [void]$value.Append('T')
                    if ($var.Value.Hours -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%h'))H")
                    }
                    if ($var.Value.Minutes -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%m'))M")
                    }
                    if ($var.Value.Seconds -ge 1) {
                        [void]$value.Append("$($var.Value.ToString('%s'))S")
                    }
                    $settingsHash.Add($var.Name, $value.ToString())
                }
                elseif ($var.Value.GetType().Name -eq 'Boolean') {
                    $settingsHash.Add($var.Name, $var.Value.ToString().ToLower())
                }
                else {
                    $settingsHash.Add($var.Name, $var.Value)
                }
            }
        }
        catch { }
    }

    ForEach ($key in $settingsHash.Keys) {
        $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
        $element.InnerText = $settingsHash.$key
        [void]$script:Config.Current.settingsElement.AppendChild($element)
    }

    if ($idleSettingsElement) {
        [void]$script:Config.Current.settingsElement.AppendChild($idleSettingsElement)
    }

    if ($restartElement) {
        [void]$script:Config.Current.settingsElement.AppendChild($restartElement)
    }

    if ($networkSettingsElement) {
        [void]$script:Config.Current.settingsElement.AppendChild($networkSettingsElement)
    }
    [void]$script:Config.Current.taskElement.AppendChild($script:Config.Current.settingsElement)
}