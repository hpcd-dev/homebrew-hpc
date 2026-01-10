class HpcAT04 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "4679013d91b14d17ecb9476a296eda91084f5c0b4a56de7f4006dd108e94ff86"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.4.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0a38e7b4f41383b8f74472e4c3b2ef25f600cc41fcc03d93726d6a503efd14aa"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e1291e8bc5876817504decc2fc3705fc2617aa9abd37dce67ff0c0efe1789d42"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a2a2e583b73fda57d177754d351be64fbe25d7d8586b2fc327c13b31cdd4ec6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "60b59bca6f58c08d69d4de5320cd0577745694324c980674fce1e80dd3d3a6ad"
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
