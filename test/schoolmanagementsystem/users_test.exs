defmodule Schoolmanagementsystem.UsersTest do
  use Schoolmanagementsystem.DataCase

  alias Schoolmanagementsystem.Users

  describe "registers" do
    alias Schoolmanagementsystem.Users.User

    import Schoolmanagementsystem.UsersFixtures

    @invalid_attrs %{address: nil, age: nil, email: nil, first_name: nil, gender: nil, last_name: nil, password: nil, phone_number: nil, type: nil}

    test "list_registers/0 returns all registers" do
      user = user_fixture()
      assert Users.list_registers() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{address: "some address", age: 42, email: "some email", first_name: "some first_name", gender: "some gender", last_name: "some last_name", password: "some password", phone_number: "some phone_number", type: "some type"}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.address == "some address"
      assert user.age == 42
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.gender == "some gender"
      assert user.last_name == "some last_name"
      assert user.password == "some password"
      assert user.phone_number == "some phone_number"
      assert user.type == "some type"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{address: "some updated address", age: 43, email: "some updated email", first_name: "some updated first_name", gender: "some updated gender", last_name: "some updated last_name", password: "some updated password", phone_number: "some updated phone_number", type: "some updated type"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.address == "some updated address"
      assert user.age == 43
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.gender == "some updated gender"
      assert user.last_name == "some updated last_name"
      assert user.password == "some updated password"
      assert user.phone_number == "some updated phone_number"
      assert user.type == "some updated type"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
