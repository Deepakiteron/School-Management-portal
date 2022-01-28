
defmodule SchoolPortalWeb.Auth.EnsureRolePlug do
  import Plug.Conn
  alias SchoolPortalWeb.Auth.Guardian
  alias SchoolPortalWeb.Users.User
  alias Phoenix.Controller

  @admin "admin"
  @teacher "teacher"
  @student "student"

  @spec init(any()) :: any()
  def init(config), do: config

  @spec call(Conn.t(), atom() | binary() | [atom()] | [binary()]) :: Conn.t()
  def call(conn, _type) do
    conn
    |> Guardian.Plug.current_resource()
    |> has_permission?(conn)
    |> maybe_halt(conn)
  end

  defp has_permission?(%User{} = user, conn) do
    permission = get_permission(conn)

    role_permission() |> Map.get(permission, []) |> Enum.member?(user.role)
  end

  defp maybe_halt(true, conn) do
    conn
  end

  defp maybe_halt(false, conn) do
    conn
    |> put_status(403)
    |> Phoenix.Controller.put_view(LibraryWeb.ErrorView)
    |> Phoenix.Controller.render("403_forbidden.json")
    |> halt()
  end

  defp get_permission(conn) do
    ["api" | req_path] = conn.path_info -- Map.values(conn.path_params)
    req_path = req_path |> Enum.join("/")
    "#{req_path}_#{conn.method}"
  end

  defp role_permission() do
    %{
      # "author_POST" => [@admin],
      # "author_PUT" => [@admin],
      # "author_DELETE" => [@admin],
      # "auhtor_GET" => [@admin],
      # "book_POST" => [@admin],
      # "book_PUT" => [@admin],
      # "book_DELETE" => [@admin],
      # "book_GET" => [@admin],
      # "book/index_GET" => [@admin, @user],
      # "book/view_GET" => [@user, @admin, @customer],
      # "book/display_GET" => [@user, @admin, @customer],
      # "book/spectate_GET" => [@user, @admin, @customer],
      # "book_usage_GET" => [@user, @admin, @customer],
      # "book_usage_POST" => [@user, @admin],
      # "book_usage_PUT" => [@user, @admin],
      # "book_usage_DELETE" => [@user, @admin]
    }
  end
end
