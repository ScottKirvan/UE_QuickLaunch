
WHITEBOARD
=========
> **Note**
>  A **Whiteboard** is a temporary spot that notes are jotted down and then
> erased.  Use it for things like brainstorming, ideation, offloading, etc.
> These notes are ***not*** important and can be erased at any time.

Installing the classic right-click menu requires a restart.  Normally this is a reboot, but
you can go into task manager, right click on "Windows Explorer" and select `restart`

Reboot is manual - I'd like to set up a conditional for this but can't figure how

It would be nice to make the option to install the classic right click menu dependent on windows version

look at  where I've hardcoded UE_QuickLaunch in package.wxs -  set up a  &lt;Directory&gt; for that

If you get a "Couldn't set association for project. Check the file is writeable" error starting Unreal, it probably means your `uproject` file (in JSON format), is broken -- you most likely have an extra or missing comma.


for UE_Quicklaunch installer - maybe better language
![](../assets/media/Pasted%20image%2020231017102955.png)


