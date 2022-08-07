defmodule Myflix.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Myflix.Repo,
      # Start the Telemetry supervisor
      MyflixWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Myflix.PubSub},
      # Start the Endpoint (http/https)
      MyflixWeb.Endpoint
      # Start a worker by calling: Myflix.Worker.start_link(arg)
      # {Myflix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Myflix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MyflixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
