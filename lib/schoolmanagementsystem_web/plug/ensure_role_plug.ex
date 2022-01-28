defmodule SchoolmanagementsystemWeb.Plug.EnsureRolePlug do


  import Plug.Conn, only: [halt: 1]
  alias SchoolmanagementsystemWeb.Router.Helpers, as: Routes
  alias Schoolmanagementsystem.Auth.Guardian
  alias Schoolmanagementsystem.Users.User
  alias Phoenix.Controller
  alias Plug.Conn
  alias Pow.Plug

  @admin "admin"
  @tecaher "teacher"
  @student "student"

  @spec init(any()) :: any()
  def init(config), do: config

  @spec call(Conn.t(), atom() | binary() | [atom()] | [binary()]) :: Conn.t()

  def call(conn, roles) do
    conn
    |> Guardian.Plug.current_resource()
    |> has_role?(roles)
    |> maybe_halt(conn)
  end

  defp has_role?(nil, _roles), do: false
  defp has_role?(user, roles) when is_list(roles), do: Enum.any?(roles, &has_role?(user, &1))
  defp has_role?(user, role) when is_atom(role), do: has_role?(user, Atom.to_string(role))
  defp has_role?(%{role: role}, role), do: true
  defp has_role?(_user, _role), do: false

  defp maybe_halt(true, conn), do: conn
  defp maybe_halt(_any, conn) do
    conn
    |> Controller.put_flash(:error, "Unauthorized access")
    |> Controller.redirect(to: Routes.page_path(conn, :index))
    |> halt()
  end
end
