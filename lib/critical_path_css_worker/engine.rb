# frozen_string_literal: true
module CriticalPathCssWorker
  class Engine < ::Rails::Engine
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.eager_load_paths << Dir["#{config.root}/lib/**/"]

  end
end
