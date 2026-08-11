class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.5.2"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.5.2/crewhaus-macos-arm64-0.5.2"
      sha256 "1c68c32118ac61289d0cb266a4bbf437c4e8aa6551eaaf26c6538ad393d0f9a3"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.5.2/crewhaus-macos-x64-0.5.2"
      sha256 "755ba7a37cb26889f6fa60e4fbc41fe8cd3df18ad7ef71e5fa6fca2164910b64"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.2/crewhaus-linux-arm64-0.5.2"
      sha256 "b5bad8ca49a4f8957ef0ed0b2e73c6e2bcbd3b1487b753136b737aaa5ebee1c4"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.2/crewhaus-linux-x64-0.5.2"
      sha256 "57c4d23613327aa8cbabf8ca81998b4e156cefa908538294adb34eba11dde0c9"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
