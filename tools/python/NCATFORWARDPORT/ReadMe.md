```

####################################################################################
#                                 PYTHON
####################################################################################

Reminder for the main need:
Have a "Forward Port Tool" in order to do the job in Windows for Podman software.
Netsh seems unable to forward cleanly ports.

1. Python is portable: easy to code for these tiny needs
2. You find in this way: the source code + ico if you want create your own program (how to? clearly I won't explain this here)
3. The file used as conf file is "rtspforward.conf" ==> set vars with your own values
4. The ready-program "RTSPForward.exe" if you want to try (delivered "as is"  without any warranties or guarantees)


####################################################################################
#                                 NCAT DEBUG
####################################################################################

If you need debug with NCAT, try ask an AI with these elements:

Enter each point below (remove the line "STEP") when the exchange with the client FFPLAY to the NCAT listener:

[STEP 1]

RTSP/1.0 200 OK
CSeq: 1
Public: OPTIONS, DESCRIBE, SETUP, PLAY, PAUSE, TEARDOWN

---

[STEP 2]

RTSP/1.0 200 OK
CSeq: 2
Content-Type: application/sdp
Content-Length: 64

v=0
o=- 0 0 IN IP4 192.168.**.**
s=No Name
t=0 0
m=video 0 RTP/AVP 96
a=rtpmap:96 H264/90000

---

[STEP 3]

RTSP/1.0 200 OK
CSeq: 3
Session: 12345678
Transport: RTP/AVP/TCP;unicast;interleaved=0-1

---

=> it will raise a blocking point at the step 3 but at least, you can validate the beginning of exchanges (way "network validated" then it could be an issue on the format).

---






Comet © 2026 by R00t4m0nk is licensed under CC BY-SA 4.0 (+ EULA)
```
[eof]
