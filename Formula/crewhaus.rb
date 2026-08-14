class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.5.5"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.5.5/crewhaus-macos-arm64-0.5.5"
      sha256 "0afb05386e5ea29e9ef0b525921164ace3bcb25407e9f6b9a9b406287b8d4b2f"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.5.5/crewhaus-macos-x64-0.5.5"
      sha256 "75785832e44cd6267183c1d1ba824b0430fad3e8335753177f881420289c9a20"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.5/crewhaus-linux-arm64-0.5.5"
      sha256 "18047bc5f50d02896d3de0ff6b5502a66b74ab53c5076c6b0f0373f15873feb4"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.5/crewhaus-linux-x64-0.5.5"
      sha256 "7d7caf241c3f2e4dc709595ca6ad657c6b77ccf64d44edb5fef0f491e03768d4"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
