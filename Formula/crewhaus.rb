class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.6.0/crewhaus-macos-arm64-0.6.0"
      sha256 "cdbc4ed114d7a736ddfcdd16b80c69eca0d6cf1eeb12f65468e7b6a0d41ef09e"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.6.0/crewhaus-macos-x64-0.6.0"
      sha256 "b86a091f7953243bd95c85788369b3bb3da4f9dfb84ea30f1869ae9d10163bbc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.6.0/crewhaus-linux-arm64-0.6.0"
      sha256 "001f2a679189e50a888357663df8d53a3502d85c5f2e8ae88c00f8951038f37c"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.6.0/crewhaus-linux-x64-0.6.0"
      sha256 "3ff6a544b6b011f566743191419fe56d0fea8fc990af8b00375b99a1a8aef0da"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
