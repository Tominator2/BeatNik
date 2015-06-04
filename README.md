# BeatNik

Beatnik is a tool I wrote back in 2008 to convert data from an Electrocardiogram (ECG) file into Comma Separated Value (CSV) format for a friend who was a cardiologist.  It extracts data from the three leads (channels) and an example graph in Excel made from Beatnik's output is shown below. 

![output-example-reduced](https://cloud.githubusercontent.com/assets/4344677/7978205/11de92ce-0abd-11e5-94bd-fd6078e30120.png)

From the first few bytes of a sample file with a '.raw' extension I was able to determine that the file was a Waveform Database (WFDB) signal file in [Format 16](http://www.physionet.org/physiotools/wag/signal-5.htm#sect3) where the amplitude for each sample is represented by a 16-bit two’s complement stored least significant byte first. A screenshot of Beatnik's user interface is shown below.

![beatnik - screenshot2](https://cloud.githubusercontent.com/assets/4344677/7978207/11e961a4-0abd-11e5-9813-659830567bb2.png)

You can obtain some sample ECG data to try with Beatnik from [PhysioBank](http://physionet.org/physiobank/) using the [Physionet ATM](http://physionet.org/cgi-bin/atm/ATM) (see the image below).   The two '.dat' files from the [American Heart Association (AHA) Database Sample Excluded Record](http://www.physionet.org/physiobank/database/ahadb/) are in Format 16. 

![physionetatm-reduced](https://cloud.githubusercontent.com/assets/4344677/7978206/11e1acc0-0abd-11e5-9661-1b159dcde758.png)

The program is written using Delphi 7 and you can download Beatnik here: 

  * [Windows Executable](https://github.com/Tominator2/BeatNik/releases/download/v0.1/Beatnik.exe) (403 KB)
  * [Delphi Source](https://github.com/Tominator2/BeatNik/archive/v0.1.zip) 




