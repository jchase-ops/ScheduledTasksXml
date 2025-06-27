# .ExternalHelp $PSScriptRoot\New-ScheduledTaskTriggerXml-help.xml
function New-ScheduledTaskTriggerXml {

    [CmdletBinding(DefaultParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]

    Param (

        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'BootTrigger')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'IdleTrigger')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'LogonTrigger')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'RegistrationTrigger')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'SessionStateChangeTrigger')]
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'TimeTrigger')]
        [ValidateNotNullOrEmpty()]
        [Boolean]
        $Enabled = $true,

        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'BootTrigger')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'IdleTrigger')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'LogonTrigger')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'RegistrationTrigger')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'SessionStateChangeTrigger')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'TimeTrigger')]
        [ValidateScript({ $_ -ge $((Get-Date).AddMinutes(-15)) })]
        [System.DateTime]
        $StartBoundary = $(Get-Date),

        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'BootTrigger')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'IdleTrigger')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'LogonTrigger')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'RegistrationTrigger')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'SessionStateChangeTrigger')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'TimeTrigger')]
        [ValidateScript({ $_ -gt $StartBoundary })]
        [System.DateTime]
        $EndBoundary = $StartBoundary.AddMinutes(30),

        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'BootTrigger')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'IdleTrigger')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'LogonTrigger')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'RegistrationTrigger')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'SessionStateChangeTrigger')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'TimeTrigger')]
        [ValidateScript({ ($_ -ge $(New-TimeSpan -Minutes 1) -and $_ -le $(New-TimeSpan -Days 31)) })]
        [System.TimeSpan]
        $RepetitionInterval,

        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'BootTrigger')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'IdleTrigger')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'LogonTrigger')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'RegistrationTrigger')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'SessionStateChangeTrigger')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'TimeTrigger')]
        [ValidateScript({ $_ -ge $(New-TimeSpan -Minutes 1) })]
        [System.TimeSpan]
        $RepetitionDuration,

        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'BootTrigger')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'IdleTrigger')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'LogonTrigger')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'RegistrationTrigger')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'SessionStateChangeTrigger')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'TimeTrigger')]
        [AllowNull()]
        [Boolean]
        $StopAtDurationEnd,

        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'BootTrigger')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'IdleTrigger')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'LogonTrigger')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'RegistrationTrigger')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'SessionStateChangeTrigger')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'TimeTrigger')]
        [ValidateScript({ $_ -ge $(New-TimeSpan -Seconds 1) -and $_ -le $(New-TimeSpan -Days 365) })]
        [System.TimeSpan]
        $ExecutionTimeLimit,


        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'BootTrigger')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'LogonTrigger')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'RegistrationTrigger')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'SessionStateChangeTrigger')]
        [ValidateScript({ $_ -ge $(New-TimeSpan -Seconds 30) -and $_ -le $(New-TimeSpan -Days 31) })]
        [System.TimeSpan]
        $Delay,

        [Parameter(Mandatory = $false, Position = 8, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [Parameter(Mandatory = $false, Position = 8, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Parameter(Mandatory = $false, Position = 8, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [Parameter(Mandatory = $false, Position = 8, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [Parameter(Mandatory = $false, Position = 8, ParameterSetName = 'TimeTrigger')]
        [ValidateScript({ $_ -ge $(New-TimeSpan -Seconds 30) -and $_ -le $(New-TimeSpan -Days 31) })]
        [System.TimeSpan]
        $RandomDelay,

        [Parameter(Mandatory = $true, Position = 9, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $true, Position = 9, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $true, Position = 9, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [ValidateScript({ $_ -in $((Get-WinEvent -ListLog *).LogName | Sort-Object -Unique) })]
        [System.String]
        $LogName,

        [Parameter(Mandatory = $true, Position = 10, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $true, Position = 10, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $true, Position = 10, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [ValidateScript({ $_ -in $((Get-WinEvent -ListProvider *).Name | Sort-Object -Unique) })]
        [System.String[]]
        $Provider,

        [Parameter(Mandatory = $false, Position = 11, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 11, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [ValidateSet('Critical', 'Error', 'Warning', 'Information', 'Verbose')]
        [ValidateCount(1, 5)]
        [System.String[]]
        $Level,

        [Parameter(Mandatory = $true, Position = 12, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 12, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 12, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [ValidateNotNullOrEmpty()]
        [System.UInt16[]]
        $EventID,

        [Parameter(Mandatory = $true, Position = 13, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [ValidateNotNullOrEmpty()]
        [System.TimeSpan]
        $TimeSpan,

        [Parameter(Mandatory = $true, Position = 14, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [ValidateNotNullOrEmpty()]
        [System.DateTime]
        $StartDate,

        [Parameter(Mandatory = $true, Position = 15, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [ValidateNotNullOrEmpty()]
        [System.DateTime]
        $EndDate,

        [Parameter(Mandatory = $false, Position = 16, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 16, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 16, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [ValidateScript({ $_ -ge $(New-TimeSpan -Minutes 1) -and $_ -le $(New-TimeSpan -Days 31) })]
        [System.TimeSpan]
        $PeriodOfOccurrence,

        [Parameter(Mandatory = $false, Position = 17, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $false, Position = 17, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $false, Position = 17, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [ValidateRange(1, 32)]
        [System.UInt16]
        $NumberOfOccurrences,

        [Parameter(Mandatory = $false, Position = 18, ParameterSetName = 'LogonTrigger')]
        [Parameter(Mandatory = $false, Position = 18, ParameterSetName = 'SessionStateChangeTrigger')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $UserId,

        [Parameter(Mandatory = $true, Position = 19, ParameterSetName = 'SessionStateChangeTrigger')]
        [ValidateSet('ConsoleConnect', 'ConsoleDisconnect', 'RemoteConnect', 'RemoteDisconnect', 'SessionLock', 'SessionUnlock')]
        [System.String]
        $StateChange,

        [Parameter(Mandatory = $false, Position = 20, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [ValidateRange(1, 365)]
        [System.UInt16]
        $DaysInterval,

        [Parameter(Mandatory = $false, Position = 21, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [ValidateRange(1, 52)]
        [System.UInt16]
        $WeeksInterval,

        [Parameter(Mandatory = $true, Position = 22, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Parameter(Mandatory = $true, Position = 22, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [ValidateSet('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')]
        [ValidateCount(1, 7)]
        [System.String[]]
        $DaysOfWeek,

        [Parameter(Mandatory = $true, Position = 23, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [ValidatePattern('[1-9]|[1-2][0-9]|3[0-1]|Last')]
        [ValidateCount(1, 32)]
        [System.String[]]
        $DaysOfMonth,

        [Parameter(Mandatory = $true, Position = 24, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [Parameter(Mandatory = $true, Position = 24, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [ValidateSet('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')]
        [ValidateCount(1, 12)]
        [System.String[]]
        $Months,

        [Parameter(Mandatory = $false, Position = 25, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [ValidatePattern('[1-4]|Last')]
        [ValidateCount(1, 5)]
        $Weeks,

        [Parameter(Mandatory = $true, ParameterSetName = 'BootTrigger')]
        [Switch]
        $BootTrigger,

        [Parameter(Mandatory = $true, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [Parameter(Mandatory = $true, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Parameter(Mandatory = $true, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [Parameter(Mandatory = $true, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [Switch]
        $CalendarTrigger,

        [Parameter(Mandatory = $true, ParameterSetName = 'CalendarTriggerScheduleByDay')]
        [Switch]
        $Daily,

        [Parameter(Mandatory = $true, ParameterSetName = 'CalendarTriggerScheduleByWeek')]
        [Switch]
        $Weekly,

        [Parameter(Mandatory = $true, ParameterSetName = 'CalendarTriggerScheduleByMonth')]
        [Switch]
        $Monthly,

        [Parameter(Mandatory = $true, ParameterSetName = 'CalendarTriggerScheduleByMonthDayOfWeek')]
        [Switch]
        $MonthDayOfWeek,

        [Parameter(Mandatory = $true, ParameterSetName = 'EventTriggerSimple')]
        [Parameter(Mandatory = $true, ParameterSetName = 'EventTriggerComplexByTimeSpan')]
        [Parameter(Mandatory = $true, ParameterSetName = 'EventTriggerComplexByDateRange')]
        [Switch]
        $EventTrigger,

        [Parameter(Mandatory = $true, ParameterSetName = 'IdleTrigger')]
        [Switch]
        $IdleTrigger,

        [Parameter(Mandatory = $true, ParameterSetName = 'LogonTrigger')]
        [Switch]
        $LogonTrigger,

        [Parameter(Mandatory = $true, ParameterSetName = 'RegistrationTrigger')]
        [Switch]
        $RegistrationTrigger,

        [Parameter(Mandatory = $true, ParameterSetName = 'SessionStateChangeTrigger')]
        [Switch]
        $SessionStateChangeTrigger,

        [Parameter(Mandatory = $true, ParameterSetName = 'TimeTrigger')]
        [Switch]
        $TimeTrigger
    )

    if ($null -eq $script:Config.Current.xmlDocument) {
        $script:Config.Current.xmlDocument = New-Object -TypeName System.Xml.XmlDocument
        [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.xmlDocument.CreateXmlDeclaration($script:Config.xmlversion, $script:Config.encoding, $null))
        $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)
        $script:Config.Current.taskElement.SetAttribute('version', '1.4')
        [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)
        $script:Config.Current.triggersElement = $script:Config.Current.xmlDocument.CreateElement('Triggers', $script:Config.xmlns)
    }
    else {
        if ($null -eq $script:Config.Current.taskElement) {
            $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)
            $script:Config.Current.taskElement.SetAttribute('version', '1.4')
            [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)
            $script:Config.Current.triggersElement = $script:Config.Current.xmlDocument.CreateElement('Triggers', $script:Config.xmlns)
        }
        else {
            if ($null -eq $script:Config.Current.triggersElement) {
                $script:Config.Current.triggersElement = $script:Config.Current.xmlDocument.CreateElement('Triggers', $script:Config.xmlns)
            }
            else {
                if ($script:Config.Current.xmlDocument.GetElementsByTagName('Triggers').Count -eq 0) {
                    $script:Config.Current.triggersElement = $script:Config.Current.xmlDocument.CreateElement('Triggers', $script:Config.xmlns)
                }
                else {
                    $script:Config.Current.triggersElement = $script:Config.Current.xmlDocument.GetElementsByTagName('Triggers')
                }
            }
        }
    }
    
    $baseHash = New-Object -TypeName System.Collections.Hashtable
    $repetitionHash = New-Object -TypeName System.Collections.Hashtable

    'RepetitionInterval', 'RepetitionDuration', 'StopAtDurationEnd' | ForEach-Object {
        try {
            $var = Get-Variable -Name $_ -ErrorAction Stop
            if ($null -ne $var.Value -and $var.Value -ne '') {
                if ($var.Value.GetType().Name -eq 'TimeSpan') {
                    $name = $var.Name.ToString().TrimStart('Repetition')
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
                    $repetitionHash.Add($name, $value.ToString())
                }
                else {
                    $repetitionHash.Add($var.Name, $var.Value.ToString().ToLower())
                }
            }
        }
        catch { }
    }

    if ($repetitionHash.Count -ge 1) {
        $repetitionElement = $script:Config.Current.xmlDocument.CreateElement('Repetition', $script:Config.xmlns)
        ForEach ($key in $repetitionHash.Keys) {
            $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
            $element.InnerText = $repetitionHash.$key
            [void]$repetitionElement.AppendChild($element)
        }
    }

    'Enabled', 'StartBoundary', 'EndBoundary', 'ExecutionTimeLimit' | ForEach-Object {
        try {
            $var = Get-Variable -Name $_ -ErrorAction Stop
            if ($null -ne $var.Value -and $var.Value -ne '') {
                if ($var.Value.GetType().Name -eq 'DateTime') {
                    $baseHash.Add($var.Name, $var.Value.ToString('yyyy-MM-ddTHH:mm:ss'))
                }
                elseif ($var.Value.GetType().Name -eq 'TimeSpan') {
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
                    $baseHash.Add($var.Name, $value.ToString())
                }
                elseif ($var.Value.GetType().Name -eq 'Boolean') {
                    $baseHash.Add($var.Name, $var.Value.ToString().ToLower())
                }
                else {
                    $baseHash.Add($var.Name, $var.Value)
                }
            }
        }
        catch { }
    }
    
    Switch ($PSCmdlet.ParameterSetName) {
        'BootTrigger' {
            'Delay' | ForEach-Object {
                try {
                    $var = Get-Variable -Name $_ -ErrorAction Stop
                    if ($null -ne $var.Value -and $var.Value -ne '') {
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
                        $baseHash.Add($var.Name, $value.ToString())
                    }
                }
                catch { }
                $triggerElement = $script:Config.Current.xmlDocument.CreateElement($PSCmdlet.ParameterSetName, $script:Config.xmlns)
                ForEach ($key in $baseHash.Keys) {
                    $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                    $element.InnerText = $baseHash.$key
                    [void]$triggerElement.AppendChild($element)
                }
                if ($repetitionElement) {
                    [void]$triggerElement.AppendChild($repetitionElement)
                }
                [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
            }
        }
        'CalendarTriggerScheduleByDay' {
            'RandomDelay' | ForEach-Object {
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
                            $baseHash.Add($var.Name, $value.ToString())
                        }
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement('CalendarTrigger', $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            $scheduleElement = $script:Config.Current.xmlDocument.CreateElement('ScheduleByDay')
            'DaysInterval' | ForEach-Object {
                try {
                    $var = Get-Variable -Name $_ -ErrorAction Stop
                    if ($null -ne $var.Value -and $var.Value -ne '') {
                        $element = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                        $element.InnerText = $var.Value
                        [void]$scheduleElement.AppendChild($element)
                    }
                }
                catch { }
            }
            [void]$triggerElement.AppendChild($scheduleElement)
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'CalendarTriggerScheduleByWeek' {
            'RandomDelay' | ForEach-Object {
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
                            $baseHash.Add($var.Name, $value.ToString())
                        }
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement('CalendarTrigger', $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            $scheduleElement = $script:Config.Current.xmlDocument.CreateElement('ScheduleByWeek', $script:Config.xmlns)
            'DaysOfWeek', 'WeeksInterval' | ForEach-Object {
                try {
                    $var = Get-Variable -Name $_ -ErrorAction Stop
                    if ($null -ne $var.Value -and $var.Value -ne '') {
                        if ($var.Value.GetType().Name -eq 'UInt16') {
                            $element = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                            $element.InnerText = $var.Value
                            [void]$scheduleElement.AppendChild($element)
                        }
                        else {
                            $element = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                            ForEach ($day in $var.Value) {
                                [void]$element.AppendChild($($script:Config.Current.xmlDocument.CreateElement($day, $script:Config.xmlns)))
                            }
                            [void]$scheduleElement.AppendChild($element)
                        }
                    }
                }
                catch { }
            }
            [void]$triggerElement.AppendChild($scheduleElement)
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'CalendarTriggerScheduleByMonth' {
            'RandomDelay' | ForEach-Object {
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
                            $baseHash.Add($var.Name, $value.ToString())
                        }
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement('CalendarTrigger', $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            $scheduleElement = $script:Config.Current.xmlDocument.CreateElement('ScheduleByMonth', $script:Config.xmlns)
            'DaysOfMonth', 'Months' | ForEach-Object {
                try {
                    $var = Get-Variable -Name $_ -ErrorAction Stop
                    if ($null -ne $var.Value -and $var.Value -ne '') {
                        if ($var.Name -eq 'DaysOfMonth') {
                            $daysOfMonthElement = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                            ForEach ($day in $var.Value) {
                                $element = $script:Config.Current.xmlDocument.CreateElement('Day', $script:Config.xmlns)
                                $element.InnerText = $day
                                [void]$daysOfMonthElement.AppendChild($element)
                            }
                            [void]$scheduleElement.AppendChild($daysOfMonthElement)
                        }
                        else {
                            $element = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                            ForEach ($m in $var.Value) {
                                [void]$element.AppendChild($($script:Config.Current.xmlDocument.CreateElement($m, $script:Config.xmlns)))
                            }
                            [void]$scheduleElement.AppendChild($element)
                        }
                    }
                }
                catch { }
            }
            [void]$triggerElement.AppendChild($scheduleElement)
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'CalendarTriggerScheduleByMonthDayOfWeek' {
            'RandomDelay' | ForEach-Object {
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
                            $baseHash.Add($var.Name, $value.ToString())
                        }
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement('CalendarTrigger', $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            $scheduleElement = $script:Config.Current.xmlDocument.CreateElement('ScheduleByMonthDayOfWeek', $script:Config.xmlns)
            'DaysOfWeek', 'Months', 'Weeks' | ForEach-Object {
                try {
                    $var = Get-Variable -Name $_ -ErrorAction Stop
                    if ($null -ne $var.Value -and $var.Value -ne '') {
                        if ($var.Name -eq 'DaysOfWeek') {
                            $element = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                            ForEach ($d in $var.Value) {
                                [void]$element.AppendChild($($script:Config.Current.xmlDocument.CreateElement($d, $script:Config.xmlns)))
                            }
                            [void]$scheduleElement.AppendChild($element)
                        }
                        elseif ($var.Name -eq 'Months') {
                            $element = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                            ForEach ($m in $var.Value) {
                                [void]$element.AppendChild($($script:Config.Current.xmlDocument.CreateElement($m, $script:Config.xmlns)))
                            }
                            [void]$scheduleElement.AppendChild($element)
                        }
                        else {
                            $weeksElement = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                            ForEach ($w in $var.Value) {
                                $element = $script:Config.Current.xmlDocument.CreateElement('Week', $script:Config.xmlns)
                                $element.InnerText = $w
                                [void]$weeksElement.AppendChild($element)
                            }
                            [void]$scheduleElement.AppendChild($weeksElement)
                        }
                    }
                }
                catch { }
            }
            [void]$triggerElement.AppendChild($scheduleElement)
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'EventTriggerSimple' {
            'Delay', 'PeriodOfOccurrence', 'NumberOfOccurrences' | ForEach-Object {
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
                            $baseHash.Add($var.Name, $value.ToString())
                        }
                        else {
                            $baseHash.Add($var.Name, $var.Value)
                        }
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement('EventTrigger', $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            $subscriptionElement = $script:Config.Current.xmlDocument.CreateElement('Subscription', $script:Config.xmlns)
            $subscriptionElement.InnerText = "&lt;QueryList&gt;&lt;Query Id=`"0`" Path=`"$LogName`"&gt;&lt;Select Path=`"$LogName`"&gt;*[System[Provider[@Name='$Provider'] and EventID=$EventID]]&lt;/Select&gt;&lt;/Query&gt;&lt;/QueryList&gt;"
            [void]$triggerElement.AppendChild($subscriptionElement)
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'EventTriggerComplexByTimeSpan' {
            'Delay', 'PeriodOfOccurrence', 'NumberOfOccurrences' | ForEach-Object {
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
                            $baseHash.Add($var.Name, $value.ToString())
                        }
                        else {
                            $baseHash.Add($var.Name, $var.Value)
                        }
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement('EventTrigger', $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            $subscriptionString = New-Object -TypeName System.Text.StringBuilder
            [void]$subscriptionString.Append("&lt;QueryList&gt;&lt;Query Id=`"0`" Path=`"$LogName`"&gt;&lt;Select Path=`"$LogName`"&gt;*[System[Provider[")
            ForEach ($p in $Provider) {
                [void]$subscriptionString.Append("@Name='$p' or ")
            }
            [void]$subscriptionString.Remove($($subscriptionString.Length - 4), 4)
            [void]$subscriptionString.Append(']')
            if ($Level) {
                [void]$subscriptionString.Append(' and ')
                if ($Level.Count -gt 1 -or $Level -contains 'Information') {
                    [void]$subscriptionString.Append('(')
                    $Level | ForEach-Object {
                        $l = $_
                        $script:Config.Level.$l | ForEach-Object {
                            [void]$subscriptionString.Append("Level=$_ or ")
                        }
                    }
                    [void]$subscriptionString.Remove($($subscriptionString.Length - 4), 4)
                    [void]$subscriptionString.Append(')')
                }
                else {
                    $Level | ForEach-Object {
                        $l = $_
                        $script:Config.Level.$l | ForEach-Object {
                            [void]$subscriptionString.Append("Level=$_")
                        }
                    }
                }
            }
            [void]$subscriptionString.Append(" and TimeCreated[timediff(@SystemTime) &amp;lt;= $($TimeSpan.Ticks)]]]&lt;/Select&gt;&lt;/Query&gt;&lt;/QueryList&gt;")
            $subscriptionElement = $script:Config.Current.xmlDocument.CreateElement('Subscription', $script:Config.xmlns)
            $subscriptionElement.InnerText = $subscriptionString.ToString()
            [void]$triggerElement.AppendChild($subscriptionElement)
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'EventTriggerComplexByDateRange' {
            'Delay', 'PeriodOfOccurrence', 'NumberOfOccurrences' | ForEach-Object {
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
                            $baseHash.Add($var.Name, $value.ToString())
                        }
                        else {
                            $baseHash.Add($var.Name, $var.Value)
                        }
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement('EventTrigger', $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            $subscriptionString = New-Object -TypeName System.Text.StringBuilder
            [void]$subscriptionString.Append("&lt;QueryList&gt;&lt;Query Id=`"0`" Path=`"$LogName`"&gt;&lt;Select Path=`"$LogName`"&gt;*[System[Provider[")
            ForEach ($p in $Provider) {
                [void]$subscriptionString.Append("@Name='$p' or ")
            }
            [void]$subscriptionString.Remove($($subscriptionString.Length - 4), 4)
            [void]$subscriptionString.Append(']')
            if ($Level) {
                [void]$subscriptionString.Append(' and ')
                if ($Level.Count -gt 1 -or $Level -contains 'Information') {
                    [void]$subscriptionString.Append('(')
                    $Level | ForEach-Object {
                        $l = $_
                        $script:Config.Level.$l | ForEach-Object {
                            [void]$subscriptionString.Append("Level=$_ or ")
                        }
                    }
                    [void]$subscriptionString.Remove($($subscriptionString.Length - 4), 4)
                    [void]$subscriptionString.Append(')')
                }
                else {
                    $Level | ForEach-Object {
                        $l = $_
                        $script:Config.Level.$l | ForEach-Object {
                            [void]$subscriptionString.Append("Level=$_")
                        }
                    }
                }
            }
            [void]$subscriptionString.Append(" and TimeCreated[@SystemTime&amp;gt;='$($StartDate.ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ss.fffZ'))' and @SystemTime&amp;lt;='$($EndDate.ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ss.fffZ'))]]]&lt;/Select&gt;&lt;/Query&gt;&lt;/QueryList&gt;")
            $subscriptionElement = $script:Config.Current.xmlDocument.CreateElement('Subscription', $script:Config.xmlns)
            $subscriptionElement.InnerText = $subscriptionString.ToString()
            [void]$triggerElement.AppendChild($subscriptionElement)
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'IdleTrigger' {
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement($PSCmdlet.ParameterSetName, $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'LogonTrigger' {
            'Delay', 'UserId' | ForEach-Object {
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
                            $baseHash.Add($var.Name, $value.ToString())
                        }
                        else {
                            $baseHash.Add($var.Name, $var.Value)
                        }
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement($PSCmdlet.ParameterSetName, $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'RegistrationTrigger' {
            'Delay' | ForEach-Object {
                try {
                    $var = Get-Variable -Name $_ -ErrorAction Stop
                    if ($null -ne $var.Value -and $var.Value -ne '') {
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
                        $baseHash.Add($var.Name, $value.ToString())
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement($PSCmdlet.ParameterSetName, $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'SessionStateChangeTrigger' {
            'Delay', 'StateChange', 'UserId' | ForEach-Object {
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
                            $baseHash.Add($var.Name, $value.ToString())
                        }
                        else {
                            $baseHash.Add($var.Name, $var.Value)
                        }
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement($PSCmdlet.ParameterSetName, $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
        'TimeTrigger' {
            'RandomDelay' | ForEach-Object {
                try {
                    $var = Get-Variable -Name $_ -ErrorAction Stop
                    if ($null -ne $var.Value -and $var.Value -ne '') {
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
                        $baseHash.Add($var.Name, $value.ToString())
                    }
                }
                catch { }
            }
            $triggerElement = $script:Config.Current.xmlDocument.CreateElement($PSCmdlet.ParameterSetName, $script:Config.xmlns)
            ForEach ($key in $baseHash.Keys) {
                $element = $script:Config.Current.xmlDocument.CreateElement($key, $script:Config.xmlns)
                $element.InnerText = $baseHash.$key
                [void]$triggerElement.AppendChild($element)
            }
            if ($repetitionElement) {
                [void]$triggerElement.AppendChild($repetitionElement)
            }
            [void]$script:Config.Current.triggersElement.AppendChild($triggerElement)
        }
    }
}