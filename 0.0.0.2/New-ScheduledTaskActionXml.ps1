# .ExternalHelp $PSScriptRoot\New-ScheduledTaskActionXml-help.xml
function New-ScheduledTaskActionXml {

    [CmdletBinding()]

    Param (

        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Command,

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Arguments,

        [Parameter(Mandatory = $false, Position = 2)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $WorkingDirectory
    )

    if ($null -eq $script:Config.Current.xmlDocument) {
        $script:Config.Current.xmlDocument = New-Object -TypeName System.Xml.XmlDocument
        [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.xmlDocument.CreateXmlDeclaration($script:Config.xmlversion, $script:Config.encoding, $null))
        $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)
        $script:Config.Current.taskElement.SetAttribute('version', '1.4')
        [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)
        $script:Config.Current.actionsElement = $script:Config.Current.xmlDocument.CreateElement('Actions', $script:Config.xmlns)
    }
    else {
        if ($null -eq $script:Config.Current.taskElement) {
            $script:Config.Current.taskElement = $script:Config.Current.xmlDocument.CreateElement('Task', $script:Config.xmlns)
            $script:Config.Current.taskElement.SetAttribute('version', '1.4')
            [void]$script:Config.Current.xmlDocument.AppendChild($script:Config.Current.taskElement)
            $script:Config.Current.actionsElement = $script:Config.Current.xmlDocument.CreateElement('Actions', $script:Config.xmlns)
        }
        else {
            if ($script:Config.Current.xmlDocument.GetElementsByTagName('Actions').Count -eq 0) {
                $script:Config.Current.actionsElement = $script:Config.Current.xmlDocument.CreateElement('Actions', $script:Config.xmlns)
            }
            else {
                $script:Config.Current.actionsElement = $script:Config.Current.xmlDocument.GetElementsByTagName('Actions')
            }
        }
    }

    $execElement = $script:Config.Current.xmlDocument.CreateElement('Exec', $script:Config.xmlns)
    'Command', 'Arguments', 'WorkingDirectory' | ForEach-Object {
        try {
            $var = Get-Variable -Name $_ -ErrorAction Stop
            if ($null -ne $var.Value -and $var.Value -ne '') {
                $element = $script:Config.Current.xmlDocument.CreateElement($var.Name, $script:Config.xmlns)
                $element.InnerText = $var.Value
                [void]$execElement.AppendChild($element)
            }
        }
        catch { }
    }
    [void]$script:Config.Current.actionsElement.AppendChild($execElement)
    [void]$script:Config.Current.taskElement.AppendChild($script:Config.Current.actionsElement)
}