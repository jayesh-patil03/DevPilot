$ErrorActionPreference = 'Stop'

$envFile = Join-Path $PSScriptRoot '.env'
$exampleFile = Join-Path $PSScriptRoot '.env.example'

if (-not (Test-Path -LiteralPath $envFile)) {
    Copy-Item -LiteralPath $exampleFile -Destination $envFile
    Write-Host 'Created backend\.env from backend\.env.example.'
    Write-Host 'Edit backend\.env with your local credentials, then run this script again.'
    exit 1
}

$lineNumber = 0
foreach ($line in Get-Content -LiteralPath $envFile) {
    $lineNumber++
    if ([string]::IsNullOrWhiteSpace($line) -or $line.TrimStart().StartsWith('#')) {
        continue
    }

    if ($line -notmatch '^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.*?)\s*$') {
        throw "Invalid setting in backend\.env on line $lineNumber."
    }

    $name = $Matches[1]
    $value = $Matches[2]
    if (($value.StartsWith('"') -and $value.EndsWith('"')) -or
        ($value.StartsWith("'") -and $value.EndsWith("'"))) {
        $value = $value.Substring(1, $value.Length - 2)
    }

    Set-Item -Path "Env:$name" -Value $value
}

$requiredSettings = @(
    'DB_URL',
    'DB_USERNAME',
    'DB_PASSWORD',
    'GEMINI_API_KEY',
    'GITHUB_CLIENT_ID',
    'GITHUB_CLIENT_SECRET',
    'TOKEN_ENCRYPTOR_PASSWORD',
    'TOKEN_ENCRYPTOR_SALT'
)

$missingSettings = @(
    foreach ($name in $requiredSettings) {
        $value = [Environment]::GetEnvironmentVariable($name)
        if ([string]::IsNullOrWhiteSpace($value) -or $value -match '^replace-') {
            $name
        }
    }
)

if ($missingSettings.Count -gt 0) {
    Write-Error "Set these values in backend\.env before starting: $($missingSettings -join ', ')"
    exit 1
}

if ($env:TOKEN_ENCRYPTOR_SALT -notmatch '^[0-9a-fA-F]{16}$') {
    Write-Error 'TOKEN_ENCRYPTOR_SALT in backend\.env must contain exactly 16 hexadecimal characters.'
    exit 1
}

Push-Location $PSScriptRoot
try {
    & .\mvnw.cmd spring-boot:run
    exit $LASTEXITCODE
}
finally {
    Pop-Location
}
