class Hpc < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "4679013d91b14d17ecb9476a296eda91084f5c0b4a56de7f4006dd108e94ff86"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.4.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "52e85b9a1382a13d043ee431e1df9562dccb911ab9e9327adf4675e8ad8c2049"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "530ecfbd91b8fdf050757eaa83f4c21623fef8fdd6e9b1af7ca21a7a57b4d2f6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ebcacbdb7e8ff431ee5057c03f676d4f6c91ccaa39bb981b56ee490aae688b8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae844822cbca54d6c667946a57f0466116de99061911cf03be4ad0ad633e4575"
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
