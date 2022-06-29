

# journoQUBES
Steps taken to harden Qubes (4.1.0) on a Librem 14 (750G-LUKS encrypted drives, 64G RAM). Despite the security of the Purism laptop, I took additional steps (hardware, software) to add enhanced security. This is a working list as I go through the intitialization of the OS, a running tab of work done to it for future reference and backup purposes; also, for future project on journalist digital security.

### best practices
- LUKS encrypt all harddrives in installation configuration
- too many levels of complexity leads to user error; eliminate attack surface, but make your security measures convenient and practical
- set the Qubes, Debian and Whonix package updates to Tor onion service repositories
- move files downloaded by Tor Browser from the ~/Downloads folder to another specially created one
- set power button to shutdown, don't leave computer unattended in public; store in hotel safes
- use Diceware passphrases
- download files securely using scurl
- files received or downloaded fromthe internet, via email, and PDFs, etc. should be opened in a DVM

### physical (& BIOS/firmware) hardening
- disabled Intel ME (Librem standard)
- Librem Key boot access (Librem standard)
- anti-evil-maid (not necessary with Librem)
- coreboot/pureboot firmware (Librem standard)
- physical hardware disconnect for microphone, wifi, bluetooth, webcam
- removed speakers
- removed beeper
- tamper-evident screws
- waxed external ports

### post-installation configurations
- disable previews of files from untrusted sources in File Manager
- swap networking (sys-net and sys-firewall) templates to customized Kicksure Templates (based on Debian 11 over tor, DVMs), making sure not to configure as a Standalone VM
- confirm Microcode Package Check (in dom0):
```dnf list | grep microcode```
- confirm AppArmor active (in Debian & Kicksure VMs):
```sudo aa-status```

- enable all available apparmor profiles in the Whonix-Workstation and Whonix-Gateway Templates.
- enable seccomp on Whonix-Gateway (sys-whonix, ProxyVM).
- 
- enable SysRq "Security Keys" functionality as insurance against system malfunctions
- enable secure Access Key ("Sak"; SysRq + k) procedure.

## enlarged dom0
```
sudo lvresize --size 50G /dev/mapper/qubes_dom0-root
sudo resize2fs /dev/mapper/qubes_dom0-root
```

## sys-net as usbvm (also can be created at initialization)
```
qubesctl top.enable qvm.sys-usb qvm.sys-net
qubesctl state.highstate
(qubesctl top.disable qvm.sys-net-as-usbvm pillar=True) if intention was to get separate sys-usb as it is by default
```

## qubes compartmentalization
I've compartmentalized my digital personal and work lives thusly:

## VPN Qube
- tk
- 
## add Windows Qube (https://github.com/elliotkillick/qvm-create-windows-qube/blob/master/README.md)
1. Download the [installation script](https://raw.githubusercontent.com/elliotkillick/qvm-create-windows-qube/master/install.sh) by opening the link, right-clicking and then selecting "Save [Page] as..."
2. Copy `install.sh` into Dom0 by running the following command in Dom0:
    - `qvm-run -p --filter-escape-chars --no-color-output <name_of_qube_script_is_located_on> "cat '/home/user/Downloads/install.sh'" > install.sh`
    - Make sure to get all the single and double quotes
3. Review the code of `install.sh` to ensure its integrity
    - Safer with escape character filtering enabled in the prior step; `qvm-run` disables it by default when the output is a file
4. Run `chmod +x install.sh && ./install.sh`
    - Note that this will install packages in the global default `TemplateVM`, which is `fedora-XX` by default
5. Review the code of the resulting `/usr/bin/qvm-create-windows-qube`

A more streamlined and secure installation process with packaging will be shipping with Qubes R4.1.

To update Qvm-Create-Windows-Qube, start by simply deleting the `windows-mgmt` VM and main program by running the following command in Dom0:

`qvm-remove -f windows-mgmt && sudo rm /usr/bin/qvm-create-windows-qube`

Lastly, follow the installation steps above to reinstall.

Note that this will also delete any Windows ISOs that have already been downloaded. This may be desirable in the case that Microsoft has updated the Windows ISOs (meaning you should redownload them anyway). However, if you would like to avoid downloading any of the Windows ISOs again, simply navigate to `/home/user/Documents/qvm-create-windows-qube/windows-media/isos` in the `windows-mgmt` VM and copy its contents to another (preferably disposable) qube. After the reinstall is complete, copy those ISOs back into `windows-mgmt` at the aforementioned directory.

The `download-windows.sh` script (located at `/home/user/Documents/qvm-create-windows-qube/windows-media/isos/download-windows.sh` in `windows-mgmt`) securely downloads the Windows ISO to be used by Qvm-Create-Windows-Qube from official Microsoft servers.

`windows-mgmt` is air gapped from the network. This means that in order to securely perform the download, one must copy the `download-windows.sh` script and `SHA256SUMS` file to another (disposable) qube followed by transferring the newly downloaded ISO(s) into `windows-mgmt` and placing them into the `/home/user/Documents/qvm-create-windows-qube/windows-media/isos` directory. Alternatively, `windows-mgmt` can temporarily be given network access, however, this isn't recommended for security reasons.

**Important:** Be sure to read the [Qubes Windows Tools Known Issues](https://github.com/elliotkillick/qvm-create-windows-qube#qubes-windows-tools-known-issues) section below for a couple small upstream issues in the case of Windows 10 and other newer OSs all of which have easy workarounds available.

*[Video demonstration](https://www.youtube.com/watch?v=cCi2MOUwS_Q)*

`qvm-create-windows-qube -n sys-firewall -oyp firefox,notepadplusplus,office365proplus -i win10x64.iso -a win10x64-pro.xml work-win10`

`qvm-create-windows-qube -n sys-firewall -oyp steam -i win10x64.iso -a win10x64-pro.xml game-console`

## add split browser personal "surfer" qube (https://github.com/rustybird/qubes-app-split-browser)
Create a new persistent VM or take an existing one, and configure it to launch the right DisposableVMs and (optionally, for safety against user error) to have no network access itself:

1. Create a new persistent VM or take an existing one, and configure it to launch the right DisposableVMs and (optionally, for safety against user error) to have no network access itself:

        qvm-create --label=purple surfer
        qvm-prefs surfer default_dispvm whonix-ws-XX-dvm
        qvm-prefs surfer netvm ''

   The DisposableVMs will know which persistent VM launched them, so don't name it "rumplestiltskin" if an exploited browser mustn't find out.

2. Install the `qubes-split-browser` package from [qubes-repo-contrib](https://www.qubes-os.org/doc/installing-contributed-packages/) in your persistent VM's TemplateVM (e.g. fedora-XX).

   _Or install manually:_ Copy `vm/` into your persistent VM or its TemplateVM (e.g. fedora-XX) and run `sudo make install-persist`; then install the `dmenu pwgen oathtool` packages in the TemplateVM.

3. Install the `qubes-split-browser-disp` package from qubes-repo-contrib in your persistent VM's default DisposableVM Template's TemplateVM (e.g. whonix-ws-XX).

   _Or install manually:_ Copy `vm/` into your persistent VM's default DisposableVM Template (e.g. whonix-ws-XX-dvm) or the latter's TemplateVM (e.g. whonix-ws-XX) and run `sudo make install-disp`; then install the `xdotool` package in the TemplateVM.

   Either way, also ensure that an extracted Tor Browser will be available in `~/.tb/tor-browser/` (e.g. by running the Tor Browser Downloader `update-torbrowser` in whonix-ws-XX).

4. You can enable the Split Browser application launcher shortcuts for your persistent VM as usual through the Applications tab in Qube Settings, or alternatively run `split-browser` in a terminal (with `-h` to see the help message).


Install the qubes-split-browser package from qubes-repo-contrib in your persistent VM's TemplateVM (e.g. fedora-XX).
 ensure that an extracted Tor Browser will be available in ~/.tb/tor-browser/ (e.g. by running the Tor Browser Downloader update-torbrowser in whonix-ws-XX). You can enable the Split Browser application launcher shortcuts for your persistent VM as usual through the Applications tab in Qube Settings, or alternatively run split-browser in a terminal (with -h to see the help message).


## TODO
- self-hosted deadman's swithc

If using Qubes-Whonix ™, assign the webcam to an untrusted VM (if needed)

Since the mobile devices security best practices for risk mitigation are often difficult / infeasible to adhere to, it might be easier to physically move all mobiles devices to a distant physical location such as a different room and close the door and/or to power off mobile devices.

In Qubes-Whonix ™, consider installing the tirdad kernel module to protect against TCP ISN-based CPU information leaks

Test the LAN's router/firewall with either an internet port scanning service or preferably a port scanning application from an external IP address. configure a de-militarized zone (perimeter network) Follow all other Whonix ™ recommendations to lock down the router.

For greater security, higher performance and a lower resource footprint, consider using an experimental MirageOS-based unikernel firewall that can run as a QubesOS ProxyVM. 

Configure each ServiceVM as a static DisposableVM to mitigate the threat from persistent malware accross VM reboots. [64]

Consider disabling the Control Port Filter Proxy to reduce the attack surface of both the Whonix-Gateway ™ and Whonix-Workstation ™.
Consider hardening systemcheck.

Use split-GPG for email to reduce the risk of key theft used for encryption / decryption and signing.
Create an App Qube that is exclusively used for email and change the VM's firewall settings to only allow network connections to the email server and nothing else ("Deny network access except...").
Only open untrusted email attachments in a DisposableVM to prevent possible infection.

For anonymous PGP-encrypted email over Tor, use Mozilla Thunderbird.

Consider running ArpON

corridor as a filtering gateway to ensure only connections to Tor relays pass through

Whonix-Workstation ™ Installation Steps

EXTERNAL_OPEN_PORTS+=" $(seq 17600 17659) "

On Whonix-Gateway ™. [7] [8]

Add onion-grater profile.

INSTALLONIONSHARE sudo onion-grater-add 40_onionshare M

If using Qubes-Whonix ™, complete these steps.
In Whonix-Workstation ™ App Qube. Make sure folder /usr/local/etc/whonix_firewall.d exists.

sudo mkdir -p /usr/local/etc/whonix_firewall.d
Qubes App Launcher (blue/grey "Q") → Whonix-Workstation ™ App Qube (commonly called anon-whonix) → Whonix ™ User Firewall Settings

If using a graphical Whonix-Workstation ™, complete these steps.

Start Menu → Applications → System → User Firewall Settings

Configuring (not an official instructions link) the experimental GUI domain; [8] [9] and/or
Setting up an AudioVM. [1

Check gpg is enabled in config files (gpgcheck=1) if new Fedora repositories are installed.

If utilizing a SSD, consider setting up a periodic job in dom0 to trim the disk since this aids against local forensics. [17] [18]

Consider creating separate, specialized minimal Templates for distinct App Qube clearnet activities (like browsing) to reduce the attack surface. [21] [22]

Consider replacing passwordless root access with a dom0 user prompt. [23

Consider split dm-crypt to isolate device-mapper based secondary storage encryption (not the root filesystem) and LUKS header processing to Disposables.

vm-boot-protect-root: suitable for service VMs like sys-usb and sys-net, as well as App Qubes such as untrusted, personal, banking, vault and so. [26]
vm-boot-protect: suitable for virtually any Debian or Fedora VM, such as Kicksecure ™ VMs, Standalone VMs and Disposable VMs.

```
