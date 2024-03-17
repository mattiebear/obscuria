defmodule Obscuria.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ObscuriaWeb.Telemetry,
      Obscuria.Repo,
      {DNSCluster, query: Application.get_env(:obscuria, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Obscuria.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Obscuria.Finch},
      # Start a worker by calling: Obscuria.Worker.start_link(arg)
      # {Obscuria.Worker, arg},
      # Start to serve requests, typically the last entry
      ObscuriaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Obscuria.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ObscuriaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
