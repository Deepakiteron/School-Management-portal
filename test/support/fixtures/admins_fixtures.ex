defmodule SchoolPortal.AdminsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SchoolPortal.Admins` context.
  """

  @doc """
  Generate a admin.
  """
  def admin_fixture(attrs \\ %{}) do
    {:ok, admin} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        password: "some password"
      })
      |> SchoolPortal.Admins.create_admin()

    admin
  end
end
