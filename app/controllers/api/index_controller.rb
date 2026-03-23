module Api
  class IndexController < ApplicationController
    def show
      base_path = ENV.fetch("ECOSYNC_BASE_PATH", Dir.home)
      index = FileIndexService.generate(base_path)
      render json: index
    end

    def mobile
      mobile_index = params[:files]
      base_path = ENV.fetch("ECOSYNC_BASE_PATH", Dir.home)
      local_index = FileIndexService.generate(base_path)

      local_paths = local_index.map { |f| f[:path] }
      mobile_paths = mobile_index.map { |f| f["path"] }

      missing = local_paths - mobile_paths

      render json: { missing: missing }
    end
  end
end
