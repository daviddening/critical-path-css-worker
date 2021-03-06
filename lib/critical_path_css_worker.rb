require "sidekiq"
require "critical-path-css-rails"
require "critical_path_css_worker/version"
require "critical_path_css_worker/worker"
require "critical_path_css_worker/cache_state"

module CriticalPathCssWorker
  def critical_css(url)
    path = URI(url).path
    css = CriticalPathCss.fetch(path)
    Worker.cache_critical_css(url, !css.empty?)
    css
  end
  module_function :critical_css
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
