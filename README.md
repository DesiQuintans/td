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

### Create a new task

```powershell
> td CHAPTER 1 - Prepare first draft
```

```
    Created         Project         Task
    -------         -------         ----
    2024-06-24      CHAPTER 1       Prepare first draft

    The task's file is located at:
    C:\Users\xxx\Desktop\CHAPTER 1 - Prepare first draft.md
```

Existing identically-named tasks will NOT be overwritten.

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
