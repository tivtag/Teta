
begin
  require 'metric_fu'

  MetricFu::Configuration.run do |config|
    config.metrics -= [:rcov]
  end

rescue LoadError
end
