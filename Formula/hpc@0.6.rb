class HpcAT06 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "6fb8c1801317a2772d5c0dce618cb26936b6a6a8a1c3d64d488cce6d84dc9970"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.6.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d2af8e430881e752ecb93fe9d97d935dbf84451a100b75f95e65bfcccb428631"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8c2b722ee362b861a80612fc99ca6a5bc6d1afb72b7763aab736123ad4b3409e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "61817dbb1625196669d6c9a677bb508392244a78db7e783bbec1307bea904bf4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3b647c6a1cdf2b2ef7687d0d94ff18fc43613b0bcfdeb2beafa3b7524ab0e80a"
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
