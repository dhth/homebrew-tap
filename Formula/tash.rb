class Tash < Formula
  desc "stash content that you can access later"
  homepage "https://tools.dhruvs.space/tash/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tash/releases/download/v0.1.0/tash-aarch64-apple-darwin.tar.xz"
      sha256 "a9153613e3915d86cfc984dd5c9222ded41b337a246745c603ecdfec93462295"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tash/releases/download/v0.1.0/tash-x86_64-apple-darwin.tar.xz"
      sha256 "0be5afa75e8b68948fa33704fa7d0a97ff92914c60f3977e27f0212d57be56ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tash/releases/download/v0.1.0/tash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "52d01a7a50d3350df71eb6daa91dce4f330f3dea66de2939f76435849994eee5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tash/releases/download/v0.1.0/tash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f07369b81fc690688c5a357bbf2789a2291caf1a4f06b2be32432817dc6061dc"
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
    bin.install "tash" if OS.mac? && Hardware::CPU.arm?
    bin.install "tash" if OS.mac? && Hardware::CPU.intel?
    bin.install "tash" if OS.linux? && Hardware::CPU.arm?
    bin.install "tash" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
