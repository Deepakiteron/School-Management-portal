defmodule SchoolPortal.Repo do
  use Ecto.Repo,
    otp_app: :school_portal,
    adapter: Ecto.Adapters.Postgres
end
