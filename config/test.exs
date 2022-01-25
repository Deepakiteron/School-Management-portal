import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :schoolmanagementsystem, Schoolmanagementsystem.Repo,
  username: "postgres",
  password: "postgres",
  database: "schoolmanagementsystem_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :schoolmanagementsystem, SchoolmanagementsystemWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "3QAO0o180jj4iD5PNtcFnfm8XOR8UbZaOdI99gxQHxwAeYlMihf9wdFbXCHhjCFX",
  server: false

# In test we don't send emails.
config :schoolmanagementsystem, Schoolmanagementsystem.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
