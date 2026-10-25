class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.8.0"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.8.0/crewhaus-macos-arm64-0.8.0"
      sha256 "33c54379f032f76c3e7397377032890c16ef84203e4b84aab3059f3b7db9734c"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.8.0/crewhaus-macos-x64-0.8.0"
      sha256 "325778ecc10af27683e20209791f8943938da888d89745ab5367f64c42f02fa3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.8.0/crewhaus-linux-arm64-0.8.0"
      sha256 "995ec54c8b6b521652ad0dac36e30ae9d72b17e3f419efaed00eb31291d639b7"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.8.0/crewhaus-linux-x64-0.8.0"
      sha256 "a969ff0304a3afc20ea572688f73dcae3e6c7e43d7b9ac1224dae5e871ba8c0e"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
