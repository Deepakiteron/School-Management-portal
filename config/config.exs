# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :school_portal,
  ecto_repos: [SchoolPortal.Repo]

# Configures the endpoint
config :school_portal, SchoolPortalWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SchoolPortalWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SchoolPortal.PubSub,
  live_view: [signing_salt: "lum18C4Q"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :school_portal, SchoolPortal.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :school_portal, SchoolPortal.Auth.Guardian,
  issuer: "school_portal",
  secret_key: "R35ToFg0n+aVCZZ/VEjueKWWhOY1jwWgdudXnj6okTyz2oB0ukozJLg0b/elgtzm"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
