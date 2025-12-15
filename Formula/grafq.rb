class Grafq < Formula
  desc "query Neo4j/AWS Neptune databases via an interactive console"
  homepage "https://github.com/dhth/grafq"
  version "0.1.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dhth/grafq/releases/download/v0.1.1/grafq-aarch64-apple-darwin.tar.xz"
    sha256 "15d0eeccebb58c470d9c3713dcfe5bf0299e8331cb9d319166b456d547a3c2f6"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/grafq/releases/download/v0.1.1/grafq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9794c91dc5eaf64096ab4855be9b71c1d15e22b634996d15961116fe9108eff7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/grafq/releases/download/v0.1.1/grafq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "42a606b10018a690ea181ff140e325a4ff4cb6c1142a8c4c3966ce0e870fe4e3"
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
