class FileIndexService
  def self.generate(base_path)
    Dir.glob("#{base_path}/**/*")
      .select { |f| File.file?(f) }
      .map do |f|
        stat = File.stat(f)
        {
          path: f.sub("#{base_path}/", ""),
          size: stat.size,
          mtime: stat.mtime.to_i
        }
      end
  end
end
