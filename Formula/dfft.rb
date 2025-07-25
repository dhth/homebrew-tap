class Dfft < Formula
  desc "monitor changes as AI agents modify your codebase"
  homepage "https://tools.dhruvs.space/dfft/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/dfft/releases/download/v0.1.0/dfft-aarch64-apple-darwin.tar.xz"
      sha256 "8cfdbeb525fc6f6f6d806691c4c5627f75461ca1e11d28ac0045785b31b70c08"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/dfft/releases/download/v0.1.0/dfft-x86_64-apple-darwin.tar.xz"
      sha256 "9f51cbfb86332da8f07cb512b45db02cace491325a7fae3e1545b22f70eaf399"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/dfft/releases/download/v0.1.0/dfft-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "8eb633f24311cc7583e5a7045596fac9fa1b2ffae125fc09c8498eacfd6f4ea9"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "dfft" if OS.mac? && Hardware::CPU.arm?
    bin.install "dfft" if OS.mac? && Hardware::CPU.intel?
    bin.install "dfft" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
