class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.5.1"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.5.1/crewhaus-macos-arm64-0.5.1"
      sha256 "ed7671eae912a9b4a4c8c0e078565c63464b4973f6165be1de52c5ed54f92b51"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.5.1/crewhaus-macos-x64-0.5.1"
      sha256 "6e80857ede36f2132565eef40e6f761b87535606ae26780c81272f916c6fb5d7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.1/crewhaus-linux-arm64-0.5.1"
      sha256 "791a75712245e80ca4e0edfa0c4a20dc6423ae1d1188baf922e4feb1ee8f0710"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.1/crewhaus-linux-x64-0.5.1"
      sha256 "6460a20ecb17748f4754d2810495889ad0d0665d26e3f6d330e148f3533ecac8"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
