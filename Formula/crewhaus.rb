class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.2.2"
  license "Apache-2.0"

  on_macos do
    # An x86_64 Homebrew running under Rosetta 2 on Apple Silicon reports
    # Hardware::CPU.intel?, but the x64 binary then executes under Rosetta — which
    # emulates a pre-AVX (Westmere) CPU. Bun's macOS x64 runtime requires AVX2 and
    # there is no AVX-free macOS Bun build, so it warns ("CPU lacks AVX support")
    # and may crash. Serve the native arm64 binary on every Apple-Silicon host,
    # translated or not. Genuine Intel Macs (AVX2-capable) still get the x64 build.
    if Hardware::CPU.physical_cpu_arm64?
      url "https://github.com/crewhaus/factory/releases/download/v0.2.2/crewhaus-macos-arm64-0.2.2"
      sha256 "d0b4c9a662c23e2d52b15ea3694cd0896afacd60b48171b9694eada8cf560e83"
    else
      url "https://github.com/crewhaus/factory/releases/download/v0.2.2/crewhaus-macos-x64-0.2.2"
      sha256 "cb698f26f19c28358ea1e305ce09f8af1161a59d09556b95e4bece0b508a4b07"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.2.2/crewhaus-linux-arm64-0.2.2"
      sha256 "8ebbf80b8e64e629ef00870bec5cb7db4d0c2e497153fd7dd9f676b0a7d933f9"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.2.2/crewhaus-linux-x64-0.2.2"
      sha256 "1f6ed5f7fc18a407b5d81b98fcbce405e159825abd4b0ddc35aa98e2befee679"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
