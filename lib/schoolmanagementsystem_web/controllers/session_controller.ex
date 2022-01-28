defmodule SchoolmanagementsystemWeb.SessionController do
  use SchoolmanagementsystemWeb, :controller

  alias Schoolmanagementsystem.Auth
  alias Schoolmanagementsystem.Users
  alias Schoolmanagementsystem.Users.User
  alias Schoolmanagementsystem.Auth.Guardian
  alias Schoolmanagementsystem.Admins
  alias Schoolmanagementsystem.Admins.Admin

  def new(conn, _) do
    changeset = Users.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: "/")
    else
      render(conn, "index.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Auth.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Welcome back!")
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: "/")

      {:error, reason} ->
        conn
        |> put_flash(:error, to_string(reason))
        |> put_status(401)
        |> new(%{})
    end
  end

  def logout(conn, _) do
    conn
    |> delete_session(:current_user)
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end


  # def new(conn, _) do
  #   changeset = Admins.change_user(%Admin{})
  #   maybe_admin = Guardian.Plug.current_resource(conn)

  #   if maybe_admin do
  #     redirect(conn, to: "/")
  #   else
  #     render(conn, "index.html", changeset: changeset, action: Routes.session_path(conn, :login))
  #   end
  # end

  # def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
  #   case Auth.authenticate_user(email, password) do
  #     {:ok, user} ->
  #       conn
  #       |> put_session(:current_user, user.id)
  #       |> put_flash(:info, "Welcome back!")
  #       |> Guardian.Plug.sign_in(user)
  #       |> redirect(to: "/")

  #     {:error, reason} ->
  #       conn
  #       |> put_flash(:error, to_string(reason))
  #       |> put_status(401)
  #       |> new(%{})
  #   end
  end

  def logout(conn, _) do
    conn
    |> delete_session(:current_user)
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end


end
