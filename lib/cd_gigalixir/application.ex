defmodule CdGigalixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CdGigalixirWeb.Telemetry,
      CdGigalixir.Repo,
      {DNSCluster, query: Application.get_env(:cd_gigalixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CdGigalixir.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CdGigalixir.Finch},
      # Start a worker by calling: CdGigalixir.Worker.start_link(arg)
      # {CdGigalixir.Worker, arg},
      # Start to serve requests, typically the last entry
      CdGigalixirWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CdGigalixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CdGigalixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
