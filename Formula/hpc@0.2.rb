class HpcAT02 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "7b2457b096083fd21fa858853b0dc4d107a70adfdb33a93e7dee0456729272d5"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fb8052d683a9e5df007212e77efac31f6e55d3881a479a04d489697533a9bf02"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "df5cf78d3d2052457944fd2e197a9a78f2d678077e829feaab0f26f07467d5c0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c25afe22628155f304bd21b3f5a9e29621028add4a1f5e2f9d1589775ed86c1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58c4db76c4de3fdc77ea1987021164950d013810c027719c552985deb2b1c8ca"
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
