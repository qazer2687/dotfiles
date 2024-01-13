<a href="https://fontmeme.com/pixel-fonts/"><img src="https://fontmeme.com/permalink/240113/d5be52a36bcc6ace6ddb4f8a88a6b3b8.png" alt="pixel-fonts" border="0"></a> <img src="https://media.tenor.com/U2g82NbluxoAAAAi/cirno-dancing.gif" width="40" height="40" /> 
![](https://github.com/alexvasilkovski/dotfiles/assets/114782572/cc80857e-69bb-414a-8a29-818982f0bb58)

This is my personal [Nix flake](https://nixos.wiki/wiki/Flakes) for my different machines.

<a href="https://fontmeme.com/pixel-fonts/"><img src="https://fontmeme.com/permalink/240113/ba05965c57c8a356ec9bad6a67a7ca0e.png" alt="pixel-fonts" border="0"></a>
![](https://github.com/alexvasilkovski/dotfiles/assets/114782572/cc80857e-69bb-414a-8a29-818982f0bb58)

- 🖥️ `jade`
- 💻 `ruby`

<a href="https://fontmeme.com/pixel-fonts/"><img src="https://fontmeme.com/permalink/240113/2d15e08a26a1493780091ace7bccb15e.png" alt="pixel-fonts" border="0"></a>
![](https://github.com/alexvasilkovski/dotfiles/assets/114782572/cc80857e-69bb-414a-8a29-818982f0bb58)

```
┌── flake.nix
├── flake.lock
├── hardware
├── nixos
│   ├── configurations
│   │   ├── <hosts>
│   │   └── shared
│   └── modules
├── .sops.yaml
└── secrets
```

<a href="https://fontmeme.com/pixel-fonts/"><img src="https://fontmeme.com/permalink/240113/bfbc555e1465f742743aef1494a3fc6b.png" alt="pixel-fonts" border="0"></a>
![](https://github.com/alexvasilkovski/dotfiles/assets/114782572/cc80857e-69bb-414a-8a29-818982f0bb58)

To install a specific NixOS system configuration from this repository, you can use the following command:

```bash
sudo nixos-rebuild switch --flake github:alexvasilkovski/dotfiles#<output>
```

Replace `<output>` with the desired system configuration you want to use from the flake.
