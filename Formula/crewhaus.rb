class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.2.3"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.2.3/crewhaus-macos-arm64-0.2.3"
      sha256 "3dd13316429ed4572e0a21cf1c40786d388788bc47484e0e0e4818638368d1eb"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.2.3/crewhaus-macos-x64-0.2.3"
      sha256 "a95287aa039202c5b5e809134d2b269820afe3be6d87509a6b17481b1b0b5e4e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.2.3/crewhaus-linux-arm64-0.2.3"
      sha256 "f9c41762c3729d71abd29c500b009b4c0e5fab8ab392b6b7f781f834943645c1"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.2.3/crewhaus-linux-x64-0.2.3"
      sha256 "21df6e79626ac197341a0d528ed329cf07fb46f25f6f0ea9c04a29c454190444"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
