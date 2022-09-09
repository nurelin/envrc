{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = [
          #pkgs.agda
          pkgs.haskellPackages.Agda
        ];
	shellHook = ''
	export ENVRC_LOAD_FUNCTION="(progn (add-to-list 'load-path (file-name-directory (shell-command-to-string \"agda-mode locate\"))) (require 'agda2) (advice-add 'agda2-restart :before 'envrc--update))"
	export ENVRC_UNLOAD_FUNCTION="(progn (if (featurep 'agda2-mode) (unload-feature 'agda2-mode)) (if (featurep 'agda2) (unload-feature 'agda2)) (setq load-path (delete (file-name-directory (shell-command-to-string \"agda-mode locate\")) load-path)))"
	'';
      };
    }
  );
}
