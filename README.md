# NixOS Configuration

Personal NixOS configuration for ThinkPad X1 Yoga 2nd Gen using flakes and modular architecture.

> [!WARNING]
> **Personal configuration - not meant for direct use.** Review and customize for your hardware before applying.

## System Specs

- **Model**: Lenovo ThinkPad X1 Yoga 2nd Gen
- **CPU**: Intel Core i5-7300U
- **RAM**: 8GB LPDDR3
- **Storage**: 512GB NVMe SSD
- **OS**: NixOS Unstable (25.11)

## Quick Overview

### Desktop
- **Primary**: KDE Plasma 6 (Wayland)
- **Alternatives**: Niri compositor, COSMIC DE (disabled by default)
- SDDM display manager with HiDPI support

### Key Features
- **Kernel**: CachyOS with sched_ext (scx_rustland)
- **Audio**: PipeWire with echo cancellation
- **Storage**: Btrfs with zstd compression + 75% zRAM
- **Input Methods**: Fcitx5 (Bengali, Japanese, Chinese, Korean)
- **Security**: Firewall enabled, fingerprint auth, TPM 2.0

### Development
Pre-configured: Rust, Python, C/C++, Java, Go, Node.js, .NET
Tools: direnv, Podman (Docker-compatible), git, LSPs

### Virtualization
QEMU/KVM, Podman containers, Waydroid (Android)

## Structure

```
├── .github/workflows/    # CI/CD checks
├── home/                 # Home Manager configs
├── hosts/                # System configuration
├── modules/              # Modular system components
├── overlays/             # Custom package overlays
├── pkgs/                 # Custom packages
├── services/             # User services
└── users/                # User definitions
```

## Installation

```bash
# Backup hardware-configuration.nix first!
git clone https://github.com/thshafi170/nixos-config /etc/nixos
cd /etc/nixos

# Customize for your system:
# - hosts/default.nix (hostname, timezone)
# - users/default.nix (username, groups)
# - modules/default.nix (enable/disable DEs)

sudo nixos-rebuild switch --flake .#X1-Yoga-2nd
```

## Quick Customization

**Switch Desktop**: Edit `modules/default.nix`
```nix
imports = [
  ./plasma6.nix    # Default
  # ./niri.nix     # Uncomment for Niri
  # ./cosmic.nix   # Uncomment for COSMIC
];
```

**Adjust Cleanup**: In `hosts/default.nix`
```nix
nix.gc.options = "--delete-older-than 14d";  # Change as needed
```

## Maintenance

```bash
# Update
nix flake update && sudo nixos-rebuild switch --flake .

# Clean old generations (automatic weekly, or manual)
sudo nix-collect-garbage --delete-older-than 7d

# Test changes without switching
sudo nixos-rebuild test --flake .
```

## Fish Shell Aliases

- `nix-switch` - Rebuild and switch
- `nix-upgrade` - Update and rebuild
- `nix-clean` - Deep clean with garbage collection
- `git-pull-all` - Pull all git repos recursively

## Binary Caches

- cache.nixos.org (official)
- nix-community.cachix.org
- Chaotic Nyx (CachyOS kernel)
- niri.cachix.org
- an-anime-team.cachix.org

## License

MIT - See [LICENSE](LICENSE)

## Acknowledgments

Chaotic Nyx • NixOS Community • OpenBangla • Niri Project

---

**Last Updated**: 19th October 2025
