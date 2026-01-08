class HpcAT03 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "af9e8f888cbb58bf71aef9e635846e843fe203c6a7d0bf2285f8b1bbc430914e"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.3.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1842c9d957cb0ad6e96d6258eab2dae89c1b66ecc96a22b6acd375af46026625"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ea2a677040d60cf3b5d44d3917c8b36b7851a4ad9d00c6a3936a2c331de79aad"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "224e47a66d45c50eba33060422db6ee5d681f2dec8521e00d7b4a70318be0f3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b5ab1ddc143b191284fc3ca47466394243f732b7d6f51edfc322befb23b0beeb"
  end

  keg_only :versioned_formula

  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "protobuf" => :build
  depends_on "openssl@3" if OS.linux?
  depends_on "sqlite" if OS.linux?

  def install
    system "cargo", "install", *std_cargo_args(path: "cli")
    system "cargo", "install", *std_cargo_args(path: "hpcd")
  end

  service do
    run [opt_bin/"hpcd"]
    keep_alive true
    log_path var/"log/hpcd.log"
    error_log_path var/"log/hpcd.log"
  end

  test do
    system bin/"hpc", "--help"
    system bin/"hpcd", "--help"
  end
end
