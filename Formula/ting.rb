class Ting < Formula
  desc "audio feedback on the command line"
  homepage "https://tools.dhruvs.space/ting/"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ting/releases/download/v0.1.1/ting-aarch64-apple-darwin.tar.xz"
      sha256 "79fc577369fa31e92ea649d9c3b8b11239c8969a489fd0faed6d3f4d39963bc8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ting/releases/download/v0.1.1/ting-x86_64-apple-darwin.tar.xz"
      sha256 "b13bee21ac5216a05891d0e7acf0652c31dd15387b36341a87f5e55e3eb6ecaa"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/ting/releases/download/v0.1.1/ting-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "d38d06f7729494a05b8603e87451ba06333377888eeb693481918ab8e9f48f80"
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
    bin.install "ting" if OS.mac? && Hardware::CPU.arm?
    bin.install "ting" if OS.mac? && Hardware::CPU.intel?
    bin.install "ting" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
