{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "dwproton";
  version = "10.0-6";

  src = fetchzip {
    url = "https://dawn.wine/dawn-winery/dwproton/releases/dwproton-${finalAttrs.version}/dwproton-${finalAttrs.version}-x86_64.tar.xz";
    hash = "sha256-PX/X3f1NcHvj32t1JhtAP/HcfJkzQm+KN3oLtcYoOds=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    # Install directly to Steam compatibility tools directory
    mkdir -p $out
    ln -s $src/* $out/
    rm $out/compatibilitytool.vdf
    cp $src/compatibilitytool.vdf $out/

    runHook postInstall
  '';

  meta = with lib; {
    description = ''
      DW-Proton compatibility layer.

      (This is installed directly to ~/.local/share/Steam/compatibilitytools.d/)
    '';
    homepage = "https://dawn.wine/";
    license = licenses.unfree;
    platforms = ["x86_64-linux"];
    maintainers = [];
    sourceProvenance = [sourceTypes.binaryNativeCode];
  };
})
