browser:
  qvm.present:
    - label: red
    - template: fedora-33
    - netvm: sys-whonix
    - features:
      - virt_mode: pv
      - qubes-core-agent-network-manager
      - qubes-core-agent-nautilus
      - qubes-core-agent-passwordless-root
      - qubes-core-agent-sysinfo
      - qubes-gpg-split
      - qubes-usb-proxy
      - qubes-update-check
      - qubes-update-notifier
      - qubes-vm-recommended
      - qubes-app-linux-pdf-converter
      - qubes-app-linux-pdf-viewer
      - qubes-app-linux-xinput
      - qubes-input-proxy-sender
      - qubes-input-proxy-receiver
      - qubes-menus
      - qubes-db
      - chromium
      - firefox-esr
