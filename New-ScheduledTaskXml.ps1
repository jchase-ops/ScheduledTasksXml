# .ExternalHelp $PSScriptRoot\New-ScheduledTaskXml-help.xml
function New-ScheduledTaskXml {

    [CmdletBinding(DefaultParameterSetName = 'FilePath')]

    Param (

        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Alias('Name', 'TaskName', 'URI')]
        [System.String]
        $TaskPath,

        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'FilePath')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'XmlString')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'XmlDocument')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'DirectRegister')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Author = "${env:USERDOMAIN}\${env:USERNAME}",

        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'FilePath')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'XmlString')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'XmlDocument')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'DirectRegister')]
        [ValidateScript({ $_ -ge $((Get-Date).AddMinutes(-15)) })]
        [System.DateTime]
        $Date = $(Get-Date),

        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'FilePath')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'XmlString')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'XmlDocument')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'DirectRegister')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'FilePath')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'XmlString')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'XmlDocument')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'DirectRegister')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Documentation,

        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'FilePath')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'XmlString')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'XmlDocument')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'DirectRegister')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $SecurityDescriptor,

        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'FilePath')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'XmlString')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'XmlDocument')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'DirectRegister')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Source,

        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'FilePath')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'XmlString')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'XmlDocument')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'DirectRegister')]
        [ValidatePattern("^\d+(\.\d+){1,3}$")]
        [System.String]
        $Version,

        [Parameter(Mandatory = $false, Position = 8, ParameterSetName = 'FilePath')]
        [Parameter(Mandatory = $false, Position = 8, ParameterSetName = 'XmlString')]
        [Parameter(Mandatory = $false, Position = 8, ParameterSetName = 'XmlDocument')]
        [Parameter(Mandatory = $false, Position = 8, ParameterSetName = 'DirectRegister')]
        [ValidateSet('Windows 10', 'Windows 7', 'Windows Server 2008 R2', 'Windows Vista', 'Windows Server 2008', 'Windows XP', 'Windows Server 2003', 'Windows 2000')]
        [System.String]
        $ConfigureFor,

        [Parameter(Mandatory = $true, Position = 9)]
        [ValidateCount(1, 48)]
        [System.Collections.Hashtable[]]
        $Triggers,

        [Parameter(Mandatory = $false, Position = 10, ParameterSetName = 'FilePath')]
        [Parameter(Mandatory = $false, Position = 10, ParameterSetName = 'XmlString')]
        [Parameter(Mandatory = $false, Position = 10, ParameterSetName = 'XmlDocument')]
        [Parameter(Mandatory = $false, Position = 10, ParameterSetName = 'DirectRegister')]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable]
        $Settings,

        [Parameter(Mandatory = $false, Position = 11, ParameterSetName = 'FilePath')]
        [Parameter(Mandatory = $false, Position = 11, ParameterSetName = 'XmlString')]
        [Parameter(Mandatory = $false, Position = 11, ParameterSetName = 'XmlDocument')]
        [Parameter(Mandatory = $false, Position = 11, ParameterSetName = 'DirectRegister')]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable]
        $Principal,

        [Parameter(Mandatory = $true, Position = 12)]
        [ValidateCount(1, 32)]
        [System.Collections.Hashtable[]]
        $Actions,

        [Parameter(Mandatory = $true, Position = 13, ParameterSetName = 'FilePath')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $FilePath,

        [Parameter(Mandatory = $true, Position = 14, ParameterSetName = 'XmlString')]
        [Switch]
        $XmlString,

        [Parameter(Mandatory = $true, Position = 15, ParameterSetName = 'XmlDocument')]
        [Switch]
        $XmlDocument,

        [Parameter(Mandatory = $true, Position = 16, ParameterSetName = 'DirectRegister')]
        [Switch]
        $DirectRegister,

        [Parameter(Mandatory = $false, Position = 17, ParameterSetName = 'DirectRegister')]
        [ValidateNotNullOrEmpty()]
        [PSCredential]
        $Credential
    )

    $script:Config.Current.xmlDocument = New-Object -TypeName System.Xml.XmlDocument
    [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.xmlDocument.CreateXmlDeclaration($script:Config.xmlversion, $script:Config.encoding, $null))
    $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)

    if (!($ConfigureFor)) {
        $choiceList = New-Object -TypeName System.Collections.ArrayList
        $count = 1
        'Windows 10', 'Windows 7', 'Windows Server 2008 R2', 'Windows Vista', 'Windows Server 2008', 'Windows XP', 'Windows Server 2003', 'Windows 2000' | ForEach-Object {
            [void]$choiceList.Add($([System.Management.Automation.Host.ChoiceDescription]::New("&${count} ${_}", 'OS Kernel Version')))
            $count++
        }
        $choices = [System.Management.Automation.Host.ChoiceDescription[]]($choiceList)
        $choice = $Host.UI.PromptForChoice('Select OS Kernel Version', 'Operating Systems', $choices, 0)
        Switch ($choice) {
            0 { $script:Config.Current.taskElement.SetAttribute('version', '1.4') }
            1 { $script:Config.Current.taskElement.SetAttribute('version', '1.3') }
            2 { $script:Config.Current.taskElement.SetAttribute('version', '1.3') }
            3 { $script:Config.Current.taskElement.SetAttribute('version', '1.2') }
            4 { $script:Config.Current.taskElement.SetAttribute('version', '1.2') }
            5 { $script:Config.Current.taskElement.SetAttribute('version', '1.1') }
            6 { $script:Config.Current.taskElement.SetAttribute('version', '1.1') }
            7 { $script:Config.Current.taskElement.SetAttribute('version', '1.1') }
        }
    }
    else {
        if ($ConfigureFor -eq 'Windows 10') {
            $script:Config.Current.taskElement.SetAttribute('version', '1.4')
        }
        elseif ($ConfigureFor -in @('Windows 7', 'Windows Server 2008 R2')) {
            $script:Config.Current.taskElement.SetAttribute('version', '1.3')
        }
        elseif ($ConfigureFor -in @('Windows Vista', 'Windows Server 2008')) {
            $script:Config.Current.taskElement.SetAttribute('version', '1.2')
        }
        else {
            $script:Config.Current.taskElement.SetAttribute('version', '1.1')
        }
    }
    [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)

    $global:infoHash = New-Object -TypeName System.Collections.Hashtable
    'Author', 'Date', 'Description', 'Documentation', 'SecurityDescriptor', 'Source', 'Version' | ForEach-Object {
        try {
            $var = Get-Variable -Name $_ -ErrorAction Stop
            if ($null -ne $var.Value -and $var.Value -ne '') {
                $infoHash.Add($var.Name, $var.Value)
            }
        }
        catch { }
    }
    if ($TaskPath.StartsWith('\') -ne $true) {
        $TaskPath = $TaskPath.Insert(0, '\')
    }
    $infoHash.Add('URI', $TaskPath)
    New-ScheduledTaskInfoXml @infoHash
    $script:Config.Current.registrationInfoElement = $script:Config.Current.xmlDocument.GetElementsByTagName('RegistrationInfo')
    $script:Config.Current.triggersElement = $script:Config.Current.xmlDocument.CreateElement('Triggers', $script:Config.xmlns)

    ForEach ($t in $Triggers) {
        ForEach ($key in $t.Keys) {
            Switch ($key) {
                'BootTrigger' {
                    $triggerHash = $t.$key
                    New-ScheduledTaskTriggerXml @triggerHash -BootTrigger
                }
                'CalendarTrigger' {
                    $triggerHash = $t.$key
                    Switch ($triggerHash.ScheduleType) {
                        'Daily' {
                            New-ScheduledTaskTriggerXml @triggerHash -CalendarTrigger -Daily
                        }
                        'Weekly' {
                            New-ScheduledTaskTriggerXml @triggerHash -CalendarTrigger -Weekly
                        }
                        'Monthly' {
                            New-ScheduledTaskTriggerXml @triggerHash -CalendarTrigger -Monthly
                        }
                        'MonthDayOfWeek' {
                            New-ScheduledTaskTriggerXml @triggerHash -CalendarTrigger -MonthDayOfWeek
                        }
                    }
                }
                'EventTrigger' {
                    $triggerHash = $t.$key
                    New-ScheduledTaskTriggerXml @triggerHash -EventTrigger
                }
                'IdleTrigger' {
                    $triggerHash = $t.$key
                    New-ScheduledTaskTriggerXml @triggerHash -IdleTrigger
                }
                'LogonTrigger' {
                    $triggerHash = $t.$key
                    New-ScheduledTriggerXml @triggerHash -LogonTrigger
                }
                'RegistrationTrigger' {
                    $triggerHash = $t.$key
                    New-ScheduledTaskTriggerXml @triggerHash -RegistrationTrigger
                }
                'SessionStateChangeTrigger' {
                    $triggerHash = $t.$key
                    New-ScheduledTaskTriggerXml @triggerHash -SessionStateChangeTrigger
                }
                'TimeTrigger' {
                    $triggerHash = $t.$key
                    New-ScheduledTaskTriggerXml @triggerHash -TimeTrigger
                }
            }
        }
    }

    New-ScheduledTaskSettingsXml @Settings
    New-ScheduledTaskPrincipalXml @Principal

    ForEach ($a in $Actions) {
        New-ScheduledTaskActionXml @a
    }

    Switch ($PSCmdlet.ParameterSetName) {
        'FilePath' {
            $script:Config.Current.xmlDocument.Save($FilePath)
            if ($?) {
                Write-Host 'File ' -NoNewline
                Write-Host "$(($script:Config.Current.xmlDocument.GetElementsByTagName('URI').'#text').Split('\') | Select-Object -Last 1).xml" -ForegroundColor Green -NoNewline
                Write-Host ' created.'
            }
            else {
                Write-Host 'File ' -NoNewline
                Write-Host "$(($script:Config.Current.xmlDocument.GetElementsByTagName('URI').'#text').Split('\') | Select-Object -Last 1).xml" -ForegroundColor Red -NoNewline
                Write-Host ' creation failed.'
            }
        }
        'XmlString' {
            $script:Config.Current.xmlDocument.OuterXml
        }
        'XmlDocument' {
            $script:Config.Current.xmlDocument
        }
        'DirectRegister' {
            Register-ScheduledTask -TaskName $(($script:Config.Current.xmlDocument.GetElementsByTagName('URI').'#text').Split('\') | Select-Object -Last 1) -Xml $script:Config.Current.xmlDocument.OuterXml -User $Credential.UserName -Password $Credential.GetNetworkCredential().Password
            if ($?) {
                Write-Host 'Task ' -NoNewline
                Write-Host "$(($script:Config.Current.xmlDocument.GetElementsByTagName('URI').'#text').Split('\') | Select-Object -Last 1)" -ForegroundColor Green -NoNewline
                Write-Host ' registered.'
            }
            else {
                Write-Host 'Task ' -NoNewline
                Write-Host "$(($script:Config.Current.xmlDocument.GetElementsByTagName('URI').'#text').Split('\') | Select-Object -Last 1)" -ForegroundColor Red -NoNewline
                Write-Host ' registration failed.'
            }
        }
    }
}