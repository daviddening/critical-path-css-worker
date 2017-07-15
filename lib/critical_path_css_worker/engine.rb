# frozen_string_literal: true
module CriticalPathCssWorker
  class Engine < ::Rails::Engine
    initializer "critical_path_css_worker" do |app|
        ActionController::Base.send :include, CriticalPathCssWorker::Helper
        ActionController::Base.helper CriticalPathCssWorker::Helper
    end
  end
end
