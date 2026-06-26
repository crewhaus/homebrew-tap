class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.1.6"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.1.6/crewhaus-macos-arm64-0.1.6"
      sha256 "651bfa04c6c7ba2be1ce51f7fe4a54b1ebfdaf70343330141bf622d4ff356a36"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.1.6/crewhaus-macos-x64-0.1.6"
      sha256 "03d9b3936250897e0b6c5a80998c1d5ff2d650b16c4d3cd4414bde05fa119456"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.6/crewhaus-linux-arm64-0.1.6"
      sha256 "eba992a797d7e8e83063a15aa5ae86b467261175dbf714fe44dd40776558faad"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.6/crewhaus-linux-x64-0.1.6"
      sha256 "ed8049c9edd97cef3bbd904bacce66aa715d4ac17eb9fdd96d379aa5fb73a131"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
