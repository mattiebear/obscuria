defmodule ObscuriaWeb.Router do
  use ObscuriaWeb, :router

  import ObscuriaWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ObscuriaWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ObscuriaWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", ObscuriaWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:obscuria, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ObscuriaWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", ObscuriaWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{ObscuriaWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", AuthLive.UserRegistrationLive, :new
      live "/users/log_in", AuthLive.UserLoginLive, :new
      live "/users/reset_password", AuthLive.UserForgotPasswordLive, :new
      live "/users/reset_password/:token", AuthLive.UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", ObscuriaWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{ObscuriaWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", AuthLive.UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", AuthLive.UserSettingsLive, :confirm_email

      live "/scribe", PuzzlesLive.Index, :index
    end
  end

  scope "/", ObscuriaWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{ObscuriaWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", AuthLive.UserConfirmationLive, :edit
      live "/users/confirm", AuthLive.UserConfirmationInstructionsLive, :new
    end
  end
end
