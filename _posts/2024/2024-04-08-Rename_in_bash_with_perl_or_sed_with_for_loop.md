--- 
title: "Rename_in_bash_with_perl_or_sed_with_for_loop" 
date: "2024-04-08 15:53" 
comments_id: 82 
--- 

```sh 

for i in *pdf;do
	new=$(echo $i | perl -pe 's/(.*?)_(.*?)(_\d*.pdf|.pdf)/\2__\1__\3/g')
	mv "$i" "$new"
done
```

[Source in SuperUser](https://superuser.com/a/31466/860920)



