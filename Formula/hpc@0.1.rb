class HpcAT01 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "efc75376d2e3bdd9ddabdc01ac2b2bc41fe3e80e2b8ada69d8e358a4b82e92fb"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "19c73890d4eb9f8076a2ee9d3b892d282984f0870131b49617ff7d04eb4b6d31"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e484be317026a973cf57fac624cafa851a7c2e14c2ec31a394dc45d8cc98cdbe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "75102a9afe8b08b32a142b267df6423e1a629187ab7afac8d0ea2a9101616925"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "777876458d76b1805075d4bc7e9ea807bfb93f1591c64fb4fc8f3fef57b035e5"
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
