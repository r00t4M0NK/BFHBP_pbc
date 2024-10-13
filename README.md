################################################################
#####          Black Flag Human Beard Project              #####
################################################################

WELCOME TO THE CARIBBEANS !

Here it's my Project, and inside this Project, you can find this Software: COMET

COMET is a debian-based environment inside a container.

It will be used for ethical hacking, but also for so many ways: why not build a stream-container? Or a Musical server, with tools dedicated? Graphical server? Gaming server as a Minecraft server? And so on...!

################################

You find here:
- a "EULA_Comet.txt" File with the legal warnings as usuel for many softwares (mainly to avoid ugly people who are searching the bad!)
- a "ReadMe" File is set on "Tools" directory and this document explains what is this project: in a hand, my needs & all the big questions, and in the other hand the solution which is the Answer, with This Project.
- a "ReadMe_Install" file with steps for installation => any issue could provide from an error during installation. It's an important Step to be carreful with.
- a main File for the Project: a Dockerfile (available mainly to be used also by Podman as a ContainerFile) to use for an ethical hacking tool [When I will achieved Validation phase! Keep in Touch, it will be soon]
- wallpapers: to use easily customised pictures as personnal backgrounds: I pick free pictures, and add on one the Debian Logo and I create a Comet Logo for the second, from free pictures too (use COPY if you want your own file or change URL: you catch project and change for your own usage)
- tools: some files to helps you with some issues I was facing!
   - bin: scripts I have used. You can download them if you need a ready-file but you can create your own with informations from Tips-Files
   - bin_prv (when dir is activated): it's the target for the main using from me in order to swap files from a machine to another (goal: validation)
   - img: here you find pictures as logos for RDP or anything to be displayed for a "better" graphical interface (more for graphism than for hardware power)

################################

COMET, an easy-software
- easy-to-use, not need a project with a structure including many files...
- base is a debian headless version
- 3 ways to access:
   * VNC throught a VNC Client
   * noVNC throught a browser
   * RDP throught a Windows Computer
- For a compatibility reason, Graphical choosen is: XFCE

The Tool can be used in RDP (for easiest way) to use on hack-boxes (next update will be to add a VPN feature).

################################

[INSTALL]

- Step 1. In WSL2, create your work directory. As mkdir -p /home/<your_user>/comet (with correct rights, correct user, up to you)
- Step 2. Follow instructions inside Dockerfile. Chapter "DOWNLOAD DIRECTLY" is an easy-way to set up fast your environment: Build, Clean, Run.
- Step 3. Check the Container which is up.
- Step 4. To add the CyberSecurity Layer (CSL), refer to /tools/bin/cyberhacktoolsinstall.sh (here in GitHub) in chapter "For Downloading parts" with 10 steps.
- Step 5. Enjoy.

  ==> refer to the document PDF "Comet_User_Guide.pdf" with some pictures and a better view for processes in order to install each component.

[ESTIMATED TIME]

- First Full Run: 180 mn
- Full Build: 30 mn
- Install CSL: 90 mn

[NOTES]

- When you build the first image, it stays in cache. So, other runnings should be faster.
- If you change Dockerfile on the top of document, it will be generated from the change. More it's near the top, more time it's need to build again.

################################

Comet © 2024 by R00t4m0nk is licensed under CC BY-SA 4.0 (+ EULA)
[eof]
