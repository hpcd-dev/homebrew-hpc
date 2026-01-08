class Hpc < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "af9e8f888cbb58bf71aef9e635846e843fe203c6a7d0bf2285f8b1bbc430914e"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.3.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f0eeaa79aef10a7a4a29d870b971f49fe7ab1db9dfa2bd17d64b35cd5e7dbf5e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8aeab07fdab53407a133c9a7f34fd77bf2f0f7a8b129197c0171365a9decadeb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b11fb7eeb83833e67ec39855c365b72c614b7da313334fcd80105563b57998b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5bfdbb00f095fce8c734e493b5f52303af8252b9a9bc837c10f63724a20b71a0"
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
