class CargoDistTest < Formula
  desc "just a test repo"
  homepage "https://github.com/dhth/cargo-dist-test"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.6/cargo-dist-test-aarch64-apple-darwin.tar.xz"
      sha256 "0f37c644700e7b1c389ec86dc2508bd430fa7a48c74f6ad7e6267cbfa5b0c2a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.6/cargo-dist-test-x86_64-apple-darwin.tar.xz"
      sha256 "19496c23291b94a309dc63e1813d2dd1d1c4d2a92815a24da546006415e35655"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.6/cargo-dist-test-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "dbd7ef00f0f1437748f6b3a0cde3febd40bebff346815bc3e2dcc80fb9d2c069"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

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
    bin.install "cargo-dist-test" if OS.mac? && Hardware::CPU.arm?
    bin.install "cargo-dist-test" if OS.mac? && Hardware::CPU.intel?
    bin.install "cargo-dist-test" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
