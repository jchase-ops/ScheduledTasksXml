# .ExternalHelp $PSScriptRoot\New-ScheduledTaskPrincipalXml-help.xml
function New-ScheduledTaskPrincipalXml {

    [CmdletBinding(DefaultParameterSetName = 'UserId')]

    Param (

        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'UserId')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $UserName = $env:USERNAME,

        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'UserId')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'GroupId')]
        [ValidateSet('GCU', 'GCE', 'CANYON', 'LOPES', 'TEST')]
        [System.String]
        $Domain = 'GCU',

        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'UserId')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'GroupId')]
        [ValidateSet('InteractiveToken', 'InteractiveTokenOrPassword', 'Password', 'S4U')]
        [System.String]
        $LogonType,

        [Parameter(Mandatory = $true, Position = 3, ParameterSetName = 'GroupId')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $GroupName,

        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'UserId')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'GroupId')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $DisplayName,

        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'UserId')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'GroupId')]
        [ValidateSet('LeastPrivilege', 'HighestAvailable')]
        [System.String]
        $RunLevel,

        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'UserId')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'GroupId')]
        [ValidateSet('None', 'Unrestricted')]
        [System.String]
        $ProcessTokenSidType,

        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'UserId')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'GroupId')]
        [ValidateScript({ $_ -in $script:Config.Privilege })]
        [ValidateCount(1, 64)]
        [System.String[]]
        $RequiredPrivileges
    )

    if ($null -eq $script:Config.Current.xmlDocument) {
        $script:Config.Current.xmlDocument = New-Object -TypeName System.Xml.XmlDocument
        [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.xmlDocument.CreateXmlDeclaration($script:Config.xmlversion, $script:Config.encoding, $null))
        $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)
        $script:Config.Current.taskElement.SetAttribute('version', '1.4')
        [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)
        $script:Config.Current.principalsElement = $script:Config.Current.xmlDocument.CreateElement('Principals', $script:Config.xmlns)
        $principalElement = $script:Config.Current.xmlDocument.CreateElement('Principal', $script:Config.xmlns)
    }
    else {
        if ($null -eq $script:Config.Current.taskElement) {
            $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)
            $script:Config.Current.taskElement.SetAttribute('version', '1.4')
            [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)
            $script:Config.Current.principalsElement = $script:Config.Current.xmlDocument.CreateElement('Principals', $script:Config.xmlns)
            $principalElement = $script:Config.Current.xmlDocument.CreateElement('Principal', $script:Config.xmlns)
        }
        else {
            if ($script:Config.Current.xmlDocument.GetElementsByTagName('Principals').Count -ne 0) {
                $script:Config.Current.principalsElement = $script:Config.Current.xmlDocument.GetElementsByTagName('Principals')
                $principalElement = $script:Config.Current.xmlDocument.CreateElement('Principal', $script:Config.xmlns)
            }
            else {
                $script:Config.Current.principalsElement = $script:Config.Current.xmlDocument.CreateElement('Principals', $script:Config.xmlns)
                $principalElement = $script:Config.Current.xmlDocument.CreateElement('Principal', $script:Config.xmlns)
            }
        }
    }

    Switch ($PSCmdlet.ParameterSetName) {
        'UserId' {
            $userIdElement = $script:Config.Current.xmlDocument.CreateElement('UserId', $script:Config.xmlns)
            $userIdElement.InnerText = $(Get-ADUser -Identity $UserName -Properties SID -Server $Domain).SID
            [void]$principalElement.AppendChild($userIdElement)
        }
        'GroupId' {
            $groupIdElement = $script:Config.Current.xmlDocument.CreateElement('GroupId', $script:Config.xmlns)
            $groupIdElement.InnerText = $(Get-ADGroup -Identity $GroupName -Properties SID -Server $Domain).SID
            [void]$principalElement.AppendChild($groupIdElement)
        }
    }

    'LogonType', 'DisplayName', 'RunLevel', 'ProcessTokenSidType' | ForEach-Object {
        try {
            $var = Get-Variable -Name $_ -ErrorAction Stop
            if ($null -ne $var.Value -and $var.Value -ne '') {
                $element = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                $element.InnerText = $var.Value
                [void]$principalElement.AppendChild($element)
            }
        }
        catch { }
    }

    if ($RequiredPrivileges) {
        $requiredPrivilegesElement = $script:Config.Current.xmlDocument.CreateElement('RequiredPrivileges', $script:Config.xmlns)
        ForEach ($rp in $RequiredPrivileges) {
            $element = $script:Config.Current.xmlDocument.CreateElement('Privilege', $script:Config.xmlns)
            $element.InnerText = $rp
            [void]$requiredPrivilegesElement.AppendChild($element)
        }
        [void]$principalElement.AppendChild($requiredPrivilegesElement)
    }
    [void]$script:Config.Current.principalsElement.AppendChild($principalElement)
    [void]$script:Config.Current.taskElement.AppendChild($script:Config.Current.principalsElement)
}