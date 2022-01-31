defmodule Schoolmanagementsystem.AdminsTest do
  use Schoolmanagementsystem.DataCase

  alias Schoolmanagementsystem.Admins

  describe "admins" do
    alias Schoolmanagementsystem.Admins.Admin

    import Schoolmanagementsystem.AdminsFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, password: nil, role: nil}

    test "list_admins/0 returns all admins" do
      admin = admin_fixture()
      assert Admins.list_admins() == [admin]
    end

    test "get_admin!/1 returns the admin with given id" do
      admin = admin_fixture()
      assert Admins.get_admin!(admin.id) == admin
    end

    test "create_admin/1 with valid data creates a admin" do
      valid_attrs = %{
        age: 42,
        email: "some email",
        name: "some name",
        password: "some password",
        role: "some role"
      }

      assert {:ok, %Admin{} = admin} = Admins.create_admin(valid_attrs)
      assert admin.age == 42
      assert admin.email == "some email"
      assert admin.name == "some name"
      assert admin.password == "some password"
      assert admin.role == "some role"
    end

    test "create_admin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admins.create_admin(@invalid_attrs)
    end

    test "update_admin/2 with valid data updates the admin" do
      admin = admin_fixture()

      update_attrs = %{
        age: 43,
        email: "some updated email",
        name: "some updated name",
        password: "some updated password",
        role: "some updated role"
      }

      assert {:ok, %Admin{} = admin} = Admins.update_admin(admin, update_attrs)
      assert admin.age == 43
      assert admin.email == "some updated email"
      assert admin.name == "some updated name"
      assert admin.password == "some updated password"
      assert admin.role == "some updated role"
    end

    test "update_admin/2 with invalid data returns error changeset" do
      admin = admin_fixture()
      assert {:error, %Ecto.Changeset{}} = Admins.update_admin(admin, @invalid_attrs)
      assert admin == Admins.get_admin!(admin.id)
    end

    test "delete_admin/1 deletes the admin" do
      admin = admin_fixture()
      assert {:ok, %Admin{}} = Admins.delete_admin(admin)
      assert_raise Ecto.NoResultsError, fn -> Admins.get_admin!(admin.id) end
    end

    test "change_admin/1 returns a admin changeset" do
      admin = admin_fixture()
      assert %Ecto.Changeset{} = Admins.change_admin(admin)
    end
  end
end
