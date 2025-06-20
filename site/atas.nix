{ lib, stdenvNoCC, texlive, pandoc, beamer-theme }:

stdenvNoCC.mkDerivation {
  name = "gelos-atas";
  src = ./src/_meetings;

  nativeBuildInputs = [
    pandoc
    (texlive.withPackages (_: [beamer-theme]))
  ];

  buildPhase = ''
    for src_markdown in *-ata.md; do
      { pandoc -t beamer --shift-heading-level-by=-1 -V theme=gelos -V themeoptions=dark $src_markdown -o ''${src_markdown%-ata.md}.pdf && echo "Built $src_markdown"; } &
    done
    wait
  '';
  installPhase = "mkdir -p $out && cp *.pdf $out/";

  meta.platforms = lib.platforms.linux;
}
