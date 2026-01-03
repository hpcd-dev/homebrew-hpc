class Hpc < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "efc75376d2e3bdd9ddabdc01ac2b2bc41fe3e80e2b8ada69d8e358a4b82e92fb"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e3963d1a7191c9206b70515dafbbadfac903bc133069e393e77ffc3991fa3cfd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f8b543f9bf75e4b7a428c9c372fde431fd053771747d663c2bf82f21d599783e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b8022b37b7598e35beac592f1c26addcc7fa5ae49c454a9c970b07562d475a0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "60d83d5180a2b919b8da98eef2f33a66607636f4696efc4edcc783578890accc"
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
