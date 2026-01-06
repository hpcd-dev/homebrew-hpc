class HpcAT03 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "25e621c4321b5ce399aa08b5844d1b530db8cf85b8a8f1f0a0c10d5fa866bc32"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "497e43be8c390db66804d28082627dcd5cffafe3795544b519e16c452ac4d541"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "afcb6254d3ab6e0f16a0110577b1808141d91088fcc25d602f277e70045eb0d5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "53bb3d95f74156ca2a220b62203f2a34f51037559392bd04a0553fea351714f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "779da58801aaf997020d34163f46c80985bc47ad95af782a313ed29d6ce2bb2f"
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
