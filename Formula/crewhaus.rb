class Crewhaus < Formula
  desc "Modular meta-harness — compile a single spec into multiple agent runtimes"
  homepage "https://github.com/crewhaus/factory"
  version "0.1.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.5/crewhaus-macos-arm64-0.1.5"
      sha256 "999d4d60608bf1ad00440dec8d2ddc533576979b1ce2e8374883efdde9653705"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.5/crewhaus-macos-x64-0.1.5"
      sha256 "5193ae5b389ff19377701044bd75234ec9fd5b8a86bb62e738e58e01bde0674b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.5/crewhaus-linux-arm64-0.1.5"
      sha256 "217f00362ac511b2b5a639977c00d1ee99fea941046829fe9d2610847935910e"
    end
    on_intel do
      url "https://github.com/crewhaus/factory/releases/download/v0.1.5/crewhaus-linux-x64-0.1.5"
      sha256 "93feeb45aa2b9000537099ba579b044b25d13001c69da83176c6ca36c53651df"
    end
  end

  def install
    bin.install Dir["*"].first => "crewhaus"
  end

  test do
    system "#{bin}/crewhaus", "--version"
  end
end
