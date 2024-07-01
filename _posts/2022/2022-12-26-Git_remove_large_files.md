--- 
title: "How to fix git error 'this exceeds GitHub's file size limit of 100.00 MB' or 'this is larger than GitHub's recommended maximum file size of 50.00 MB'" 
date: "2022-12-26 23:40" 
comments_id: 59
--- 

I will not explain the all detail why and how because I just do not know.
I just post what fixed this on my case:

![](../assets/images/posts/2022/2022-12-26_23-39-39.jpg){: width="1000" }

You have first to remove those files from your repo.
Then remove them from the history by using [git-filter-repo](https://github.com/newren/git-filter-repo).
Download the git-filter-repo.py, put it your path and use it like `git filter-repo` or as standalone with `python3 git-filter-repo.py`

For this you can first analyze your repos and check things out.

```sh
python3 git-filter-repo.py --analyze
```
It will write some files in `.git\filter-repo\analysis` and you can easily find problematic files in here:

In my case I find those file again in `path-deleted-sizes.txt`

```txt
=== Deleted paths by reverse accumulated size ===
Format: unpacked size, packed size, date deleted, path name(s)
   107151516  106712325 2022-12-22 files/Batch/FFmpeg/202212212131_ScreenCapture.mp4
    92785522   92413548 2022-12-22 files/Batch/FFmpeg/202212212235_ScreenCapture.mp4
    72096675   27407725 2022-11-18 files/srtm_37_04.tif
    12877654   12780899 2022-12-22 files/Batch/FFmpeg/202212212220_ScreenCapture.mp4
```

You need the **correct fullpath** of those files to run:

```sh
python3 C:\Users\doria\Downloads\git-filter-repo.py --path files/srtm_37_04.tif --invert-paths
```

You may need to force it with `--force`.

![](../assets/images/posts/2022/2022-12-26_23-52-23.jpg){: width="1000" }

You will see that it is working with the files number decreasing.
And finally push.

```sh
git push --set-upstream origin master --force
```

If you have a creditential error, you may have to run:

```sh
git remote add origin https://github.com/DGrv/dorian.gravier.github.io
```

Other usefull cmd to see the history :)

```sh
git log --graph --decorate --pretty=oneline --abbrev-commit --all --name-status

```