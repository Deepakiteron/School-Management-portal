defmodule SchoolPortalWeb.SessionAdminController do
  use SchoolPortalWeb, :controller

  alias SchoolPortal.Auth
  alias SchoolPortal.Admins
  alias SchoolPortal.Admins.Admin
  alias SchoolPortal.Auth.Guardian

  def index(conn, _params) do
    changeset = Admins.change_admin(%Admin{})
    maybe_admin = Guardian.Plug.current_resource(conn)
    message = if maybe_admin != nil do
      "Someone is logged in"
    else
      "No one is logged in"
    end
    conn
      |> put_flash(:info, message)
      |> render("admin.html", changeset: changeset, action: Routes.session_admin_path(conn, :login))
  end
  def login(conn, %{"admin" => %{"email" => email, "password" => password}}) do
    Auth.authenticate_admin(email, password)
    |> login_reply(conn)
  end
  defp login_reply({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/")
  end
  defp login_reply({:ok, admin}, conn) do
    conn
      |> Guardian.Plug.sign_in(admin)
   end
  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: Routes.page_path(conn, :index))
  end
  def secret(conn, _params) do
    render(conn, "admin_view.html")
  end
end
