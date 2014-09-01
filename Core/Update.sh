#!/bin/bash
#Copyright © 2014 Damian Majchrzak (DamiaX)
#http://damiax.github.io/kernelup/
url="https://raw.githubusercontent.com/DamiaX/YT_Playlist_downloader/master/yt-download.sh";
remove_url="https://raw.githubusercontent.com/DamiaX/YT_Playlist_downloader/master/Core/remove.sh"
name="yt-download";
remove_name="remove.sh"
wget -q $remove_url -O $remove_name;
chmod +x $remove_name;
./$remove_name;
wget -q $url -O $name;
chmod +x $name;
./$name -iu;
rm -rf $0;
exit;
