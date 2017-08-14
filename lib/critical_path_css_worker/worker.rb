require 'sidekiq'
require "critical-path-css-rails"

module CriticalPathCssWorker
  class Worker
    include Sidekiq::Worker

    CRITICAL_CSS_CACHE_NAMESPACE = "critical-path-css-processing".freeze

    def perform(url)
      puts "CacheCriticalCssWorker.perform(url) #{url}"
      path = URI(url).path
      CriticalPathCss.generate(path)
      CacheState.fresh(path)
    end

    def self.cache_critical_css(url, critical_css_present)
      puts "cache_critical_css(url,...) #{url}"
      path = URI(url).path

      return if critical_css_present && CacheState.fresh?(path)
      return if CacheState.processing?(path)

      CacheState.processing(path)
      puts "CacheCriticalCssWorker.perform_async(url) #{url}"
      Worker.perform_async(url)
    end
  end
end
