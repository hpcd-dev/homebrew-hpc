class HpcAT03 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "8e1f7490e6686fabd2572d1c9efd075234656d8d5dfde5ba585da2b763faa649"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.3.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "228d229efbffc3fb33a5de3bf012e51dd57e4400bb7a55549e356a44bafe3aec"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e2a203f1ad607569f562fae9e006ead71250cd95e98f8834ed0df804ac7e4a90"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ff25bc7831c378282f472c328043e749f2f066601ce3fac14cdc0b015d1abc1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa24002ad74473d3a167bec57fc4fc5beef95679f63be5e66dfd6a667adf7726"
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
