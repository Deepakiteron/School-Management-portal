defmodule SchoolPortal.UsersTest do
  use SchoolPortal.DataCase

  alias SchoolPortal.Users

  describe "users" do
    alias SchoolPortal.Users.User

    import SchoolPortal.UsersFixtures

    @invalid_attrs %{address: nil, age: nil, category_type: nil, email: nil, firstname: nil, gender: nil, lastname: nil, password: nil, phone_number: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{address: "some address", age: 42, category_type: "some category_type", email: "some email", firstname: "some firstname", gender: "some gender", lastname: "some lastname", password: "some password", phone_number: "some phone_number"}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.address == "some address"
      assert user.age == 42
      assert user.category_type == "some category_type"
      assert user.email == "some email"
      assert user.firstname == "some firstname"
      assert user.gender == "some gender"
      assert user.lastname == "some lastname"
      assert user.password == "some password"
      assert user.phone_number == "some phone_number"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{address: "some updated address", age: 43, category_type: "some updated category_type", email: "some updated email", firstname: "some updated firstname", gender: "some updated gender", lastname: "some updated lastname", password: "some updated password", phone_number: "some updated phone_number"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.address == "some updated address"
      assert user.age == 43
      assert user.category_type == "some updated category_type"
      assert user.email == "some updated email"
      assert user.firstname == "some updated firstname"
      assert user.gender == "some updated gender"
      assert user.lastname == "some updated lastname"
      assert user.password == "some updated password"
      assert user.phone_number == "some updated phone_number"
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
