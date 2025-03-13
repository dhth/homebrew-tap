class Ecscope < Formula
  desc "ecscope lets you monitor AWS ECS resources from the terminal"
  homepage "https://tools.dhruvs.space/ecscope/"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ecscope/releases/download/v0.2.0/ecscope-aarch64-apple-darwin.tar.xz"
      sha256 "e4adff964ed8182a05e83c60759b02cff8cf3258c0b64d010c55daaee9acf6ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ecscope/releases/download/v0.2.0/ecscope-x86_64-apple-darwin.tar.xz"
      sha256 "7083bc18150cfc492be56317e5b87a3a97ef944dfd5f88a4abca83ac9aa5c9d4"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/ecscope/releases/download/v0.2.0/ecscope-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a4511939b5b5630da7b5eb7b902a33c7774571fbf8d27b46cf34724477574dfa"
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
    bin.install "ecscope" if OS.mac? && Hardware::CPU.arm?
    bin.install "ecscope" if OS.mac? && Hardware::CPU.intel?
    bin.install "ecscope" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
