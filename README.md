# td - A command-line *files on desktop*-style task organiser

A version of Zach Holman's `todo`, personalised for me. See:

- <https://zachholman.com/posts/inbox-zero-everything-zero/>
- <https://github.com/holman/dotfiles/commit/d774e970a88a04aca8024178849301af6d6ac5c3>

My version creates _.md_ text files so that I can put task-related info inside 
them. It also prints a tree structure of my desktop's subfolders and _.md_ files;
since my desktop is cleared of everything except to-do related files, this gives me a
glance at all of my active tasks.

The script returns the new file so it can be piped forward.

It's written in Powershell as a quick exercise. If I end up really liking this idea
I'll probably do something fancier in Nim.


## Usage

This script needs to be accessed through a Powershell terminal, and the script should 
to be in the computer's [PATH](https://www.howtogeek.com/118594/how-to-edit-your-system-path-for-easy-command-line-access/). 

### Create a new task

``` powershell
> td my-proj/prepare first draft
```

```
+---my-proj
|       download newest data
|    -> prepare first draft
|       tree measurement field trip 2023-05-07
|
\---personal
        mow lawn
        pick up moon cakes
        
C:\Users\...\Desktop\my-proj\prepare first draft.md
```

Existing identically-named tasks will be overwritten.

### Create a new task and then immediately open its file

`ii` is an alias for *Invoke-Item*. The file opens in your default text editor.

``` powershell
> td my-proj/prepare first draft | ii
```
