import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :wallaby_test, WallabyTest.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "wallaby_test_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wallaby_test, WallabyTestWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "4lZDqXXntkD0F4Ib1cbLfegt7mVL/V0k2htT5Fb6WhV9V7mOuvcNfWEZ6Hc+KPdk",
  server: false

# In test we don't send emails.
config :wallaby_test, WallabyTest.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
