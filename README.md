Task running :

1. clone repo
2. ganti JDK Flutter dengan mendownload : https://www.dropbox.com/scl/fi/apet89ildzaphemvfdvnm/jdk-17.0.13_windows-x64_bin.exe
3. install jdk 17 
4. setting dengan menggunakan command : flutter config --jdk-dir "C:\Program Files\Java\jdk-17" 
5. buka kembali folder repo melalui vscode, pastikan tampilan "flutter doctor -v" memiliki tampilan seperti ini :
   
    [√] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
   
    • Android SDK at C:\Users\proxi\AppData\Local\Android\sdk
   
    • Platform android-34, build-tools 34.0.0
   
    • Java binary at: C:\Program Files\Java\jdk-17\bin\java
   
    • Java version Java(TM) SE Runtime Environment (build 17.0.13+10-LTS-268)
   
    • All Android licenses accepted.
   
    lalu lanjutkan pada nomor 6
   
7. flutter update
8. flutter pub get
9. flutter run
