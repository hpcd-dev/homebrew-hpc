class Hpc < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "b89c794948d25b0addf63ca24fbcd4dd3527565a7da94e121e64911692293b5e"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.6.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "26c6c2f5742c9831d4b8274c28da18b91ff0176a971f429e0f5cab14d526ae30"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4e2c1eb5bd85e992575f12262e310b4ce0a89e8793ff505f81999cb2152f9a96"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8405bd5adaa5aa9babab25fcb18e822fdd1c4b5c71e167ab4b50504e28ac8a3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ddb80b790524180b85b88d33c6e65686454eeaa1ad3240c295f76e3ffee17de"
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
