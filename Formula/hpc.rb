class Hpc < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "8e1f7490e6686fabd2572d1c9efd075234656d8d5dfde5ba585da2b763faa649"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.3.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b000db784896304bd1158d2b017c03464a0d3e89ae04d2ae78bc3547666398a6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d3992065148730485c0dc7b4e4c798dc3acf956b8374bb7bda494b7edba018c0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ace866452392b3d4bc0559642ef52acfd12d380f03e285e55b7bd395557f70e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "17e3df34b9c1be0569b9b23c7f0ab25cc105349e391a2ebb743d32ed0a8c99f8"
  end

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
