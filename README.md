> [!WARNING]  
> I (accidentally) used links to images from a repo I deleted so I'm using this super boring readme for a while till I can make another.

<p align="center">
  <h3 align="center" >Dotfiles V7</h3>
</p>

<div align="center">
  
![GitHub Repo stars](https://img.shields.io/github/stars/qazer2687/dotfiles?style=flat)
![GitHub repo size](https://img.shields.io/github/repo-size/qazer2687/dotfiles)
![GitHub commit activity](https://img.shields.io/github/commit-activity/t/qazer2687/dotfiles)

</div>


<h3>Hosts</h3>

| Name         | Description                                                                                       |  Type   |     Arch      |
| :----------- | :------------------------------------------------------------------------------------------------ | :-----: | :-----------: |
| `jade`       | My desktop PC.                                                                                    | Desktop | x86_64-linux  |
| `ruby`       | My Thinkpad T480. No longer used.                                                                 | Laptop  | x86_64-linux  |
| `onyx`       | The MacOS install on my Macbook. No longer used.                                                  | Laptop  | aarch64-darwin  |
| `jet`        | The Asahi install on my Macbook.                                                                  | Laptop  | aarch64-linux  |
| `opal`       | My homeserver.                                                                                    | Server  | x86_64-linux  |
| `quartz`     | RPI4B server configuration. Not yet included.                                                     | Server  | aarch64-linux |

<h3>Structure</h3>

<div style="text-align: right;">
  <div style="display: inline-block; text-align: left;">
    <pre>
      dotfiles/
      ├── containers/ (extra modules for opal)
      ├── flake.lock
      ├── flake.nix
      ├── hardware/ (hardware configurations for each host)
      │   ├── jade/ 
      │   ├── opal/
      │   └── ruby/
      ├── homes/ (home-manager configurations for each host)
      │   ├── jade/
      │   └── ruby/
      ├── hosts/ (nixos configurations for each host)
      │   ├── jade/
      │   ├── opal/
      │   ├── ruby/
      │   └── shared/ (shared configuration for jade and ruby)
      ├── LICENSE
      ├── modules/ 
      │   ├── home/ (home-manager modules)
      │   └── nixos/ (nixos modules)
      ├── README.md
      ├── secrets/
      └── shell.nix
    </pre>
  </div>
</div>

<h3>Credits</h3>
<div align="center">

![Fufexan](https://github.com/fufexan)\
For having the patience to explain how Nix works to me, making them the reason I use it today.\
![NobbZ](https://github.com/NobbZ)\
For solving the overwhelming majority of Nix issues I've had along the way. I've also taken inspiration from their dotfiles for my flake structure.\
![Gerg-L](https://github.com/Gerg-L)\
For, likewise, helping with many of my Nix issues. He's also bald.

Others who have been super helpful or inspired things:\
![Misterio77](https://github.com/Misterio77) - ![NotAShelf](https://github.com/NotAShelf) - ![Sioodmy](https://github.com/sioodmy) - ![Éclairvoyant](https://github.com/eclairevoyant/)

</div>
