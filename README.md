# td - A command-line *files on desktop*-style task organiser

A version of Zach Holman's `todo`, personalised for me. See:

- <https://zachholman.com/posts/inbox-zero-everything-zero/>
- <https://github.com/holman/dotfiles/commit/d774e970a88a04aca8024178849301af6d6ac5c3>

My version creates _.md_ text files so that I can put task-related info inside 
them. It also prints a nice table of the tasks within each project.

If a task file was created or referenced, the script returns it so it can be piped forward.

It's written in Powershell as a quick exercise.


## Usage

This script needs to be accessed through a Powershell terminal, and the script should 
to be in the computer's [PATH](https://www.howtogeek.com/118594/how-to-edit-your-system-path-for-easy-command-line-access/). 

By default, files are created inside a folder called `Task list` that is on your Desktop (i.e. `C:\Users\xxx\Desktop\Task list\`). To change where this is, edit the `ToDoPath` variable near line 35.

### Create a new task

```powershell
> td CHAPTER 1 - Prepare first draft
```

```
    Created         Project         Task
    -------         -------         ----
    2024-06-24      CHAPTER 1       Prepare first draft

    The task's file is located at:
    C:\Users\xxx\Desktop\CHAPTER 1 - Prepare first draft - (2025-09-17).md
```

Existing identically-named tasks will NOT be overwritten. Filenames are suffixed with their 
creation date to counteract potential data loss; for example, if you download the file from an
email or the web, the Creation Time metadata in the file might be replaced with the date when
the file was downloaded to your computer.

### Create a new task and then immediately open its file

`ii` is an alias for *Invoke-Item*. The file opens in your default text editor.

``` powershell
> td CHAPTER 1 - Prepare first draft | ii
```

### Looking at all of your tasks

```powershell
> td
```

```
    Created         Project         Task
    -------         -------         ----
    2024-06-24      CHAPTER 1       Prepare first draft
```

Files are sorted first by project, and then by creation date.

### Clearing finished tasks

`td` only lists Markdown files that are located in the `ToDoPath`. To make them no longer appear as active tasks, simply move them out of this folder.

My personal method is to create a folder for the first day of each week in the year (e.g. `Task list\2025-10-06\`, `Task list\2025-10-13\`, etc.) and to put all tasks that I've completed during that week into that folder.

