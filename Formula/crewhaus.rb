class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.4.1"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.4.1/crewhaus-macos-arm64-0.4.1"
      sha256 "e18084ee52033ebae7d58d44e953ebb3911be8a270375fa99735f5323de6e1a9"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.4.1/crewhaus-macos-x64-0.4.1"
      sha256 "752588097c7cbf2714974a9addd6797aec6b99616cd37567d6c03f6211455296"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.4.1/crewhaus-linux-arm64-0.4.1"
      sha256 "f7d00423fd4f69257de9fa23c88fa8b299066cb7937717cba1cb37f1ba47dc3a"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.4.1/crewhaus-linux-x64-0.4.1"
      sha256 "601ba0e23b12f241dcdfdb30c6d4d04cba073a2aa1dfd0154ef72438e699e555"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
