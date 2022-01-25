defmodule SchoolmanagementsystemWeb.PageController do
  use SchoolmanagementsystemWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
