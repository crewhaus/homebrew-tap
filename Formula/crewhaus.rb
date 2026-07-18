class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.4.0/crewhaus-macos-arm64-0.4.0"
      sha256 "93f03008ac9d3f9f57ca02951e7935c6e227585a8a29f835710cc3ef5e822676"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.4.0/crewhaus-macos-x64-0.4.0"
      sha256 "f51e2bb77d18ac1bf4f8827a197f29d804e97fefed4c4aa5b54d81aaa9ac72e7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.4.0/crewhaus-linux-arm64-0.4.0"
      sha256 "e98c3968078d5a9164be1f0a0a0390198fee0014ed204765a6e323fb26010706"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.4.0/crewhaus-linux-x64-0.4.0"
      sha256 "13f7311f499f181e443bef1837c98af65e63c2ab2cc4088228230e2d454d696a"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
