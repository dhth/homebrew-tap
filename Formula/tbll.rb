class Tbll < Formula
  desc "tbll outputs data in tabular format"
  homepage "https://github.com/dhth/tbll"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tbll/releases/download/v1.1.0/tbll-aarch64-apple-darwin.tar.xz"
      sha256 "55efa0822adb709bca6fc1021a23d1b101f07b92b232603366f0b162bf93e4a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tbll/releases/download/v1.1.0/tbll-x86_64-apple-darwin.tar.xz"
      sha256 "f9e3a69ee7edd42177884d760188fa4afc7285bbd3154796961827089e3a3ffe"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/tbll/releases/download/v1.1.0/tbll-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "d9c15742877c1eb8bec0f3053f54ef7c1aad93c2722078d12058dbf461963591"
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
