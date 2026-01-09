class HpcAT04 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "6335094871c61ee83f9d5dee50caea7571566786f4dc0909915ed0df2437a878"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "509912f3ff5be4e2887fb873e6167b83829a4b672d40765ecb70bc81c662a06d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8fe6d71f2fc4bbcd927cabc2a1a5455f40674be19af7dd9289f0b58b2ec0a819"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3bf243d6f70eec8e219c943bccb5a4594eeb86cd1f12622e86faf0e0c6968cf7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6721cf7699b096583f6c997dd46f555c11ef78c6442efefeee3120ae90809fe5"
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
