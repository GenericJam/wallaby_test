defmodule WallabyTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WallabyTestWeb.Telemetry,
      # Start the Ecto repository
      WallabyTest.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: WallabyTest.PubSub},
      # Start Finch
      {Finch, name: WallabyTest.Finch},
      # Start the Endpoint (http/https)
      WallabyTestWeb.Endpoint
      # Start a worker by calling: WallabyTest.Worker.start_link(arg)
      # {WallabyTest.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WallabyTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WallabyTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
