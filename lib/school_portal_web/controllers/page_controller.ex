defmodule SchoolPortalWeb.PageController do
  use SchoolPortalWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
