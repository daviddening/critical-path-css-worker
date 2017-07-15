require "sidekiq"
require "critical-path-css-rails"

require "critical_path_css_worker/version"
require "critical_path_css_worker/helper"
require "critical_path_css_worker/cache_critical_css_worker"
require "critical_path_css_worker/critical_css_cache_helper"

module CriticalPathCssWorker
  extend self
end
