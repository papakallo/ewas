# Inspired by : https://github.com/shourovrm/nixos-config/blob/main/guides/latex.md

# Initialise the per-user MiKTeX installation
# miktexsetup finish

# Enable automatic package download (the killer feature — no prompts)
# initexmf --set-config-value "[MPM]AutoInstall=1"

# TODO: check if the last line works, because it didn't work last time
# Temporary fix:
# miktex packages install PACKAGE_NAME

{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = {nixpkgs, ...} @ inputs: 
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in
    {
        devShells.${system}.default = pkgs.mkShell {
            packages = with pkgs; [
                miktex
            ];
        };
    };

}
