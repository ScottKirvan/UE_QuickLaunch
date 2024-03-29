# Explanatory notes on the organization of this project.
## Repository Branches
The most recent, and potentially unstable build, will be in the `main` branch.  Releases are branched/tagged with semantic version numbers (ie. `v2.3.4`).  WIP Features and will usually be housed in temporary branches  -- these branches are often deleted when no longer needed.  

I develop my documentation in Obsidian.  In this repo, he `obsidian` branch is a WIP documentation branch that contains automatic checkins from Obsidian.  These are merged (and squashed) back into main periodically. 

## Building from source

I've turned this into a **Microsoft Visual Studio Solution** to organize the dependencies between the resource project (`skvfximageres`), the batch files (`UE_QuickLaunch`) and the installer (`UE_QuickLaunch_installer`) projects.  I use **Microsoft Visual Studio Community 2022**

## Visual Studio 2022 - requirements:
The installer is built using **WiX v4**, and uses the **HeatWave** extension:  
![](../assets/media/Pasted%20image%2020230816133706.png)

If you load the solution and the installer project comes up as "incompatible" (you'll get an error on load), just enable the extension, restart, and then right click on the **UE_QuickLaunch_installer** project, and select "reload project" (or something similar to that).

If you're interested in learning how to make an MSI installer using something like HeatWave, I found the Wix v4 documentation pretty impenetrable, but ChatGPT did a pretty good job at getting me started with the xml syntax.

The installer, `UE_QuickLaunch_installer.msi`, runs unassisted and builds into the UE_QuickLaunchInstaller/bin folder and installs to `ProgramFiles/SKVFX UE_QuickLaunch`. It can be uninstalled/modified, in **Window's Settings > Apps > Installed apps**.

# WiX v4 resources:

- https://github.com/wixtoolset/wix/blob/e29b4aacf89ce060509b20a5f81df200f7d2fbc1/src/ext/UI/wixlib/WixUI_InstallDir.wxs
	- This is the wix extension code for the InstallDialog - I was
	able to kind of understand what was needed by just digging into
	this source.
- https://www.nuget.org/packages/WixToolset.UI.wixext/
	- This looks like it may have a list of the extensions I can
	install.  I don't see any documentation, though
- https://www.firegiant.com/wix/tutorial/user-interface/ui-wizardry/
	- This is WiX v3, but I think I'm starting to get my head around
	the v3/v4 differences (i.e. "Product," became, "Package", etc.)
- https://www.firegiant.com/docs/wix/v3/tutorial/
- I'm finding I can stub together close-to-working v3 code snippets and use `wix convert` to get a better idea how to format the v4 version.  This is helping, but what a PITA.  Document your fucking code.


# Generate Logfile for Installer
```
msiexec /i UE_QuickLaunch_installer.msi /L*v ".\InstallLog.txt"
```



