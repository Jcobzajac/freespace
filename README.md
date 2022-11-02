Following is a synopsis of the script:

freespace [-r] [-t ###] file [file...]
If file is not compressed - will zip it under name “fc-<origname>”
If file is compressed - will move it to name “fc-<origname>” and 'touch' it
If file is called “fc-*” AND is older than 48 hours - will rm it
If file is a folder - will go over all non-folder files in it
If in recursive mode - will also follow folders recursively

Flags:
-r - recursive mode
-t - alternative timeout in hours. Default is 48.