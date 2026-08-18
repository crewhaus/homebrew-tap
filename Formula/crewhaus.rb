class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.5.7"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.5.7/crewhaus-macos-arm64-0.5.7"
      sha256 "57f539c8fc9e77927b5756564b5408fef7202a271cb163a189e8c1ce079d661d"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.5.7/crewhaus-macos-x64-0.5.7"
      sha256 "edf216c20714cc5f5e67404d3c096130fe2646159359c10498da1f1fb89fa7eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.7/crewhaus-linux-arm64-0.5.7"
      sha256 "ad518eb1a0fcf64e30f42ad1487c8a165b8b088cae52fd4a991df57bf120bac3"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.7/crewhaus-linux-x64-0.5.7"
      sha256 "2b9800adf8c09e199133d629936a197fdd85ef6684b77011b8550015c87fdea0"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
