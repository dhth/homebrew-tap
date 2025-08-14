class CargoDistTest < Formula
  desc "just a test repo"
  homepage "https://github.com/dhth/cargo-dist-test"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.7/cargo-dist-test-aarch64-apple-darwin.tar.xz"
      sha256 "f4d721524fb821465b9c4d3ea89084244e0c29ccd3ad7c6603eeec609275aab1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.7/cargo-dist-test-x86_64-apple-darwin.tar.xz"
      sha256 "5e28779c0f83ab4c2a741fb049a2ffbc4cb1f88811917db17411212ad588f3df"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/cargo-dist-test/releases/download/v0.1.7/cargo-dist-test-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "99ff75a7fd01cd533104f6b8d6152e2117b209cbd83d8ecc6da5b53e9d1cabae"
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
