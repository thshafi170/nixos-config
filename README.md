# NixOS Configuration

Personal NixOS configuration for my ThinkPad X1 Yoga 2nd Gen using flakes and modular architecture.

> [!WARNING]
> **This is a personal configuration repository.** Do not use these configs as-is. They are tailored specifically for my hardware and workflow. Before proceeding with this config, please check all the files and modify all the necessary syntaxes according to your needs.

## System Info

- **Model**: Lenovo ThinkPad X1 Yoga 2nd Gen (20JES0YA00)
- **CPU**: Intel® Core™ i5-7300U
- **RAM**: 8GB SK Hynix LPDDR3 (Soldered)
- **SSD**: Toshiba KXG60ZNV512G NVMe
- **NixOS Channel**: Unstable (25.11), with additional channels for staging packages and bleeding-edge features

## Structure

```
├── .github/
│   └── workflows/
│       └── flake-check.yml   # CI/CD validation
├── home/                      # Home Manager configurations
│   ├── fish.nix              # Fish shell configuration
│   └── home-manager.nix      # Home Manager settings
├── hosts/                     # Host-specific configurations
│   ├── default.nix           # Main system configuration
│   └── hardware-configuration.nix  # Hardware-specific settings
├── modules/                   # System modules
│   ├── audio.nix             # PipeWire audio with echo cancellation
│   ├── boot.nix              # Systemd-boot and Plymouth
│   ├── cosmic.nix            # COSMIC desktop environment
│   ├── drivers.nix           # Hardware drivers & graphics acceleration
│   ├── fcitx5-im.nix         # Input methods (Fcitx5 with OpenBangla)
│   ├── kernel.nix            # CachyOS kernel & sched_ext
│   ├── networking.nix        # NetworkManager & firewall
│   ├── niri.nix              # Niri compositor configuration
│   ├── nix-ld.nix            # Dynamic linking compatibility
│   ├── openbangla-keyboard.nix  # Custom OpenBangla module
│   ├── plasma6.nix           # KDE Plasma 6 (default DE)
│   ├── programs.nix          # User applications & packages
│   ├── services.nix          # System services
│   ├── shell-sudo.nix        # Shell configuration & sudo rules
│   ├── system-devenv.nix     # Development environment
│   └── virtualisation.nix    # QEMU/KVM, Podman, Waydroid
├── overlays/                  # Custom package overlays
│   └── openbangla-keyboard.nix  # OpenBangla keyboard overlay
├── pkgs/                      # Custom package definitions
│   └── openbangla-keyboard/  # Custom OpenBangla build
├── services/                  # User services
│   ├── niri-session.nix      # Niri session services
│   └── power-wm.nix          # Power management for WMs
├── users/                     # User account definitions
│   └── default.nix
├── flake.nix                  # Flake configuration
├── flake.lock                 # Flake lock file
├── LICENSE                    # MIT License
└── README.md                  # This file
```

## Features

### Desktop Environment
- **Primary**: KDE Plasma 6 with Wayland
- **Alternative**: Niri (scrollable tiling compositor) and COSMIC DE configurations available
- **Display Manager**: SDDM with HiDPI support

### System Optimizations
- **Kernel**: CachyOS kernel from Chaotic Nyx with sched_ext (scx_rustland scheduler)
- **Audio**: PipeWire with ALSA/JACK/PulseAudio compatibility and echo cancellation
- **Storage**: Btrfs with zstd compression, automatic scrubbing, and optimized mount options
- **Swap**: 75% zRAM compression for improved performance
- **Nix Store**: Automatic garbage collection (14-day retention) and store optimization
- **Build Caching**: Enabled with `keep-outputs` and `keep-derivations` for faster rebuilds
- **Firewall**: Enabled with DNS/DHCP ports open

### Hardware Support
- **Graphics**: Intel HD 620 with hardware acceleration (VA-API, Vulkan)
- **Fingerprint**: 06cb:009a sensor support with auto-restart on resume
- **Bluetooth**: Auto-power on boot
- **Sensors**: IIO sensor proxy for screen rotation
- **Tablet**: OpenTabletDriver support

### Input Methods
- **Primary**: Fcitx5 with Wayland support
- **Languages**: Bengali (OpenBangla), Japanese (Anthy, Mozc, SKK), Chinese, Korean
- **Custom**: Custom-built OpenBangla keyboard from develop branch

### Development Environment
Pre-configured for multiple languages:
- **Rust**: Complete toolchain via Fenix with rust-analyzer
- **Python**: 3.12 with LSP, formatters, and common libraries
- **C/C++**: GCC, Clang with language servers
- **Java**: JDK with language server
- **Go**: Latest stable
- **JavaScript/Node.js**: Node.js 22 with pnpm
- **.NET**: SDK with Mono
- **Nix**: nixd, nixfmt for Nix development

Additional tools: direnv, Docker-compatible Podman, git with GitHub CLI

### Virtualization
- **QEMU/KVM**: Full virtualization with virt-manager, OVMF, TPM support
- **Containers**: Podman with Docker compatibility, IPv6 support
- **Android**: Waydroid for Android app emulation
- **Container Management**: Distrobox and BoxBuddy

### Shell Configuration
- **User Shell**: Fish with custom functions and aliases
- **System Shell**: Zsh with Oh My Zsh
- **Prompt**: Starship with Git integration
- **Tools**: bat, eza, fzf, ripgrep, fd

### Security
- **TPM 2.0**: Enabled
- **U2F**: Enabled for hardware keys
- **Fingerprint**: PAM authentication for sudo and KDE
- **Firewall**: Enabled with minimal open ports

## Installation

```bash
# IMPORTANT: Backup your hardware-configuration.nix before proceeding!
# This file contains machine-specific information that should not be overwritten

# Clone the repository
git clone https://github.com/thshafi170/nixos-config /etc/nixos
cd /etc/nixos

# Restore your backed-up hardware-configuration.nix
# cp /path/to/backup/hardware-configuration.nix hosts/hardware-configuration.nix

# Review and customize for your system
# - Edit hosts/default.nix for hostname, timezone, locale
# - Modify users/default.nix for your username and groups
# - Adjust modules/default.nix to enable/disable desktop environments

# Build and switch
sudo nixos-rebuild switch --flake .#X1-Yoga-2nd
```

## Customization

### Switching Desktop Environments

Edit `modules/default.nix` to enable your preferred DE:

```nix
imports = [
  # ... other modules
  ./plasma6.nix    # KDE Plasma 6 (default)
  # ./niri.nix     # Uncomment for Niri
  # ./cosmic.nix   # Uncomment for COSMIC
];
```

### Adjusting Garbage Collection

In `hosts/default.nix`, modify the retention period:

```nix
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 14d";  # Change to 7d, 30d, etc.
};
```

### Firewall Configuration

In `modules/networking.nix`, add ports as needed:

```nix
networking.firewall = {
  enable = true;
  allowedTCPPorts = [ /* your ports */ ];
  allowedUDPPorts = [ 53 67 ];  # DNS, DHCP
};
```

## Binary Caches

This configuration uses multiple binary caches for faster builds:
- **cache.nixos.org**: Official NixOS cache
- **nix-community.cachix.org**: Community packages
- **an-anime-team.cachix.org**: Anime game tools
- **niri.cachix.org**: Niri compositor
- **Chaotic Nyx**: CachyOS kernel and optimized packages

## Maintenance

### Update System
```bash
# Update flake inputs
nix flake update

# Rebuild with new inputs
sudo nixos-rebuild switch --flake .
```

### Clean Old Generations
```bash
# Automatic (runs weekly via systemd timer)
# Manual cleanup if needed:
sudo nix-collect-garbage --delete-older-than 7d
sudo nixos-rebuild boot  # Cleanup bootloader entries
```

### Check Configuration
```bash
# Validate flake
nix flake check

# Test changes without switching
sudo nixos-rebuild test --flake .
```

## Useful Aliases

Defined in `home/fish.nix`:
- `nix-switch`: Rebuild and switch system
- `nix-upgrade`: Update and rebuild system
- `nix-clean`: Deep clean with garbage collection
- `git-pull-all`: Pull all git repos in subdirectories

## Contributing

While this is a personal configuration, feel free to:
- Open issues for questions about specific configurations
- Submit PRs for bug fixes
- Use parts of this config as reference for your own setup

## License

MIT License - See [LICENSE](LICENSE) file for details.

## Acknowledgments

- **Chaotic Nyx**: For CachyOS kernel and optimized packages
- **NixOS Community**: For extensive documentation and support
- **OpenBangla Project**: For Bengali input method
- **Niri**: For the innovative scrollable tiling compositor

---

**Last Updated**: October 2025 | **NixOS Version**: 25.11 (Unstable)

**Always backup your configuration before making changes.**
