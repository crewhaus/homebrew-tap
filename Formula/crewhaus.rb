class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.5.0"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.5.0/crewhaus-macos-arm64-0.5.0"
      sha256 "63ec45dee5f20722df20238015692e7af2daac20725cbeac3d9c7d98a8290de7"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.5.0/crewhaus-macos-x64-0.5.0"
      sha256 "2d89621b18850ab278f23b76dfb81e3a1f26ce39b55a812f18b851509561a24a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.0/crewhaus-linux-arm64-0.5.0"
      sha256 "7f1af48d3d63caa52a8531ef11c7253d3976a9d26f84c7acaa4457c3d1f945fe"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.0/crewhaus-linux-x64-0.5.0"
      sha256 "8dfbae2bf004af4a401226a505eff1869370047ce40989563c204f90112d1286"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
