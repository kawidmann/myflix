defmodule MyflixWeb.Router do
  use MyflixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticate do
    plug MyflixWeb.Plugs.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyflixWeb do
    pipe_through :browser # Use the default browser stack
    get "/", SessionController, :new
    post "/", SessionController, :create
  end

  scope "/", MyflixWeb do
    pipe_through [:browser, :authenticate]

    delete "/sign-out", SessionController, :delete
    resources "/registrations", UserController, only: [:new, :create]
    get "/home", UserController, :index
    resources "/videos", VideoController
    get "/watch/:id", WatchController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyflixWeb do
  #   pipe_through :api
  # end
end
