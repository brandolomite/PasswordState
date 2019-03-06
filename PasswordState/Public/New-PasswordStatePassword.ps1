function New-PasswordStatePassword {
    <#
    .SYNOPSIS
        Create a new password in PasswordState.
    .DESCRIPTION
        Create a new password in PasswordState.
    .PARAMETER ApiKey
        The API key for the password list in PasswordState.
    .PARAMETER PasswordListId
        The Id of the password list in PasswordState.
    .PARAMETER Endpoint
        The Uri of your PasswordState site.
        (i.e. https://passwordstate.local)
    .PARAMETER Format
        The response format from PasswordState.
        Choose either json or xml.
    .PARAMETER Title
        The title field for the password entry.
    .PARAMETER Password
        The password field for the password entry.
    .PARAMETER Username
        The username field for the password entry.
    .PARAMETER Description
        The description field for the password entry.
    .PARAMETER GenericField1
        The generic field 1 for the password entry.
    .PARAMETER GenericField2
        The generic field 2 for the password entry.
    .PARAMETER GenericField3
        The generic field 3 for the password entry.
    .PARAMETER GenericField4
        The generic field 4 for the password entry.
    .PARAMETER GenericField5
        The generic field 5 for the password entry.
    .PARAMETER GenericField6
        The generic field 6 for the password entry.
    .PARAMETER GenericField7
        The generic field 7 for the password entry.
    .PARAMETER GenericField8
        The generic field 8 for the password entry.
    .PARAMETER GenericField9
        The generic field 9 for the password entry.
    .PARAMETER GenericField10
        The generic field 10 for the password entry.
    .PARAMETER Notes
        The notes field for the password entry.
    .PARAMETER AccountTypeId
        The account type id number for the password entry.
    .PARAMETER Url
        The url field for the password entry.
    .PARAMETER ExpiryDate
        The expire field for the password entry.
    .PARAMETER AllowExport
        Allow the password to be exported.
    .PARAMETER GeneratePassword
        If set to true, a newly generated random password will be created based on the Password Generator options associated with the Password List.
        If the Password List is set to use the user's Password Generator options, the Default Password Generator options will be used instead.
    .PARAMETER GenerateGenFieldPassword
        If set to true, any 'Generic Fields' which you have set to be of type 'Password' will have a newly generated random password assigned to it.
        If the Password List or Generic Field is set to use the user's Password Generator options, the Default Password Generator options will be used instead.
    .PARAMETER UseV6Api
        PasswordState versions prior to v7 did not support passing the API key in a HTTP header but instead expected the API key to be passed as a query parameter.
        This switch is used for  backwards compatibility with older PasswordState versions.
    .PARAMETER DocumentDescription
        The description of the document shown in PasswordState.
    .PARAMETER DocumentName
        The name of the file to be displayed in PasswordState, this is also the name used, when the file is downloaded from PasswordState.
    .PARAMETER DocumentPath
        This is the path to the file, that is to be uploaded to PasswordState.
    .EXAMPLE
        PS C:\> New-PasswordStatePassword -ApiKey $key -PasswordListId 1 -Title 'testPassword' -Username 'testPassword' -Description 'this is a test' -GeneratePassword

        Create a new password entry with an auto-generated password in list with ID 1 and tile of 'testPassword'.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPassWordParams', '')]
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [parameter(Mandatory)]
        [pscredential]$ApiKey,

        [parameter(Mandatory)]
        [int]$PasswordListId,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [ValidateSet('json','xml')]
        [string]$Format = 'json',

        [Parameter(Mandatory)]
        [string]$Title,

        [Parameter(Mandatory = $true,ParameterSetName = 'UsePassword')]
        [Parameter(Mandatory = $true,ParameterSetName = 'UsePasswordWithFile')]
        [securestring]$Password,

        [string]$Username,

        [string]$Description,

        [string]$GenericField1,

        [string]$GenericField2,

        [string]$GenericField3,

        [string]$GenericField4,

        [string]$GenericField5,

        [string]$GenericField6,

        [string]$GenericField7,

        [string]$GenericField8,

        [string]$GenericField9,

        [string]$GenericField10,

        [string]$Notes,

        [int]$AccountTypeID,

        [string]$Url,

        [string]$ExpiryDate,

        [bool]$AllowExport,

        [Parameter(Mandatory = $true,ParameterSetName = 'GenPassword')]
        [Parameter(Mandatory = $true,ParameterSetName = 'GenPasswordWithFile')]
        [switch]$GeneratePassword,

        [switch]$GenerateGenFieldPassword,

        [switch]$UseV6Api,

        [Parameter(Mandatory = $true,ParameterSetName = 'GenPasswordWithFile')]
        [Parameter(Mandatory = $true,ParameterSetName = 'UsePasswordWithFile')]
        [String]$DocumentPath,

        [Parameter(Mandatory = $true,ParameterSetName = 'GenPasswordWithFile')]
        [Parameter(Mandatory = $true,ParameterSetName = 'UsePasswordWithFile')]
        [String]$DocumentName,

        [Parameter(Mandatory = $true,ParameterSetName = 'GenPasswordWithFile')]
        [Parameter(Mandatory = $true,ParameterSetName = 'UsePasswordWithFile')]
        [String]$DocumentDescription
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"

    $request = '' | Select-Object -Property Title, PasswordListID, apikey
    $request.Title = $Title
    $request.PasswordListID = $PasswordListId
    $request.apikey = $($ApiKey.GetNetworkCredential().password)

    if ($null -ne $Password) {
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
        $unsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
        $request | Add-Member -MemberType NoteProperty -Name Password -Value $unsecurePassword
    }

    if ($PSBoundParameters.ContainsKey('Username')) {
        $request | Add-Member -MemberType NoteProperty -Name UserName -Value $Username
    }
    if ($PSBoundParameters.ContainsKey('Description')) {
        $request | Add-Member -MemberType NoteProperty -Name Description -Value $Description
    }
    if ($PSBoundParameters.ContainsKey('GenericField1')) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField1 -Value $GenericField1
    }
    if ($PSBoundParameters.ContainsKey('GenericField2')) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField2 -Value $GenericField2
    }
    if ($PSBoundParameters.ContainsKey('GenericField3')) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField3 -Value $GenericField3
    }
    if ($PSBoundParameters.ContainsKey('GenericField4')) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField4 -Value $GenericField4
    }
    if ($PSBoundParameters.ContainsKey('GenericField5')) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField5 -Value $GenericField5
    }
    if ($PSBoundParameters.ContainsKey('GenericField6')) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField6 -Value $GenericField6
    }
    if ($PSBoundParameters.ContainsKey('GenericField7')) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField7 -Value $GenericField7
    }
    if ($PSBoundParameters.ContainsKey('GenericField8')) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField8 -Value $GenericField8
    }
    if ($PSBoundParameters.ContainsKey('GenericField9')) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField9 -Value $GenericField9
    }
    if ($PSBoundParameters.ContainsKey('GenericField10')) {
        $request | Add-Member -MemberType NoteProperty -Name GenericField10 -Value $GenericField10
    }
    if ($PSBoundParameters.ContainsKey('Notes')) {
        $request | Add-Member -MemberType NoteProperty -Name Notes -Value $Notes
    }
    if ($PSBoundParameters.ContainsKey('AccountTypeID')) {
        $request | Add-Member -MemberType NoteProperty -Name AccountTypeID -Value $AccountTypeID
    }
    if ($PSBoundParameters.ContainsKey('Url')) {
        $request | Add-Member -MemberType NoteProperty -Name Url -Value $Url
    }
    if ($GeneratePassword.IsPresent) {
        $request | Add-Member -MemberType NoteProperty -Name GeneratePassword -Value $true
    }
    if ($GenerateGenFieldPassword.IsPresent) {
        $request | Add-Member -MemberType NoteProperty -Name GenerateGenFieldPassword -Value $true
    }

    $uri = "$Endpoint/passwords"

    if (-Not $PSBoundParameters.ContainsKey('UseV6Api')) {
        $headers['APIKey'] = $ApiKey.GetNetworkCredential().password
    } else {
        $uri += "?apikey=$($ApiKey.GetNetworkCredential().password)"
    }

    $json = ConvertTo-Json -InputObject $request
    Write-Verbose -Message $json

    $output = @()

    $documentInfo = $null
    if ($DocumentPath) {
        $DocumentInfo = "Upload Document.`nDocumentPath : $DocumentPath`nDocumentName : $DocumentName`nDocument Description : $DocumentDescription"
    }

    if ($PSCmdlet.ShouldProcess("Creating new password entry: $Title `n$json`n$DocumentInfo")) {
        $result = Invoke-RestMethod -Uri $uri -Method Post -ContentType "application/$Format" -Headers $headers -Body $json
        $output += $result

        if ($DocumentPath) {
            $uri = "$Endpoint/document/password/$($result.PasswordID)?DocumentName=$([System.Web.HttpUtility]::UrlEncode($DocumentName))&DocumentDescription=$([System.Web.HttpUtility]::UrlEncode($DocumentDescription))"
            Write-Verbose -Message $uri

            $result = Invoke-RestMethod -Uri $uri -Method Post -InFile $DocumentPath -ContentType 'multipart/form-data' -Headers $headers
            $output += $result
        }
        return $output
    }
}
