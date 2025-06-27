
# .ExternalHelp $PSScriptRoot\ScheduledTasksXml-help.xml

#region ModuleVariables
################################################################################
#                                                                              #
#                               VARIABLES                                      #
#                                                                              #
################################################################################
try {
    $script:Config = Import-Clixml -Path "$PSScriptRoot\config.xml"
}
catch {
    $script:Config = [ordered]@{
        Current    = [ordered]@{
            xmlDocument             = $null
            taskElement             = $null
            registrationInfoElement = $null
            triggersElement         = $null
            settingsElement         = $null
            principalsElement       = $null
            actionsElement          = $null
        }
        Level      = [ordered]@{
            Critical    = 1
            Error       = 2
            Warning     = 3
            Information = @(4, 0)
            Verbose     = 5
        }
        Privilege  = @(
            'SeAssignPrimaryTokenPrivilege'
            'SeAuditPrivilege'
            'SeBackupPrivilege'
            'SeChangeNotifyPrivilege'
            'SeCreateGlobalPrivilege'
            'SeCreatePagefilePrivilege'
            'SeCreatePermanentPrivilege'
            'SeCreateSymbolicLinkPrivilege'
            'SeCreateTokenPrivilege'
            'SeDebugPrivilege'
            'SeEnableDelegationPrivilege'
            'SeImpersonatePrivilege'
            'SeIncreaseBasePriorityPrivilege'
            'SeIncreaseQuotaPrivilege'
            'SeIncreaseWorkingSetPrivilege'
            'SeLoadDriverPrivilege'
            'SeLockMemoryPrivilege'
            'SeMachineAccountPrivilege'
            'SeManageVolumePrivilege'
            'SeProfileSingleProcessPrivilege'
            'SeRelabelPrivilege'
            'SeRemoteShutdownPrivilege'
            'SeRestorePrivilege'
            'SeSecurityPrivilege'
            'SeShutdownPrivilege'
            'SeSyncAgentPrivilege'
            'SeSystemEnvironmentPrivilege'
            'SeSystemProfilePrivilege'
            'SeSystemTimePrivilege'
            'SeTakeOwnershipPrivilege'
            'SeTcbPrivilege'
            'SeTimeZonePrivilege'
            'SeTrustedCredManAccessPrivilege'
            'SeUndockPrivilege'
            'SeUnsolicitedInputPrivilege'
        )
        encoding   = 'UTF-16'
        xmlns      = 'http://schemas.microsoft.com/windows/2004/02/mit/task'
        xmlversion = '1.0'
    }
    $script:Config | Export-Clixml -Path "$PSScriptRoot\config.xml" -Depth 100
}
#endregion

#region DotSourcedScripts
################################################################################
#                                                                              #
#                           DOT-SOURCED SCRIPTS                                #
#                                                                              #
################################################################################
. "$PSScriptRoot\New-ScheduledTaskXml.ps1"
. "$PSScriptRoot\New-ScheduledTaskInfoXml.ps1"
. "$PSScriptRoot\New-ScheduledTaskTriggerXml.ps1"
. "$PSScriptRoot\New-ScheduledTaskSettingsXml.ps1"
. "$PSScriptRoot\New-ScheduledTaskPrincipalXml.ps1"
. "$PSScriptRoot\New-ScheduledTaskActionXml.ps1"
#region ModuleMembers
################################################################################
#                                                                              #
#                              MODULE MEMBERS                                  #
#                                                                              #
################################################################################
Export-ModuleMember -Function New-ScheduledTaskXml
Export-ModuleMember -Function New-ScheduledTaskInfoXml
Export-ModuleMember -Function New-ScheduledTaskTriggerXml
Export-ModuleMember -Function New-ScheduledTaskSettingsXml
Export-ModuleMember -Function New-ScheduledTaskPrincipalXml
Export-ModuleMember -Function New-ScheduledTaskActionXml
#endregion
