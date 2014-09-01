#!/bin/bash

#Copyright © 2014 Damian Majchrzak (DamiaX)
#http://damiax.github.io/YT_Playlist_downloader/

version="2.1";
name="yt-download";
actual_dir="$(pwd)";
temp=".adres";
temp2=".adres2";
temp3=".adres3";
programs_dir="/usr/bin";
app_dir="/usr/local/bin";
youtube_name="youtube-dl";
lame_name="lame";
mplayer_name="mplayer";
tump="audiodump.wav";
mp3_dir="MP3";
filetype=".mp4";
update_url="https://raw.githubusercontent.com/DamiaX/YT_Playlist_downloader/master/Core/Update.sh";
lang_pl_url="https://raw.githubusercontent.com/DamiaX/YT_Playlist_downloader/master/Lang/yt_playlist_downloader.pl.lang";
lang_en_url="https://raw.githubusercontent.com/DamiaX/YT_Playlist_downloader/master/Lang/yt_playlist_downloader.en.lang";
version_url="https://raw.githubusercontent.com/DamiaX/YT_Playlist_downloader/master/VERSION";
remove_url="https://raw.githubusercontent.com/DamiaX/YT_Playlist_downloader/master/Core/remove.sh";
connect_test_url1='google.com';
connect_test_url2='facebook.com';
connect_test_url3='kernel.org';
version_name=".version";
update_name="update.sh";
remove_name="remove.sh";
lang_pl_name="yt-download.pl.lang";
lang_en_name="yt-download.en.lang";

data_clear()
{
rm -rf $temp;
rm -rf $temp2;
rm -rf $temp3;
rm -rf $tump;
}

langpl()
{
if [ -e $app_dir/$name ] ; then
if [ ! -e $app_dir/$lang_pl_name ] ; then
wget -q $lang_pl_url -O $app_dir/$lang_pl_name
fi
else
wget -q $lang_pl_url -O $lang_pl_name
fi
}

langen()
{
if [ -e $app_dir/$name ] ; then
if [ ! -e $app_dir/$lang_en_name ] ; then
wget -q $lang_en_url -O $app_dir/$lang_en_name
fi
else
wget -q $lang_en_url -O $lang_en_name
fi
}

case $LANG in
*PL*)
langpl;
if [ -e $app_dir/$lang_pl_name ] ; then
source $app_dir/$lang_pl_name;
else
source $lang_pl_name;
fi;;
*)
langen;
if [ -e $app_dir/$lang_en_name ] ; then
source $app_dir/$lang_en_name;
else
source $lang_en_name;
fi;;
esac

print_text()
{
for TXT in $( echo $2 | tr -s '[ ]' '[@]' | sed -e 's@[a-x A-X 0-9]@ &@g' )
do
echo -e -n "\E[$1;1m$TXT\033[0m" | tr '@' ' '
sleep 0.06
done
echo ""
}

show_text()
{
echo -e -n "\E[$1;1m$2\033[0m"
echo ""
}

check_app()
{
if [ ! -e $programs_dir/$youtube_name ] ; then
show_text 31 "$Require $youtube_name."
show_text 31 "$To_Install $youtube_name $Chose"
show_text 31 "sudo apt-get install $youtube_name"
exit 127;
fi
}

default_answer()
{
if [ -z $answer ]; then
answer='y';
fi
}

check_security()
{
if [ "$(id -u)" != "0" ]; then
show_text 31 "$root_fail" 1>&2
exit;
fi
}

add_chmod()
{
chmod 777 *.mp4;
chmod 777 $mp3_dir;
chmod 777 $mp3_dir/*.mp3;
}

update()
{
wget --no-cache --no-dns-cache -q $version_url -O $version_name
echo "$version" > $temp3
cat $version_name|tr . , >$temp
cat $temp3|tr . , >$temp2
sed -i 's@,@@g' $temp
sed -i 's@,@@g' $temp2
ver7=`cat "$temp"`
ver9=`cat "$temp2"`
if [ $ver7 -eq $ver9 ]
then
print_text 35 "=> $Check_version"
else
print_text 37 "=> $Download_new"
wget -q $update_url -O $update_name
chmod +x "$update_name"
rm -rf $temp
rm -rf $temp2
rm -rf $temp3
rm -rf $url
./"$update_name"
exit;
fi
}

test_connect()
{
ping -q -c1 $connect_test_url1 >$temp
if [ "$?" -eq "2" ];
then
ping -q -c1 $connect_test_url2 >$temp
if [ "$?" -eq "2" ];
then
ping -q -c1 $connect_test_url3 >$temp
if [ "$?" -eq "2" ];
then
show_text 31 "$No_connect";
rm -rf $temp;
exit;
fi
fi
fi
}

remove_app()
{
show_text 31 "$Answer_remove";
read answer;
default_answer;
if [[ $answer == "T" || $answer == "t" || $answer == "y" || $answer == "Y" ]]; then
wget -q $remove_url -O $remove_name;
chmod +x $remove_name;
./$remove_name;
exit;
fi
}

copy_error()
{
print_text 31 "=> $Copy_wrong";
wget -q $remove_url -O $remove_name;
chmod +x $remove_name;
./$remove_name;
exit;
}

check_success_copy()
{
if [ $? != 0 ]
then
copy_error;
fi
}

copy_file()
{
cp $0 $app_dir/$name
check_success_copy;
cp $name*.lang $app_dir
check_success_copy;

if [ $? -eq 0 ]
then
print_text 33 "=> $Copy_ok";
echo -e "\E[37;1m=> $run\033[0m" "\E[35;1msudo $name\033[0m";
fi
}

install_file()
{
if [ "$1" = "1" ]
then
if [ ! -e $app_dir/$name ] ; then
show_text 31 "=> $Copy_file";
read answer;
default_answer;
if [[ $answer == "T" || $answer == "t" || $answer == "y" || $answer == "Y" ]]; then
copy_file;
fi
fi
else
copy_file;
fi
}

youtube_parser()
{
sed -e 's@<a href="/watch?v=@\n<program2>@g' $temp >$temp2
sed -e 's@&amp;index=@\n@g' $temp2 >$temp
sed -i 's/[[:space:]]/\n/g' $temp
sed -i 's/&amp;list=/\n/g' $temp
cat $temp | cut -d'"' -f2-100 >$temp2
sed -i 's/[[:space:]]//g' $temp2
sed -i 's/\n//g' $temp2
grep "<program2>" $temp2 >$temp
sed -i '/^[ \t]*$/ d' $temp
sed -i 's@<program2>@http://www.youtube.com/watch?v=@g' $temp
sort -u $temp >$temp2
cat $temp2 > $temp
}

youtube_website_download()
{
show_text 33 "$Download";
read adres;

if [ -z "$adres" ] ; then
	show_text 31 "$unknow";
	show_text 31 "$unknow1";
	exit 1;
fi

show_text 33 "$Chose_dir";

read katalog;

if [ -z "$katalog" ] ; then
	show_text 31 "$unknow";
	show_text 31 "$unknow1";
	exit 1;
fi

if [ ! -e "$katalog" ] ; then
mkdir -p "$katalog";
fi

cd "$katalog";

wget -q $adres -O $temp;
}

playlist_download()
{
for i in `cat $temp`
do
youtube-dl $i
done
add_chmod;
print_text 32 "=> $Download_end"
print_text 34 "=> $Save_to $katalog";

rm -rf $temp
rm -rf $temp2

cd "$actual_dir"
}

convert_to_mp3()
{
cd "$katalog"

echo "$Convert";
read answer;
default_answer;
if [[ $answer == "T" || $answer == "t" || $answer == "y" || $answer == "Y" ]]; then

if [ ! -e $programs_dir/$lame_name ] ; then
show_text 31 "$Require $lame_name."
show_text 31 "$To_Install $lame_name $Chose"
show_text 31 "sudo apt-get install $lame_name"
exit 127;
fi

if [ ! -e $programs_dir/$mplayer_name ] ; then
show_text 31 "$Require $mplayer_name."
show_text 31 "$To_Install $mplayer_name $Chose"
show_text 31 "sudo apt-get install $mplayer_name"
exit 127;
fi

mkdir -p $mp3_dir;

for file in *$filetype ; do

basename=`basename "$file" ".$filetype"`
name=`echo "$basename" | sed -e "s/.mp4$//g"`
mplayer -novideo -nocorrect-pts -ao pcm:waveheader "$file"
lame -h -b 192 $tump "$name.mp3"
rm -rf $tump
mv "$name.mp3" $mp3_dir/"$name.mp3"
add_chmod;
done
else
exit 0;
fi
}

while [ "$1" ] ; do
case "$1" in
"--help"|"-h")
echo -e "$App"
echo "-h, --help: $help";
echo "-v, --version: $ver_info";
echo "-u, --update: $update_info";
echo "-r, --remove: $Yt_download_remove";
echo "-c, --copy: $copy_info";
echo "-a, --author: $author_info";
exit;;
"--version"|"-v")
echo -e "\E[1;1m$App $version\033[0m";
echo "$version_info $version";
exit;;
"--update"|"-u")
echo -e "\E[1;1m$App $version\033[0m";
check_security;
test_connect;
update;
exit;;
"--remove"|"-r")
echo -e "\E[1;1m$App $version\033[0m";
check_security;
test_connect;
remove_app;
exit;;
"--copy"|"-c")
echo -e "\E[1;1m$App $version\033[0m";
check_security;
test_connect;
rm -rf "$app_dir/$name*";
install_file 1;
exit;;
"--install_update"|"-iu")
check_security;
install_file 0;
exit;;
"--author"|"-a")
echo -e "$App"
echo -e "$name_author";
exit;;
*)
echo -e "$error_unknown_option_text"
exit;
;;
esac
done

clear;
echo -e "\E[1;1m$App $version\033[0m";
check_security;
test_connect;
update;
check_app;
install_file 1;
youtube_website_download;
youtube_parser;
playlist_download;
data_clear;
chmod 777 $katalog;
convert_to_mp3;
exit;
