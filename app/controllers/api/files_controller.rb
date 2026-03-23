module Api
  class FilesController < ApplicationController
    def download
      base_path = ENV.fetch("ECOSYNC_BASE_PATH", Dir.home)
      file_path = File.join(base_path, params[:path])

      if File.exist?(file_path) && file_path.start_with?(base_path)
        send_file file_path, disposition: "attachment"
      else
        render json: { error: "File not found" }, status: :not_found
      end
    end

    def upload
      base_path = ENV.fetch("ECOSYNC_BASE_PATH", Dir.home)
      dest_path = File.join(base_path, params[:path])

      return render json: { error: "Invalid path" }, status: :forbidden unless dest_path.start_with?(base_path)

      file = params[:file]
      FileUtils.mkdir_p(File.dirname(dest_path))
      File.binwrite(dest_path, file.read)

      render json: { ok: true }
    end
  end
end
