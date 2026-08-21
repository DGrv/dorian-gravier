
---
title: "Scoop"
permalink: /code/scoop/
toc: true
author_profile: false
layout: code
---



# Downgrade version

```sh
scoop reset <app>@<version>
scoop reset python@3.13.1
```

# Clean

```sh
scoop help cleanup
Usage: scoop cleanup <app> [options]

'scoop cleanup' cleans Scoop apps by removing old versions.
'scoop cleanup <app>' cleans up the old versions of that app if said versions exist.

You can use '*' in place of <app> to cleanup all apps.

Options:
  -g, --global       Cleanup a globally installed app
  
scoop cleanup * --cache

```