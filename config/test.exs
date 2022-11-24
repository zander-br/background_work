import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :background_work, BackgroundWork.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "background_work_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :background_work, BackgroundWorkWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "f9N4OlLp1zu35s1ely5zqrK3L/Au/DUVlJAiCx4OxYm4t2EC10QEKkVhKNh+QtB5",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
