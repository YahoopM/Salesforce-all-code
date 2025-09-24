Param(
    [Parameter(Mandatory=$true)][string]$SiteUrl,
    [Parameter(Mandatory=$true)][string]$Issue,
    [Parameter(Mandatory=$true)][string]$Email,
    [Parameter(Mandatory=$true)][string]$Token,
    [Parameter(Mandatory=$false)][string]$TransitionName = 'In Progress',
    [Parameter(Mandatory=$false)][string]$PriorityName = 'High'
)

$ErrorActionPreference = 'Stop'

function New-BasicAuthHeader {
    param([string]$email, [string]$token)
    $pair = "{0}:{1}" -f $email, $token
    $b64  = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($pair))
    return @{ Authorization = "Basic $b64" }
}

function Invoke-JiraGetTransitions {
    param([string]$siteUrl, [string]$issue, [hashtable]$auth)
    $headers = $auth.Clone()
    $headers['Accept'] = 'application/json'
    return Invoke-RestMethod -Method GET -Uri "$siteUrl/rest/api/3/issue/$issue/transitions" -Headers $headers
}

function Invoke-JiraTransitionIssue {
    param([string]$siteUrl, [string]$issue, [hashtable]$auth, [string]$transitionId)
    $headers = $auth.Clone()
    $headers['Content-Type'] = 'application/json'
    $body = @{ transition = @{ id = $transitionId } } | ConvertTo-Json
    Invoke-RestMethod -Method POST -Uri "$siteUrl/rest/api/3/issue/$issue/transitions" -Headers $headers -Body $body | Out-Null
}

function Invoke-JiraSetPriority {
    param([string]$siteUrl, [string]$issue, [hashtable]$auth, [string]$priorityName)
    if ([string]::IsNullOrWhiteSpace($priorityName)) { return }
    $headers = $auth.Clone()
    $headers['Content-Type'] = 'application/json'
    $body = @{ fields = @{ priority = @{ name = $priorityName } } } | ConvertTo-Json
    Invoke-RestMethod -Method PUT -Uri "$siteUrl/rest/api/3/issue/$issue" -Headers $headers -Body $body | Out-Null
}

function Invoke-JiraGetStatusPriority {
    param([string]$siteUrl, [string]$issue, [hashtable]$auth)
    $headers = $auth.Clone()
    $headers['Accept'] = 'application/json'
    return Invoke-RestMethod -Method GET -Uri "$siteUrl/rest/api/3/issue/$issue?fields=priority,status" -Headers $headers
}

Write-Host "Preparing authentication..."
$auth = New-BasicAuthHeader -email $Email -token $Token

Write-Host "Fetching available transitions for $Issue..."
$transitions = Invoke-JiraGetTransitions -siteUrl $SiteUrl -issue $Issue -auth $auth
$target = $transitions.transitions | Where-Object { $_.name -ieq $TransitionName } | Select-Object -First 1
if (-not $target) {
    throw "No transition named '$TransitionName' is available for issue $Issue."
}

Write-Host "Transitioning $Issue using id $($target.id) ($TransitionName)..."
Invoke-JiraTransitionIssue -siteUrl $SiteUrl -issue $Issue -auth $auth -transitionId $target.id

Write-Host "Setting priority of $Issue to $PriorityName..."
Invoke-JiraSetPriority -siteUrl $SiteUrl -issue $Issue -auth $auth -priorityName $PriorityName

Write-Host "Verifying updated status and priority..."
$issueResp = Invoke-JiraGetStatusPriority -siteUrl $SiteUrl -issue $Issue -auth $auth
$result = [PSCustomObject]@{
    issue    = $Issue
    status   = $issueResp.fields.status.name
    priority = $issueResp.fields.priority.name
}
$result | ConvertTo-Json -Compress | Write-Output


