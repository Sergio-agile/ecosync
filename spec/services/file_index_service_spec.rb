require "rails_helper"
require_relative "../../app/services/file_index_service"

RSpec.describe FileIndexService do
  describe ".generate" do
    let(:tmp_dir) { Dir.mktmpdir("ecosync_test") }

    after { FileUtils.rm_rf(tmp_dir) if File.exist?(tmp_dir) }

    it "returns an empty array for an empty directory" do
      expect(FileIndexService.generate(tmp_dir)).to eq([])
    end

    it "returns path, size and mtime for each file" do
      File.write(File.join(tmp_dir, "song.mp3"), "fake content")

      result = FileIndexService.generate(tmp_dir)

      expect(result.length).to eq(1)
      expect(result.first[:path]).to eq("song.mp3")
      expect(result.first[:size]).to be > 0
      expect(result.first[:mtime]).to be_a(Integer)
    end

    it "finds files in subdirectories" do
      subdir = File.join(tmp_dir, "album")
      FileUtils.mkdir_p(subdir)
      File.write(File.join(subdir, "track.mp3"), "fake content")

      result = FileIndexService.generate(tmp_dir)

      expect(result.first[:path]).to eq("album/track.mp3")
    end
  end
end
