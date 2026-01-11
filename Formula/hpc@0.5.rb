class HpcAT05 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "2515b37e9cc4e354014608d9d04442f3a210b48bcd42f31ec5574ae2604dcb4a"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d609f86f849fa08cd6ea70138cd8177110cb801a51858e579434034d531575aa"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5b15d663474596ad35f818c3bd0a0cff0c6d9271a7d76153644742d21ad12fed"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4f5832856cde4806262fbe8a117c053b069648ba9b8eeeb71b7f35c301d4573a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c65ea32f39cda8cb802d780a4043e85237f211c28b7348907ef4bb767f93d8f8"
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
