class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.5.8"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.5.8/crewhaus-macos-arm64-0.5.8"
      sha256 "b9072051fc208dd1c0727677f3b910bd16690ecf1b0b30d9ccbf2e86c10c0492"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.5.8/crewhaus-macos-x64-0.5.8"
      sha256 "d5c3b8dce9d55b72eb02d52d5421c64e24378ac8bc84de82ea0df60ba8060f08"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.8/crewhaus-linux-arm64-0.5.8"
      sha256 "ac0067491b63b3a441a817ef83b09bf398a8b976f6741e66aa029c635d11315a"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.8/crewhaus-linux-x64-0.5.8"
      sha256 "71aba497ef741526a8279f3978219f749047a03db18128712b8978ac2ed7cac3"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
