class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.5.3"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.5.3/crewhaus-macos-arm64-0.5.3"
      sha256 "3005745974005b85bfdcd0bf639f8134209cc4bb65c50e2c0c5f18fad876fbc3"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.5.3/crewhaus-macos-x64-0.5.3"
      sha256 "6051955c50982f13cfd2c458513b9ad833116ecfa95e1219aa6132f8b6691b68"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.3/crewhaus-linux-arm64-0.5.3"
      sha256 "9f3327538951c770f5598a2709da19135ec1cbd706d7281c0f1363ec2f3518db"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.5.3/crewhaus-linux-x64-0.5.3"
      sha256 "df946cc59c1474eb697aee0470cb8c2b9b27ad6b375b68fd232310b68531e287"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
