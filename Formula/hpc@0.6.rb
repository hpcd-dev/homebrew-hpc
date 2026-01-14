class HpcAT06 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "b89c794948d25b0addf63ca24fbcd4dd3527565a7da94e121e64911692293b5e"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.6.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "739a2f3e46014ae535acd316fbce3a8b149c69954132d8e7cfa853b6221aaf81"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9eb7c41afdfa42f66645165c02e1b568c9f5b6e457ab2b7dce7da99c85e49347"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dd6b18bc5353ae207eed279fe689120bcd999fd078b76af9648a1525c0d3f8c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5cb3857378e95a5c8a21a300c06f3550cd6ef8402a78477ea94375db6c206850"
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
