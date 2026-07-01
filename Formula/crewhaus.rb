class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.1.7"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.1.7/crewhaus-macos-arm64-0.1.7"
      sha256 "e4a70d64b18957450eadada6258588007d3346203887c73049431c578135dfc5"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.1.7/crewhaus-macos-x64-0.1.7"
      sha256 "64ce706208ed3a7f49585bc9a8f87fb4b17f0c5eba4e7599fba43d6b86833000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.7/crewhaus-linux-arm64-0.1.7"
      sha256 "c605add84719dc03955d12714c8f5da5e7b3b132d3348c04707d486278a9054f"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.7/crewhaus-linux-x64-0.1.7"
      sha256 "53794727bac1d46bcd717772782ef4d3bced3d41dd2bcca10175469908a8eb40"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
