$text = Get-Content -Raw index.html
$m = [regex]::Match($text, '<script>(.*)</script>', 'Singleline')
if (!$m.Success) {
  Write-Host 'no script'
  exit 1
}
$s = $m.Groups[1].Value
$pattern = '("(?:(?:\\.)|[^"\\])*")|(''(?:(?:\\.)|[^''\\])*'')|(`(?:(?:\\.)|[^`\\])*`)|(/\*[\s\S]*?\*/)|(//.*?$)'
$s2 = [regex]::Replace($s, $pattern, '', 'Singleline,Multiline')
$open = ($s2 -split '{').Count - 1
$close = ($s2 -split '}').Count - 1
Write-Host "filtered braces open $open close $close diff $($open - $close)"
