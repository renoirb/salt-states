laner:
  group:
    - present
    - gid: 1001
  user:
    - present
    - home: /home/laner
    - shell: /bin/bash
    - uid: 1001
    - gid: 1001
    - groups:
      - ops
      - deployment
    - require:
      - group: laner
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQD6lKom1wW/TQzxv2t8xOezDhR/imfMKge35SiHDnau/L+Dtl6HF2rArzs1cx3lMHJEmH6Weykxo8/fbtzXsF0lYa9iu97DcMCAYHNbmqnTjgZypNXV0AU/9JZzsBY3kSNL87byddb7Pz8JVXHmChoPfP1dc6v+nzGxsE7o/dVGI25zQo99Vtt1Io4dN8lBQs81NtYKPWYDZRX/H/rN8qaCdzLng6/JpIczQBV+Jzj74v1I3XgynAu2tGmQCwbN9J1fNGUp1Fe9x6/mw2lh0mPJSwMRYfp81SjLA0doxOMRzD1qxUraRvI0x+qZW+5wkqCe7z0AqcfHmZ1/wHMa2iLr:
  ssh_auth:
    - present
    - user: laner
    - enc: ssh-rsa
    - comment: laner@Free-Public-Wifi.local
    - require:
      - user: laner

shepazu:
  group:
    - present
    - gid: 1002
  user:
    - present
    - home: /home/shepazu
    - shell: /bin/bash
    - uid: 1002
    - gid: 1002
    - groups:
      - ops
      - deployment
    - require:
      - group: shepazu
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAABIwAAAQEAs9jNBiTGPRAwaJV+XDlPU2AI+B8Z0JXVXFVKDorgdBdGHJdedVVqT3lBIoATNhOCKGZX4xNWcO1NVK7demguHBem7uDfPFASBER6ZKF7EauXf9axMM/nk5x6vgZtejFjeZbwrpxFIkiESlvDdwXNbKI7rT5vYybrhY3YCLCwRo9HLSLdANH5P4XvVcMenyEFG6HXEf9n7jqXOJoPgPetW26sJlBp0tRXvpPgpiLuE/lLJzMxKI8t0+87JOYyb0ARHD8dCQRpBSkR3KsyLhivlMI1ZAXQ5ctwZnuyytjYDDaxDo9t0JSpq6XwsxcNQBZhnHam1BkkuKM2tzYKr+WIyw==:
  ssh_auth:
    - absent
    - user: shepazu
    - enc: ssh-rsa
    - require:
      - user: shepazu

AAAAB3NzaC1yc2EAAAADAQABAAABAQDhull02mfjHWnCJjzBcDH25odEYue0a6bkKM1woyFWvl8KdUSzlLbhD3/8itxXcDC185e+rKBgIza1lMgB0dMhc+dv5Ph0OshX4QaYeQHSWsa4dwIdZP41NoHTppFcPJNLg/CreJC0no/TQmXQ/i6P3Ne7QQYJh/YKu9kM1UB0+LuNhnB9UDslDIZyEGKynqeVqdLgu7rRCqcBG/ldY439nwDI4QKxGw10qafKYyN196volv5BD5K6GAvHRv5FGf+yWDJ2vWsZWqvXraoZP/gEaWawVC5ddp4eg/o+bx91mIkHJTy4uGquCy/vTE3ZZAf1XX6ZZovpNaoCh17TtU63:
  ssh_auth:
    - present
    - user: shepazu
    - enc: ssh-rsa
    - comment: shepazu@unknown109adde84c2e
    - require:
      - user: shepazu
