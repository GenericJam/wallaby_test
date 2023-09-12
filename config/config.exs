# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :wallaby_test,
  ecto_repos: [WallabyTest.Repo]

# Configures the endpoint
config :wallaby_test, WallabyTestWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: WallabyTestWeb.ErrorHTML, json: WallabyTestWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: WallabyTest.PubSub,
  live_view: [signing_salt: "+9WFqR3a"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :wallaby_test, WallabyTest.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :wallaby,
  otp_app: :wallaby_test,
  chromedriver: [
    headless: false,
    # path: "/usr/bin/chromedriver",
    binary:
      "/home/kevinedey/.local/share/flatpak/app/com.google.Chrome/x86_64/stable/active/export/bin/com.google.Chrome"
  ],
  driver: Wallaby.Chrome

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
