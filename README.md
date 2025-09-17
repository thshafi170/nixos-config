# Severely screwed up thanks to the stupid hallucinating box. DO NOT USE!

# NixOS Configuration

Personal NixOS configuration for my ThinkPad X1 Yoga 2nd Gen using flakes and modular architecture.

> [!WARNING]
> **This is a personal configuration repository.** Do not use these configs as-is. They are tailored specifically for my hardware and workflow. Before proceeding with this config, please check all the files and modify all the necessary syntaxes according to your needs.

## System Info

- **Model**: Lenovo ThinkPad X1 Yoga 2nd Gen (20JES0YA00)
- **CPU**: Intel® Core™ i5-7300U
- **RAM**: 8GB SK Hynix LPDDR3 (Soldered)
- **SSD**: Toshiba KXG60ZNV512G NVMe
- **NixOS Channel**: Unstable (25.11 as of 16 Aug 25), with some extra channels. Check `flake.nix` file for input channels.

## Structure


```
※ Not all files are shown here

├── home/                    # Home Manager configurations
|   ├── fish.nix            # Fish configuration, user-wide
|   └── home-manager.nix    # Home Manager configurations
├── hosts/                   # Host-specific configurations
|   └── default.nix         # Main NixOS configurations
├── modules/                 # System modules
│   ├── audio.nix           # Audio (PipeWire)
│   ├── boot.nix            # Boot loader and Plymouth configurations
│   ├── cosmic.nix          # COSMIC desktop
│   ├── drivers.nix         # Hardware drivers
|   ├── kernel.nix          # Kernel configurations
│   ├── networking.nix      # Network configurations
│   ├── niri.nix            # Niri compositor
│   ├── plasma6.nix         # KDE Plasma 6
│   ├── power.nix           # Power management
|   ├── programs.nix        # Essential programs
|   ├── system-devenv.nix   # Integrated Development Environment
│   ├── virtualisation.nix  # Docker & VMs
│   └── ...
├── packages/                # Custom packages
├── services/                # Autostart programs, mainly for Niri
├── users/                   # User configurations
├── configuration.nix        # Main system config
├── flake.nix                # Flake definition
└── overlays.nix             # Package overlays

```

## Default Features

- **Kernel**: Uses CachyOS kernel from [Chaotic Nyx](https://www.nyx.chaotic.cx) with 'rusty' sched_ext schedulers profile.
- **Desktop**: Has configurations for COSMIC, KDE Plasma 6, Niri (Wayland TWM). Uses Niri by default.
- **Audio**: PipeWire with ALSA compatibility.
- **Development**: Integrate Development Environment for Python, Rust, C/++ and Java. Nix-ld enabled with nix-alien to run unpatched binaries.
- **Virtualization**: Uses QEMU/KVM, KVM is enabled by default. Waydroid for Android emulation.
- **Shell**: Uses Fish with Starship by default for user accounts, while ZSH system-wide.
- **Hardware**: Optimized for ThinkPad X1 Yoga 2nd Gen.

## Usage

```bash
# IMPORTANT: Backup your hardware-configuration.nix elsewhere, before cloning the repo and moving it inside hosts folder
# Clone and customize for your hardware
git clone https://github.com/thshafi170/nixos-config /etc/nixos
cd /etc/nixos

# Build and switch
sudo nixos-rebuild switch --flake .
```

## License

MIT License

---

**Always backup your configuration before making changes.**
