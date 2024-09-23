class Tbll < Formula
  desc "tbll outputs data in tabular format"
  homepage "https://github.com/dhth/tbll"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tbll/releases/download/v0.2.3/tbll-aarch64-apple-darwin.tar.xz"
      sha256 "f4fdf671bb65acf7e93b914adc1067823f1a80a23285420352928d66c9261584"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tbll/releases/download/v0.2.3/tbll-x86_64-apple-darwin.tar.xz"
      sha256 "278318f4204a4ec0ae4da3b6c1499f7e71c82681b8ae5e3c00d49eef4b4e17c1"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/tbll/releases/download/v0.2.3/tbll-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "33bf50480871301a07ed48deace4ec983c26c212498a294115ccc999d0a6fbf2"
  end

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
    bin.install "tbll" if OS.mac? && Hardware::CPU.arm?
    bin.install "tbll" if OS.mac? && Hardware::CPU.intel?
    bin.install "tbll" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
