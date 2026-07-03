class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.2.0/crewhaus-macos-arm64-0.2.0"
      sha256 "97a42f1df04c20a948b614dacf9221f985032bdb272a83966a86d791b208253e"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.2.0/crewhaus-macos-x64-0.2.0"
      sha256 "19de372fc3a62d6cf90f5266abf545c6844bafceeff614e446d042d84620dfcd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.2.0/crewhaus-linux-arm64-0.2.0"
      sha256 "9b19fcdb9c6466adce0e84cb2ba355e01b70bb7e6da6a5730c9df96b67a0f1ec"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.2.0/crewhaus-linux-x64-0.2.0"
      sha256 "cc36be582929b5e3e3eafe2449df0644d3d828769c97bd7492a6d69c3df440f9"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
