class Tbll < Formula
  desc "tbll outputs data in tabular format"
  homepage "https://github.com/dhth/tbll"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tbll/releases/download/v0.1.0/tbll-aarch64-apple-darwin.tar.xz"
      sha256 "25405799b81e9962c812c50f1ab0c87b2912a49103e7bf7f6b2cc6f0e1fbc3a9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tbll/releases/download/v0.1.0/tbll-x86_64-apple-darwin.tar.xz"
      sha256 "e0423a10c1bbb21bbde22df5ef800b8b8d4c7c1de96673ae1c795f61d050b6d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tbll/releases/download/v0.1.0/tbll-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9679de06026dc359feb45393b364841b0c3a7007d90dff3638b2da44b3876b09"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}}

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tbll"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tbll"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tbll"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
