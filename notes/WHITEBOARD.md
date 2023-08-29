
About Whiteboard
=============
> **Note**
> A whiteboard is a temporary spot that notes are jotted down and then erased.  Use it for things like brainstorming, ideation, offloading, etc.  These notes are ***not*** important and can be erased at any time.

I'm walking away from this project for a few days.  Here's some links I had open while working on the installer, and that may help when I come back to this:

- https://github.com/wixtoolset/wix/blob/e29b4aacf89ce060509b20a5f81df200f7d2fbc1/src/ext/UI/wixlib/WixUI_InstallDir.wxs
	- This is the wix extension code for the InstallDialog - I was able to kind of understand what was needed by just digging into this source.
- https://www.nuget.org/packages/WixToolset.UI.wixext/
	- This looks like it may have a list of the extensions I can install.  I don't see any documentation, though
- https://www.firegiant.com/wix/tutorial/user-interface/ui-wizardry/
	- This is WiX v3, but I think I'm starting to get my head around the v3/v4 differences (i.e. "Product," became, "Package")
