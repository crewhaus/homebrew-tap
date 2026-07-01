class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.1.8"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.1.8/crewhaus-macos-arm64-0.1.8"
      sha256 "c182d99ba0903222cdcff2e2f7c44015463f181823ad07defccda5f4c73f80ce"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.1.8/crewhaus-macos-x64-0.1.8"
      sha256 "311189fb54beb69a6956e8cc9b9ada4dcbb18cd5d1731a69828d70b6d1127c80"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.8/crewhaus-linux-arm64-0.1.8"
      sha256 "362d8ce49458c664b9eda78769e88d4b6c0366a09cea6f79caf99134513935c6"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.8/crewhaus-linux-x64-0.1.8"
      sha256 "b1d3f1bb306e5b51c4b9cdb9cad795c3760afa719f472e1aabaeab322e93e2da"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
