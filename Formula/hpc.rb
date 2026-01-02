class Hpc < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "efc75376d2e3bdd9ddabdc01ac2b2bc41fe3e80e2b8ada69d8e358a4b82e92fb"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ca8577658ea5bcccea43aa58abea4958fbf1686cbf40d47301fea0275eedcfc9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "beef11602d4a48a18626a8fa50a1d2b9e39bbaa3a6aa20b9fd4e7c45d12ddc07"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a1221515f75c2bd53e1f27dc0b8701cccc4fe6c1bc9aee0ce3b06add1beecb88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db1bf2ddfb7ebe22b1bc66c64984abdbc5dee5276bda6ed8641d33edea69ef20"
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
