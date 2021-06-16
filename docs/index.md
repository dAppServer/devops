# Host Platform Agnostic Build Tool

Our build system is a framework that allows any project to utilise and automate derivative docker base images via CI Pipelines

Without additional work, all users of the project get access to platform agnostic, dev tools, one line commands that are simple and not confusing to document

## It's easy, they said

Compiling is easy, it should "just work", it says so in the README, it will be fun they said!

it's now 10 hours later, you're questioning if you have the IQ to classify as a human,
the README has broken your mouse finger... then in confused tiredness you just replaced a system library with a version that breaks your world.

Lethean Builder, true to the meaning of "Lethean", to forget; is a forgetful & private builder that abstracts all 
that geeky stuff for a few reasons: `Performance`, `Security` & `Compute Reuse (a.k.a being kinder to the planet)`.

Compiling takes time, uses power, it's also wasteful when repeated for no real reason, the solutions to this are too complicated for laypeople.

It's not a simple process, "ain't nobody got time for that".

## Cache all the things!

Using our builder, with some adjustments to settings (*future features) we can do a full compile of our blockchain in just under 2 minutes, or about 15 minutes without pushing limits.

The layers here enable us to deliver fast builds in an acceptable timeframe, instantiated from a terminal or script, on a framework that can be customised to compile literally anything, all options customisable.

## Security

When you are compiling code, you are trusting the author of the code to not do something like install a virus.

Our builder is an 84 MB Alpine linux image, with an internal builder service that interacts with an internal daemon.

Once the task is complete, we run the image and extract the build assets with a simple file copy and store the result of that in the mounted directory.

This enables you to run builds with docker in an isolated context, it is not the way to use docker, don't copy my docker abuse, this is a build tool and temporary.

## Sharing is caring
 
It is wasteful to ask N+1 users to do the same task, using checksums we can prove if some code is safe to compile or use.

If the source checksum and the resulting compile checksum pass validation then why redo what others have already done? 

Thousands of hours wasted, the project will expand shortly with some new features to address that issue, it's not published yet. 
