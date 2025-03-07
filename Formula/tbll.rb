class Tbll < Formula
  desc "tbll outputs data in tabular format"
  homepage "https://github.com/dhth/tbll"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tbll/releases/download/v1.0.0/tbll-aarch64-apple-darwin.tar.xz"
      sha256 "62eced115773308eefde90c0ec99174a192c0d0eb7035906862c6e71a8a2f273"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tbll/releases/download/v1.0.0/tbll-x86_64-apple-darwin.tar.xz"
      sha256 "b3e747d5f0178f023c83758f00edcf2fa00d8c6decb61a5be7e07190ad3a38c3"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/tbll/releases/download/v1.0.0/tbll-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a372de83873abd3ecd4fca12d2e370b0838eb051e4406414572e677c2222d6c1"
  end

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
