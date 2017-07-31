require "sidekiq"
require "critical-path-css-rails"
# require "rails"

require "critical_path_css_worker/version"
require "critical_path_css_worker/helper"
require "critical_path_css_worker/cache_critical_css_worker"
require "critical_path_css_worker/critical_css_cache_helper"

module CriticalPathCssWorker
  def critical_css(url)
    path = URI(url).path
    css = CriticalPathCss.fetch(path)
    CacheCriticalCssWorker.cache_critical_css(url, !css.empty?)
    css
  end
end

# Override Critical Path Css 
#
module CriticalPathCss
  CACHE_NAMESPACE = "critical-path-css".freeze
  AGENT = "Penthouse Critical Path CSS Generator".freeze

  def self.generate(route)
    Rails.cache.write(
      route,
      CssFetcher.new.fetch_route(route),
      namespace: CACHE_NAMESPACE,
      expires_in: 1.week
    )
  end

  def self.fetch(route)
    Rails.cache.read(route, namespace: CACHE_NAMESPACE) || ''
  end

  class CssFetcher
    protected

    def css_for_route(route)
      url = @config.base_url + route

      Phantomjs.run(
        '--ignore-ssl-errors=true',
        '--ssl-protocol=tlsv1',
        PENTHOUSE_PATH,
        '--width', '375',
        url,
        @config.css_path
      )
    end
  end
end
