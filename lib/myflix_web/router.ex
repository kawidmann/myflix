defmodule MyflixWeb.Router do
  use MyflixWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :authenticate do
    plug(MyflixWeb.Plugs.Authenticate)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", MyflixWeb do
    # Use the default browser stack
    pipe_through(:browser)
    get("/", SessionController, :new)
    post("/", SessionController, :create)
  end

  scope "/", MyflixWeb do
    pipe_through([:browser, :authenticate])

    delete("/sign-out", SessionController, :delete)
    resources("/registrations", UserController, only: [:new, :create])
    get("/home", UserController, :index)
    resources("/videos", VideoController)
    get("/watch/:id", WatchController, :show)
    post("/search/", SearchController, :index)
    get("/search/:id", SearchController, :show)
    resources("/movie", MovieController, only: [:index, :show])
    resources("/tv", TvController, only: [:index, :show])
    resources("/person", PersonController, only: [:index, :show])
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyflixWeb do
  #   pipe_through :api
  # end
end
