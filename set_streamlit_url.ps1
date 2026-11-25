# Uso: .\set_streamlit_url.ps1 https://<nome-app>.streamlit.app
param([Parameter(Mandatory=$true)][string]$Url)
$f = Join-Path $PSScriptRoot 'index.html'
$h = [IO.File]::ReadAllText($f)
$h = $h.Replace('http://localhost:8501', $Url).Replace('localhost:8501', ($Url -replace '^https?://',''))
if ($h -notmatch 'name="robots"') { $h = $h -replace '(?i)<head>', "<head>`n<meta name=`"robots`" content=`"noindex, nofollow`">" }
[IO.File]::WriteAllText($f, $h, (New-Object Text.UTF8Encoding $false))
"localhost rimasti: " + ([regex]::Matches($h,'localhost')).Count
