class Bmm < Formula
  desc "bmm lets you get to your bookmarks in a flash"
  homepage "https://tools.dhruvs.space/bmm/"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/bmm/releases/download/v0.2.0/bmm-aarch64-apple-darwin.tar.xz"
      sha256 "3a07259bb431d02bef65999ab074c74b5ade22ec217bdf72e385f99118637007"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/bmm/releases/download/v0.2.0/bmm-x86_64-apple-darwin.tar.xz"
      sha256 "44b1fed36a5aedef4f3512a0d6e7e7ae8b6b8746a36b7c9339252825b86e3581"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/bmm/releases/download/v0.2.0/bmm-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "159c3f08e5ba3871f3a9a47f800ad28f4d50da8fe86982e707f9bfc98fd53933"
  end
  license "MIT"

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
    bin.install "bmm" if OS.mac? && Hardware::CPU.arm?
    bin.install "bmm" if OS.mac? && Hardware::CPU.intel?
    bin.install "bmm" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
