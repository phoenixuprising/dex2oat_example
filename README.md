# Dex2oat failure example with more than 512 modules.
Highly modularized apps with more than 512 modules and a minSdk > 22 will fail the dex2oat process when the apk is installed due to having too many dexs. The app *will* still install, but will run interpreted bytecode rather than optimized native code. This is also a problem for organizations that create custom Android OS and need to run dex2oat in a build pipeline to include an app in an OS image (our use case). It appears that there is a 1:1 mapping of modules to dexs intended as a build speed optimization to skip the dex merging process. I've attached the dex2oat logs from a pixel 3 emulator running api 26.

## Steps to reproduce
<ol>
<li>Build the app: ./gradlew :app:assembleDebug</li>
<li>Check the number of dexs in the app: unzip -l app/build/outputs/apk/debug/app-debug.apk | egrep 'classes\d+\.dex' | wc -l</li>
<li>Install the app (minSdk 23+)</li>
<li>Check logcat for dex2oat exception being thrown</li>
</ol>