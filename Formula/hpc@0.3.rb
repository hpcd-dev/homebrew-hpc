class HpcAT03 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "be2632a7e85e74acaa07eb9ac02bc8ddaac689101a00bdcafba5e80a9d547cbf"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "acb04c65d6f35416246303a336da64c54a40ec655b39dbb363f289dadfe92772"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0a9a6264c60cc2685d0f58ad9b132ad395debd64e19e07884067537f9871b067"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1acd981d53637e785ed0398475626e06dda93d208cc21a5fc641c3aedf75b0be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c1b390684011b8937e9c0691d2b9d91a99c189085232891e677085b5ab21c116"
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
