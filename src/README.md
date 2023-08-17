# Explanatory notes on the organization of this project.

I've turned this into a **Microsoft Visual Studio Solution** to organize the dependencies between the resource project (`skvfximageres`), the batch files (`UE_QuickLaunch`) and the installer (`UE_QuickLaunch_installer`) projects.

The installer is built using **WiX v4**, and uses the **HeatWave** extension:  
![](../notes/images/Pasted%20image%2020230816133706.png)

If you load the solution and the installer project comes up as "incompatible" (you'll get an error on load), just enable the extension, restart, and then right click on the **UE_QuickLaunch_installer** project, and select "reload project" (or something similar to that).

The initial development will roughly follow https://www.firegiant.com/wix/tutorial/  (not really that much - just general guidance).  TBH, ChatGPT ended up being a better resource for "how do I do.." type questions on a lot of this, so if you want to make changes or learn WiX, don't fear the GPT.

The installer, `UE_QuickLaunch_installer.msi`, runs unassisted and builds into the EU_QuickLaunchInstaller/bin folder and installs to `ProgramFiles/SKVFX UE_QuickLaunch`. It can be uninstalled/modified, in **Window's Settings > Apps > Installed apps**.







