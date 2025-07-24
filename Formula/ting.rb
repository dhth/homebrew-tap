class Ting < Formula
  desc "audio feedback on the command line"
  homepage "https://tools.dhruvs.space/ting/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ting/releases/download/v0.1.0/ting-aarch64-apple-darwin.tar.xz"
      sha256 "0264b517357aaa89528cf807f704d487173f7cc40ddacab2c931f958731f1d56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ting/releases/download/v0.1.0/ting-x86_64-apple-darwin.tar.xz"
      sha256 "5a4c4d46f9f6438786f0c89eeff68a10cd3220606aebba6b44183a9a8c5baf7b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/ting/releases/download/v0.1.0/ting-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "35c4de1d634577adb16facc4171c071bc01ec467047aca8085f2d08fe0d1661e"
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
