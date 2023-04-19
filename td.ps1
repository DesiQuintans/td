# td.ps1 (todo)
# Inspired by: https://github.com/holman/dotfiles/commit/d774e970a88a04aca8024178849301af6d6ac5c3
# Creates .md text files so that I can put task-related info inside them if necessary.
#
# Usage:
#     > td my-proj/prepare first draft
#
#     Created:
#       Desktop\my-proj\prepare first draft.md
#
#     +---my-proj
#     |       download newest data
#     |    -> prepare first draft
#     |       tree measurement field trip 2023-05-07
#     |
#     \---personal
#             mow lawn
#             pick up moon cakes



# Desktop isn't always in ~\Desktop\, so it has to be found this way.
$DesktopPath = [Environment]::GetFolderPath("Desktop")

$TaskPath = $args -replace "[$([RegEx]::Escape([string][IO.Path]::GetInvalidPathChars()))]+", " "
$TaskPath = $TaskPath -replace "/", "\"
$TaskName = Split-Path -Path $TaskPath -Leaf
$FullPath = "$DesktopPath\$TaskPath.md"


# Parts of the new file.
$DateStamp = Get-Date -Format yyyy-MM-dd
$Contents  = @"
# $TaskPath ($DateStamp)

--------------------------------------------------------------------------------


"@

New-Item "$FullPath" -Force -Value $Contents | Out-Null

# Saving $mytree ... | Out-String and then Write-Hosting it makes it behave
# nicely when td is used in a pipeline.
$mytree = 
    & tree $DesktopPath /F /a |
        Select-String -Pattern '(^.-+|^.\s+$|\.md$)' | 
        % {$_ -replace "\.md$",""} |
        % {$_ -replace "(^.\s+)(\s{3})($($TaskName)$)", "`$1-> `$3"} |
        Out-String

Write-Host $mytree

return $FullPath
