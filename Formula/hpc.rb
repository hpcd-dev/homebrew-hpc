class Hpc < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "25e621c4321b5ce399aa08b5844d1b530db8cf85b8a8f1f0a0c10d5fa866bc32"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f63b2d9de0b8c5841fffb5c49b715ef5e2d32790c5e0e6c4aff129795a4cf673"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e0ec1d0f72d05976cbcbc27792b79d3a3854e873877d9719af36a2d8d5b7a22"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "10b228bb7cd1192ae6c62a0930a7c84ac4185d953583d0e8cd27359557c3f87a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0234136ef4e0b335d1ae417b25cf143bb486d0e6bf4a8fb0578c6529703fc23b"
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
