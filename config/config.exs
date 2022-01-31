import Config

config :issues, github_url: "https://api.github.com"

# deprecated
# config :logger, compile_time_purge_level: :info
config :logger, compile_time_purge_matching: [[level_lower_than: :info]]
