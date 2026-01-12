class HpcAT06 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "b939fe5abcc2e787403df98322fa68f9615670414aacaa75b7fad17e6f2f0106"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7f500d6303676288d5d5b5eb9c6d61e9f7d054ea1f3bf73e8f2c13e970ae2aa2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3de18d413343917321c88b9a4ae499e181ecf6bd76a5e75cf0c04d41eeb060fe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "092bef4028df1cc6f75c179d5da151a7992cea52cc3c3df77d8a9558cac99a02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "335abf96ef3746393eeab3382f9248f908e984ff774850cba0ca54d32e818ee0"
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
