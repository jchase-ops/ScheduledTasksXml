# .ExternalHelp $PSScriptRoot\New-ScheduledTaskInfoXml-help.xml
function New-ScheduledTaskInfoXml {

    [CmdletBinding(DefaultParameterSetName = 'Name')]

    Param (

        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'Name')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true, Position = 0, ParameterSetName = 'URI')]
        [ValidatePattern("^\\($|\b[a-zA-Z]?){1,}")]
        [System.String]
        $URI,

        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'Name')]
        [Parameter(Mandatory = $false, Position = 1, ParameterSetName = 'URI')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Author = "${env:USERDOMAIN}\${env:USERNAME}",

        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'Name')]
        [Parameter(Mandatory = $false, Position = 2, ParameterSetName = 'URI')]
        [ValidateScript({ $_ -ge $((Get-Date).AddMinutes(-15)) })]
        [System.DateTime]
        $Date = $(Get-Date),

        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'Name')]
        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'URI')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Description,

        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'Name')]
        [Parameter(Mandatory = $false, Position = 4, ParameterSetName = 'URI')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Documentation,

        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'Name')]
        [Parameter(Mandatory = $false, Position = 5, ParameterSetName = 'URI')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $SecurityDescriptor,

        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'Name')]
        [Parameter(Mandatory = $false, Position = 6, ParameterSetName = 'URI')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Source,

        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'Name')]
        [Parameter(Mandatory = $false, Position = 7, ParameterSetName = 'URI')]
        [ValidatePattern("^\d+(\.\d+){1,3}$")]
        [System.String]
        $Version
    )

    if ($null -eq $script:Config.Current.xmlDocument) {
        $script:Config.Current.xmlDocument = New-Object -TypeName System.Xml.XmlDocument
        [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.xmlDocument.CreateXmlDeclaration($script:Config.xmlversion, $script:Config.encoding, $null))
        $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)
        $script:Config.Current.taskElement.SetAttribute('version', $script:Config.schemaversion)
        [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)
    }
    else {
        if ($null -eq $script:Config.Current.taskElement) {
            $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)
            $script:Config.Current.taskElement.SetAttribute('version', $script:Config.schemaversion)
            [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)
        }
    }
    $script:Config.Current.registrationInfoElement = $script:Config.Current.xmlDocument.CreateElement('RegistrationInfo', $script:Config.xmlns)
    'Author', 'Date', 'Description', 'Documentation', 'SecurityDescriptor', 'Source', 'Version' | ForEach-Object {
        try {
            $var = Get-Variable -Name $_ -ErrorAction Stop
            if ($null -ne $var.Value -and $var.Value -ne '') {
                $element = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                if ($var.Value.GetType().Name -eq 'DateTime') {
                    $element.InnerText = $($var.Value.ToString('yyyy-MM-ddTHH:mm:ss.fffffff')).ToString()
                }
                else {
                    $element.InnerText = $var.Value
                }
                [void]$script:Config.Current.registrationInfoElement.AppendChild($element)
            }
        }
        catch { }
    }
    Switch ($PSCmdlet.ParameterSetName) {
        'Name' {
            if (!($Name)) {
                $Name = Read-Host -Prompt 'Enter task name'
            }
            $uriElement = $script:Config.Current.xmlDocument.CreateElement('URI', $script:Config.xmlns)
            $uriElement.InnerText = "\$Name"
            [void]$script:Config.Current.registrationInfoElement.AppendChild($uriElement)
        }
        'URI' {
            $uriElement = $script:Config.Current.xmlDocument.CreateElement('URI', $script:Config.xmlns)
            $uriElement.InnerText = $URI
            [void]$script:Config.Current.registrationInfoElement.AppendChild($uriElement)
        }
    }
    [void]$script:Config.Current.taskElement.AppendChild($script:Config.Current.registrationInfoElement)
}