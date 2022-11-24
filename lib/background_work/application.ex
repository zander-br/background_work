defmodule BackgroundWork.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BackgroundWork.Repo,
      # Start the Telemetry supervisor
      BackgroundWorkWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BackgroundWork.PubSub},
      # Start the Endpoint (http/https)
      BackgroundWorkWeb.Endpoint,
      {Task.Supervisor, name: BackgroundWork.PokemonDetailSupervisor}
      # Start a worker by calling: BackgroundWork.Worker.start_link(arg)
      # {BackgroundWork.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BackgroundWork.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BackgroundWorkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
