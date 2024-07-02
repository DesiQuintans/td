# td.ps1 (todo)
# Inspired by: https://github.com/holman/dotfiles/commit/d774e970a88a04aca8024178849301af6d6ac5c3
#
# A to-do system that uses loose Markdown files to track tasks. Each file is an action item, and
# can contain notes relevant to that task. You should name your tasks as
#    PROJECTNAME - Task description
# so that they show up nicely in the task list table.
#
# Usage:
#     > td CHAPTER 1 - Prepare first draft
#
#         Created         Project         Task
#         -------         -------         ----
#         2024-06-24      CHAPTER 1       Prepare first draft
#
#         The task's file is located at:
#         C:\Users\xxx\Desktop\CHAPTER 1 - Prepare first draft.md
#
#     > td
#
#         Created         Project         Task
#         -------         -------         ----
#         2024-06-24      CHAPTER 1       Prepare first draft
#



# Establish where the files will be created. If you want to put them on your desktop, use:
$ToDoPath = [Environment]::GetFolderPath("Desktop")
# $ToDoPath = "C:\Users\myusername\path\to\folder"



# This function prints a table of current projects and tasks, sorted first by project and then by creation date.
function Show-Tasks {
    # This is what the table will look like.
    $tdlayout = @{Label = 'Created'; Expression = {$_.CreationTime -replace '^(.{10}).*?$', '$1'}; Width = 15},
                @{Label = 'Project'; Expression = {$_.Name -replace '^(.*?) - .*?$', '$1'};        Width = 15},
                @{Label = 'Task';    Expression = {$_.Name -replace '^.*? - (.*?)\.md$', '$1'}}

    Get-ChildItem -Path $ToDoPath -Filter *.md |
    Sort-Object Name, CreationTime |
    Format-Table -Property $tdlayout -Wrap |
    Out-String |
    Write-Host
}


# If no arguments are provided, just print the task list.
if($args.Count -eq 0) {
    Show-Tasks
    return
}



# If arguments are provided, treat them as the name of a new task. Clean the
# input so that it can be used as a valid filename.
$TaskPath = $args -replace '[:*?\"<>|]+', "_"
$TaskPath = $TaskPath -replace "/", "\"
$TaskPath = $TaskPath -replace "(\.md)+$", ""
$TaskPath = $TaskPath -replace "^(.\\)+", ""
$TaskName = Split-Path -Path $TaskPath -Leaf
$FullPath = "$ToDoPath\$TaskPath.md"


# Contents of the file that will be created.
$DateStamp = Get-Date -Format yyyy-MM-dd
$Contents  = @"
# $TaskPath ($DateStamp)

-------------------------------------------------------------------------------


"@



# Create the file if it doesn't already exist.
if (-not (Test-Path -Path $FullPath)) {
    New-Item -Path "$FullPath" -Force -Value $Contents | Out-Null
}

# Print the updated task list.
Show-Tasks

# Print a little message about the task file.
# Returning the full path to the new file allows me to pipe into `td my_new_task | ii`.
Write-Host "The task's file is located at:" -ForegroundColor green
return $FullPath
