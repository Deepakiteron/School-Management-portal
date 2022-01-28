defmodule SchoolmanagementsystemWeb.Router do
  use SchoolmanagementsystemWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SchoolmanagementsystemWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug SchoolmanagementsystemWeb.Plug.EnsureRolePlug, :admin
  end

  pipeline :auth do
    plug Schoolmanagementsystem.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", SchoolmanagementsystemWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index
    resources "/registers", UserController
    resources "/admins", AdminController
    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
  end

  scope "/admin" do
    pipe_through [:browser, :admin]
    put("/teacher/:userID", UserController, :teacher)
    put("/admin/:userID", AdminController, :admin)
    put("/student/:userID", UserController, :student)
  end

  # Other scopes may use custom stacks.
  # scope "/api", SchoolmanagementsystemWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: SchoolmanagementsystemWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:browser]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end