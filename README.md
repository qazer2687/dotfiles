<h1 align="left"><a href="https://fontmeme.com/pixel-fonts/"><img src="https://fontmeme.com/permalink/240129/1add7ef2bcaa28a4305401d08446746c.png" alt="pixel-fonts" border="0"></a></h1>

<p align="left">A repository containing my personal nix flake.</p>

## Hosts
┌── jade (16GB RAM, R9 3900x, RTX 2070S, GTX 1050) (kinda brokey rn)<br>
├── ruby (8GB RAM, I5 8350U)<br>
└── opal (8GB RAM, I7 7700) (completely brokey) <br>
## Structure
┌── flake.nix<br>
├── containers<br>
│   └── \<containers><br>
├── hardware<br>
│   ├── jade<br>
│   ├── opal<br>
│   └── ruby<br>
├── homes<br>
│   ├── jade<br>
│   └── ruby<br>
├── hosts<br>
│   ├── jade<br>
│   ├── opal<br>
│   ├── ruby<br>
│   └── shared<br>
├── modules<br>
│   ├── home<br>
│   └── nixos<br>
└── secrets<br>
