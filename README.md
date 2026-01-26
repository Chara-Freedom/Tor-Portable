**[РУССКОЕ ЧИТАЙМЕНЯ](https://github.com/Chara-Freedom/Tor-Portable/blob/main/README-RU.md)**

[Telegram channel](https://t.me/Tor_Portable)

[Tutorial to use Tor Portable to unlock Telegram](https://t.me/Tor_Portable/131)

**Keep It Functional, F#####!** 🤘

**Tor is not a browser!**

---
# Tor Portable

The fine-tuned Tor core for any browser configurations. EN, CN and RU configs. 2025 version Webtunnel proto. Linux, win 7 and win 8+ support.

Support me: 0xb9569717b5f1ee67a2ace2b999a61e3d8d4cce52 USDT BEP20, https://www.donationalerts.com/r/verity_freedom.

**Please leave a star:**

<a href="https://www.star-history.com/#Chara-Freedom/Tor-Portable&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=Chara-Freedom/Tor-Portable&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=Chara-Freedom/Tor-Portable&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=Chara-Freedom/Tor-Portable&type=date&legend=top-left" />
 </picture>
</a>

Developed with community support (especially thanks to [bananakid](https://github.com/anticensority/runet-censorship-bypass/issues/224#issuecomment-2025676123) and [DesuIsALie](https://github.com/Chara-Freedom/Tor-Portable/issues/2#issuecomment-2362230547)).  
The main author of Tor Portable is Verity Freedom. Concept, configurations, Win 7 patch, Linux portable deployment, [update system](https://github.com/Chara-Freedom/GRU-current), services, guide by Verity Freedom.  
[Win 7 patcher](https://github.com/stunndard/golangwin7patch) by stunnard.  
[Hosts list](https://github.com/dartraiden/no-russia-hosts) by dartraiden.  
The author of the [Antizapret proxy](http://antizapret.prostovpn.org/) is ValdikSS.  
[Tor Expert Bundle](https://www.torproject.org/download/tor/) by Tor Project.  
[SwitchyOmega](https://github.com/FelisCatus/SwitchyOmega) by FelisCatus, [ZeroOmega](https://github.com/zero-peak/ZeroOmega) by zero-top.  
[Discord-drover](https://github.com/hdrover/discord-drover) by hdrover, [discord-linux-bypass](https://github.com/nik9play/discord-linux-bypass) by nik9play.  
[Technical help](https://github.com/Chara-Freedom/Tor-Portable/commits?author=NoPlagiarism) by NoPlagiarism, also helped naming Tor bridges (private frozen project) and testing Webtunnel.  
Win 7 and bitness tests ([1](https://github.com/Chara-Freedom/Tor-Portable/issues/8#issuecomment-2906773975), [2](https://github.com/Chara-Freedom/Tor-Portable/issues/21#issuecomment-2907699471)) by qwers99.  
Tests and technical help in Linux [portable](https://github.com/NixOS/nixpkgs/issues/425977) [deployment](https://github.com/NixOS/nixpkgs/issues/427078) by imsweetdogs and 7c6f434c respectively.  
Elevation system by [Matt](https://stackoverflow.com/a/12264592), [Verity Freedom](https://stackoverflow.com/a/79585058) and [Mofi](https://stackoverflow.com/questions/7044985/how-can-i-auto-elevate-my-batch-file-so-that-it-requests-from-uac-administrator/12264592#comment140920768_12264592) (professional review and editing).

## Philosophy

The Tor Project develops breakthrough technologies for bypassing censorship. However, their flexibility is constrained by several factors: 1) excessive dependence on the browser, which always requires a connection to the Tor network; 2) the lack of exits hidden from external censorship.

By freeing the Tor core from the browser, I return to this technology the user freedom that it should retain, and I always say that Tor is not a browser. Binding to a browser also prevents maintaining support for Windows 7 (is not the only reason, tho). [The mentioned exits issue has been acknowledged by the developers](https://gitlab.torproject.org/tpo/core/tor/-/issues/41098). The Russian community [used](https://ntc.party/t/мосты-webtunnel-в-tor-browser/15595/150) a patched, censorship-resistant version of Webtunnel several months before the developers officially introduced similar changes (although the official version is safer and so significantly better, but hundreds of people benefited from the quick patch), and only the independent core build made it possible. It's also much lighter than the browser.

Tor Portable is a simple, fully portable core with configuration files for interacting with it. My goal is to provide free access to the Internet for the maximum number of people while living in a country with strict censorship and an authoritarian regime.

To achieve my goal, I freely combine, modify and distribute available open-source solutions with the most promising future today. Ensuring the popularity of these solutions is achieved by keeping them simple and accessible. My motivation is crystal clear, and I don't pretend to do anything greater than this. It's enough that some of my users like what I do, while I do this because of a deep aversion to authoritarianism and the desire to get some of the popularity for it. The project shares the BSD-3 license common to Tor.

Without further ado, here we go.

## Installation

First of all, if you want an experience similar to Tor Portable on Android, there is a great program from Gedsh. I translated [the guide](https://github.com/Chara-Freedom/Tor-Portable/wiki/InviZible-Pro-EN) for you.

Tor Portable is hosted on the IPNS "eternal cloud", which is extremely convenient for independent information distribution, since proprietary clouds are unreliable (for many reasons, and even GitHub has mistakenly removed Tor Portable several times, making it unavailable). For this, pinata.cloud and ipns.ipfs.network were used. I don't recommend anyone to use free proprietary clouds like MEGA with their censorship and lack of features, as dependence on them deprives you of technological sovereignty.

[Download the release from here](https://ipfs.io/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4/).

Select the Tor you need and unpack it. Avoid special characters in the paths to your folder. Running AntiTor will open Tor for current session, while running service-manager will create a service. To remove the service, run service-manager again. AntiTor and service-manager are the only two files that will run Tor correctly. Tor will start with all the necessary universal connection settings. Opening tor.exe in the tor folder will launch pure, bridgeless core Tor. It can take a significant amount of time to find its directory, but if successful, it might even work quite well.

If you are running win 7 version, do not mix up the bitness. If you mixed up the bitness, open the reset-oldwin-patch file and download the version with a different bitness.

If Discord does not work in your country, install Discord-* mod. After installing Discord-*, Tor should be running, and Discord will not work normally without it anymore until proper deinstallation of the mod.

![0](https://github.com/user-attachments/assets/aa520f99-cc6a-45f3-84d5-6da15b587225)
<img width="431" height="317" alt="0" src="https://github.com/user-attachments/assets/f22e0395-b851-4606-aebe-eb3b69788007" />

Then install the ZeroOmega extension ([Chrome](https://chromewebstore.google.com/detail/proxy-switchyomega-3-zero/pfnededegaaopdmhkdmcofjmoldfiped), [Firefox](https://addons.mozilla.org/en-US/firefox/addon/zeroomega/), [GitHub](https://github.com/zero-peak/ZeroOmega)). Pin it to your extensions bar. Before using ZeroOmega on Firefox, you need to grant it the "Run in private windows" permission. ZeroOmega is the best platform for mass deployment of browser proxy settings, so you can 5 star it in your store. It is possible to install an extension from a local file (ExtensionsLocal.zip). This is especially important if there are issues with the extension's availability in your store.

If you use Chrome-like browser (except Brave), please also install [WebRTC Control](https://chromewebstore.google.com/detail/webrtc-control/fjkmabmdepjfammlpliljpnbhleegehm). It will protect your IP against leakage [until identical functionality is added to ZeroOmega](https://github.com/zero-peak/ZeroOmega/issues/182).

It's time to sync your settings. Choose between three configs:

https://ipfs.io/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4/ZeroOmegaOptions-CN.bak  
https://ipfs.io/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4/ZeroOmegaOptions-EN.bak  
https://ipfs.io/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4/ZeroOmegaOptions-RU.bak

![1](https://github.com/user-attachments/assets/ba35f792-2e3a-4113-94da-f26a3e9fad26)

All three configs have three main modes: System, AUTO and VIRTUAL. In System there is no proxying, in AUTO only blocked sites are proxied, in VIRTUAL everything is proxied by Tor. The modes are switched by clicking the mouse button on the extension. Transparent circle - System, purple circle with a black center - AUTO, purple circle - VIRTUAL. VIRTUAL is used to speedcheck (e.g. speedtest.net) your Tor speed and protect your privacy. Change the mode to the one you need immediately after synchronization.

You are using quick switch to switch between modes, optionally you can disable it at any time by right-clicking on the extension and pressing Enable Quick Switch. Then you will have to select the modes manually in the menu that opens with the left mouse button on the icon. You can be creative by changing the theme of the extension and the colors of the modes. To restore everything as it was, re-sync.

![3](https://github.com/user-attachments/assets/c055ca4c-d531-4680-ba96-d3fe7bf1c64a)

ZeroOmega has a very advanced address parser. It can be used to refill domains in AUTO mode without leaving the extension, or any other things. To open it, right-click on the extension and click Network monitor.

![4](https://github.com/user-attachments/assets/a96c04ae-fa78-4c4a-815e-7aac65ffab2c)

Tor Portable itself has two modes: pro and default, which are switched via the change-mode file, replacing torrc.txt config. Switching to pro mode is necessary to partially compensate for the lack of hidden Tor exits, since sometimes sites impose restrictions on them, such as the inability to send images in Discord or some inaccessible music videos on YouTube, or inability to talk with Gemini. Pro mode is using only one exit. But the default mode uses completely random exits (so these restrictions are triggered randomly), and should survive much longer, while even having a pro mode won't help you avoid restrictions on some sites.

![5](https://github.com/user-attachments/assets/bc404d5e-f8eb-498d-a894-1aade051eedb)

If you want to try to completely avoid restrictions from sites like Grok.com, you should install [Psiphon TM](https://github.com/Chara-Freedom/Tor-Portable/releases/tag/v1.0), and change the setting of VIRTUAL mode from TOR to PROXY. But I'm not recommending this to everyone, since Psiphon TM is not that properly developed (at the time of writing), and is much slower than Tor. I should try to at least create the Linux version of it, but I use it on my Windows the way it is.

Updater is updater. It updates everything fast and seamlessly. I'm really proud that I made it. [It follows GRU specs](https://github.com/Chara-Freedom/GRU-current).

That's all for now. You can write anything to me [here](https://github.com/Chara-Freedom/Tor-Portable/issues/8). Good luck.
