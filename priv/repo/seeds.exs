# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LvChat.Repo.insert!(%LvChat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LvChat.Accounts

%{name: "freddie", password: "mercury"} |> Accounts.register_user
%{name: "brian", password: "may"}       |> Accounts.register_user
%{name: "john", password: "deacon"}     |> Accounts.register_user
%{name: "roger", password: "taylor"}    |> Accounts.register_user
