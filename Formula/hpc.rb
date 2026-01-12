class Hpc < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "6fb8c1801317a2772d5c0dce618cb26936b6a6a8a1c3d64d488cce6d84dc9970"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.6.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6d96f77277f0971e053f293223a0a3a0fa4853c2a1e7ca0bbabfce054c0ecb69"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "898629ea784d20f7f3de3e4d83fd972427e64c7c55075ac684c59f0dfce83542"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "02e70107fa210e48e0c75a993dd8f44b3192f7acc167155256d50c84063c3bec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "70e60ce1385a9afaec496d95a435803a2a8e9e4d652aae7176a1556876ece705"
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
