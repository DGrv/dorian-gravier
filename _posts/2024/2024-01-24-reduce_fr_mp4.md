--- 
title: "Create an alias to reduce the frame rate of video if above a certain value in bash" 
date: "2024-01-24 16:13" 
comments_id: 76
--- 

Here is the code:

It will reduce the frame rate from a video to 60 if greater than 60, in the current folder.

```sh
for i in *mp4; do  
	fr=$(exiftool -n -T -VideoFrameRate -s3 $i); 
	fr=$(calc -d "round($fr)");  
	fr=$(echo $fr);
	if [[ "$fr" -gt "60" ]]; then 
		nname="$(basename $i .mp4)___old_fr-$fr.mp4"; 
		mv "$i" "$nname";
		cecho -g "Convert $i:"; 
		ffmpeg -stats -loglevel error -i "$nname" -r 60 "$i";
		echo;
	fi;
done
```

Insert this in your ~/.bashrc.

```sh
alias reduce.fr.60='for i in *mp4; do  fr=$(exiftool -n -T -VideoFrameRate -s3 $i);  fr=$(calc -d "round($fr)");  fr=$(echo $fr);  if [[ "$fr" -gt "60" ]]; then   nname="$(basename $i .mp4)___old_fr-$fr.mp4";   mv "$i" "$nname"; cecho -g "Convert $i:"; ffmpeg -stats -loglevel error -i "$nname" -r 60 "$i"; echo;  fi; done'
```



