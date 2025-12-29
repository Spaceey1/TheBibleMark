{
	description = "TheBibleMark dev nix flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, utils }:
		utils.lib.eachDefaultSystem (system:
				let
				pkgs = import nixpkgs {
				system = system;
				config.allowUnfree = true; # Required if you use certain proprietary MS tools
				};

# Define the .NET SDK version
				dotnet-sdk = pkgs.dotnetCorePackages.sdk_10_0;

				in
				{
				devShells.default = pkgs.mkShell {
				buildInputs = [
				dotnet-sdk
				pkgs.dotnetPackages.Nuget # Optional: useful for manual nuget CLI tasks
				pkgs.omnisharp-roslyn      # Optional: C# Language Server for editors like Neovim/VS Code
				pkgs.netcoredbg            # Optional: Debugger for C#
				];

				shellHook = ''
					export DOTNET_ROOT=${dotnet-sdk}
				export PATH="$PATH:$HOME/.dotnet/tools"

					echo "--- .NET 10 Development Environment ---"
					dotnet --version
					'';
				};
				}
	);
}
