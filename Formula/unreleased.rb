class Unreleased < Formula
  desc "view the commits to your GitHub repos since their last release"
  homepage "https://tools.dhruvs.space/unreleased"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/unreleased/releases/download/v0.1.1/unreleased-aarch64-apple-darwin.tar.xz"
      sha256 "4c1de6c727c94d1e0da39ebc6a660d03576c4ae126a399d1f54aa3b10a7a96e2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/unreleased/releases/download/v0.1.1/unreleased-x86_64-apple-darwin.tar.xz"
      sha256 "f17b935e4e10ebec8dff179502ce55292b6d682092dc4608c414499a5d128d80"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/unreleased/releases/download/v0.1.1/unreleased-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0e797e15776170a595b657646a0c8cd50131d91ba783722d4b3308df27de67d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/unreleased/releases/download/v0.1.1/unreleased-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ab4a18f27edf07c54180f04cf5400859df7e6f917a21d886f7a8c4480d884314"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
    bin.install "unreleased" if OS.mac? && Hardware::CPU.arm?
    bin.install "unreleased" if OS.mac? && Hardware::CPU.intel?
    bin.install "unreleased" if OS.linux? && Hardware::CPU.arm?
    bin.install "unreleased" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
