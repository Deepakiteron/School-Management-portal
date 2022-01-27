defmodule SchoolPortalWeb.SessionController do
  use SchoolPortalWeb, :controller

  alias SchoolPortal.Auth
  alias SchoolPortal.Users
  alias SchoolPortal.Users.User
  alias SchoolPortal.Auth.Guardian

  def index(conn, _params) do
    changeset = Users.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    message = if maybe_user != nil do
      "Someone is logged in"
    else
      "No one is logged in"
    end
    conn
      |> put_flash(:info, message)
      |> render("index.html", changeset: changeset, action: Routes.session_path(conn, :login))
  end
  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    Auth.authenticate_user(email, password)
    |> login_reply(conn)
  end
  defp login_reply({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/")
  end
  defp login_reply({:ok, user}, conn) do
    conn
     |> put_flash(:success, "Welcome back!")
     |> Guardian.Plug.sign_in(user)
     |> render("secret_page.html")
  end
  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: Routes.page_path(conn, :index))
  end
  def secret(conn, _params) do
    render(conn, "secret_page.html")
  end
end
