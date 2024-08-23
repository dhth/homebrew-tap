class CargoDistTest < Formula
  desc "just a test repo"
  homepage "https://github.com/dhth/cargo-dist-test"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.3/cargo-dist-test-aarch64-apple-darwin.tar.xz"
      sha256 "c0464a25e181bd189c1c46f45ba1e32a5521e17df6195aff4610ba965bd82572"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.3/cargo-dist-test-x86_64-apple-darwin.tar.xz"
      sha256 "8f7fa5e74dd4cb4333430bc32a19ecb92c4ac714de47fcdb5a791b2c4184e66d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.3/cargo-dist-test-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6b547e83d3c88a009bc1bcb50227c27ee3192d4aa34230c2efc830edc90d3f3d"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cargo-dist-test"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cargo-dist-test"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cargo-dist-test"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
