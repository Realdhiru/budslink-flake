# budslink-flake

Nix flake packaging [BudsLink](https://github.com/maniacx/BudsLink) for NixOS and Linux.

BudsLink provides battery status monitoring and feature control (ANC, Ambient Sound / Transparency, Normal modes, and touch gestures) for Bluetooth earbuds on Linux over BlueZ sockets.

---

## Quick Start

```sh
# Run directly without installing
nix run github:Realdhiru/budslink-flake
```

---

## Installation on NixOS

Add `budslink-flake` to your flake inputs:

```nix
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  budslink = {
    url = "github:Realdhiru/budslink-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

Import the overlay and install the package:

```nix
# In your NixOS configuration or overlays:
nixpkgs.overlays = [
  inputs.budslink.overlays.default
];

environment.systemPackages = [
  pkgs.budslink
];
```

Or use the provided NixOS module:

```nix
imports = [ inputs.budslink.nixosModules.default ];
```

---

## Supported Devices

Supports popular Bluetooth wearable devices including:
- OnePlus & Oppo Buds (via HeyMelody BLE protocol)
- Sony (WH-1000XM / WF-1000XM series)
- Samsung Galaxy Buds
- Apple AirPods / Beats
- Nothing & CMF Ear
- Bose QuietComfort
- Xiaomi & Redmi Buds
- Sennheiser Momentum / Accentum
- Soundcore Liberty
- Cambridge Audio Melomania

---

## License

GPL-3.0-or-later
