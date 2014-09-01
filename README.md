About:<blockquote>
**YT-Download** is a program to download entire playlist from youtube.
</blockquote>
<hr>
Features:<br>
<blockquote>
* Automatic updates YT-Download.<br>
* The translations (Polish and English).<br>
* Converter from mp4 to mp3.<br>
* Downloading Youtube playlist.<br>
</blockquote>
<hr>
GUI Install:<br>
<blockquote>
Download this: https://raw.githubusercontent.com/DamiaX/YT_Playlist_downloader/master/yt-download.sh file.<br>
Give permissions to run.
Run as root this file on terminal.
</blockquote>
<hr>
Terminal Install:<br>
<blockquote>
Step 1: Download (Method 1/2: Use <code>wget</code> to download a install script and give permissions to run)
<pre><code>wget https://raw.githubusercontent.com/DamiaX/YT_Playlist_downloader/master/yt-download.sh -O yt-download; 
chmod +x yt-download</code></pre>

Step 1: Download (Method 2/2: Use <code>curl</code> to download a install script and give permissions to run)
<pre><code>curl https://raw.githubusercontent.com/DamiaX/YT_Playlist_downloader/master/yt-download.sh > yt-download;
chmod +x yt-download</code></pre>

Step 2: Run as root the <code>yt-download</code> script.
<pre><code>sudo ./yt-download</code></pre>
</blockquote>
<hr>
Uninstall YT-Download:<br>
<blockquote>
Method 1: Manually uninstalling the program files.<br>
<code>sudo rm -rf /usr/local/bin/yt-download*</code> removing the application<br>
      
Method 2: Starting automatic uninstaller<br>
<code>sudo yt-download -r</code><br>
</blockquote>
<hr>
Advanced usage examples and notes:<blockquote>
<code>-h</code> or <code>--help</code> view the content of help.<br>
<code>-v</code> or <code>--version</code> display the version of the program.<br>
<code>-u</code> or <code>--update</code> check the available program updates.<br>
<code>-r</code> or <code>--remove</code> remove application.<br>
<code>-c</code> or <code>--copy</code> install program.<br>
<code>-a</code> or <code>--author</code> display information about the author of the program.<br>
</blockquote>
<hr>

Author:<br>
<blockquote>
Damian Majchrzak (https://www.facebook.com/DamiaX).
</blockquote>
