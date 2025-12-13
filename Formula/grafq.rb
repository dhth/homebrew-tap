class Grafq < Formula
  desc "query Neo4j/AWS Neptune databases via an interactive console"
  homepage "https://github.com/dhth/grafq"
  version "0.1.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dhth/grafq/releases/download/v0.1.0/grafq-aarch64-apple-darwin.tar.xz"
    sha256 "9e933c65b7a8bff19c3bb22f82324dc67fb03f84ea64315aff0b476589dee2af"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/grafq/releases/download/v0.1.0/grafq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0c8bc11762914b20613ae8691e6a5545730c1235527ead8e36e0819fccfa4123"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/grafq/releases/download/v0.1.0/grafq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4595b3fbdb206c88ac3b4aafda0c4ab857b53659a382b74029629c23ceef9e55"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "grafq" if OS.mac? && Hardware::CPU.arm?
    bin.install "grafq" if OS.linux? && Hardware::CPU.arm?
    bin.install "grafq" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
