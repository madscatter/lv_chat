defmodule LvChatWeb.Router do
  use LvChatWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug LvChatWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", LvChatWeb do
  #   pipe_through :browser

  #   get "/", PageController, :index
  #   resources "/users", UserController, only: [:new, :create]
  #   resources "/sessions", SessionController, only: [:new, :create, :delete]
  # end
  scope "/", LvChatWeb do
    pipe_through :browser

    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create]
  end

  scope "/", LvChatWeb do
    pipe_through [:browser, :authenticate_user]

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:delete]
    resources "/boards", BoardController # add this
  end


  # Other scopes may use custom stacks.
  # scope "/api", LvChatWeb do
  #   pipe_through :api
  # end
end
