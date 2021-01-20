# GenericSeqMon
Matlab project for automatically converting audio files to spike files using the Neuromorphic Auditory Sensor.

## Note
This project has been tested in a x64 computer running Windows10.

## Previous considerations
If I clone this repository in the following path:

`D:\dgutierrezATC\myrepos\GenericSeqMon\`

Then I will have a folde architecture like:
```
...\myrepos
       |
       --GenericSeqMon
               |
               --.gitignore
               --LICENSE
               --README
               --GenericSeqMon
                      |
                      --Dataset
                         |
                         --audio
                             |
                             -a
                               |
                               --1.wav
                               --2.wav
                             -b
                               |
                               --1.wav
                               --2.wav
                             -c
                               |
                               --1.wav
                               --2.wav
                         --events
                      --host
                         |
                         --java
                             |
                             --dist
                                 |
                                 --...
                             --jars
                                 |
                                 --...
                      --startup.m
                      --mainSoundDB
                      --...
```
## Configuration steps
Few previous configurations need to be done before running the code:

1. If jAER software has been launched, please close it.
2. In Matlab, write `edit libraryPath.txt`
3. At the end of the file, please add `D:\dgutierrezATC\myrepos\GenericSeqMon\host\java\jars`
4. Save the file, and close it.
5. Close Matlab and open it again.

:warning:**WARNING!: If you copy the Java libraries to another folder (eg. `C:\dgutierrezATC\Documents\MATLAB`) then you would need to change the absolute path in the file `startup.m` since it uses the function `pwd` to obtain the current path of the Matlab file.**

---------------------------------------
:key: Sometimes, after running `startup.m`, the following warning message could appear:

> WARNING!: no usbiojava in java.library.path: usbiojava libary not found; either you are not running Windows, the UsbIoJava.jar is not on the classpath, or the native DLL is not on java.library.path

In that case, follow this steps:
1. Go to the folder `D:\dgutierrezATC\myrepos\GenericSeqMon\host\java\jars\win64`.
2. Look for the file `usbiojava.dll.file` and change its name by removing `.file` (so the file should be `usbiojava.dll`).
3. Finally, modify again the `libraryPath.txt` by adding at the end of the file the path to the .dll file (`D:\dgutierrezATC\myrepos\GenericSeqMon\host\java\jars\win64`).
4. Save the file, and close it.
5. Close Matlab and open it again.
---------------------------------------
Then, in mainSoundDB.m file, change both the source and destination directories.
- `source = D:\dgutierrezATC\myrepos\GenericSeqMon\Dataset\audio`
- `dest = D:\dgutierrezATC\myrepos\GenericSeqMon\Dataset\events`

## Main steps

1. Run startup.m
2. Run mainSoundDB.m
