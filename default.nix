{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "proton-cachyos";
  version = "10.0-20251023-slr";

  src = fetchzip {
    url = "https://github.com/CachyOS/proton-cachyos/releases/download/cachyos-${finalAttrs.version}/proton-cachyos-${finalAttrs.version}-x86_64_v3.tar.xz";
    hash = "sha256-HVNR/F+qi75zxXx2BH6JWZAcHxbuDUFc6oN8VvLju2A=";
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
      CachyOS Proton compatibility layer.

      (This is installed directly to ~/.local/share/Steam/compatibilitytools.d/)
    '';
    homepage = "https://cachyos.org/";
    license = licenses.unfree;
    platforms = ["x86_64-linux"];
    maintainers = [];
    sourceProvenance = [sourceTypes.binaryNativeCode];
  };
})

