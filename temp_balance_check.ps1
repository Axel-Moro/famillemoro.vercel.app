$text = Get-Content -Raw index.html
$matches = [regex]::Matches($text,'<script[^>]*>(.*?)</script>','Singleline')
if ($matches.Count -eq 0) { Write-Host 'no script'; exit 1 }
$s = $matches[$matches.Count-1].Groups[1].Value
$pattern = '("(?:\\.|[^"\\])*"|(''(?:(?:\\.|[^''\\])*)'')|`(?:\\.|[^`\\])*`|//.*?$|/\*[\s\S]*?\*/)' 
$code = [regex]::Replace($s, $pattern, '', 'Singleline,Multiline')
$b = ($code -split '{').Count - 1
$B = ($code -split '}').Count - 1
$p = ($code -split '\(').Count - 1
$P = ($code -split '\)').Count - 1
$lb = ($code -split '\[').Count - 1
$rb = ($code -split '\]').Count - 1
Write-Host "{ $b } } $B diff $($b-$B)"
Write-Host "( $p ) $P diff $($p-$P)"
Write-Host "[ $lb ] $rb diff $($lb-$rb)"
