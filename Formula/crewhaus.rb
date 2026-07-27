class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.4.2"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.4.2/crewhaus-macos-arm64-0.4.2"
      sha256 "bf16c9878b23d8f02c575a320b929788309cb0a3e66bb698387707774e31a0db"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.4.2/crewhaus-macos-x64-0.4.2"
      sha256 "8d1a44eb9b65c46f78fc04247e11e3b38350583017e109714f1bddc3ef1b11f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.4.2/crewhaus-linux-arm64-0.4.2"
      sha256 "8a6596b133f26e83140d772cc6c12e8f0d805681cce28cdf479e08607f7c235e"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.4.2/crewhaus-linux-x64-0.4.2"
      sha256 "0ae8799aff8be5881ebc0deb89fca9ef1c926fd9cf544ba6cd10259edc32d898"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
