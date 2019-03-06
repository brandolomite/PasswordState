function Find-PasswordStatePassword {
    <#
    .SYNOPSIS
        Finds a password entries using criteria.
    .DESCRIPTION
        Finds a password entries using criteria.
    .PARAMETER ApiKey
        The API key for the password list in PasswordState.
    .PARAMETER SystemApiKey
        The system API key for PasswordState.
    .PARAMETER Endpoint
        The Uri of your PasswordState site.
    .PARAMETER PasswordListId
        The Id of the password list in PasswordState.
    .PARAMETER SearchString
        Search text.
    .PARAMETER Title
        Search for text in Title field.
    .PARAMETER Username
        Search for text in Username field.
    .PARAMETER Description
        Search for text in Description field.
    .PARAMETER GenericField1
        Search for text in GenericField1 field.
    .PARAMETER GenericField2
        Search for text in GenericField2 field.
    .PARAMETER GenericField3
        Search for text in GenericField3 field.
    .PARAMETER GenericField4
        Search for text in GenericField4 field.
    .PARAMETER GenericField5
        Search for text in GenericField5 field.
    .PARAMETER GenericField6
        Search for text in GenericField6 field.
    .PARAMETER GenericField7
        Search for text in GenericField7 field.
    .PARAMETER GenericField8
        Search for text in GenericField8 field.
    .PARAMETER GenericField9
        Search for text in GenericField9 field.
    .PARAMETER GenericField10
        Search for text in GenericField10 field.
    .PARAMETER Notes
        Search for text in Notes field.
    .PARAMETER Url
        Search for text in Url field.
    .PARAMETER ExpireBefore
        Search passwords expiring before this date.
    .PARAMETER ExpireAfter
        Search passwords expiring after this date.
    .PARAMETER Format
        The response format from PasswordState.
        Choose either json or xml.
    .PARAMETER UseV6Api
        PasswordState versions prior to v7 did not support passing the API key in a HTTP header
        but instead expected the API key to be passed as a query parameter.
        This switch is used for backwards compatibility with older PasswordState versions.
    .EXAMPLE
        PS C:\> Find-PasswordStatePassword -ApiKey $key -PasswordListId 1 -Title 'test'

        Find password in list ID 1 with 'test' in the title
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPassWordParams', '')]
    [cmdletbinding(DefaultParameterSetName='ListSearch')]
    param(
        [Parameter(ParameterSetName='ListSearch', Mandatory=$true)]
        [pscredential]$ApiKey,

        [Parameter(ParameterSetName='GlobalSearch', Mandatory=$true)]
        [pscredential]$SystemApiKey,

        [string]$Endpoint = (_GetDefault -Option 'api_endpoint'),

        [Parameter(ParameterSetName='ListSearch', Mandatory=$true)]
        [Parameter(ParameterSetName='GeneralSearch', Mandatory=$true)]
        [int]$PasswordListId,

        [Parameter(ParameterSetName='GeneralSearch', Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$SearchString,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Title,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Username,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Description,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField1,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField2,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField3,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField4,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField5,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField6,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField7,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField8,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField9,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$GenericField10,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Notes,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [string]$Url,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [datetime]$ExpireBefore,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [datetime]$ExpireAfter,

        [Parameter(ParameterSetName='ListSearch')]
        [Parameter(ParameterSetName='GlobalSearch')]
        [ValidateSet('json','xml')]
        [string]$Format = 'json',

        [switch]$UseV6Api
    )

    $headers = @{}
    $headers['Accept'] = "application/$Format"

    $params = "?format=$Format"

    if ($PSBoundParameters.ContainsKey('Title')) {
        $params += "&Title=$Title"
    }
    if ($PSBoundParameters.ContainsKey('Description')) {
        $params += "&Description=$Description"
    }
    if ($PSBoundParameters.ContainsKey('Username')) {
        $params += "&Username=$Username"
    }
    if ($PSBoundParameters.ContainsKey('GenericField1')) {
        $params += "&GenericField1=$GenericField1"
    }
    if ($PSBoundParameters.ContainsKey('GenericField2')) {
        $params += "&GenericField2=$GenericField2"
    }
    if ($PSBoundParameters.ContainsKey('GenericField3')) {
        $params += "&GenericField3=$GenericField3"
    }
    if ($PSBoundParameters.ContainsKey('GenericField4')) {
        $params += "&GenericField4=$GenericField4"
    }
    if ($PSBoundParameters.ContainsKey('GenericField5')) {
        $params += "&GenericField5=$GenericField5"
    }
    if ($PSBoundParameters.ContainsKey('GenericField6')) {
        $params += "&GenericField6=$GenericField6"
    }
    if ($PSBoundParameters.ContainsKey('GenericField7')) {
        $params += "&GenericField7=$GenericField7"
    }
    if ($PSBoundParameters.ContainsKey('GenericField8')) {
        $params += "&GenericField8=$GenericField8"
    }
    if ($PSBoundParameters.ContainsKey('GenericField9')) {
        $params += "&GenericField9=$GenericField9"
    }
    if ($PSBoundParameters.ContainsKey('GenericField10')) {
        $params += "&GenericField10=$GenericField10"
    }
    if ($PSBoundParameters.ContainsKey('Notes')) {
        $params += "&Notes=$Notes"
    }
    if ($PSBoundParameters.ContainsKey('Url')) {
        $params += "&Url=$Url"
    }
    if ($PSBoundParameters.ContainsKey('SystemApiKey')) {
        if (-Not $PSBoundParameters.ContainsKey('UseV6Api')) {
            $headers['APIKey'] = $SystemApiKey.GetNetworkCredential().password
            $uri = "$Endpoint/searchpasswords" + "$params"
        } else {
            $uri = "$Endpoint/searchpasswords" + "$params&apikey=$($SystemApiKey.GetNetworkCredential().password)"
        }
    } else {
        if (-Not $PSBoundParameters.ContainsKey('UseV6Api')) {
            $headers['APIKey'] = $ApiKey.GetNetworkCredential().password
            $uri = "$Endpoint/searchpasswords/$PasswordListId" + "$params"
        } else {
            $uri = "$Endpoint/searchpasswords/$PasswordListId" + "$params&apikey=$($ApiKey.GetNetworkCredential().password)"
        }
    }

    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/$Format" -Headers $headers
    return $result
}
