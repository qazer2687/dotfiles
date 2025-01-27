{
	cage,
	stdenv,
	esbuild,
	dart-sass,
	which,
	inputs,
	accountsservice,
	writeShellScript,
	fd,
	system
}:
let
	name = "jbar";

	ags = inputs.ags.packages.${system}.default.override {
		extraPackages = [accountsservice];
	};

	dependencies = [
		which
		dart-sass
		fd
	];

	addBins = list:
		builtins.concatStringsSep ":" (builtins.map (p: "${p}/bin") list);

	desktop = writeShellScript name ''
		export PATH=$PATH:${addBins dependencies};
		${ags}/bin/ags -b ${name} -c ${config}/config.js $@
	'';

	greeter = writeShellScript "greeter" ''
		export PATH=$PATH:${addBins dependencies}
		${cage}/bin/cage -ds -m last ${ags}/bin/ags -- -c ${config}/greeter.js
	'';

	config = stdenv.mkDerivation {
		inherit name;
		src = ./.;

		buildInputs = [which];
		
		configurePhase = ''
			${ags}/bin/ags --init --config ./main.js
			rm main.js
		'';

		buildPhase = ''
			${esbuild}/bin/esbuild \
				--bundle ./desktop/main.ts \
				--outfile=config.js \
				--format=esm \
				--external:resource://\* \
				--external:gi://\* \

			${esbuild}/bin/esbuild \
				--bundle ./greeter/greeter.ts \
				--outfile=greeter.js \
				--format=esm \
				--external:resource://\* \
				--external:gi://\* \
		'';

    installPhase = ''
      mkdir -p $out
			cp -r ./* $out
      # cp -r assets $out
      # cp -r style $out
      # cp -r greeter $out
      # cp -r widget $out
      # cp -f main.js $out/config.js
      # cp -f greeter.js $out/greeter.js
    '';
	};
in
	stdenv.mkDerivation {
		inherit name;
		src = config;
		installPhase = ''
			mkdir -p $out/bin
			cp -r . $out
			cp ${desktop} $out/bin/${name}
			cp ${greeter} $out/bin/greeter
		'';
	}
